#!/bin/bash
set -e

# Directories
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
APK_DIR="$REPO_DIR/build/app/outputs/flutter-apk"

echo "=== Building Android APKs ==="
flutter build apk --release --split-per-abi

# Extract version from pubspec.yaml
VERSION=$(grep '^version: ' "$REPO_DIR/pubspec.yaml" | sed 's/version: //')
echo "=== Detected version: $VERSION ==="

# Clean old APKs in root directory
rm -f "$REPO_DIR"/Anx_Remix-*.apk

echo "=== Copying and Renaming APKs to Project Root ==="

# Copy and rename arm64-v8a
if [ -f "$APK_DIR/app-arm64-v8a-release.apk" ]; then
  cp "$APK_DIR/app-arm64-v8a-release.apk" "$REPO_DIR/Anx_Remix-${VERSION}-arm64-v8a.apk"
  echo "=== APK successfully created at: $REPO_DIR/Anx_Remix-${VERSION}-arm64-v8a.apk ==="
fi

# Copy and rename armeabi-v7a
if [ -f "$APK_DIR/app-armeabi-v7a-release.apk" ]; then
  cp "$APK_DIR/app-armeabi-v7a-release.apk" "$REPO_DIR/Anx_Remix-${VERSION}-armeabi-v7a.apk"
  echo "=== APK successfully created at: $REPO_DIR/Anx_Remix-${VERSION}-armeabi-v7a.apk ==="
fi

# Copy and rename x86_64
if [ -f "$APK_DIR/app-x86_64-release.apk" ]; then
  cp "$APK_DIR/app-x86_64-release.apk" "$REPO_DIR/Anx_Remix-${VERSION}-x86_64.apk"
  echo "=== APK successfully created at: $REPO_DIR/Anx_Remix-${VERSION}-x86_64.apk ==="
fi

echo "=== All APKs successfully built and renamed! ==="
