# Drafts Folder

This folder contains work-in-progress blog posts that aren't ready for publication yet.

## Usage

- Add draft posts here (no date prefix needed)
- Preview drafts locally: `bundle exec jekyll serve --drafts`
- Move to `_posts/` with proper date when ready to publish

## Draft Workflow

1. **Create draft**: `./new-post.sh "Title" --draft`
2. **Preview locally**: `bundle exec jekyll serve --drafts`
3. **Publish**: `./publish-draft.sh draft-filename.md`