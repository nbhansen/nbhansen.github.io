# Blog Workflow Overview

This diagram shows how the enhanced Jekyll blogging setup works from idea to published post:

```mermaid
graph TD
    A[Blog Post Idea] --> B{Create Post}
    B --> C[new-post.sh]
    C --> D{Post Type?}
    D --> E[General Template]
    D --> F[Paper Template]
    D --> G[Conference Template]
    D --> H[Teaching Template]
    D --> I[Project Template]
    
    E --> J[drafts folder]
    F --> J
    G --> J
    H --> J
    I --> J
    
    J --> K[Write Content]
    K --> L{Add Images?}
    L -->|Yes| M[optimize-image.sh]
    M --> N[assets/img]
    L -->|No| O[Preview Drafts]
    N --> O
    
    O --> P[jekyll serve --drafts]
    P --> Q{Ready to Publish?}
    Q -->|No| K
    Q -->|Yes| R[publish-draft.sh]
    R --> S[posts folder]
    
    S --> T[Deploy]
    T --> U[deploy.sh]
    U --> V[jekyll build]
    V --> W[site folder]
    W --> X[FTP Upload]
    X --> Y[nbhansen.dk]
    
    Z[blog-helper.sh] --> AA[Quick Commands]
    AA --> C
    AA --> O
    AA --> T
```

## Workflow Sections

### Content Creation (Blue)
From initial idea through template selection to draft creation. The `new-post.sh` script handles all the technical details.

### Draft Workflow (Purple) 
Writing, editing, and previewing content. Includes image optimization and draft preview capabilities.

### Production Pipeline (Green)
Publishing drafts and deploying to the live website via automated FTP upload.

### Supporting Tools (Orange)
Helper scripts, content planning, and configuration files that support the entire workflow.

## Key Benefits

- **One command** from idea to draft: `./new-post.sh "Title"`
- **Visual preview** with drafts: `bundle exec jekyll serve --drafts`
- **One command** deployment: `./deploy.sh`
- **No manual file management** - scripts handle naming, dates, front matter
- **Template-driven** content creation for consistency