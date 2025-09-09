@echo off
echo 🔧 Fixing Git and deploying to RENDER...

echo 📥 Pulling latest changes from GitHub...
git pull origin master

echo 📝 Adding local changes...
git add .

echo 💾 Committing changes...
git commit -m "Fix API endpoints for RENDER deployment"

echo 📤 Pushing to GitHub...
git push origin master

echo ✅ Deployment complete! RENDER will automatically build the new version.
echo 🌐 Check your RENDER dashboard for build status.
pause
