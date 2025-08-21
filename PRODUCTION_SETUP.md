# Production Setup Guide for Play Store Deployment

## 🚀 Backend Deployment

### Option 1: Heroku (Recommended for beginners)
1. **Create Heroku Account**
   - Sign up at [heroku.com](https://heroku.com)
   - Install Heroku CLI

2. **Deploy Backend**
   ```bash
   cd backend
   heroku create your-capstone-backend
   git init
   git add .
   git commit -m "Initial commit"
   heroku git:remote -a your-capstone-backend
   git push heroku main
   ```

3. **Set Environment Variables**
   ```bash
   heroku config:set MONGODB_URI="your-atlas-connection-string"
   heroku config:set JWT_SECRET="your-production-secret-key"
   heroku config:set EMAIL_USER="your-email@gmail.com"
   heroku config:set EMAIL_PASS="your-app-password"
   ```

### Option 2: Railway
1. **Deploy to Railway**
   - Connect your GitHub repo to Railway
   - Set environment variables in Railway dashboard
   - Deploy automatically

### Option 3: DigitalOcean/Render
- Similar process to Heroku
- Set environment variables in dashboard

## 📱 Flutter App Preparation

### 1. Update Production Backend URL
Edit `lib/config.dart`:
```dart
static const String _prodUrl = 'https://your-actual-backend-url.com';
```

### 2. Build Release APK
```bash
flutter build apk --release
```

### 3. Test Release Build
```bash
flutter install --release
```

## 🔐 Security Checklist

### Backend Security
- [ ] Use HTTPS only (no HTTP)
- [ ] Set strong JWT_SECRET
- [ ] Enable CORS for your domain only
- [ ] Use environment variables for all secrets
- [ ] Set up proper MongoDB Atlas security

### App Security
- [ ] Remove debug prints
- [ ] Use HTTPS URLs only
- [ ] Implement proper error handling
- [ ] Add input validation

## 📋 Play Store Requirements

### 1. App Signing
```bash
# Generate keystore
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Configure signing in android/app/build.gradle.kts
android {
    signingConfigs {
        create("release") {
            keyAlias = "upload"
            keyPassword = "your-key-password"
            storeFile = file("~/upload-keystore.jks")
            storePassword = "your-store-password"
        }
    }
    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
        }
    }
}
```

### 2. App Bundle (Recommended)
```bash
flutter build appbundle --release
```

### 3. Required Assets
- [ ] App icon (512x512 PNG)
- [ ] Feature graphic (1024x500 PNG)
- [ ] Screenshots (at least 2)
- [ ] App description
- [ ] Privacy policy URL

### 4. Content Rating
- Complete content rating questionnaire
- Set appropriate age rating

### 5. App Store Listing
- App name: "Capstone Food App"
- Short description: "Food ordering and delivery app"
- Full description: Detailed app features
- Keywords: food, delivery, ordering, restaurant

## 🧪 Testing Checklist

### Pre-Release Testing
- [ ] Test on multiple Android devices
- [ ] Test all user flows (register, login, forgot password, order)
- [ ] Test network connectivity issues
- [ ] Test app performance
- [ ] Test with different screen sizes

### Backend Testing
- [ ] Test all API endpoints
- [ ] Test email functionality
- [ ] Test database operations
- [ ] Test error handling

## 📊 Analytics & Monitoring

### Add Firebase Analytics
1. **Add Firebase to your project**
   ```bash
   flutter pub add firebase_core firebase_analytics
   ```

2. **Initialize Firebase**
   ```dart
   import 'package:firebase_core/firebase_core.dart';
   
   void main() async {
     WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp();
     runApp(MyApp());
   }
   ```

### Backend Monitoring
- Set up logging (Winston)
- Monitor API performance
- Set up error tracking

## 🚨 Important Notes

### Before Publishing
1. **Change Application ID**
   - Update `android/app/build.gradle.kts`
   - Use unique package name: `com.yourcompany.capstonefoodapp`

2. **Update App Name**
   - Change in `android/app/src/main/AndroidManifest.xml`
   - Use user-friendly name

3. **Test Production Build**
   - Always test release build before publishing
   - Verify all features work in production

4. **Backup Everything**
   - Keep keystore file safe
   - Document all passwords and keys
   - Backup your code

### Post-Publishing
1. **Monitor Reviews**
2. **Track Crash Reports**
3. **Update Regularly**
4. **Respond to User Feedback**

## 🔄 Update Process

### For App Updates
1. Increment version in `pubspec.yaml`
2. Update versionCode in `build.gradle.kts`
3. Test thoroughly
4. Build new APK/Bundle
5. Upload to Play Console

### For Backend Updates
1. Deploy to production
2. Test all endpoints
3. Monitor for errors
4. Update app if needed

## 📞 Support

- Keep backend running 24/7
- Monitor server health
- Set up alerts for downtime
- Have backup hosting plan

---

**Remember**: Once published, you cannot change the package name. Choose wisely!
