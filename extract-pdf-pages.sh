set -e
###############################################################################
# SCRIPT ARGUMENTS
###############################################################################
# 1 - First page
# 2 - Last page
# 3 - Input File Name
# 4 - Output File Name

###############################################################################
# ARGUMENTS:
###############################################################################
FIRST_PAGE="$1"
LAST_PAGE="$2"
INPUT_FILE_NAME="$3"
OUTPUT_FILE_NAME="$4"
TMP_DIR=$(mktemp -d)

###############################################################################
# EXTRACT PAGES
###############################################################################
pdfseparate -f $FIRST_PAGE -l $LAST_PAGE $INPUT_FILE_NAME "$TMP_DIR/out-%d.pdf"

###############################################################################
# GET & SORT PAGES
###############################################################################
PAGES=$(find $TMP_DIR -name '*.pdf' | sort -V)

###############################################################################
# MERGE PAGES
###############################################################################
pdfunite $PAGES $OUTPUT_FILE_NAME

###############################################################################
# CLEANUP
###############################################################################
rm -rf $TMP_DIR

###############################################################################
# DONE
###############################################################################
echo "\nDONE\n"
