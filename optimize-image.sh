#!/bin/bash

# Image optimization script for Jekyll blog
# Usage: ./optimize-image.sh image-file.jpg [--thumbnail]

set -e

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if image file is provided
if [ -z "$1" ]; then
    echo -e "${RED}❌ Usage: ./optimize-image.sh image-file.jpg [--thumbnail]${NC}"
    exit 1
fi

INPUT_FILE="$1"
CREATE_THUMBNAIL=false

# Check for thumbnail flag
if [ "$2" = "--thumbnail" ]; then
    CREATE_THUMBNAIL=true
fi

# Check if file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}❌ File not found: $INPUT_FILE${NC}"
    exit 1
fi

# Get file info
FILENAME=$(basename "$INPUT_FILE")
EXTENSION="${FILENAME##*.}"
BASENAME="${FILENAME%.*}"

# Target directory
TARGET_DIR="assets/img"
mkdir -p "$TARGET_DIR"

echo -e "${BLUE}🖼️  Optimizing: $FILENAME${NC}"

# Check if ImageMagick is available
if ! command -v convert &> /dev/null; then
    echo -e "${YELLOW}⚠️  ImageMagick not found. Installing...${NC}"
    echo "Please install ImageMagick:"
    echo "  • Ubuntu/Debian: sudo apt install imagemagick"
    echo "  • macOS: brew install imagemagick"
    echo "  • Fedora: sudo dnf install ImageMagick"
    exit 1
fi

# Optimize main image (max 1200px width, 85% quality)
OUTPUT_FILE="$TARGET_DIR/$FILENAME"
convert "$INPUT_FILE" \
    -resize "1200x1200>" \
    -quality 85 \
    -strip \
    "$OUTPUT_FILE"

echo -e "${GREEN}✅ Optimized: $OUTPUT_FILE${NC}"

# Create thumbnail if requested
if [ "$CREATE_THUMBNAIL" = true ]; then
    THUMB_FILE="$TARGET_DIR/${BASENAME}_thumb.$EXTENSION"
    convert "$INPUT_FILE" \
        -resize "400x400>" \
        -quality 80 \
        -strip \
        "$THUMB_FILE"
    echo -e "${GREEN}✅ Thumbnail: $THUMB_FILE${NC}"
fi

# Show file size comparison
if command -v du &> /dev/null; then
    ORIGINAL_SIZE=$(du -h "$INPUT_FILE" | cut -f1)
    NEW_SIZE=$(du -h "$OUTPUT_FILE" | cut -f1)
    echo -e "${BLUE}📊 Size: $ORIGINAL_SIZE → $NEW_SIZE${NC}"
fi

# Generate markdown for easy copying
echo -e "${YELLOW}📋 Markdown snippet:${NC}"
echo "![Description](/$OUTPUT_FILE \"Caption\")"

if [ "$CREATE_THUMBNAIL" = true ]; then
    echo "Thumbnail: ![Description](/$THUMB_FILE \"Caption\")"
fi