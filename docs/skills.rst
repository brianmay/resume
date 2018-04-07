Skills
======

Software Development
--------------------
I keep my skills up to date by a combination of professional work, personal
projects, and open source projects I contribute to. I also attend the PyCon AU
conference annually.

All my projects use git, which is considered the defacto default revision control
system.

My projects use continuous integration (CI) meaning a set of unit tests automatically
run with every git push or git pull request. This is typically implemented with
tools such as Jenkins or Travis. This can then trigger automatically building of docker
images.

One of my projects uses continuous delivery (CD) meaning after the CI tests have approved
the changes, it will build docker images and then automatically deploy the images to ECS
instances running on AWS EC2 instances.

My recent experience is with Python 3 and MicroPython. I have developed using numerous
python libraries such as Django, Django Rest Framework, and Django Channels.

I am also experienced with JavaScript (including ES6), TypeScript, CSS, SASS, and frameworks
such as Angular2 and Vue.

I am also very excited with the growth of other programming languages,
such as Ruby, Scala, Erlang, Elixir and Go. Given the opportunity I would
jump at the opportunity to learn some of these languages.

I have also given talks at Conferences such as PyCon AU and local user
group meetings on my software. Some of the highlights:

- Karaage talk at `PyCon AU 2015 <https://www.youtube.com/watch?v=9yiiwcntx5M>`_.
- Robotica talk at `LCA2018 <https://www.youtube.com/watch?v=mCUpShC9Cs8>`_.

I contribute a lot to discussions in local user group mailing lists.

Open Source Community
---------------------
Many of my skills come from open source projects. These are available on github. Some of the highlights are:

- `Spud <https://github.com/brianmay/spud>`_ is a photo database using Django for the REST
  back-end and Angular for the frontend.
- `Robotica <https://github.com/brianmay/robotica/>`_ is a asyncio python based tool for
  management of events around the house.
- A MicroPython based 3d printed `remote control <https://github.com/brianmay/robotica-remote/>`_
  for Robotica.

Linux/Unix Computer Administration
----------------------------------
I keep my Linux skills up to date by maintaining computer and network
systems for personal use. I also attend the Linux.conf.au conference on
an annual basis.

In the past I have setup and maintained TSM and Bacula tape backups, IBM tape
libraries, LTO4 tape drives. I have also setup and maintained a a NT domain Samba
and done a lot of testing to upgrade this to an AD style domain. 

More currently, at home I maintain a CISCO ADSL router, a UniEdge Router, and a
UniEdge switch which supports a number of VLANs and a server running a number of
virtual machines using ProxMox (KVM and LXC). This network fully supports IPv4 and IPv6.

Computer Security
-----------------
Computer security is very important, but often neglected.

All of my personal websites fully support secure SSL encryption that gives good results when
tested with Qualys SSL Labs. Also my DNS records have DNSSEC security.

My work with Debian requires usage of GNU Privacy Guard (GnuPG) for encrypting and signing
of packages. Furthermore I also use GnuPG with git for ensuring tags cannot be tampered with.
