#MOLGENIS nodes=1 ppn=1 mem=1gb walltime=10:00:00

### variables to help adding to database (have to use weave)
#string internalId
#string sampleName
#string project
###
#string stage
#string checkStage
#string fastqcVersion
#string WORKDIR
#string projectDir
#string fastqcDir
#string fastqcZipExt
#string reads1FqGz
#string reads2FqGz
#string singleEndRRna
#string pairedEndRRna1
#string pairedEndRRna2
#string singleEndfastqcZip
#string pairedEndfastqcZip1
#string pairedEndfastqcZip2

echo -e "test ${pairedEndRRna1} ${pairedEndRRna2} 1: $(basename ${pairedEndRRna1} .gz)${fastqcZipExt} \n2: $(basename ${pairedEndRRna2} .gz)${fastqcZipExt} "
echo "ID (internalId-project-sampleName): ${internalId}-${project}-${sampleName}"
echo "SINGLE END ONLY"
${stage} FastQC/${fastqcVersion}
${checkStage}


echo "## "$(date)" ##  $0 Started "

echo "## "$(date)" Started single end fastqc"

mkdir -p ${fastqcDir}
cd ${fastqcDir}
	
##################################################################
echo
echo "## "$(date)" reads1FqGz"
if fastqc \
    --noextract ${singleEndRRna} \
	--outdir ${fastqcDir}
	
then
    echo "returncode: $?";
	
	echo
    cp -v ${fastqcDir}/${singleEndRRna%%.*}${fastqcZipExt} ${singleEndfastqcZip}

	##################################################################
	
    cd $OLDPWD

    cd ${fastqcDir}
    md5sum $(basename ${pairedEndfastqcZip1}) > $(basename ${pairedEndfastqcZip1}).md5
    cd -
    echo "succes moving files";
else
    echo "returncode: $?";
 	echo "fail";
fi

