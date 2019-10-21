# Version Control with Git & GitHub

## Introduction

- what is version control?
- why should I use it?
- what is git?
- what is GitHub?

## GitHub

- look at an example repo
    - e.g. https://github.com/tobyhodges/software-carpentry-embl-2018
    - basic structure of 'front page' - list of files, README rendered, commit messages, last modified time, contributors
    - look at graph of history, branches, commit messages and codes
    - open an example file, use blame to look at when a line was added/most recently changed, and by whom
- create your own repository
    - look at README
    - edit README, quick intro to Markdown
    - commit messages - what they are; advice for writing good ones
    - look at history
    - repeat steps above
    - add a new file (python script), commit, look at result
- discuss limitations of online-only approach
    - how can we be sure that our script is doing what we intend?
    - would like to make changes, test, then update the material online when we're sure that it's ready
- now switch to the command line

## Command Line

- navigate to relevant directory
- clone repo
- change global settings
  - `git config --global user.name "user name"`
  - `git config --global user.email username@host.com`
  - `git config --global core.editor "nano -w"`
- mention `git init`
- `git status`
- `git add`
- `git status`
- `git commit`
  - commit messages
  - imagine your future self as a collaborator, who won't know (remember) why you made the changes you're making
- `git status`
- `git add`
- `git commit -m`
- `git log`
  - `git log -1`
  - `git log --oneline`
  - `git log --oneline --graph --all --decorate`
- `git diff`
  - `git add` + `git diff --staged`
  - `git diff --color-words`
  - `git diff <commithash> <filename>`
  - `git diff HEAD~2 <filename>`
- `git checkout HEAD` to revert to most recent committed state
  - `git checkout HEAD <filename>` to achieve the same thing with a single file
- detached head!
  - `git checkout <commithash>` (forgetting filename)
  - `git checkout master` to recover from this
- `.gitignore`
- remotes
  - `git remote`
  - `git push origin master`
  - make a change on GitLab
  - `git pull origin master`

## GitHub + Command Line - Collaboration Exercises

- pair up learners
    - A & B
- slides - collaborating on same repository exercise
    - A adds B to their repository
    - B clones A's repository
    - B makes some changes, commits, pushes, while __A does nothing__
    - now, A pulls changes from B
- swap roles, repeat
- if time, repeat with both working simultaneously on different files
- slides - merge conflict exercise
    - A and B both change the same file in A's project
    - B pushes before A
    - A tries to push
        - if didn't already cover rejected push, talk through error message now
        - else, move straight onto pulling and merge conflict message
    - `git status`
    - `less file_with_conflicts`
    - explain pattern of conflict
    - A fixes conflict, commits, pushes, B pulls
- swap roles, repeat
