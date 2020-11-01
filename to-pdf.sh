#!/bin/bash


FIRST_ARGS_LENGTH=$(($#-1))
FIRST_ARGS=${@:1:$FIRST_ARGS_LENGTH}
LAST_ARG=${@:$#}

convert $FIRST_ARGS -quality 60 -compress jpeg -auto-orient $LAST_ARG

