# GYMSMART
GYMSMART: Don't just gym hard, gym smart

# Setup 

The project is on the master channel of Flutter, by default, Flutter is set to the stable channel.

To change the channel to master run these commands in your terminal
```bash
flutter channel master
flutter upgrade
```

# Adding Changes
**Do Not** commit straight to the main branch unless it is a very small change.

When you want to add a change:
1. through the terminal, vscode, or GitHub desktop, pull origin so that your copy of the project is up to date, do this before making **any** change
2. create a branch and indicate what type of branch it is (feature, hotfix, bugfix, whatever) in the branch name
3. commit any changes to that branch and create branches off that branch if you really want to
4. when whatever you wanted to do on the branch is completed, create a pull request
5. if what you are adding is very small, you can probably just merge, but if is a major addition, we should probably call or at least have somebody else peer review the code so we don't miss anything.

While developing make sure to test and make sure there are no errors in your code to your best ability. Otherwise, good luck.
