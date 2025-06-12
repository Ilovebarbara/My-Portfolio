# Jodeo Portfolio Deployment Script
# PowerShell script for easy deployment to Google App Engine

param(
    [string]$ProjectId = "",
    [string]$Version = "v1",
    [switch]$SetupProject,
    [switch]$AddDomain,
    [string]$Domain = ""
)

Write-Host "🚀 Jodeo Portfolio Deployment Script" -ForegroundColor Cyan
Write-Host "=====================================" -ForegroundColor Cyan

# Function to check if gcloud is installed
function Test-GCloudInstalled {
    try {
        $null = Get-Command gcloud -ErrorAction Stop
        return $true
    }
    catch {
        Write-Host "❌ Google Cloud SDK not found. Please install it first." -ForegroundColor Red
        Write-Host "Download from: https://cloud.google.com/sdk/docs/install" -ForegroundColor Yellow
        return $false
    }
}

# Function to setup new project
function Setup-Project {
    param([string]$ProjectId)
    
    Write-Host "🔧 Setting up Google Cloud Project: $ProjectId" -ForegroundColor Yellow
    
    # Set project
    gcloud config set project $ProjectId
    
    # Enable required APIs
    Write-Host "📡 Enabling required APIs..." -ForegroundColor Yellow
    gcloud services enable appengine.googleapis.com
    gcloud services enable cloudbuild.googleapis.com
    
    # Create App Engine app
    Write-Host "🏗️ Creating App Engine application..." -ForegroundColor Yellow
    $region = Read-Host "Enter your preferred region (e.g., us-central1, europe-west1, asia-northeast1)"
    gcloud app create --region=$region
    
    Write-Host "✅ Project setup complete!" -ForegroundColor Green
}

# Function to deploy application
function Deploy-Application {
    param([string]$Version)
    
    Write-Host "🚀 Deploying portfolio to App Engine..." -ForegroundColor Yellow
    Write-Host "Version: $Version" -ForegroundColor Cyan
    
    # Deploy with specified version
    gcloud app deploy --version=$Version --quiet
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✅ Deployment successful!" -ForegroundColor Green
        Write-Host "🌐 Opening your portfolio..." -ForegroundColor Cyan
        gcloud app browse
    } else {
        Write-Host "❌ Deployment failed!" -ForegroundColor Red
        exit 1
    }
}

# Function to add custom domain
function Add-CustomDomain {
    param([string]$Domain)
    
    Write-Host "🌐 Adding custom domain: $Domain" -ForegroundColor Yellow
    
    # Add main domain
    gcloud app domain-mappings create $Domain
    
    # Add www subdomain
    $wwwDomain = "www.$Domain"
    gcloud app domain-mappings create $wwwDomain
    
    Write-Host "✅ Domain mapping created!" -ForegroundColor Green
    Write-Host "📋 DNS Configuration Required:" -ForegroundColor Yellow
    Write-Host "Add these CNAME records to your DNS:" -ForegroundColor White
    Write-Host "  $wwwDomain → ghs.googlehosted.com" -ForegroundColor Cyan
    Write-Host "Add these A records for root domain:" -ForegroundColor White
    Write-Host "  $Domain → 216.239.32.21" -ForegroundColor Cyan
    Write-Host "  $Domain → 216.239.34.21" -ForegroundColor Cyan
    Write-Host "  $Domain → 216.239.36.21" -ForegroundColor Cyan
    Write-Host "  $Domain → 216.239.38.21" -ForegroundColor Cyan
}

# Main execution
if (-not (Test-GCloudInstalled)) {
    exit 1
}

# Setup project if requested
if ($SetupProject) {
    if (-not $ProjectId) {
        $ProjectId = Read-Host "Enter your Google Cloud Project ID"
    }
    Setup-Project -ProjectId $ProjectId
    exit 0
}

# Add domain if requested
if ($AddDomain) {
    if (-not $Domain) {
        $Domain = Read-Host "Enter your domain (e.g., yourdomain.com)"
    }
    Add-CustomDomain -Domain $Domain
    exit 0
}

# Default: Deploy application
if (-not $ProjectId) {
    $currentProject = gcloud config get-value project 2>$null
    if ($currentProject) {
        $ProjectId = $currentProject
        Write-Host "Using current project: $ProjectId" -ForegroundColor Cyan
    } else {
        $ProjectId = Read-Host "Enter your Google Cloud Project ID"
        gcloud config set project $ProjectId
    }
}

Write-Host "Project: $ProjectId" -ForegroundColor Cyan
Write-Host "Version: $Version" -ForegroundColor Cyan

Deploy-Application -Version $Version

Write-Host "🎉 Portfolio deployment complete!" -ForegroundColor Green
Write-Host "📊 View logs: gcloud app logs tail -s default" -ForegroundColor Yellow
Write-Host "⚙️ Manage versions: gcloud app versions list" -ForegroundColor Yellow
