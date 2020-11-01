# DEPENDENCIES: jq, google-cloud-sdk (gsutil & gcloud), ffmpeg

# SETUP
TMP_DIR=$(mktemp -d)
GCLOUD_BUCKET_NAME="colbyn-tmp"
GCLOUD_OBJECT_PATH="gs://$GCLOUD_BUCKET_NAME/tmp-speech-to-text$TMP_DIR/$1.flac"

# TRANSCODE AUDIO FILE TO MONO FLACC
ffmpeg -i "$1" -ac 1 $TMP_DIR/out.flac

# UPLOAD OBJECT TO GCLOUD BUCKET
gsutil cp $TMP_DIR/out.flac $GCLOUD_OBJECT_PATH

# RUN SPEECH TO TEXT
gcloud ml speech recognize-long-running \
    $GCLOUD_OBJECT_PATH \
    --language-code=en-US > $TMP_DIR/out.json

# REMOVE OBJECT IN GCLOUD BUCKET
gsutil rm $GCLOUD_OBJECT_PATH

# GET TEXT
cat $TMP_DIR/out.json | jq -r '.results[].alternatives[].transcript'

# DONE
rm -rf $TMP_DIR
