#!/bin/bash

# Define a list of playlist URLs
playlist_urls=(
	" # Enter here your youtube Url in double quotes"
)

# Loop through each playlist URL
for playlist_url in "${playlist_urls[@]}"; do
	# Get the playlist tittle
   	 playlist_title=$(yt-dlp -J --yes-playlist "$playlist_url" | python3 -c "import sys, json; print(json.load(sys.stdin)['title'])")

	# Replace characters that are not allowed in folder names
	safe_playlist_title=$(echo "$playlist_tittle" | tr '/\\:*?<>|' '_')
	# Create subfolders for audio and video inside their respective topp-level folders if they don't exist
	if [ ! -d "audio/${safe_playlist_title}" ]; 
	then
	mkdir -p "audio/${safe_playlist_title}"
	fi

	if [ ! -d "video/${safe_playlist_title}" ];
	then
	mkdir -p "video/${safe_playlist_title}"
	fi

	# Download video files (with max 1080p quality, .mov format, and H.264 video codec and AAC audio codec)
#	yt-dlp --ignore-errors --no-warnings --format "bestvideo[height<=1080]+bestaudio" --merge-output-format mov --output "video/${safe_playlist_title}/%(title)s.%(ext)s" --yes-playlist "$playlist_url" --download-archive "video/${safe-playlist_title}/downloaded_${safe_playlist_title}_video.txt" --postprocessor "FFmpegVideoConvertor" --postprocessor-args "-c:v libx264 -c aac"

	# Download audio files
	yt-dlp --ignore-errors --no-warnings --format bestaudio --extract-audio --audio-format mp3 --audio-quality 160K --output "audio/${safe_playlist_title}/%(title)s.%(ext)s" --yes-playlist "$playlist_url" --download-archive "audio/${safe_playlist_title}/download_${safe_playlist_title}_audio.txt"

done
