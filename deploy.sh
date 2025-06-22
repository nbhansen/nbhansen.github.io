#!/bin/bash

# Simple deploy script for nbhansen.dk
# Usage: ./deploy.sh

echo "🚀 Building and deploying to nbhansen.dk..."

# Load FTP credentials from .env file
if [ -f ".env" ]; then
    echo "🔐 Loading credentials from .env..."
    export $(grep -v '^#' .env | xargs)
else
    echo "❌ Error: .env file not found!"
    echo "Copy .env.example to .env and fill in your FTP credentials"
    exit 1
fi

# Check if credentials are set
if [ -z "$FTP_HOST" ] || [ -z "$FTP_USER" ] || [ -z "$FTP_PASS" ]; then
    echo "❌ Error: Missing FTP credentials in .env file"
    echo "Please check your .env file has FTP_HOST, FTP_USER, and FTP_PASS"
    exit 1
fi

# Build the site
echo "📦 Building Jekyll site..."
bundle exec jekyll build

# Deploy via FTP
echo "🌐 Uploading to $FTP_HOST..."
lftp -c "
open -u $FTP_USER,$FTP_PASS ftp://$FTP_HOST
lcd _site
mirror --reverse --delete --verbose
bye
"

echo "✅ Done! Check https://nbhansen.dk"