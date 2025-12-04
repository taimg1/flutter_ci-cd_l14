#!/bin/bash

# Automated version bump script
# This script automatically increments the build number in pubspec.yaml

set -e

PUBSPEC_FILE="pubspec.yaml"

# Check if pubspec.yaml exists
if [ ! -f "$PUBSPEC_FILE" ]; then
  echo "❌ Error: $PUBSPEC_FILE not found"
  exit 1
fi

echo "🔢 Starting version bump..."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# Read current version from pubspec.yaml
CURRENT_VERSION=$(grep "version:" "$PUBSPEC_FILE" | awk '{print $2}')

if [ -z "$CURRENT_VERSION" ]; then
  echo "❌ Error: Could not read version from $PUBSPEC_FILE"
  exit 1
fi

echo "📦 Current version: $CURRENT_VERSION"

# Split version into name and build number
VERSION_NAME=$(echo "$CURRENT_VERSION" | cut -d'+' -f1)
BUILD_NUMBER=$(echo "$CURRENT_VERSION" | cut -d'+' -f2)

# If there's no build number, initialize it
if [ "$VERSION_NAME" = "$BUILD_NUMBER" ]; then
  BUILD_NUMBER=0
fi

echo "   - Version name: $VERSION_NAME"
echo "   - Build number: $BUILD_NUMBER"

# Increment build number
NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))
NEW_VERSION="${VERSION_NAME}+${NEW_BUILD_NUMBER}"

echo ""
echo "🎯 New version: $NEW_VERSION"
echo "   - Version name: $VERSION_NAME"
echo "   - Build number: $NEW_BUILD_NUMBER"

# Update pubspec.yaml
# Using different approach for cross-platform compatibility
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  sed -i '' "s/version: ${CURRENT_VERSION}/version: ${NEW_VERSION}/" "$PUBSPEC_FILE"
else
  # Linux
  sed -i "s/version: ${CURRENT_VERSION}/version: ${NEW_VERSION}/" "$PUBSPEC_FILE"
fi

# Verify the change
UPDATED_VERSION=$(grep "version:" "$PUBSPEC_FILE" | awk '{print $2}')

if [ "$UPDATED_VERSION" = "$NEW_VERSION" ]; then
  echo ""
  echo "✅ Version updated successfully!"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  echo "📝 Summary:"
  echo "   Old: $CURRENT_VERSION"
  echo "   New: $NEW_VERSION"
  echo "   Increment: +1 build number"
  echo ""
else
  echo ""
  echo "❌ Error: Version update failed"
  echo "   Expected: $NEW_VERSION"
  echo "   Got: $UPDATED_VERSION"
  exit 1
fi

# Optional: Create git tag
if command -v git &> /dev/null; then
  if git rev-parse --git-dir > /dev/null 2>&1; then
    echo "🏷️  Git repository detected"
    echo "   Tag: v${NEW_VERSION}"
    
    # Uncommit the following line to automatically create git tags
    # git tag -a "v${NEW_VERSION}" -m "Version ${NEW_VERSION}"
    
    echo "   (Tag creation is commented out by default)"
    echo ""
  fi
fi

echo "🎉 Done! Ready to commit and push."
echo ""

exit 0
