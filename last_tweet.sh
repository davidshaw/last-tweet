#!/usr/bin/env bash

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "              last_tweet.sh by David Shaw"
echo "Determines the latest tweet time of people you follow!"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo
echo "[!] Note: If you have more than 15,000 followers,"
echo "          please use the \"--slow\" flag."
echo

if [ $# -ne 1 ] && [ $# -ne 2 ]; then
	echo "Usage: $0 username [--slow]"
	echo "   ex: $0 dshaw_"
	exit
fi

slow=false;
if [ $# -eq 2 ] && [ $2 == "--slow" ]; then
	slow=true;
fi

# initial setup
rm -f tweets.txt

echo "[+] Grabbing follower list..."
curl "https://api.twitter.com/1/friends/ids.json?screen_name=$1" 2>/dev/null > following.txt
cat following.txt | sed 's/.*\[\(.*\)\].*/\1/g' > follow_ids.txt
num=`cat follow_ids.txt | tr ',' '\n' | wc -l`

echo "[+] Processing $num users... please be patient!"
### experimental code ###
place=1;
next=100;
while [ $place -le $num ] ; do
	echo "Processing users $place to $next";
	curl "https://api.twitter.com/1/users/lookup.xml?user_id=`cat follow_ids.txt | tr '\n' ',' | cut -d',' -f$place-$next`" 2>/dev/null | grep '<screen_name\|^\s\s\s\s<created' >> tweet_times.txt
	if [ $slow == true ]; then
		sleep 25;
	else
		sleep 1;
	fi
	place=$((next + 1))
	next=$((place + 99))
done

echo "[+] Done! Cleaning up."
cat tweet_times.txt | sed 's/.*name>\(.*\)<.*/http:\/\/twitter.com\/\1/g' | tr '\n' ' ' | sed 's/http/\nhttp/g' | sed 's/\(.*\)\s*<created_at>\(.*\)<\/created_at>.*/\1 \2/g' > tweets.txt
mv tweets.txt tweet_times.txt

# cleanup
rm -f following.txt
rm -f follow_ids.txt

