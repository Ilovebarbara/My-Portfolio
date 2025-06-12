# 🚀 Quick Deployment Guide - Jodeo Portfolio

## 📋 Pre-Deployment Checklist

1. ✅ **Google Cloud SDK** installed
2. ✅ **Project created** in Google Cloud Console
3. ✅ **Billing enabled** for your project
4. ✅ **App Engine API** enabled

## 🎯 Step-by-Step Deployment

### 1. **Initial Setup** (First-time only)
```powershell
# Authenticate with Google Cloud
gcloud auth login

# Set your project ID
gcloud config set project YOUR-PROJECT-ID

# Enable required APIs
gcloud services enable appengine.googleapis.com
gcloud services enable cloudbuild.googleapis.com

# Create App Engine application
gcloud app create --region=us-central1
```

### 2. **Deploy Your Portfolio**
```powershell
# Navigate to your project directory
cd "c:\Users\ADMIN\myproject\My-Portfolio"

# Deploy to App Engine
gcloud app deploy

# View your deployed portfolio
gcloud app browse
```

### 3. **Custom Domain Setup** (Optional)
```powershell
# Add your custom domain
gcloud app domain-mappings create yourdomain.com
gcloud app domain-mappings create www.yourdomain.com

# Get verification instructions
gcloud app domain-mappings list
```

## 🔧 DNS Configuration for Custom Domain

Add these records to your domain registrar:

**A Records (for root domain):**
```
yourdomain.com → 216.239.32.21
yourdomain.com → 216.239.34.21
yourdomain.com → 216.239.36.21
yourdomain.com → 216.239.38.21
```

**CNAME Record (for www subdomain):**
```
www.yourdomain.com → ghs.googlehosted.com
```

## 🚀 Using the PowerShell Script

### **First Deployment:**
```powershell
# Make script executable
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Setup project (first time only)
.\deploy.ps1 -SetupProject -ProjectId "your-project-id"

# Deploy portfolio
.\deploy.ps1 -Version "v1"
```

### **Updates & New Versions:**
```powershell
# Deploy new version
.\deploy.ps1 -Version "v2"

# Add custom domain
.\deploy.ps1 -AddDomain -Domain "yourdomain.com"
```

## 📊 Post-Deployment Commands

```powershell
# View application logs
gcloud app logs tail -s default

# Check app status
gcloud app describe

# List all versions
gcloud app versions list

# Manage traffic between versions
gcloud app services set-traffic default --splits=v1=50,v2=50
```

## 🔍 Troubleshooting

### **Common Issues:**

1. **Permission Denied:**
   ```powershell
   gcloud auth login
   gcloud config set project YOUR-PROJECT-ID
   ```

2. **Billing Not Enabled:**
   - Go to Google Cloud Console → Billing
   - Link a billing account to your project

3. **App Engine Region Error:**
   ```powershell
   gcloud app create --region=us-central1
   ```

4. **Domain Verification Failed:**
   - Check DNS propagation (use dig or nslookup)
   - Wait 24-48 hours for DNS changes

## 🌟 Success Indicators

✅ **Deployment Successful** if you see:
```
Deployed service [default] to [https://YOUR-PROJECT-ID.appspot.com]
```

✅ **Domain Configured** if you see:
```
Created mapping [yourdomain.com]
```

## 📈 Performance Monitoring

```powershell
# View performance metrics
gcloud app operations list

# Monitor resource usage
gcloud app instances list

# View error logs
gcloud app logs read --severity=ERROR
```

## 🎉 Your Portfolio is Live!

**App Engine URL:** `https://YOUR-PROJECT-ID.appspot.com`  
**Custom Domain:** `https://yourdomain.com` (after DNS configuration)

---
**Need Help?** Contact: jodeoiraluisjoson@gmail.com
