#! /bin/bash
#PBS -A SEAQT
#PBS -l walltime=72:00:00
#PBS -l nodes=1:ppn=12
#PBS -W group_list=newriver
#PBS -q normal_q
#PBS -j oe
#
#
cd /home/mevan3/ARC_NR_2020_01_22_A
#  Following the "module purge" you can add "module load xxx" commands.
#
module purge
module load matlab/R2018a
#
#  Here is where you should include the commands you want to execute.
#  We will just print a message that includes the name of the node.
#
echo "Here is where your computational commands should go."
matlab -nodisplay -nosplash -r LSMparallel_v1
echo ""
echo "PBS_NEWRIVER: Normal end of execution."
exit 0

