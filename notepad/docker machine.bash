Step 1 — Installing Docker Machine on Your Local Computer

In this step, we'll work through the process of installing Docker Machine on your local computer running Ubuntu 16.04.

To download and install the Docker Machine binary, type:

wget https://github.com/docker/machine/releases/download/v0.6.0/docker-machine-$(uname -s)-$(uname -m)
The name of the file should be docker-machine-Linux-x86_64. Rename it to docker-machine to make it easier to work with:

mv docker-machine-Linux-x86_64 docker-machine
Make it executable:

chmod +x docker-machine
Move or copy it to the usr/local/bin directory so that it will be available as a system command.

sudo mv docker-machine /usr/local/bin
Check the version, which will indicate that it's properly installed:

docker-machine version
The output should be similar to

Output
docker-machine version 0.6.0, build e27fb87
Step 2 — Installing Additional Docker Machine Scripts

There are three bash scripts in the Docker Machine GitHub repository designed to facilitate the usage of the docker and docker-machine commands. They provide command completion and bash-prompt customization.

In this step, we'll install these three scripts on your local machine. They will be downloaded and installed into the /etc/bash_completion.d directory.

The first script allows you to see the active machine from your bash prompt. This comes in handy when you are working with and switching between multiple Dockerized machines. The script is called docker-machine-prompt.bash. To download it, type:

sudo wget https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine-prompt.bash -O /etc/bash_completion.d/docker-machine-prompt.bash
To complete the installation of the above file, you'll have to set a custom value for the PS1 variable in your .bashrc file. To do so, open it using nano (PS1 is a special shell variable used to modify the bash command prompt):

nano ~/.bashrc
Within that file, there are three lines that begin with PS1. They should be just like these:

~/.bashrc
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '

PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
For each line, insert $(__docker_machine_ps1 " [%s]") near the end so that they read:

~/.bashrc
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(__docker_machine_ps1 " [%s]")\$ '

PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__docker_machine_ps1 " [%s]")\$ '

PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$(__docker_machine_ps1 " [%s]")$PS1"
Save and close the file.

The second script is called docker-machine-wrapper.bash. It adds a use subcommand to the docker-machine command, making it easy to switch between Docker Machines. To download it, type:

$(__docker_machine_ps1 " [%s]")The third script is called docker-machine.bash. It adds bash completion for docker-machine commands. Download it using:

sudo wget https://raw.githubusercontent.com/docker/machine/master/contrib/completion/bash/docker-machine.bash -O /etc/bash_completion.d/docker-machine.bash
To apply the changes you've made so far, close, then reopen your terminal. If you're logged into the machine via SSH, exit the session and log in again. Command completion for the docker and docker-machine commands should now be working.

Step 3 — Provisioning a Dockerized Host Using Docker Machine

Now that you have Docker and Docker Machine running on your local machine, you can now provision a Dockerized Droplet on your DigitalOcean account using Docker Machine's docker-machine create command. If you've not done so already, assign your DigitalOcean API token to a bash variable using:

export DOTOKEN=your-api-token
NOTE: This tutorial uses DOTOKEN as the bash variable for the DO API token. The variable name does not have to be DOTOKEN, and it does not have to be in all caps.

To make the variable permanent, put it in your ~/.bashrc file. This step is optional, but it is necessary if you want to the value to persist across terminal sessions.

Open that file with nano:

nano ~/.bashrc
Add a line similar to this anywhere:

~/.bashrc
export DOTOKEN=your-api-token
To activate the variable in the current terminal session, type:

source ~/.bashrc
To call the docker-machine create command successfully you must specify (at a minimum) the driver, the API token (or the variable that evaluates to it), and a unique name for the machine. To create your first machine, type:

docker-machine create --driver digitalocean --digitalocean-access-token $DOTOKEN machine-name
Partial output as the machine is being created follows. In this output, the name of the machine is ubuntu1604-docker:
echo “DOCKER_OPTS=\”\$DOCKER_OPTS –registry-mirror=http://77f86377.m.daocloud.io\”” >> /var/packages/Docker/target/usr/bin/docker
Output
 ...
