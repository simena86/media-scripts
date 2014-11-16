#!/bin/sh

# script to download subtitle and rename 
# files after completed download
# dependencies:
#	-filebot

logfile=~/media/.media-scripts/dl_log.txt
echo "Downloaded file: " $TR_TORRENT_NAME " In dir: " $TR_TORRENT_DIR \ 
		 " Downloaded at time: " $TR_TIME_LOCALTIME >> $logfile


filename=$TR_TORRENT_NAME
dir=$TR_TORRENT_DIR
cd $dir

#check if directory or file
if [ -d "${filename}" ] ; then
    echo "$filename is a directory" >> $logfile;
	cd "$dir/$filename"
	echo "entering dir: "$dir/$filename >> $logfile
	movie_file=$(ls * | grep 'mp4\|mkv\|avi\|mpg')
 # get subtitles
	filebot -get-subtitles $movie_file --lang en --output srt --encoding utf8 -non-strict >> $logfile
 # get subtitle without extension eng.srt
	filename_no_ext="${movie_file%.*}"
	temp="$filename_no_ext*"	
 # rename
	filebot -rename $temp -non-strict
else
    if [ -f "${filename}" ]; then
	     # get subtitles
        echo "${filename} is a file" >> $logfile; filebot -get-subtitles $filename --lang en --output srt --encoding utf8 -non-strict >> $logfile
	 # get subtitle without extension eng.srt
		filename_no_ext="${filename%.*}"
		temp="$filename_no_ext*"	
	 # rename
		filebot -rename $temp -non-strict
    else
        echo "${filename} is not valid" >> $logfile;
        exit 1
    fi
fi

