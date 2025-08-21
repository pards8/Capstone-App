const express = require('express');
const os = require('os');
const mongoose = require('mongoose');
const cors = require('cors');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
require('dotenv').config();

const app = express();
const PORT = process.env.PORT || 3000;

// Utility function for handling errors
const handleError = (res, error, context = 'operation') => {
  console.error(`Error during ${context}:`, error);
  res.status(500).json({
    success: false,
    message: `Error during ${context}`,
    error: process.env.NODE_ENV === 'development' ? error.message : undefined
  });
};

// Middleware
app.use(express.json());
app.use(cors({
  origin: '*', // For development only! Restrict in production.
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
}));

// MongoDB Connection
console.log('Attempting to connect to MongoDB Atlas...');
const db = mongoose.connection;

mongoose.connect(process.env.MONGODB_URI, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
  serverSelectionTimeoutMS: 5000,
  socketTimeoutMS: 45000
});

db.on('error', (error) => {
  console.error('MongoDB connection error:', error);
  console.error('Connection string used:', process.env.MONGODB_URI ? 
    process.env.MONGODB_URI.replace(/:[^:]*@/, ':***@') : 'MONGODB_URI not set');
});

db.once('open', () => {
  console.log('Successfully connected to MongoDB Atlas');
  // List all collections
  mongoose.connection.db.listCollections().toArray((err, collections) => {
    if (err) {
      console.error('Error listing collections:', err);
      return;
    }
    console.log('Available collections:');
    collections.forEach(collection => {
      console.log(`- ${collection.name}`);
    });
  });
});

// User Schema
const userSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
    trim: true
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    lowercase: true
  },
  password: {
    type: String,
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

const User = mongoose.model('User', userSchema);

// Password Reset Schema
const passwordResetSchema = new mongoose.Schema({
  email: {
    type: String,
    required: true,
    trim: true,
    lowercase: true
  },
  code: {
    type: String,
    required: true
  },
  expiresAt: {
    type: Date,
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  }
});

const PasswordReset = mongoose.model('PasswordReset', passwordResetSchema);

// Email configuration
const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.EMAIL_USER || 'your-email@gmail.com',
    pass: process.env.EMAIL_PASS || 'your-app-password'
  }
});

// Routes

// Protected route example
app.get('/api/profile', async (req, res) => {
  try {
    const token = req.headers.authorization?.split(' ')[1];
    
    if (!token) {
      return res.status(401).json({
        success: false,
        message: 'No token provided'
      });
    }

    const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your-secret-key');
    const user = await User.findById(decoded.userId).select('-password');
    
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'User not found'
      });
    }

    res.json({
      success: true,
      user
    });

  } catch (error) {
    console.error('Profile error:', error);
    res.status(401).json({
      success: false,
      message: 'Invalid token'
    });
  }
});

// Health check endpoint
app.get('/api/health', (req, res) => {
  res.json({ 
    success: true, 
    message: 'Server is running',
    timestamp: new Date().toISOString(),
    database: mongoose.connection.readyState === 1 ? 'connected' : 'disconnected'
  });
});

// List all users (for testing only - remove in production)
app.get('/api/users', async (req, res) => {
  try {
    const users = await User.find({}).select('-password');
    res.json({
      success: true,
      count: users.length,
      users
    });
  } catch (error) {
    handleError(res, error, 'fetching users');
  }
});

// Check if email exists (for diagnostics/UX)
app.get('/api/email-exists', async (req, res) => {
  try {
    const email = String(req.query.email || '').trim().toLowerCase();
    if (!email) {
      return res.status(400).json({ success: false, message: 'Email query param is required' });
    }
    const exists = await User.exists({ email });
    return res.json({ success: true, exists: Boolean(exists) });
  } catch (error) {
    handleError(res, error, 'checking email existence');
  }
});

// Forgot password - send reset code
app.post('/api/forgot-password', async (req, res) => {
  try {
    const { email } = req.body;
    const normalizedEmail = typeof email === 'string' ? email.trim().toLowerCase() : '';

    if (!normalizedEmail) {
      return res.status(400).json({
        success: false,
        message: 'Please provide a valid email address'
      });
    }

    // Check if user exists
    const user = await User.findOne({ email: normalizedEmail });
    if (!user) {
      return res.status(404).json({
        success: false,
        message: 'No account found with this email address'
      });
    }

    // Generate 6-digit code
    const resetCode = Math.floor(100000 + Math.random() * 900000).toString();
    const expiresAt = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes

    // Save or update reset code
    await PasswordReset.findOneAndUpdate(
      { email: normalizedEmail },
      { 
        email: normalizedEmail,
        code: resetCode,
        expiresAt: expiresAt
      },
      { upsert: true, new: true }
    );

    // Send email (with fallback for development)
    try {
      const mailOptions = {
        from: process.env.EMAIL_USER || 'your-email@gmail.com',
        to: normalizedEmail,
        subject: 'Password Reset Code - Capstone App',
        html: `
          <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto;">
            <h2 style="color: #333;">Password Reset Request</h2>
            <p>Hello ${user.name},</p>
            <p>You requested a password reset for your Capstone App account.</p>
            <p>Your reset code is: <strong style="font-size: 24px; color: #007bff;">${resetCode}</strong></p>
            <p>This code will expire in 10 minutes.</p>
            <p>If you didn't request this reset, please ignore this email.</p>
            <br>
            <p>Best regards,<br>Capstone App Team</p>
          </div>
        `
      };

      await transporter.sendMail(mailOptions);
      console.log(`✅ Reset code sent via email to ${normalizedEmail}`);
    } catch (emailError) {
      console.log(`⚠️ Email sending failed, but reset code generated: ${resetCode}`);
      console.log(`📧 For development, use this code: ${resetCode}`);
      // Continue with the response even if email fails
    }

    res.json({
      success: true,
      message: 'Password reset code sent to your email'
    });

  } catch (error) {
    console.error('Forgot password error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to send reset code. Please try again.'
    });
  }
});

