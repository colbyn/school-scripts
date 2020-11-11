set -e

function log_failed {
    python3 -c "import sty; print(sty.bg(36, 5, 5) + sty.fg(255, 0, 0) + '$1' + sty.rs.fg + sty.rs.bg)"
}

TMP_DIR_UNZIPED=$(mktemp -d)
INPUT_FILE="$1"
OUTPUT_DIR="$2"
if [ -z "$2" ]
then
    # EMPTY
    OUTPUT_DIR=$(basename $1 .ppsx)
fi

unzip $INPUT_FILE -d "$TMP_DIR_UNZIPED"

mkdir -p $OUTPUT_DIR
AUDIO_FILES=$(find /var/folders/7k/ltr5p2hd75g9r5n6kl5hhv6c0000gn/T/tmp.92cd5QdC -name "*.m4a")
for i in $AUDIO_FILES; do
    cp -n $i $OUTPUT_DIR || (log_failed "ERROR FILE EXISTS!!! $i")
done

rm -rf $TMP_DIR_UNZIPED

