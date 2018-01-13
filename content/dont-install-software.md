Title: Why I rarely install software on my Ubuntu laptop
Date: 2018-01-06 10:20
Modified: 2018-01-06 10:20
Category: system
Tags: Docker, Ubuntu
Slug: dont-install-software-on-ubuntu
Authors: Chicken
Summary: Installing software on host system is not a good idea
Status: published


Recently I have realised that I hardly install any software on my machine these days. The primary reason for that is Docker.
Docker is a truly awesome piece of software. With the growth of cloud, microservices it got a lot of hype in the recent years, and not without a good reason. Docker is one of the technologies that make all of the above things possible. Interestingly enough even if all you have is just a laptop, Docker can be of great help and in this short article, I will show you how.

You may ask, why would you care about Docker? You don't have a cloud server, you don't own an infrastructure consisting of microservices talking to each other, why would you even bother about it? Some time ago my laptop became a bit sluggish. I had a quick look at the System Monitor and I got seriously perplexed. I found out that there were some >6GB of RAM being consumed on a standby.

Back then I had only 8 GB of RAM, and I started to feel that the machine is getting sort of cramped. These days machine I use has 16GB of RAM, so it wouldn't be an issue, but back in the days, I decided, that it's not working for me anymore, and I had to figure out why.  I realised however that most of the things that were consuming resources were not needed. At least not all of the time.

I like to play with new technologies. I used to play with MongoDB, Neo4j, Cassandra, Apache Spark, Jenkins, and many others.
Simply installing them is fine, most of the time. The problem with that, however, is that you don't necessarily want to have them running all the time. Maybe one weekend I would be working with Neo4j so installing it would be fine, but perhaps next week I wouldn't use it, and having the service running does not make much sense. I decided that I need to clean my system a bit. I got rid of most of the services and RAM on standby got back to the more acceptable level of circa 1 GB.

Because docker allows tying the files system of the container to the file system on the host, data in the database is preserved and you don't have to worry about data persistence when your container is stopped.
Now whenever I need to use MongoDB, ElasticSearch or Neo4j, instead of installing it system-wide I would run Docker container, do my thing and after I am done, simply stop the container.
This allows me to enjoy all of the goodies of the aforementioned technologies, without polluting the pristine Ubuntu environment.

Of course in the real life MongoDB deployment, it's not quite as simple as a one-liner. Preparing a container for production is a bit more involved, perhaps you want to use Ansible, Chef or Puppet, but for my home development, I find it the best remedy for my laptop turning itself into a software spaghetti plate, where there are hundreds of services running, but you don't remember anymore why did you install them in the first place...