Installing Docker...
Copying certs to the local machine directory...
Copying certs to the remote machine...
Setting Docker configuration on the remote daemon...
Checking connection to Docker...
Docker is up and running!
To see how to connect your Docker Client to the Docker Engine running on this virtual machine, run: docker-machine env ubuntu1604-docker
An SSH key pair is created for the new host so that docker-machine can access it remotely. The Droplet is provisioned with the desired operating system, and Docker is installed on the system. When the command is complete, your Docker Droplet is up and running.

To see the newly create machine from the command line, type:

docker-machine ls
The output should be similar to this:

Output
NAME               ACTIVE      DRIVER         STATE     URL                         SWARM   DOCKER    ERRORS
ubuntu1604-docker    -        digitalocean   Running   tcp://104.236.120.71:2376            v1.11.1
Step 4 — Specifying the Base OS When Creating a Dockerized Host

By default, the base operating system used when creating a Dockerized host with Docker Machine is supposed to be the latest Ubuntu LTS. However, at the time of this publication, the docker-machine create command is still using Ubuntu 15.10 as the base operating system, even though Ubuntu 16.04 is the latest LTS edition. So if you need to run Ubuntu 16.04 on a recently-provisioned machine, you'll have to specify Ubuntu along with the desired version by passing the --digitalocean-image flag to the docker-machine create command.

For example, to create a machine using Ubuntu 16.04, type:

docker-machine create --driver digitalocean --digitalocean-image ubuntu-16-04-x64 --digitalocean-access-token $DOTOKEN machine-name
You're not limited to a version of Ubuntu. You can create a machine using any operating system supported on DigitalOcean. For example, to create a machine using Debian 8, type:

docker-machine create --driver digitalocean --digitalocean-image debian-8-x64 --digitalocean-access-token $DOTOKEN machine-name
To provision a Dockerized host using CentOS 7 as the base OS, specify centos-7-0-x86 as the image name, like so:

docker-machine create --driver digitalocean --digitalocean-image centos-7-0-x64 --digitalocean-access-token $DOTOKEN centos7-docker
The base operating system is not the only choice you have. You can also specify the size of the Droplet. By default, it is the smallest Droplet, which has 512 MB of RAM and a 20 GB SSD. This next example provisions a machine with 1 GB of RAM:

docker-machine create --driver digitalocean --digitalocean-size 1gb --digitalocean-access-token $DOTOKEN machine-name
To see all the flags specific to creating a Docker Machine using the DigitalOcean driver, type:

docker-machine create --driver digitalocean -h
Tip: If you refresh the Droplet page of your DigitalOcean dashboard, you will see the new machines you created using the docker-machine command.

Step 5 — Executing Additional Docker Machine Commands

You've seen how to provision a Dockerized host using the create subcommand. You also seen how to list the hosts available to Docker Machine using the ls subcommand. In this step, you'll learn a few more docker-machine subcommands.

To obtain detailed information about a Dockerized host, use the inspect subcommand, like so:

docker-machine inspect machine-name
The output should include lines like these. The Image line reveals the version of the Linux distribution used:

Output
...

"DropletName": "",
        "Image": "ubuntu-15-10-x64",
        "Region": "nyc3",
        "SSHKeyID": 1857042,
        "Size": "512mb",
        "IPv6": false,
        "Backups": false,
        "PrivateNetworking": false,

---

To print the connection configuration for a host, type:

docker-machine config machine-name
The output should be similar to this:

Output
--tlsverify
--tlscacert="/home/kamit/.docker/machine/certs/ca.pem"
--tlscert="/home/kamit/.docker/machine/certs/cert.pem"
--tlskey="/home/kamit/.docker/machine/certs/key.pem"
-H=tcp://104.131.102.147:2376
The last line in the output of the docker-machine config command reveals the IP address of the host, but you can also get that piece of information by typing:

docker-machine ip machine-name
If you need to power down a remote host, you can use docker-machine to stop it:

docker-machine stop machine-name
Verify that it is stopped.

docker-machine ls
The status of the machine has changed:

Ouput
NAME                 ACTIVE   DRIVER         STATE     URL                        SWARM   DOCKER    ERRORS
ubuntu1604-docker                  digitalocean   Timeout
To start it again:

docker-machine start machine-name
Verify that it is started:

docker-machine ls
You will see that the STATE is now set Running for the host:

