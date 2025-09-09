@echo off
echo 🚀 Deploying to RENDER...

echo 📝 Adding changes to Git...
git add .

echo 💾 Committing changes...
git commit -m "Fix API endpoints for RENDER deployment"

echo 📤 Pushing to GitHub...
git push origin main

echo ✅ Deployment complete! RENDER will automatically build the new version.
echo 🌐 Check your RENDER dashboard for build status.
pause
