#!/bin/bash

# Test script for GitHub Actions workflows

echo "GitHub Actions Testing Guide"
echo "============================"
echo ""

echo "1. Manual Testing on GitHub:"
echo "   a) Push this code to your repository"
echo "   b) Go to Actions tab on GitHub"
echo "   c) Select 'Mathlib Type Checker Sentinel' workflow"
echo "   d) Click 'Run workflow' and enter a mathlib tag (e.g., 'v4.0.0')"
echo ""

echo "2. Test the monitoring workflow:"
echo "   - Go to 'Monitor Mathlib Tags' workflow"
echo "   - Click 'Run workflow' to trigger it manually"
echo ""

echo "3. Test minimal workflow first:"
echo "   - Go to 'Test Minimal Workflow'"
echo "   - Click 'Run workflow'"
echo "   - This tests individual components without running the full pipeline"
echo ""

echo "4. Local simulation test:"
echo "   This script simulates what the monitoring workflow would do:"
echo ""

# Simulate the tag checking logic
echo "Simulating tag check..."
LATEST_TAG=$(curl -s https://api.github.com/repos/leanprover-community/mathlib4/tags | jq -r '.[0].name' 2>/dev/null)

if [ $? -eq 0 ] && [ -n "$LATEST_TAG" ]; then
    echo "Latest mathlib4 tag: $LATEST_TAG"
    
    if [ -f .last_processed_tag ]; then
        LAST_PROCESSED=$(cat .last_processed_tag)
        echo "Last processed tag: $LAST_PROCESSED"
        
        if [ "$LATEST_TAG" = "$LAST_PROCESSED" ]; then
            echo "No new tags to process"
        else
            echo "New tag found! Would trigger workflow for: $LATEST_TAG"
        fi
    else
        echo "No previous tag record found"
        echo "Would trigger workflow for: $LATEST_TAG"
    fi
else
    echo "Error: Could not fetch tags from mathlib4"
    echo "Make sure you have 'curl' and 'jq' installed"
fi

echo ""
echo "5. Testing tips:"
echo "   - Start with the 'Test Minimal Workflow' to verify components work"
echo "   - Use workflow_dispatch to test specific tags"
echo "   - Check the Actions tab for logs and errors"
echo "   - Test with a recent mathlib tag first (check https://github.com/leanprover-community/mathlib4/tags)"
echo "   - Monitor the workflow run time - full mathlib builds can take a while"