#!/bin/bash
# Enter the command to run
# ./s.sh auth.log

FILE=$1

echo "Number Failed attempts: "
cat $FILE | grep Failed | wc -l


echo "unique IP addresses involved in attacks"
cat $FILE | grep Failed | awk '{print $(NF-3)}' | sort | uniq -c | sort | wc -l


echo "users with valid failed attempts"
cat $FILE | grep Failed | grep -v invalid | awk '{print $(NF-3)}' | sort | uniq -c | sort | wc -l


echo "users with invalid user attempts"
cat $FILE | grep Failed | grep invalid | awk '{print $(NF-3)}' | sort | uniq -c | sort | wc -l


echo "Most Failed IP"
MOST_FAILED=$(cat $FILE | grep Failed | awk '{print $(NF-3)}' | sort | uniq -c | sort | tail -n 1)
MOST_FAILED_IP=$(echo $MOST_FAILED | awk '{print $2}')
MOST_FAILED_ATTEMPTS=$(echo $MOST_FAILED | awk '{print $1}')
MOST_FAILED_COUNTRY=$(whois $MOST_FAILED_IP | grep -i country | awk '{print $NF}' | uniq)
echo "$MOST_FAILED_IP ($MOST_FAILED_ATTEMPTS attempts) from $MOST_FAILED_COUNTRY"
