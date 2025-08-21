# Capstone App Backend

This is the Node.js/Express backend for the Capstone App with MongoDB integration.

## Setup Instructions

1. **Create MongoDB Atlas Cluster (Recommended)**
   - Go to `https://www.mongodb.com/cloud/atlas`
   - Create a free cluster
   - Create a database user with password
   - Add your IP address to Network Access (or 0.0.0.0/0 for development)
   - Get your connection string: `mongodb+srv://<user>:<password>@<cluster>/capstone_app?retryWrites=true&w=majority&appName=<yourAppName>`

2. **Install Dependencies**
   ```bash
   cd backend
   npm install
   ```

3. **Start the Server**
   ```bash
   npm start
   ```
   or for development with auto-restart:
   ```bash
   npm run dev
   ```

4. **API Endpoints**
   - `POST /api/register` - Register new user
   - `POST /api/login` - Login user
   - `POST /api/forgot-password` - Send password reset code
   - `POST /api/reset-password` - Reset password with code
   - `GET /api/profile` - Get user profile (protected)
   - `GET /api/health` - Health check
   - `GET /api/users` - List all users (for testing)
   - `GET /api/email-exists` - Check if email exists

5. **Environment Variables**
   Create a `.env` file in the backend directory:
   ```
   PORT=3000
   # Use your Atlas connection string here
   MONGODB_URI=mongodb+srv://<user>:<password>@<cluster>/capstone_app?retryWrites=true&w=majority&appName=<yourAppName>
   JWT_SECRET=your-secret-key-change-this-in-production
   
   # Email configuration for password reset
   # For Gmail, you need to use an App Password (not your regular password)
   # Go to Google Account settings > Security > 2-Step Verification > App passwords
   EMAIL_USER=your-email@gmail.com
   EMAIL_PASS=your-app-password
   ```

   Example for local MongoDB (optional):
   ```
   MONGODB_URI=mongodb://localhost:27017/capstone_app
   ```

   **Email Setup Instructions:**
   1. **Gmail Setup:**
      - Enable 2-Step Verification on your Google Account
      - Go to Google Account settings > Security > App passwords
      - Generate an app password for "Mail"
      - Use your Gmail address as EMAIL_USER and the generated app password as EMAIL_PASS
   
   2. **Alternative Email Services:**
      - **Resend:** Sign up at resend.com, get API key, use as EMAIL_USER
      - **SendGrid:** Sign up at sendgrid.com, get API key, use as EMAIL_USER
      - **Mailgun:** Sign up at mailgun.com, get API key, use as EMAIL_USER

## Database Schema

Users collection:
- name (String, required)
- email (String, required, unique)
- password (String, required, hashed)
- createdAt (Date, auto-generated)

## Security Features

- Password hashing with bcrypt
- JWT token authentication
- Email uniqueness validation
- CORS enabled for Flutter app 