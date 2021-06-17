# Malicious
## Rewrite email address
<https://stackoverflow.com/questions/2919878/git-rewrite-previous-commit-usernames-and-emails>
``` bashl
git filter-branch --commit-filter '
      if [ "$GIT_AUTHOR_EMAIL" = "example@example.com" ];
      then
              GIT_AUTHOR_NAME="shenlebantongying";
              GIT_AUTHOR_EMAIL="shenlebantongying@gmail.com";
              git commit-tree "$@";
      else
              git commit-tree "$@";
      fi' HEAD
```