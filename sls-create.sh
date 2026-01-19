#!/bin/bash

projectFolder=${1:-NewProject}
templateFolder=$HOME/Templates/serverless-typescript-boiler

echo "📁 Creating serverless project $projectFolder"

# Check if template exists
if [ ! -d "$templateFolder" ]; then
    echo "❌ Template not found"
    exit 1
fi

cp -r $templateFolder "$projectFolder"

echo "✅ Project created"

cd "$projectFolder"
rm -rf .git
git init > /dev/null
echo "# $projectFolder Lambda" > README.md
echo "" >> README.md

echo "✅ Project initialized"

echo "🚀 Project ready to go!"
