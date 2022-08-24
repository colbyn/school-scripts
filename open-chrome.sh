set -e
###############################################################################
# OVERVIEW
###############################################################################
# open-chrome.sh : Opens chrome in app mode (No URL bar), useful when you want
# a browser to test specific html pages without any UI fluff or disable
# extensions (which this script disables).

###############################################################################
# SCRIPT ARGUMENTS
###############################################################################
# 1 - ADDRESS AND PORT (e.g. http://127.0.0.1:1234/)

###############################################################################
# ARGUMENTS:
###############################################################################
ADDRESS="$1"


/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome \
    --app=$ADDRESS \
    –-disable-background-mode \
    --disable-component-extensions-with-background-pages \
    --disable-extensions \
    -–disable-background-networking \