// Verify reset code and reset password
app.post('/api/reset-password', async (req, res) => {
  try {
    const { email, code, newPassword } = req.body;
    const normalizedEmail = typeof email === 'string' ? email.trim().toLowerCase() : '';
    const normalizedCode = typeof code === 'string' ? code.trim() : '';
    const normalizedPassword = typeof newPassword === 'string' ? newPassword : '';

    if (!normalizedEmail || !normalizedCode || !normalizedPassword) {
      return res.status(400).json({
        success: false,
        message: 'Please provide email, code, and new password'
      });
    }

    if (normalizedPassword.length < 6) {
      return res.status(400).json({
        success: false,
        message: 'Password must be at least 6 characters long'
      });
    }

    // Find reset record
    const resetRecord = await PasswordReset.findOne({
      email: normalizedEmail,
      code: normalizedCode,
      expiresAt: { $gt: new Date() }
    });

    if (!resetRecord) {
      return res.status(400).json({
        success: false,
        message: 'Invalid or expired reset code'
      });
    }

    // Update user password
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(normalizedPassword, saltRounds);
    
    await User.findOneAndUpdate(
      { email: normalizedEmail },
      { password: hashedPassword }
    );

    // Delete used reset record
    await PasswordReset.deleteOne({ _id: resetRecord._id });

    res.json({
      success: true,
      message: 'Password reset successfully'
    });

  } catch (error) {
    console.error('Reset password error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to reset password. Please try again.'
    });
  }
});

// Login endpoint
app.post('/api/login', async (req, res) => {
  try {
    let { email, password } = req.body;
    const normalizedEmail = typeof email === 'string' ? email.trim().toLowerCase() : '';
    const normalizedPassword = typeof password === 'string' ? password : '';

    // Validate input
    if (!normalizedEmail || !normalizedPassword) {
      return res.status(400).json({
        success: false,
        message: 'Please provide email and password'
      });
    }

    // Check if user exists
    const user = await User.findOne({ email: normalizedEmail });
    if (!user) {
      return res.status(401).json({
        success: false,
        message: 'Invalid email or password'
      });
    }

    // Check password
    const isPasswordValid = await bcrypt.compare(normalizedPassword, user.password);
    if (!isPasswordValid) {
      return res.status(401).json({
        success: false,
        message: 'Invalid email or password'
      });
    }

    // Generate JWT token
    const token = jwt.sign(
      { userId: user._id, email: user.email },
      process.env.JWT_SECRET || 'your-secret-key',
      { expiresIn: '24h' }
    );

    res.json({
      success: true,
      message: 'Login successful',
      token,
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        createdAt: user.createdAt
      }
    });
  } catch (error) {
    handleError(res, error, 'user login');
  }
});

// Regular registration endpoint
app.post('/api/register', async (req, res) => {
  try {
    let { name, email, password } = req.body;
    const normalizedName = typeof name === 'string' ? name.trim() : '';
    const normalizedEmail = typeof email === 'string' ? email.trim().toLowerCase() : '';
    const normalizedPassword = typeof password === 'string' ? password : '';

    // Validate input
    if (!normalizedName || !normalizedEmail || !normalizedPassword) {
      return res.status(400).json({
        success: false,
        message: 'Please provide name, email, and password'
      });
    }

    // Check if user exists
    const existingUser = await User.findOne({ email: normalizedEmail });
    if (existingUser) {
      return res.status(400).json({
        success: false,
        message: 'User with this email already exists'
      });
    }

    // Create user
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(normalizedPassword, saltRounds);
    const user = new User({
      name: normalizedName,
      email: normalizedEmail,
      password: hashedPassword
    });

    await user.save();

    // Generate JWT token
    const token = jwt.sign(
      { userId: user._id, email: user.email },
      process.env.JWT_SECRET || 'your-secret-key',
      { expiresIn: '24h' }
    );

    res.status(201).json({
      success: true,
      message: 'User registered successfully',
      token,
      user: {
        id: user._id,
        name: user.name,
        email: user.email,
        createdAt: user.createdAt
      }
    });
  } catch (error) {
    if (error && error.code === 11000) {
      return res.status(400).json({
        success: false,
        message: 'User with this email already exists'
      });
    }
    handleError(res, error, 'user registration');
  }
});

// Test registration endpoint

app.listen(PORT, '0.0.0.0', () => {
  const interfaces = os.networkInterfaces();
  let localIp = 'localhost';
  for (const name of Object.keys(interfaces)) {
    for (const iface of interfaces[name]) {
      if (iface.family === 'IPv4' && !iface.internal) {
        localIp = iface.address;
        break;
      }
    }
  }
  console.log(`Server running on:`);
  console.log(`  Local:   http://localhost:${PORT}`);
  console.log(`  Network: http://${localIp}:${PORT}`);
});