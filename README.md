# nbhansen.dk - Personal Academic Website

This is the source code for [nbhansen.dk](https://nbhansen.dk), a Jekyll-based academic website for HCI and Participatory Design researcher Nicolai Brodersen Hansen.

## Quick Start

### Development
```bash
# Start local development server
./blog-helper.sh serve

# Create new post
./new-post.sh "My Post Title"

# Deploy to production
./deploy.sh
```

### Workflow Overview
See [WORKFLOW.md](WORKFLOW.md) for a visual diagram of how the entire blogging system works.

## Features

✅ **Enhanced Content Creation Workflow**  
✅ **Modern Jekyll 4.4.1** with Ruby 3.4+ compatibility  
✅ **Beautiful Jekyll 6.0.1** theme  
✅ **Automated FTP deployment** to webhosting.dk  
✅ **Draft system** for work-in-progress posts  
✅ **Smart post templates** for different content types  
✅ **Image optimization** with automatic resizing  

## Content Creation

### Creating Posts

**Quick post creation:**
```bash
./new-post.sh "Post Title"                    # Published post
./new-post.sh "Draft Title" --draft           # Draft post
./new-post.sh "Paper Title" --type=paper      # Use paper template
```

**Available templates:**
- `general` - Default blog post
- `paper` - Research paper announcements
- `conference` - Conference experiences
- `teaching` - Course and teaching content
- `project` - Research project updates

### Working with Drafts

```bash
# Preview drafts locally
bundle exec jekyll serve --drafts

# Publish a draft
./publish-draft.sh draft-filename.md
```

### Helper Commands

```bash
./blog-helper.sh                    # Show all available commands
./blog-helper.sh new                # Interactive post creation
./blog-helper.sh serve              # Start development server
./blog-helper.sh drafts             # Serve with drafts included
./blog-helper.sh status             # Show blog statistics
./blog-helper.sh deploy             # Deploy to production
```

## Image Management

**Optimize images for web:**
```bash
./optimize-image.sh photo.jpg                 # Optimize for web
./optimize-image.sh photo.jpg --thumbnail     # Create thumbnail too
```

Images are automatically:
- Resized to max 1200px width
- Compressed to 85% quality
- Stripped of metadata
- Given web-friendly markdown snippets

## Development

### Local Development
```bash
# Install dependencies
bundle install

# Start development server
bundle exec jekyll serve
# Available at http://localhost:4000

# Build for production
bundle exec jekyll build
```

### Project Structure

```
├── _posts/           # Published blog posts
├── _drafts/          # Work-in-progress posts
├── _templates/       # Post templates by type
├── assets/img/       # Optimized images
├── IDEAS.md          # Content planning
├── new-post.sh       # Post creation script
├── publish-draft.sh  # Draft publishing
├── deploy.sh         # Production deployment
├── blog-helper.sh    # Command shortcuts
└── optimize-image.sh # Image optimization
```

## Deployment

**One-command deployment to nbhansen.dk:**
```bash
./deploy.sh
```

The deployment script:
1. Builds the Jekyll site
2. Prompts for FTP credentials (stored securely in `.env`)
3. Uploads via FTP to webhosting.dk
4. Syncs all changes

### First-time Deployment Setup
1. Copy `.env.example` to `.env`
2. Add your webhosting.dk FTP credentials to `.env`
3. Run `./deploy.sh`

## Content Planning

Use `IDEAS.md` for capturing post ideas and content planning. The file includes:
- Content type suggestions
- Monthly theme ideas
- Recurring content patterns

## Tech Stack

- **Jekyll 4.4.1** - Static site generator
- **Beautiful Jekyll 6.0.1** - Theme
- **Ruby 3.4.2** - Runtime environment
- **lftp** - FTP deployment
- **ImageMagick** - Image optimization (optional)

## Support

- **Local docs**: See `CLAUDE.md` for detailed technical documentation
- **Jekyll docs**: [jekyllrb.com](https://jekyllrb.com/)
- **Theme docs**: [beautifuljekyll.com](https://beautifuljekyll.com/)

---

This enhanced Jekyll setup removes friction from academic blogging, making it easy to share research updates, teaching experiences, and professional insights.