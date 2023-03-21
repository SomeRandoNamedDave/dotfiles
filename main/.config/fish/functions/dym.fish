function dym --description 'download youtube video from address in clipboard as an mp3'
    yt-dlp --ignore-config --no-playlist \
        -f 'ba' -x --audio-format mp3 --audio-quality 0 \
        --embed-thumbnail --embed-metadata \
        --ppa "EmbedThumbnail+ffmpeg_o:-c:v mjpeg -vf crop=\"'if(gt(ih,iw),iw,ih)':'if(gt(iw,ih),ih,iw)'\"" \
        -o '~/music/TBS/yt-dlp/%(title)s.%(ext)s' \
        (xclip -selection clipboard -o)
end
