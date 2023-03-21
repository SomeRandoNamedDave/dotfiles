function dy --description 'download youtube video from address in clipboard'
    yt-dlp (xclip -selection clipboard -o)
end
