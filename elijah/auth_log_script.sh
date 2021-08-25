#1/bin/bash

#argument check
if [ $# -ne 1 ]; then
  echo "Please enter the filename 'auth.log' and run the script again."
  echo "Example: $0 auth.log"
  exit 1
fi

#Assign variable
FILE=$1

#Check if the file 'auth.log' exists
if [ -f $FILE ]; then
  if [ $FILE = 'auth.log' ]; then
    echo
    echo "==============================================================="
    #Present to the user the number of Failed attempts made on his system
    FAILED_ATT=$(cat $FILE | grep Failed | wc -l)
    echo "No. of failed attempts: $FAILED_ATT"
    echo
    #Present to the user the number of IP addresses involved in the attacks
    IP_COUNT=$(cat $FILE  | grep Failed | awk '{print $(NF-3)}' | sort | uniq | wc -l)
    echo "No. of IP addresses involved in the attacks: $IP_COUNT"
    echo
    #Present to the user the valid users with Failed attempts
    echo "Valid users with Failed attempts:"
    cat $FILE  | grep Failed | grep -vi invalid | awk '{print $(NF-5)}' | sort | uniq
    echo
    #Present to the user the number of invalid user attempts
    INVALID_USER_ATT=$(cat $FILE  | grep Failed | grep -i invalid | wc -l)
    echo "No. of invalid user attempts: $INVALID_USER_ATT"
    echo
    #Present to the user the IP address with the most Failed attempts, +the number of his failed attempts, and from which country he is from
    FAILED_IP_MAX=$(cat $FILE  | grep Failed | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | tail -n 1 |awk '{print $(NF)}')
    echo "IP address with the most Failed attempts: $FAILED_IP_MAX"
    FAILED_IP_MAX_COUNT=$(cat $FILE  | grep Failed | awk '{print $(NF-3)}' | sort | uniq -c | sort -n | tail -n 1 |awk '{print $1}')
    echo "Number of Failed attempts from $FAILED_IP_MAX: $FAILED_IP_MAX_COUNT"
    FAILED_IP_COUNTRY=$(whois $FAILED_IP_MAX | grep -i country | head -n 1 | awk '{print $NF}')
    echo "The country which the IP $FAILED_IP_MAX is from: $FAILED_IP_COUNTRY"
    echo "==============================================================="
  else
    echo "This script can only analyse an 'auth.log' file. Please run $0 again."
    echo "Example: $0 auth.log"
    fi
else
  echo "The file name entered does not exist. Please run $0 again."
  echo "Example: $0 auth.log"
fi
