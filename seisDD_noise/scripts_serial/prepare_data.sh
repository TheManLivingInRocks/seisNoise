#!/bin/bash

################################################
#source /scratch/l/liuqy/zhang18/seisDD/GJI2016/Exp1/submit_job/parameter

velocity_dir=$1
SUBMIT_DIR=$2
SCRIPTS_DIR=$3 
SUBMIT_RESULT=$4 
WORKING_DIR=$5


source $SUBMIT_DIR/parameter


#################################################
# Submit directory
iproc=$PBS_VNODENUM

cd $SUBMIT_DIR

###############################################

data_tag='DATA_obs'
SAVE_FORWARD=false


###############################################
    iproc0=1
    isource=$(echo $(echo "$iproc $iproc0" | awk '{print $1+$2}'))


##############################################

  if  $ExistDATA && [ -d "$DATA_DIR" ]; then    
      sh $SCRIPTS_DIR/copy_data.sh $isource $data_tag $data_list $WORKING_DIR $DATA_DIR $SUBMIT_DIR 2>./job_info/error_copy_data

  else
      
      echo "sh $SCRIPTS_DIR/Forward_${solver}.sh $isource $NPROC_SPECFEM $data_tag $data_list \
       $velocity_dir $SAVE_FORWARD $WORKING_DIR $DATA_DIR $job $SUBMIT_DIR"
      sh $SCRIPTS_DIR/Forward_${solver}.sh $isource $NPROC_SPECFEM $data_tag $data_list \
       $velocity_dir $SAVE_FORWARD $WORKING_DIR $DATA_DIR $job $SUBMIT_DIR  2>./job_info/error_Forward_simulation
  fi



   # ENDTIME=$(date +%s)
    # Ttaken=$(($ENDTIME - $STARTTIME))


