#
# =====================================================
# $Id$
# $URL$
# $LastChangedDate$
# $LastChangedRevision$
# $LastChangedBy$
# =====================================================
#

#MOLGENIS walltime=00:45:00

inputs "${matefixedcovariatecsv}"
inputs "${sortedrecalcovariatecsv}"
alloutputsexist \
"${cyclecovariatebefore}" \
"${cyclecovariateafter}"

module load GATK/1.0.5069
module load R/2.14.2
module list

java -jar -Xmx4g $GATK_HOME/AnalyzeCovariates.jar -l INFO \
-resources ${indexfile} \
--recal_file ${matefixedcovariatecsv} \
-outputDir ${recalstatsbeforedir} \
-Rscript $RHOME/bin/Rscript \
-ignoreQ 5

java -jar -Xmx4g $GATK_HOME/AnalyzeCovariates.jar -l INFO \
-resources ${indexfile} \
--recal_file ${sortedrecalcovariatecsv} \
-outputDir ${recalstatsafterdir} \
-Rscript $RHOME/bin/Rscript \
-ignoreQ 5
