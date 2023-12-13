# Code to run MSprime 

directory=$1
num_runs=$2
num_subruns=$3 
# Load required modules and get into a python environment
module load gnu-parallel 
module load bcftools-1.15
module load R-4.0.0
module load anaconda-python3
source /software/python/anaconda3/etc/profile.d/conda.sh

# Write a loop to run all of the simulations and to process all of the files 

for i in $(seq 1 1 $num_runs)
do

# Run the simulations
mkdir $directory/Run${i}

for j in $(seq 1 1 $num_subruns)
do
mkdir $directory/Run${i}/SubRun${j}
cd $directory/Run${i}/SubRun${j}

python3 /home/farleik/Anolis/MSprime/MSprime_sims.py

ls > Files_R${i}_SR${j}.txt


# Use the files names to create PGDspider commands
cat Files_R${i}_SR${j}.txt | while read line; do echo "java -Xmx60000m -Xms512m -jar /home/farleik/Software/PGDSpider_2.1.1.5/PGDSpider2-cli.jar  PGDSpiderCli -inputfile $directory/Run${i}/SubRun${j}/$line -inputformat VCF -outputfile $directory/Run${i}/SubRun${j}/$line.str -outputformat STRUCTURE -spid /home/farleik/Anolis/MSprime/Anolis_MD_Vcf2str.spid" >> PGDspiderR${i}_SR${j}.sh; done


# Replace odd extentsion
sed -i 's/.vcf.str/.str/g' PGDspiderR${i}_SR${j}.sh

sh PGDspiderR${i}_SR${j}.sh

# Delete empty files 
find . -type f -empty -print -delete

# Move into another directory 
mkdir ./SuccessfulRuns 
mv *.str SuccessfulRuns
cd ./SuccessfulRuns

ls > Files_R${i}_SR${j}_success.txt
mkdir Combined

cat Files_R${i}_SR${j}_success.txt | while read line; do echo "cut -f3 $line > ./Combined/$line" >> Strproc.sh; done
rm Files_R${i}_SR${j}_success.txt

sh Strproc.sh 

cd ./Combined

paste * | column -s $'\t' -t > Comb_R${i}_SR${j}.str

sed '1d' Comb_R${i}_SR${j}.str >  Comb_R${i}_SR${j}_noheader.str

mv Comb_R${i}_SR${j}_noheader.str $directory/

cd $directory/Run${i}/SubRun${j}

rm * -r

cd $directory/Run${i}

done

echo "======================================"
echo "--------------------------------------"
echo "Finished SubRun simulations for Run${i}"
echo "--------------------------------------"
echo "======================================"

  
cd $directory/Run${i}

Rscript /home/farleik/Anolis/MSprime/Anolis_MSprime_combine.R Run{i}_combined

cd $directory

echo "====================================================================="
echo "---------------------------------------------------------------------"
echo "Finished simulation for Run ${i}, total progress is ${i}/${num_runs}"
echo "---------------------------------------------------------------------"
echo "====================================================================="

done 


