#!/bin/bash
if [ "$#" -ne 2 ];then
      echo "This Script requires two arguments:"
      echo "Frecuency and FileName"
else
ulinered="\033[4;31;40m"
red="\033[31;40m"
none="\033[0m"
createfile(){
	if [ -f $1 ]
	then
		echo The file $1 exists already,
	else
    	touch $1; echo The file $1 has been created
	fi
	chmod a=rw $1;echo  Permitions \"Read+Write\" have been set for $ulinered"ALL"$none, testing with ls - l; ls -l | grep $1
}
createandmove(){
	if [ -d archieved ]
	then 
		echo The folder archieved already exists
	else
		mkdir archieved ; echo The folder archived has been created
	fi	
	echo Moving and renaming file $1, Permitions \"Read+Write\" will be set for $ulinered"OWNER"$none;chmod 600 $1; mv $1 "archieved/$1$(date +_%Y%m%d_%H%M%S)"
	echo testing with ls into folder ; cd archieved ; pwd; ls -l | grep $1;cd ..
}
validformat(){
	valid=0
	Frecuency=$1
	while [ $valid -eq 0 ]
	do
	    case $Frecuency in
	    [1-99][sSmMhH]|[0-99]second|[0-99]minute|[0-99]hour|[2-99]seconds|[2-99]minutes|[2-99]hours) echo Format accepted; valid=1 ;;
	     *   ) echo 'Frecuency format must be an int number (no more that 99) and a value of time like m , s, h,  minunte, etc';read -p "give me a valid Frecuency: " Frecuency  ;;  
	    esac
	done

}
	
validformat $1
echo The Frequency is : $Frecuency
echo The File name is : $2
while true; do
	createfile  $2
	Frecuency="$(echo $Frecuency| sed -e  's/minutes/m/' -e  's/minute/m/' -e 's/seconds/s/' -e 's/second/s/' -e 's/hours/h/' -e 's/hour/h/')"		    
	echo I will wait $Frecuency; sleep $Frecuency 
	createandmove $2
done
fi