Ouput
NAME                 ACTIVE   DRIVER         STATE     URL                        SWARM   DOCKER    ERRORS

ubuntu1604-docker         -        digitalocean   Running   tcp://159.203.117.16:2376           v1.11.1
Then you may remove it using:

docker-machine rm machine-name
The Droplet is deleted along with the SSH key created for it by docker-machine. Now, when you list the Dockerized hosts, you shouldn't see the one you just deleted:

docker-machine ls
Step 6 — Executing Commands on a Dockerized Host via SSH

At this point, you've been getting information about your machines, but you can do more than that. For example, you can execute native Linux commands on a Docker host by using the ssh subcommand of docker-machine from your local system. This section explains how to perform ssh commands via docker-machine as well as how to open an SSH session to a Dockerized host.

Assuming that you've provisioned a machine with Ubuntu as the operating system, execute the following command from your local system to update the package database on the Docker host:

docker-machine ssh machine-name apt-get update
You can even apply available updates using:

docker-machine ssh machine-name apt-get upgrade
Not sure what kernel your remote Docker host is using? Type the following:

docker-machine ssh machine-name uname -r
Besides using the ssh subcommand to execute commands on the remote Docker host, you can also use it to log into the machine itself. It's as easy as typing:

docker-machine ssh machine-name
Your command prompt will change to reflect the fact that you're logged into the remote host:

Output
root@machine-name#
To exit from the remote host, simply type:

exit
Step 7 — Activating a Dockerized Host

Activating a Docker host connects your local Docker client to that system, which makes it possible to run normal docker commands on the remote system. To activate a Docker host, type the following command:

eval $(docker-machine env machine-name)
Alternatively, you can activate it by using this command:

docker-machine use machine-name
Tip When working with multiple Docker hosts, the docker-machine use command is the easiest method of switching from one to the other.

After typing any of the above commands, your bash prompt should change to indicate that your Docker client is pointing to the remote Docker host. It will take this form. The name of the host will be at the end of the prompt:

username@localmachine:~ [machine-name]$
Now any docker command you type at this command prompt will be executed on that remote host.

If a host is active on the terminal that the docker-machine ls command is run, the asterisk under the ACTIVE column shows that it is the active one.

Output
NAME                ACTIVE          DRIVER         STATE     URL                         SWARM   DOCKER    ERRORS
ubuntu1604-docker   *        digitalocean   Running   tcp://45.55.183.145:2376             v1.11.1   
To exit from the remote Docker host, type the following:

docker-machine use -u
Step 8 — Creating Docker Containers on a Remote Dockerized Host

So far, you have provisioned a Dockerized Droplet on your DigitalOcean account and you've activated it — that is, your Docker client is pointing to it. The next logical step is to spin up containers on it. As an example, let's try running the official Nginx container.

While still pointing to your Docker host (as indicated by the changed prompt), execute this command to run an Nginx container:

docker run -d -p 8080:80 --name httpserver nginx
In this command, we're mapping port 80 in the Nginx container to port 8080 on the Dockerized host so that we can access the default Nginx page from anywhere.

If the command executed successfully, you will be able to access the default Nginx page by pointing your Web browser to http://machine-ip:8080.

To exit the prompt for the remote host, type. This will close the terminal as well:

exit
Note: If you intend to create containers on a remote machine, your Docker client must be pointing to it — that is, it must be the active machine in the terminal that you're using. Otherwise you'll be creating the container on your local machine. Again, let your command prompt be your guide.

Step 9 — Disabling Crash Reporting (Optional)

By default, whenever an attempt to provision a Dockerized host using Docker Machine fails or Docker Machine crashes, some diagnostic information is sent automatically to a Docker account on Bugsnag. If you're not comfortable with this, you can disable the reporting by creating an empty file called no-error-report in your installation .docker/machine directory.

To create the file, type:

touch ~/.docker/machine/no-error-report
Check the file for error messages if provisioning fails or Docker Machine crashes.

Conclusion

This has been an introduction to installing and using Docker Machine to provision multiple Docker Droplets remotely from one local system. Now you should be able to quickly provision as many Dockerized hosts on your DigitalOcean account as you need.

For more on Docker Machines, visit the official documentation page. The three Bash scripts downloaded in this tutorial are hosted on this GitHub page.
