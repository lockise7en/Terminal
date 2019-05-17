Git global setup

git config --global user.name "lockyse7en"
git config --global user.email "lockyse7en@outlook.com"

Create a new repository

git clone ssh://git@192.168.168.3:30001/git/Github.git
cd Github
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master

Existing folder

cd existing_folder
git init
git remote add origin http://192.168.168.3:30000/git/Github.git
git add .
git commit -m "Initial commit"
git push -u origin master

Existing Git repository

cd existing_repo
git remote add origin http://192.168.168.3:30000/git/Github.git
git push -u origin --all
git push -u origin --tags

git push --set-upstream git@gitlab.lockyse7en.com:git/$(git rev-parse --show-toplevel | xargs basename).git $(git rev-parse --abbrev-ref HEAD)

 git push --all  --set-upstream git@gitlab.lockyse7en.com:git/$(git rev-parse --show-toplevel | xargs basename).git
 
git pull --progress -v --no-rebase "origin"
