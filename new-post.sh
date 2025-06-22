#!/bin/bash

# New post creation script
# Usage: ./new-post.sh "Post Title" [--draft] [--type=paper|conference|teaching|project]

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Default values
TITLE=""
IS_DRAFT=false
POST_TYPE="general"

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --draft)
            IS_DRAFT=true
            shift
            ;;
        --type=*)
            POST_TYPE="${1#*=}"
            shift
            ;;
        *)
            if [ -z "$TITLE" ]; then
                TITLE="$1"
            fi
            shift
            ;;
    esac
done

# Check if title is provided
if [ -z "$TITLE" ]; then
    echo -e "${YELLOW}📝 Creating a new blog post${NC}"
    read -p "Enter post title: " TITLE
fi

# Check post type
if [ "$POST_TYPE" = "general" ]; then
    echo -e "${BLUE}What type of post is this?${NC}"
    echo "1) General/Personal"
    echo "2) Paper/Publication"
    echo "3) Conference/Event"
    echo "4) Teaching/Course"
    echo "5) Project/Research"
    read -p "Choose (1-5): " choice
    
    case $choice in
        1) POST_TYPE="general" ;;
        2) POST_TYPE="paper" ;;
        3) POST_TYPE="conference" ;;
        4) POST_TYPE="teaching" ;;
        5) POST_TYPE="project" ;;
        *) POST_TYPE="general" ;;
    esac
fi

# Generate filename-safe slug
SLUG=$(echo "$TITLE" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')

# Set directory and filename
if [ "$IS_DRAFT" = true ]; then
    DIR="_drafts"
    FILENAME="${SLUG}.md"
else
    DIR="_posts"
    DATE=$(date +%Y-%m-%d)
    FILENAME="${DATE}-${SLUG}.md"
fi

FILEPATH="${DIR}/${FILENAME}"

# Check if file already exists
if [ -f "$FILEPATH" ]; then
    echo -e "${YELLOW}⚠️  File already exists: $FILEPATH${NC}"
    read -p "Overwrite? (y/N): " confirm
    if [[ ! $confirm =~ ^[Yy]$ ]]; then
        echo "Cancelled."
        exit 1
    fi
fi

# Load template based on post type
TEMPLATE_FILE="_templates/${POST_TYPE}.md"
if [ -f "$TEMPLATE_FILE" ]; then
    TEMPLATE_CONTENT=$(cat "$TEMPLATE_FILE")
else
    # Default template
    TEMPLATE_CONTENT="---
layout: post
title: \"TITLE_PLACEHOLDER\"
subtitle: \"\"
tags: []
thumbnail-img: 
share-img: 
---

Write your post content here.

## Section

Content goes here.

---

Think I do cool stuff? Why not [collaborate](../collaborate) with me?"
fi

# Replace placeholders
CONTENT=$(echo "$TEMPLATE_CONTENT" | sed "s/TITLE_PLACEHOLDER/$TITLE/g")

# Add date for published posts
if [ "$IS_DRAFT" = false ]; then
    CONTENT=$(echo "$CONTENT" | sed "s/^---$/---\ndate: $(date +%Y-%m-%d)/")
fi

# Create the file
echo "$CONTENT" > "$FILEPATH"

echo -e "${GREEN}✅ Created: $FILEPATH${NC}"

# Offer to open in editor
if command -v code &> /dev/null; then
    read -p "Open in VS Code? (Y/n): " open_editor
    if [[ ! $open_editor =~ ^[Nn]$ ]]; then
        code "$FILEPATH"
    fi
elif command -v nano &> /dev/null; then
    read -p "Open in nano? (Y/n): " open_editor
    if [[ ! $open_editor =~ ^[Nn]$ ]]; then
        nano "$FILEPATH"
    fi
fi

echo -e "${BLUE}💡 Tips:${NC}"
if [ "$IS_DRAFT" = true ]; then
    echo "  • Preview drafts: bundle exec jekyll serve --drafts"
    echo "  • Publish draft: ./publish-draft.sh ${FILENAME}"
else
    echo "  • Preview: bundle exec jekyll serve"
    echo "  • Deploy: ./deploy.sh"
fi