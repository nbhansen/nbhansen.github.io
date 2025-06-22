# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Jekyll-based personal academic website using the Beautiful Jekyll theme. The site is hosted on GitHub Pages and serves as a portfolio for an HCI and Participatory Design researcher (nbhansen.dk).

## Development Commands

### Local Development
```bash
# Install dependencies
bundle install

# Serve the site locally for development
bundle exec jekyll serve

# Build the site
bundle exec jekyll build

# Build and serve with draft posts
bundle exec jekyll serve --drafts
```

### Content Creation Workflow
```bash
# Create new posts with templates
./new-post.sh "Post Title"                    # Published post
./new-post.sh "Draft Title" --draft           # Draft post
./new-post.sh "Paper Title" --type=paper      # Paper template

# Work with drafts
bundle exec jekyll serve --drafts             # Preview drafts
./publish-draft.sh draft-filename.md          # Publish draft

# Helper commands
./blog-helper.sh                              # Show all commands
./blog-helper.sh new                          # Interactive post creation
./blog-helper.sh serve                        # Start dev server
./blog-helper.sh status                       # Show blog stats
```

### Image Optimization
```bash
# Optimize images for web
./optimize-image.sh photo.jpg                 # Optimize image
./optimize-image.sh photo.jpg --thumbnail     # Create thumbnail too
```

### Production Deployment
```bash
# Deploy to nbhansen.dk via FTP
./deploy.sh
```

## Architecture and Structure

### Jekyll Configuration
- **_config.yml**: Main configuration file containing site settings, theme customization, navigation, and social links
- **Gemfile**: Ruby dependencies including Jekyll 3.9 and required plugins
- **beautiful-jekyll-theme.gemspec**: Theme specification with runtime dependencies

### Content Structure
- **_posts/**: Published blog posts in markdown format following `YYYY-MM-DD-title.md` naming convention
- **_drafts/**: Work-in-progress posts (no date prefix needed)
- **_templates/**: Post templates for different content types (paper, conference, teaching, project, general)
- **_layouts/**: HTML templates (post.html, page.html, base.html, etc.)
- **_includes/**: Reusable HTML components (header.html, footer.html, comments.html, etc.)
- **_data/**: YAML data files (ui-text.yml for internationalization)
- **assets/**: Static assets including CSS, JavaScript, and images
- **_site/**: Generated site (excluded from version control)
- **IDEAS.md**: Content planning and post ideas

### Page Types
- **Posts**: Blog entries with YAML front matter, tags, social sharing, and pagination
- **Pages**: Static pages (aboutme.md, projects.md, publications.md, teaching.md, collaborate.md)
- **Index**: Homepage with post feed

### Theme Customization
The site uses custom colors defined in `_config.yml`:
- Dark theme with navbar (#1C1D1F), yellow accents (#EACD00), and light text (#F6F2ED)
- Custom social network links including Bluesky, Mastodon, ORCID, and GitHub
- No avatar/logo configured

### Key Features
- Responsive design with Bootstrap
- Social media sharing buttons
- Tag system for posts
- Comment system support (currently disabled)
- SEO optimization with jekyll-sitemap
- Analytics ready (Google Analytics, Cloudflare Analytics)

## Content Management

### Adding New Posts
Create files in `_posts/` with format `YYYY-MM-DD-title.md` and include YAML front matter:
```yaml
---
layout: post
title: Post Title
subtitle: Post Subtitle
tags: [tag1, tag2]
thumbnail-img: /assets/img/image.jpg
---
```

### Adding New Pages
Create markdown files in root directory with YAML front matter:
```yaml
---
layout: page
title: Page Title
subtitle: Page Subtitle
---
```

### Image Management
Images are stored in `assets/img/` and referenced using relative paths like `/assets/img/filename.jpg`.

## Development Notes

- The site uses Jekyll 3.9.x (older version for GitHub Pages compatibility)
- Kramdown markdown processor with GFM input
- Rouge syntax highlighter
- Pagination set to 5 posts per page
- Timezone set to "America/Toronto"
- Posts automatically include comments and social sharing unless disabled per-post