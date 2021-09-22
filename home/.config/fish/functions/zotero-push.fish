function zotero-push
    rclone sync --fast-list  --checkers 10 --transfers 5 -P ./Zotero/ 1drive:Zotero/
end