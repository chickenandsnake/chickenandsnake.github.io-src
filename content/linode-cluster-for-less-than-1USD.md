Title: Linode cluster for less than 1 USD
Date: 2018-01-20 20:20
Category: cloud
Tags: cloud, linode, API,
Slug: linode-cluster-for-less-than-1USD
Authors: Chicken
Summary: In this post I will show you how to create a cheap 10 CPU cluster for less than 1 USD.
Status: published

I have been playing with Linode recently. I like it a lot because it's reasonably priced and it simply does the job. In this short tutorial, I will show you how to create a 10 CPU cluster for less than one 1 USD.
Code for this post will be available [here](https://chickenandsnake.github.io/linode-cluster-for-less-than-1USD.html).
here, Python 3.6 was used in this tutorial.


First things first, you have to make an account at Linode. Once you are logged in, you'll need to generate the API key.
That will allow us to use Linode's API and create/update and destroy nodes at will.

You'll need to install python library for Linode's API. Official repo can be found here: https://github.com/linode/python-linode-api
You should be able to easily reproduce this project using virtual environment, or anaconda environments using requirements file in this repo.

First, you should put your API key in the settings.py file. Linode allows you to generate API keys which are valid for only some period of time, good security practice.

Your settings.py should look like this:
```python
# settings.py

API_KEY ='Your API-KEY goes here'
```
Next, we'll create a specification of our Linode instances. Let's explore what Linode has to offer. Run Python shell and type:

```python
import linode
from settings import API_KEY
client = linode.LinodeClient(API_KEY)
```

At this point, you have a connection with Linode API. Let's see which machine can we provision using Linode API.

```python
for item in client.linode.get_types():
    print(item)
```
Result should be something like this:
```python
Type: g5-standard-1
Type: g5-standard-2
Type: g5-standard-4
Type: g5-standard-6
Type: g5-standard-8
Type: g5-standard-12
Type: g5-standard-16
Type: g5-standard-20
Type: g5-nanode-1
Type: g5-highmem-1
Type: g5-highmem-2
Type: g5-highmem-4
Type: g5-highmem-8
Type: g5-highmem-16
```


Your request will retrun an iterable of `Type` objects and provides basic information about a linode. `Type` class has various properties like label, id, memory and price, vcpus, disks. and so on . To get more information about each linode we could run:

```python
for item in client.linode.get_types():
    print(f"Id: {item.id} Memory: {item.memory} CPU: {item.vcpus} Disk: {item.disk} Price hourly: {item.price.hourly}\n")

```

Feature that makes Linode API more user-friendly is filtering. Let's assume for a second that you want 60 nodes, one CPU each and you think that 1 GB of RAM will be enough.

To get all the node types that fulfill this criteria you can run something like this:
```python
for i in client.linode.get_types(Type.memory == 1024, Type.vcpus == 1):
    print(i.id)
```

As you can see only one `Type` fulfils this criterion. It's worth noting that Linode API accepts id as arguments for inodes creation.

Using filters allows us to create a function that will provide the desired specification for us:
```python

def create_linode(api_key, image: str, name: str,  ram: int = 1024, cpus: int = 1):
    client = linode.LinodeClient(api_key)
    im_id = client.get_images(linode.Image.label == image)[0].id
    image = Image(client, im_id)
    nodename = client.linode.get_types(Type.memory == ram, Type.vcpu == cpus)[0].id
    region = Region(client, 'eu-west-1a').id
    type = linode.Type(client, nodename)
    l, pw = client.linode.create_instance(type, region, image=image)
    l.label = name
    l.save()
    return dict(name=l.label, ip=l.ipv4[0], passwd=pw)
```
One limitation of the above code is that if more than one Linode type fulfils your criteria, only the first one will be used.
As long as you don't supply a password to `create_instance()` method, Linode will create a password for you and return it.

```python
node_details = list()

for num in range(1, 11):
    node_details.append(create_linode(api_key=API_KEY, image='Ubuntu 16.04 LTS', name='Node{}'.format(num), ram=1024, cpus=1))
print(node_details)
```

If we run the code above you will get 10 nodes, ready to do whatever task you have on your mind. Running this cluster for one hour will cost you 0.15 USD, which I think is very good value for money. 1 USD will buy you 6 hours of 10 CPUs. Not bad, huh?
You have seen how to quickly provision custom-specification nodes in the cloud without a massive bill. In the next post, we'll try to use our mini-cluster to do something meaningful.