#!/bin/bash 

#---------------------------------------------------------------------------------------
#    Comments from BinHe(binhebj@gmail.com/hebin14@mails.ucas.ac.cn) 2020-05-12
#    Please pay attention: NPROC_SPECFEM must be >1
#    This code only condier this case. If NPROC_SPECFEM==1, the code will be break
#---------------------------------------------------------------------------------------

# temporary work around for pbsdsh,this scipt can realize the same function as pbsdsh

source $PBS_O_WORKDIR/parameter

iproc=0;

# show all cores(processor) we apply for 

for i in `cat $PBS_NODEFILE`;
do	
        iproc=$(($iproc + 1));
        # iproc means that the processor ID (1,2,....,ntasks*NPROC_SPECFEM)
        if [ $iproc -gt $(($ntasks*$NPROC_SPECFEM)) ] ; then
		continue
        fi

        # which source the current iproc belongs to:iproc/$NPROC_SPECFEM+1 
        ntask_floor=$(($iproc/$NPROC_SPECFEM+1));
        # calculate the: iproc%$NPROC_SPECFEM
        ntask_floor_ceiling=$(($iproc%$NPROC_SPECFEM))
        #echo "iproc="$iproc"NPROC_SPECFEM="$NPROC_SPECFEM"ntask_floor_ceiling"$ntask_floor_ceiling"ntask_floor"$ntask_floor

        ## the condition which ditermine when we launch the ssh:   ssh $i "export PBS_VNODENUM=$ntask_floor; $@" &
        #  when ntask_floor_ceiling = 1 , we will launch
 
        if [ $ntask_floor_ceiling -eq 1 ] ; then 

           # the condition we break the script
           if [ $ntask_floor -gt $NSRC ]; then
              break
           fi

           ssh $i "export PBS_VNODENUM=$ntask_floor; $@" & 
           #echo "ntask_floor_ceiling="$ntask_floor_ceiling"i="$i"export PBS_VNODENUM="$ntask_floor         
           # the condition we break the script

        else
           continue
        fi 
done

wait

