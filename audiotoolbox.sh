#!/bin/bash

#Audio clipping method originally by Nils Lindemann
#from superuser.com, modified to fit digital capture. 

flacrip(){
	artist="${1:-Unknown}"
	title="${2:-Unknown}"
	album="${3:-Unknown}"
	filename="$artist - $title.flac"
	echo -e "\e[1;36mPlease select a capture device:\e[0m"
	pactl list sources short
	read deviceId;
	echo -e "\e[1;33mPreparing to rip:\n$filename"
	echo -e "\e[1;31m[!] Press Q to end capturing [!]\e[0m"
	echo -e "\e[1;36mPlease wait...\e[0m"
	pactl unload-module module-suspend-on-idle
	sleep 1
	ffmpeg -hide_banner -f pulse -ar 44100 -sample_fmt s16 -i $deviceId "temp.wav"
	pactl load-module module-suspend-on-idle	
	ffmpeg -hide_banner -i "temp.wav"\
	-af silenceremove=start_periods=1:start_silence=0.1:start_threshold=0,areverse,silenceremove=start_periods=1:start_silence=0.1:start_threshold=0,areverse\
	-metadata title="$title" -metadata artist="$artist" -metadata album="$album" -metadata album_artist="$artist" -sample_fmt s16 "$filename"
	rm temp.wav
	echo -e "\e[1;32mRip complete! Saved file:\e[0m\n\e[1;33m$filename\e[0m"
}

mp3ify(){
	ffmpeg -hide_banner -i "$1" -codec:a libmp3lame -qscale:a ${2:-0} "${1%%.*}.mp3"
}

audioclip(){
	mv "$1" "temp_$1"
	ffmpeg -hide_banner -i "temp_$1"\
	-af silenceremove=start_periods=1:start_silence=0.1:start_threshold=0,areverse,silenceremove=start_periods=1:start_silence=0.1:start_threshold=0,areverse\
	-sample_fmt s16 "$1"
	rm "temp_$1"
}

flacer(){
	ffmpeg -hide_banner -i "$1" -c:a flac -af aformat=s16:44100 "${1%.*}.flac"
	if [[ -f $NAME.flac ]]; then
	echo -e "\e[1;33mConversion complete: "${1%.*}.flac" in $PWD\e[0m"
	fi
}

flactag(){
	filePath="${1:-Unknown}"
	if test -f "$filePath"; then
	picturePath="${2:-Unknown}"
	echo -e "\e[1;33mRemoving old metadata...\e[0m"
	metaflac --remove-all "$filePath"
	echo -e "\e[1;33mSet new tags:\e[0m"
	echo -e "Artist:"
	read artist
	echo -e "Title:"
	read title
	echo -e "Album:"
	read album
	metaflac --set-tag ARTIST="$artist" "$filePath"
	metaflac --set-tag=TITLE="$title" "$filePath"
	metaflac --set-tag=ALBUM="$album" "$filePath"
	mv "$filePath" "./$artist - $title.flac"
	if ! [ -z "$2" ]; then
	if test -f "$picturePath"; then
	metaflac --import-picture-from="./$picturePath" "./$artist - $title.flac"
	else
	echo -e "\e[1;31mGiven image file does not exsist!\e[0m"
	fi
	fi
	echo -e "\e[1;32mNew tags set! Saved file:\e[0m\n\e[1;33m$artist - $title \e[0m"
	else
	echo -e "\e[1;31mGiven .flac file does not exsist!\e[0m"
	fi
}
