#!/bin/bash


### FUNCTIONS ###
jpg(){ find $i -maxdepth 1 -name "*.[jJ][pP][gG]" -print; }
mv_jpg(){ find $i -maxdepth 1 -name "*.[jJ][pP][gG]" -exec mv '{}' $pict_down \;
}

png(){ find $i -maxdepth 1 -name "*.[pP][nN][gG]" -print; }
mv_png(){ find $i -maxdepth 1 -name "*.[pP][nN][gG]" -exec mv '{}' $pict_down \;
}

pdf(){ find $i -maxdepth 1 -name "*.[pP][dD][fF]" -print; }
mv_pdf(){ find $i -maxdepth 1 -name "*.[pP][dD][fF]" -exec mv '{}' $doc_down \;
}

mpg(){ find $i -maxdepth 1 -name "*.[mM][pP][gG]" -print; }
mv_mpg(){ find $i -maxdepth 1 -name "*.[mM][pP][gG]" -exec mv '{}' $vid_down \;
}

mpeg(){ find $i -maxdepth 1 -name "*.[mM][pP][eE][gG]" -print; }
mv_mpeg(){ find $i -maxdepth 1 -name "*.[mM][pP][eE][gG]" -exec mv '{}' $vid_down \;
}

avi(){ find $i -maxdepth 1 -name "*.[aA][vV][iI]" -print; }
mv_avi(){ find $i -maxdepth 1 -name "*.[aA][vV][iI]" -exec mv '{}' $vid_down \;
}

mp3(){ find $i -maxdepth 1 -name "*.[mM][pP]3" -print; }
mv_mp3(){ find $i -maxdepth 1 -name "*.[mM][pP]3" -exec mv '{}' $music_down \;
}

flac(){ find $i -maxdepth 1 -name "*.[fF][lL][aA][cC]" -print; }
mv_flac(){ find $i -maxdepth 1 -name "*.[fF][lL][aA][cC]" -exec mv '{}' $music_down \;
}

wav(){ find $i -maxdepth 1 -name "*.[wW][aA][vV]" -print; }
mv_wav(){ find $i -maxdepth 1 -name "*.[wW][aA][vV]" -exec mv '{}' $music_down \;
}

doc(){ find $i -maxdepth 1 -name "*.[dD][oO][cC]" -print; }
mv_doc(){ find $i -maxdepth 1 -name "*.[dD][oO][cC]" -exec mv '{}' $doc_down \;
}

docx(){ find $i -maxdepth 1 -name "*.[dD][oO][cC]" -print; }
mv_docx(){ find $i -maxdepth 1 -name "*.[dD][oO][cC][xX]" -exec '{}' $doc_down \;
}

flv(){ find $i -maxdepth 1 -name "*.[fF][lL][vV]" -print; }
mv_flv(){ find $i -maxdepth 1 -name "*.[fF][lL][vV]" -exec mv '{}' $vid_down \;
}


### SCRIPT ###
script_print(){
for i in $LIST; do
        for j in $ALEGERE; do
                $j;
        done;
done;
}


### MOVE SCRIPT ###
script_mv(){
for i in $LIST; do
        for j in $ALEGERE; do
               mv_$j;
        done;
done;
}

### VARIABILES ###
dow=$HOME/Downloads
pict=$HOME/Pictures
pict_down=$HOME/Pictures/Downloads
music=$HOME/Music
music_down=$HOME/Music/Downloads
doc=$HOME/Documents
doc_down=$HOME/Documents/Downloads
vid=$HOME/Videos
vid_down=$HOME/Videos/Downloads
LIST=$(echo {$dow,$pict,$music,$doc,$vid})
ALEGERE=''
finished=0

### DIRECTORY CREATION ###
if [ ! -d "$pict_down" ]; then
	mkdir "$pict_down";
fi;

if [ ! -d "$music_down" ]; then
	mkdir "$music_down";
fi;

if [ ! -d "$doc_down" ]; then
	mkdir "$doc_down";
fi;

if [ ! -d "$vid_down" ]; then
	mkdir "$vid_down";
fi;


### ZENITY ###
zenity_choose(){
zenity_ans=$(zenity  --list  --text "What file types do you want to move?" --checklist  --column "Pick" --column "File types" \
FALSE "jpg" \
FALSE "png" \
FALSE "pdf" \
FALSE "mp3" \
FLASE "doc" \
FALSE "docx" \
FALSE "mpeg" \
FALSE "mpg" \
FALSE "flac" \
FLASE "flv" \
FALSE "wav" --separator=":");
ALEGERE=$(echo $zenity_ans | sed 's/:/\ /g');
}


### ZENITY LOOP ###
zenity_loop(){
while [ $finished != 1 ]; do
zenity_choose
	if [ -z "$ALEGERE" ];
		then
			if $(zenity --question --text="Continue cleaning" );then
				until [ -n "$ALEGERE" ]; do
				zenity_choose;
				done;
			else exit;
			fi;
	else script_print;
	fi;
if $(zenity --question --text="The files listed above will be moved. Proceed?" ); then
	script_mv;
	if $(zenity --question --text "Continue cleanup?"); then 
	finished=0;
		else exit;
	fi;

	else
		if $(zenity --question --text "Continue cleanup?"); then 
			finished=0;
			else exit;
		fi;
	
fi;
done;
}


### ZENITY CHECK ###
main(){
if [ -e /usr/bin/zenity ]; then
	zenity_loop;
	else echo "You need to install Zenity for this script to work."; exit;
fi;
}


### MAIN PROGRAM ###
main;
