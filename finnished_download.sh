#!/bin/sh

logfile=~/media/.media-scripts/dl_log.txt
echo "Downloaded file: " $TR_TORRENT_NAME " In dir: " $TR_TORRENT_DIR " Downloaded at time: " $TR_TIME_LOCALTIME >> $logfile
filename=$TR_TORRENT_NAME
dir=$TR_TORRENT_DIR
cd $dir

#check if directory or file
if [ -d "${filename}" ] ; then
    echo "$filename is a directory" $logfile;
else
    if [ -f "${filename}" ]; then

		# get subtitles
        echo "${filename} is a file" >> $logfile;
		filebot -get-subtitles $filename --lang en --output srt --encoding utf8 -non-strict >> $logfile

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


