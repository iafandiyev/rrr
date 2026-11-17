#!/bin/bash
set -euo pipefail

echo "=== Build script for Tap the Circle iOS app ==="

# Find the iOS SDK
SDK_PATH=$(xcrun --sdk iphoneos --show-sdk-path 2>/dev/null || echo "")
if [ -z "$SDK_PATH" ]; then
  echo "error: Could not find iOS SDK" >&2
  exit 1
fi
echo "iOS SDK: $SDK_PATH"

# Find framework directory
FRAMEWORKS_DIR="$SDK_PATH/System/Library/Frameworks"
if [ ! -d "$FRAMEWORKS_DIR" ]; then
  # Try alternate location
  FRAMEWORKS_DIR="$SDK_PATH/usr/lib/swift"
fi
echo "Frameworks dir: $FRAMEWORKS_DIR"

# Show Xcode version
xcodebuild -version 2>/dev/null || true

# Compile Swift files
echo "=== Compiling Swift sources ==="
SWIFT_FILES=$(ls TapTheCircle/TapTheCircle/*.swift)
echo "Source files: $SWIFT_FILES"

xcrun swiftc \
  -target arm64-apple-ios15.0 \
  -sdk "$SDK_PATH" \
  -F "$FRAMEWORKS_DIR" \
  -framework SwiftUI \
  -framework Combine \
  -framework UIKit \
  -o TapTheCircle \
  $SWIFT_FILES

echo "Compilation successful"

# Create .app bundle
echo "=== Creating .app bundle ==="
APP_DIR="Payload/TapTheCircle.app"
rm -rf "$APP_DIR"
mkdir -p "$APP_DIR"

# Copy executable
cp TapTheCircle "$APP_DIR/TapTheCircle"
chmod +x "$APP_DIR/TapTheCircle"

# Copy Info.plist
cp TapTheCircle/TapTheCircle/Info.plist "$APP_DIR/Info.plist"

echo "App bundle created at $APP_DIR"

# Verify .app contents
echo "=== .app contents ==="
ls -la "$APP_DIR/"

# Package into IPA
echo "=== Packaging IPA ==="
rm -f TapTheCircle.ipa
(cd Payload && zip -r -X "../TapTheCircle.ipa" TapTheCircle.app)

echo "IPA created: TapTheCircle.ipa"
ls -lh TapTheCircle.ipa

# Verify IPA
echo "=== Verifying IPA ==="
unzip -t TapTheCircle.ipa
unzip -l TapTheCircle.ipa | grep 'TapTheCircle.app/'

echo "=== Build complete ==="
