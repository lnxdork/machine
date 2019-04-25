ssh-keygen -t rsa -b 4096 -C "lnxdork@gmail.com"
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa

git config --list --show-origin
git config --global user.name "lnxdork"
git config --global user.email "lnxdork@gmail.com"
mkdir test
cd test

git init
touch README.md
touch .gitignore
git add .
git commit -m "First commit"
git remote add origin https://github.com/lnxdork/test.git
git remote -v
git push origin master
git remove remove origin
git remote add origin git@github.com:lnxdork/test.git
