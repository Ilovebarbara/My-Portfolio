# Jodeo Ira Luis D. Joson - Portfolio Deployment Guide

This modern portfolio website is deployed on Google Cloud Platform using App Engine with advanced features and optimizations.

## 🚀 Live Website
- **App Engine URL**: `https://[YOUR-PROJECT-ID].appspot.com`
- **Custom Domain**: `https://[YOUR-DOMAIN].com` (after domain configuration)

## 📋 Prerequisites
1. Google Cloud SDK installed and configured
2. Google Cloud Project created
3. App Engine enabled in your project
4. Billing account linked (required for App Engine)

## 🛠️ Local Development
```bash
# Open the portfolio locally
start index.html
# or
python -m http.server 8000
```

## 🌐 Deployment Process

### 1. Initial Setup
```bash
# Set your project ID
gcloud config set project [YOUR-PROJECT-ID]

# Enable required APIs
gcloud services enable appengine.googleapis.com
gcloud services enable cloudbuild.googleapis.com

# Initialize App Engine (choose your preferred region)
gcloud app create --region=[REGION]
```

### 2. Deploy to App Engine
```bash
# Deploy your portfolio
gcloud app deploy

# Deploy and view immediately
gcloud app deploy --version=v1 && gcloud app browse
```

### 3. Custom Domain Configuration
```bash
# Add your custom domain
gcloud app domain-mappings create [YOUR-DOMAIN].com

# Add www subdomain
gcloud app domain-mappings create www.[YOUR-DOMAIN].com

# List all domain mappings
gcloud app domain-mappings list
```

## 🔧 Configuration Files

### app.yaml Features
- **HTTPS enforced** for security
- **Auto-scaling** with cost optimization
- **Cache optimization** for static assets
- **Compression** enabled
- **Security headers** configured

### Portfolio Features
- ✨ **Incredible 3D morphing header** with coral gradient theme
- 🎨 **Advanced animations** and particle effects
- 📱 **Fully responsive** mobile design
- ⚡ **Performance optimized** with modern CSS
- 🛡️ **SEO optimized** meta tags

## 📊 Monitoring & Management
```bash
# View application logs
gcloud app logs tail -s default

# Check application status
gcloud app versions list

# View app details
gcloud app describe
```

## 🔗 Domain DNS Configuration
After running domain mapping commands, configure your DNS:

1. **Add CNAME records** in your domain registrar:
   ```
   www.yourdomain.com → ghs.googlehosted.com
   ```

2. **Add A records** for root domain:
   ```
   yourdomain.com → 216.239.32.21
   yourdomain.com → 216.239.34.21
   yourdomain.com → 216.239.36.21
   yourdomain.com → 216.239.38.21
   ```

## 💡 Advanced Features
- **Automatic HTTPS** with managed SSL certificates
- **Global CDN** for fast loading worldwide
- **DDoS protection** included
- **99.95% uptime SLA**

## 🎯 Project Structure
```
My-Portfolio/
├── index.html              # Main portfolio page with incredible design
├── avatar.png              # Profile image
├── app.yaml                # App Engine configuration
├── deployment-readme.md    # This deployment guide
└── README.md              # Project documentation
```

## 🔄 Updates & Versioning
```bash
# Deploy new version
gcloud app deploy --version=v2

# Promote version to receive traffic
gcloud app versions migrate v2

# Split traffic between versions
gcloud app services set-traffic default --splits=v1=50,v2=50
```

## 📈 Performance Tips
1. **Images**: Optimize avatar.png for web (WebP format recommended)
2. **Caching**: Static assets cached for 30 days
3. **Compression**: Gzip enabled automatically
4. **CDN**: Global distribution included

## 🆘 Troubleshooting
```bash
# Check deployment status
gcloud app operations list

# View detailed logs
gcloud app logs read --service=default --version=[VERSION]

# SSH into App Engine instance (if needed)
gcloud app instances ssh [INSTANCE] --service=default
```

---
**Portfolio by Jodeo Ira Luis D. Joson** | Deployed with ❤️ on Google Cloud Platform
