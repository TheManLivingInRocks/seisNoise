#!/bin/bash

isource=$1
data_tag=$2
data_list=$3
WORKING_DIR=$4
DATA_DIR=$5
SUBMIT_DIR=$6

ISRC_WORKING_DIR=$( seq --format="$WORKING_DIR/%06.f" $(($isource-1)) $(($isource-1)) ) 
ISRC_DATA_DIR=$ISRC_WORKING_DIR/$data_tag
data_tag_syn=DATA_syn
ISRC_DATA_DIR_syn=$ISRC_WORKING_DIR/$data_tag_syn

echo "mkdir -p $ISRC_WORKING_DIR $ISRC_DATA_DIR"
mkdir -p $ISRC_WORKING_DIR $ISRC_DATA_DIR
mkdir -p $ISRC_WORKING_DIR $ISRC_DATA_DIR_syn

cd $ISRC_WORKING_DIR

# Source location
DATA_DIR=$( seq --format="$DATA_DIR/%06.f" $(($isource-1)) $(($isource-1)) )

cp -r $SUBMIT_DIR/parameter ./
cp -r $DATA_DIR/*su    $ISRC_DATA_DIR/

echo "cp -r $DATA_DIR/*su    $ISRC_DATA_DIR/"


# if $SUBMIT_DIR/SU_process exist
if [ -d "$SUBMIT_DIR/SU_process" ]; then
    cp -r $SUBMIT_DIR/SU_process ./
fi

## copy and preprocessing of data 
arr=$(echo $data_list | tr "," "\n")

for x in $arr
do
    if [ -f "SU_process/process_obs.sh" ]; then
        sh SU_process/process_obs.sh \
            $DATA_DIR/U${x}_file_single.su \
            $ISRC_DATA_DIR/U${x}_file_single.su
    else
        cp  $DATA_DIR/U${x}_file_single.su \
            $ISRC_DATA_DIR/U${x}_file_single.su
    fi
done
