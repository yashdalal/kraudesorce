ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 > ip.txt;
grep -o '.*[.]' ip.txt > ip2.txt;
sed 's/$/*/' ip2.txt > ip3.txt;
tput setaf 9;
echo "Counting number of hosts ...";
nmap -sP -iL ip3.txt > nmap_output.txt;
grep hosts nmap_output.txt > nmap_output2.txt;
awk -F'[()]' '{print $2}' nmap_output2.txt > nmap_output3.txt;
awk '{print $1}' nmap_output3.txt > hosts.txt;
echo '{"hostCount": ' > data.json;
cat hosts.txt >> data.json;
tput setaf 11;
echo "Gathering metadata ...";
echo ',"hostData":{"latitude":' >> data.json;
LocateMe -f "{LAT}" >> data.json;
echo ',"longitude":' >> data.json;
LocateMe -f "{LON}" >> data.json;
echo ',"time": "' >> data.json;
date >> data.json;
echo '"}}' >> data.json;
tr '\n' ' ' < data.json > data2.json;
tput setaf 10;
echo "Sending data to server ...";
tput sgr0;
firebase data:update /locations/holmesLounge/ data2.json -f fiery-inferno-2827 -y;
echo "Number of devices connected to this network:";
tput setaf 12;
cat hosts.txt;
tput sgr0;
rm -rf ip.txt ip2.txt ip3.txt nmap_output.txt nmap_output2.txt nmap_output3.txt hosts.txt data.json data2.json;