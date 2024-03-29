#!/bin/bash
#SBATCH --output=install_DAISIE.log
#SBATCH --nodes=1
#SBATCH --cpus-per-task=32
#SBATCH --time=00:14:57
#SBATCH --partition=gelifes
module load R

VERSION=${1}
R CMD INSTALL --preclean /data/$USER/fabrika/libs/DAISIE_${VERSION}.tar.gz
