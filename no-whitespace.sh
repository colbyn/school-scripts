set -e

if [ -z "$1" ]
then
    # EMPTY - JUST REMOVES ALL SPACES
    find . -name "* *" -type f | rename 's/ //g'
else
    # OTHERWISE
    TARGET_START='s/ /'
    TARGET_END='/g'
    TARGET="$TARGET_START$1$TARGET_END"
    find . -name "* *" -type f | rename "$TARGET"
fi
