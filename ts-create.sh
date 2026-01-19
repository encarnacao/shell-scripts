#!/bin/bash

projectFolder=${1:-NewProject}
templateFolder=$HOME/Templates/serverless-typescript-boiler

# This Script is used to create a new TypeScript project with the template on $HOME/Templates/typescript-blank-project/

echo "📁 Creating project $projectFolder"

# Check if template exists
if [ ! -d "$templateFolder" ]; then
    echo "❌ Template not found"
    exit 1
fi

cp -r "$templateFolder" "$projectFolder"

# Change directory to project folder
cd "$projectFolder"

# Start git repository
git init > /dev/null
echo "✅ Git repository initialized"

# Success message
echo "✅ Project created successfully"
