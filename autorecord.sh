#Variables

#--------------------------
echo "Hi!"
sleep 0.5
echo "-------"
echo "Please specify the filename of the record."
read filename
sleep 0.5
echo "Is "$filename" correct? [y/n]"
read answer
if [[ $answer == "y" ]];
then
    sleep 1
    echo "Nice."
else
    sleep 0.5
    echo "Oh..."
    sleep 0.3
    echo "Error!1!!"
    exit 1
fi
sleep 0.5
echo "Do you wanna have playback while recording? [y/n]"
read answer
if [[ $answer == "y" ]];
then
    playback=yes
    sleep 1
    echo "Nice."
else
    playback=no
    sleep 0.5
    echo "Okay."
fi
echo "Starting record."
echo "To stop recording, press strg+c"
echo "Ignore the first underrun..."
echo ""
echo ""
sleep 0.5
if [[ $playback == "yes" ]];
then
    arecord --buffer-time=2000000 -f dat - | tee $filename.wav | aplay --buffer-time=2000000 -f dat -
else
    arecord --buffer-time=2000000 -f dat - | tee $filename.wav > /dev/null
fi
echo "Recording ended."
sleep 0.3
echo "Converting wav to flac."
ffmpeg -loglevel quiet -stats -i $filename.wav $filename.flac
echo " "
echo " "
sleep 0.3
echo "Removing $filename.wav"
rm $filename.wav
sleep 0.1
echo "Doné - Have a nice day!"
