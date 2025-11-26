#!/bin/bash

# Frontend deployment script
# Handles backup and deployment of frontend dist files

set -e  # Exit on any error

echo "Starting frontend deployment..."

# Check if dist directory exists
if [ ! -d "dist" ]; then
    echo "Error: dist directory not found in current location"
    exit 1
fi

# Check if backup directory exists
if [ ! -d "../backup" ]; then
    echo "Error: backup directory not found in parent directory"
    exit 1
fi

# Find the latest frontend-dist zip file
LATEST_ZIP=$(ls -t frontend-dist-*.zip | head -1)
if [ -z "$LATEST_ZIP" ]; then
    echo "Error: No frontend-dist-*.zip file found"
    exit 1
fi

echo "Latest zip file: $LATEST_ZIP"

# Remove old backup dist directory if exists
if [ -d "../backup/dist" ]; then
    echo "Removing old backup dist directory..."
    rm -rf ../backup/dist
fi

# Backup current dist directory
echo "Backing up current dist directory..."
cp -r dist ../backup/

# Extract new dist files
echo "Extracting $LATEST_ZIP to dist directory..."
rm -rf dist/*  # Clean current dist directory
unzip -q "$LATEST_ZIP" -d

echo "Frontend deployment completed successfully!"
echo "Backup saved to: ../backup/dist"
echo "New deployment extracted from: $LATEST_ZIP"