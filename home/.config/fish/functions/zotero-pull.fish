function zotero-pull
    rclone sync -P 1drive:Zotero/ $HOME/Zotero/
end