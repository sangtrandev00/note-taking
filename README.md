# NoteTaking - Organized Knowledge Base

This repository contains a well-organized personal knowledge management system combining Obsidian vault and Jekyll blog.

## 📁 Folder Structure

```
NoteTaking/
├── obsidian-vault/           # 🧠 Obsidian Knowledge Base
│   ├── .obsidian/           # Obsidian configuration
│   ├── daily-notes/         # Daily notes and journaling
│   ├── evergreen/           # Permanent notes and concepts
│   ├── concepts/            # Study materials (formerly Notion content)
│   ├── work/                # Work-related notes
│   ├── attachments/         # Images, PDFs, etc.
│   ├── templates/           # Note templates
│   ├── Excalidraw/          # Drawing and diagrams
│   ├── MOC/                 # Maps of Content
│   ├── MyBlog/              # Blog ideas and drafts
│   └── copilot-custom-prompts/ # AI prompts
├── jekyll-blog/             # 🌐 Jekyll Website
│   ├── _posts/              # Published blog posts
│   ├── _site/               # Generated website
│   ├── assets/              # Site assets (CSS, JS, images)
│   ├── _config.yml          # Jekyll configuration
│   ├── Gemfile              # Ruby dependencies
│   └── [other Jekyll files] # Pages and layouts
└── shared/                  # 🔗 Shared Resources
    ├── images/              # Shared images
    └── docs/                # Shared documents (PDFs, etc.)
```

## 🚀 Getting Started

### Obsidian Vault
1. Open Obsidian
2. Open the `obsidian-vault/` folder as your vault
3. Your notes, daily notes, and knowledge base are all organized here

### Jekyll Blog
1. Navigate to the `jekyll-blog/` directory
2. Run `bundle install` to install dependencies
3. Run `bundle exec jekyll serve` to start the development server
4. Access your blog at `http://localhost:4000`

## 📝 Workflow

1. **Note-taking**: Use Obsidian for personal notes, daily journaling, and knowledge management
2. **Content creation**: Draft blog posts in Obsidian (`MyBlog/` folder)
3. **Publishing**: Move refined content from Obsidian to Jekyll `_posts/` for publishing
4. **Shared resources**: Use the `shared/` folder for assets used by both systems

## 🎯 Benefits of This Structure

- ✅ **Clear separation** between private notes and public content
- ✅ **Easy tracking** with organized folders
- ✅ **Better workflow** from note-taking to publishing
- ✅ **Cleaner repository** with appropriate `.gitignore` rules
- ✅ **Flexible** - work in either system independently

## 🖼️ Image Management

### **Global Image Storage**
All images are now stored in `shared/images/` and accessible from both systems:

- **📍 Source Location:** `shared/images/` (237 Obsidian images)
- **🔗 Jekyll Access:** `jekyll-blog/assets/images/obsidian → ../../../shared/images`
- **🔗 Obsidian Access:** `obsidian-vault/attachments/images → ../../shared/images`

### **Path References**
- **In Jekyll posts:** Use `/assets/images/obsidian/filename.png`
- **In Obsidian notes:** Use `attachments/images/filename.png`
- **Single source of truth:** All images stored once in `shared/images/`

### **Benefits**
✅ **No image duplication** - saves disk space  
✅ **Consistent paths** - works across both systems  
✅ **Easy maintenance** - manage images in one location  
✅ **Automatic sync** - changes reflected everywhere  

## 🔧 Customization

Feel free to adjust the folder structure to match your specific needs. The key is maintaining the separation between Obsidian vault content and Jekyll blog content while using symbolic links for shared resources.

