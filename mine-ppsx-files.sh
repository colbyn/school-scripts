set -e
function log_failed {
    python3 -c "import sty; print(sty.bg(36, 5, 5) + sty.fg(255, 0, 0) + '$1' + sty.rs.fg + sty.rs.bg)"
}

INPUT_DIR="./"
OUTPUT_PATH="out.txt"

if [ -z "$1" ]
then echo "" # EMPTY
else INPUT_DIR="$1" # OTHERWISE
fi

if [ -z "$2" ]
then echo "" # EMPTY
else OUTPUT_PATH="$1" # OTHERWISE
fi


no-whitespace.sh

rm -rf $OUTPUT_PATH
touch $OUTPUT_PATH

for i in $(find $INPUT_DIR -name "*.ppsx"); do
    OUTPUT_DIR=$(basename $i .ppsx)
    ppsx-extract-audio.sh "$i"
    pdftotext "$OUTPUT_DIR.pdf" "$OUTPUT_DIR.txt" || echo "\nNO PDF FILE\n"
    echo "\n\n$OUTPUT_DIR\n" >> $OUTPUT_PATH
    for f in $(find "$OUTPUT_DIR" -name "*.m4a"); do
        speech-to-text.sh $f >> $OUTPUT_PATH
    done
done



