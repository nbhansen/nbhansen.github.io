#!/bin/bash

# Publish draft script
# Usage: ./publish-draft.sh draft-filename.md

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if draft filename is provided
if [ -z "$1" ]; then
    echo -e "${YELLOW}📋 Available drafts:${NC}"
    ls -1 _drafts/*.md 2>/dev/null | sed 's|_drafts/||' | sed 's|\.md$||' || echo "No drafts found"
    echo ""
    read -p "Enter draft filename (without .md): " DRAFT_NAME
    DRAFT_FILE="${DRAFT_NAME}.md"
else
    DRAFT_FILE="$1"
fi

DRAFT_PATH="_drafts/${DRAFT_FILE}"

# Check if draft exists
if [ ! -f "$DRAFT_PATH" ]; then
    echo -e "${RED}❌ Draft not found: $DRAFT_PATH${NC}"
    exit 1
fi

# Generate published filename
DATE=$(date +%Y-%m-%d)
SLUG=$(echo "$DRAFT_FILE" | sed 's/\.md$//')
PUBLISHED_FILE="${DATE}-${SLUG}.md"
PUBLISHED_PATH="_posts/${PUBLISHED_FILE}"

# Check if published file already exists
if [ -f "$PUBLISHED_PATH" ]; then
    echo -e "${YELLOW}⚠️  Published post already exists: $PUBLISHED_PATH${NC}"
    read -p "Overwrite? (y/N): " confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 1
    fi
fi

# Copy draft to posts with date prefix
cp "$DRAFT_PATH" "$PUBLISHED_PATH"

# Add/update date in front matter if not present
if ! grep -q "^date:" "$PUBLISHED_PATH"; then
    sed -i '/^---$/a date: '"$DATE" "$PUBLISHED_PATH"
else
    sed -i "s/^date:.*/date: $DATE/" "$PUBLISHED_PATH"
fi

echo -e "${GREEN}✅ Published: $PUBLISHED_PATH${NC}"

# Ask if user wants to delete draft
read -p "Delete draft? (Y/n): " delete_draft
if [[ ! $delete_draft =~ ^[Nn]$ ]]; then
    rm "$DRAFT_PATH"
    echo -e "${GREEN}🗑️  Deleted draft${NC}"
fi

echo -e "${YELLOW}💡 Next steps:${NC}"
echo "  • Preview: bundle exec jekyll serve"
echo "  • Deploy: ./deploy.sh"