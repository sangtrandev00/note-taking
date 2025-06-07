#!/bin/bash

# NoteTaking Setup Script
# This script helps you set up your organized note-taking environment

echo "🚀 Setting up your organized NoteTaking environment..."

# Check if we're in the right directory
if [ ! -d "obsidian-vault" ] || [ ! -d "jekyll-blog" ]; then
    echo "❌ Error: Please run this script from the NoteTaking root directory"
    exit 1
fi

echo "📁 Folder structure verified!"

# Setup Jekyll blog
echo "🌐 Setting up Jekyll blog..."
cd jekyll-blog

if [ ! -f "Gemfile" ]; then
    echo "❌ Error: Gemfile not found in jekyll-blog directory"
    exit 1
fi

# Install Jekyll dependencies
echo "📦 Installing Jekyll dependencies..."
bundle install

if [ $? -eq 0 ]; then
    echo "✅ Jekyll dependencies installed successfully!"
else
    echo "⚠️  Warning: Some dependencies might not have installed correctly"
fi

cd ..

# Create symbolic links for shared resources (optional)
echo "🔗 Setting up shared resources..."
if [ ! -L "obsidian-vault/attachments/shared-images" ]; then
    ln -s "../../shared/images" "obsidian-vault/attachments/shared-images"
    echo "✅ Created symbolic link for shared images in Obsidian"
fi

if [ ! -L "jekyll-blog/assets/shared-images" ]; then
    ln -s "../../shared/images" "jekyll-blog/assets/shared-images"
    echo "✅ Created symbolic link for shared images in Jekyll"
fi

echo ""
echo "🎉 Setup complete! Your organized NoteTaking environment is ready."
echo ""
echo "📝 Next steps:"
echo "   1. Open Obsidian and select 'obsidian-vault/' as your vault"
echo "   2. To start Jekyll blog: cd jekyll-blog && bundle exec jekyll serve"
echo "   3. Your blog will be available at http://localhost:4000"
echo ""
echo "📖 Check the README.md for detailed usage instructions."
echo "Happy note-taking! 📚✨"

