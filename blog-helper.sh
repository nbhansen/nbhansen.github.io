#!/bin/bash

# Blog helper script - quick commands for common tasks
# Usage: ./blog-helper.sh [command]

GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

show_help() {
    echo -e "${BLUE}📝 Blog Helper Commands${NC}"
    echo ""
    echo "Content Creation:"
    echo "  ./blog-helper.sh new         - Create new post"
    echo "  ./blog-helper.sh draft       - Create draft post"
    echo "  ./blog-helper.sh ideas       - Open ideas file"
    echo ""
    echo "Development:"
    echo "  ./blog-helper.sh serve       - Start development server"
    echo "  ./blog-helper.sh drafts      - Serve with drafts"
    echo "  ./blog-helper.sh build       - Build site"
    echo ""
    echo "Publishing:"
    echo "  ./blog-helper.sh publish     - Publish a draft"
    echo "  ./blog-helper.sh deploy      - Deploy to production"
    echo ""
    echo "Utilities:"
    echo "  ./blog-helper.sh status      - Show blog status"
    echo "  ./blog-helper.sh image       - Optimize image"
    echo "  ./blog-helper.sh clean       - Clean build files"
}

case "$1" in
    "new")
        ./new-post.sh
        ;;
    "draft")
        ./new-post.sh --draft
        ;;
    "ideas")
        if command -v code &> /dev/null; then
            code IDEAS.md
        else
            nano IDEAS.md
        fi
        ;;
    "serve")
        echo -e "${BLUE}🚀 Starting development server...${NC}"
        bundle exec jekyll serve
        ;;
    "drafts")
        echo -e "${BLUE}🚀 Starting server with drafts...${NC}"
        bundle exec jekyll serve --drafts
        ;;
    "build")
        echo -e "${BLUE}📦 Building site...${NC}"
        bundle exec jekyll build
        ;;
    "publish")
        ./publish-draft.sh
        ;;
    "deploy")
        ./deploy.sh
        ;;
    "status")
        echo -e "${BLUE}📊 Blog Status${NC}"
        echo ""
        echo "Published posts: $(ls -1 _posts/*.md 2>/dev/null | wc -l)"
        echo "Draft posts: $(ls -1 _drafts/*.md 2>/dev/null | wc -l)"
        echo ""
        if [ -d "_site" ]; then
            echo -e "${GREEN}✅ Site built${NC}"
        else
            echo -e "${YELLOW}⚠️  Site not built${NC}"
        fi
        ;;
    "image")
        if [ -z "$2" ]; then
            echo "Usage: ./blog-helper.sh image <filename>"
        else
            ./optimize-image.sh "$2"
        fi
        ;;
    "clean")
        echo -e "${YELLOW}🧹 Cleaning build files...${NC}"
        rm -rf _site .sass-cache .jekyll-cache
        echo -e "${GREEN}✅ Clean complete${NC}"
        ;;
    *)
        show_help
        ;;
esac