@echo off
echo 🚀 Force deploying to RENDER...

echo 📝 Adding all changes...
git add .

echo 💾 Committing changes...
git commit -m "Fix API endpoints for RENDER deployment"

echo 📤 Force pushing to GitHub...
git push origin master --force

echo ✅ Force deployment complete! RENDER will automatically build the new version.
echo 🌐 Check your RENDER dashboard for build status.
pause
