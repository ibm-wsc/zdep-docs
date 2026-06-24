#!/bin/bash
set -e

echo "🔨 Building public documentation..."
npm run build:public

echo "📦 Copying to public repo..."
cp -r .docs-engine/out/* ../zdep-docs/

echo "🚀 Deploying to public repo..."
cd ../zdep-docs
git add .
git commit -m "Deploy: $(date '+%Y-%m-%d %H:%M:%S')"
git push origin main

echo ""
echo "✅ Done! Deployment initiated."
echo ""
echo "📍 Check deployment status: https://github.com/ibm-wsc/zdep-docs/actions"
echo "🌐 Site will be live at: https://ibm-wsc.github.io/zdep-docs/"
echo ""
echo "⏱️  Deployment usually takes 2-3 minutes to complete."

# Made with Bob
