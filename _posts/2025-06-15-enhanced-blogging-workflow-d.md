---
date: 2025-06-15
layout: post
title: "Enhanced blogging workflow :D"
subtitle: ""
tags: []
thumbnail-img: /assets/img/blogging-workflow.jpg 
share-img: 
---
Aided by anthropics Claude, I finally managed to cut through the clutter of [Jekyll](https://jekyllrb.com/) and actually setup a workflow for running this site like I want. Very simply, the actual code can be seen on my [Github](https://github.com/nbhansen/nbhansen.github.io). In a nutshell its just a Jekyll server running locally that with the aid of a bunch of smaller linux scripts allows me to use VSCode (or any other markdown editor basically) to remove all friction from writing posts - **technical friction that is** - I sadly still have to write the actual posts but lets see now my blood is up. 


## The magic (?!?)
Its not REALLY magic but okay basically there are five bash scripts for a range of blog-related activities, like creating new posts from a markdown template, formatting images the right way, and accessing and uploading to the ftp-server at the venerable danish hosting company [www.webhosting.dk](https://www.webhosting.dk). 

Here's how the whole workflow works:

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

### Key Benefits

- **One command** from idea to draft: `./new-post.sh "Title"`
- **Visual preview** with drafts: `bundle exec jekyll serve --drafts`
- **One command** deployment: `./deploy.sh`
- **No manual file management** - scripts handle naming, dates, front matter
- **Template-driven** content creation for consistency

## so uhm... why not wordpress or something else?
Well, I am a giant nerd, is the first reason. Second, I love the idea of my site here consisting ONLY OF STATIC HTML/CSS/JAVASCRIPT i mean... its so fast right. Thats why. 

---

Think I do cool stuff? Why not [collaborate](../collaborate) with me?
