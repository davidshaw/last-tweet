# last_tweet.sh
## Determines the latest tweet time of people you follow!

I love Twitter. If you're like me, though, you've probably run into the same problem as me: what do you do when someone you follow "goes dark"?

It's an interesting problem that Twitter itself does not seem to address. For example, I found recently (June 2013) that I was still following people who hadn't tweeted--even once--since early 2010! They've probably given up on Twitter, and don't need to be followed anymore.

`last_tweet.sh` solves this problem.

Usage is simple: `./last_tweet.sh username [--slow]`
An example use might be: `./last_tweet.sh dshaw_`

You'll end up with a result that looks like this:

		http://twitter.com/following1      Mon Jun 03 21:59:56 +0000 2013
		http://twitter.com/following2      Mon Jun 03 21:34:44 +0000 2013
		http://twitter.com/following3      Mon Jun 03 23:57:28 +0000 2013

Which is stored, by default, in `tweet_times.txt`.

I hope this helps you as much as it helped me!
