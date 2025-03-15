#/bin/bash
cwd=$(dirname $0)
output_dir=$cwd/../public/spelling

mkdir -p $output_dir
rm $cwd/piper.log

while read word; do
    echo "Converting: $word" >> $cwd/piper.log
    echo "$word" \
    | $cwd/piper/piper --model $cwd/piper/hu_HU-anna-medium.onnx --noise_w 1.0 --output-raw 2>> $cwd/piper.log \
    | ffmpeg -y -loglevel error -f s16le -ar 22050 -ac 1 -i pipe:0 -codec:a libmp3lame -q:a 7 -write_id3v1 0 -id3v2_version none "$output_dir/$word.mp3"
done < $cwd/../src/data/spelling.txt
