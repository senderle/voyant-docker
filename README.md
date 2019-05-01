# voyant-docker

This contains everything you need to set up a Voyant server behind an 
SSL-enabled proxy, with corpora preloaded. (Well, sort of; see below.)

## Setup

This should work for any server running Ubuntu or Debian. Many of the details
will be the same on other servers, but you may have to consult other sources 
for the docker and docker-compose installation processes. I assume you have
admin access and, if necessary, know what [sudo](https://en.wikipedia.org/wiki/Sudo)
is and [how to use it](https://xkcd.com/149/).

### Install Docker

I've broken this down into invidual steps to explain what's going on, but you can
just copy the shell commands and run them one-by-one. These steps are necessary
to ensure that the most up-to-date version of Docker is being installed by the 
Ubuntu's package manager.

1. First, we need to add the Docker repository key. This makes sure that the package 
manager knows to trust Docker's repository.

        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

2. Next, we add the repository itself to the package manager's list of repositories:

        sudo add-apt-repository \
            "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

3. Having done so, we also have to tell the package manager to update its index of available packages:

        sudo apt-get update

4. To confirm that we have done everything correctly, we run a quick check to see what
versions of docker the package manager thinks are avaialble:

        apt-cache policy docker-ce

    If everything is working as expected, and assuming Docker isn't already installed, you should see something like this:

        terminal-prompt:~# apt-cache policy docker-ce
        docker-ce:
          Installed: (none)
          Candidate: 5:18.09.5~3-0~ubuntu-bionic
                 ...
                 ... more irrelevant lines ...
                 ...
                 
5. Finally, we actually install Docker:

        sudo apt-get install -y docker-ce

### Install Docker Compose

Installing Docker Compose is both more and less straightforward. More straightforward 
because we aren't using the package manager at all, and are just plunking a file down
in one of the `bin` folders full of executable files. Less straightforward because, 
well, we are just plunking a file down, which means we don't get the network-of-trust
guarantees that come from using a package manager. 

Why don't we use a package manager? Because we need to install a more recent version
of Docker Compose than is apparently available via any ordinary package manager setup.

Why is there not a way to install a recent-enough version using the package manager? I 
don't know. Hopefully that will change soon. 

(By the way, these instructions are basically taken verbatim from the 
[Digital Ocean](https://www.digitalocean.com/community/tutorials/how-to-install-docker-compose-on-ubuntu-16-04)
docs.

1. Download the `docker-compose` binary into `/usr/local/bin`:

        sudo curl -L https://github.com/docker/compose/releases/download/1.18.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
   
2. Make the binary executable:

        sudo chmod +x /usr/local/bin/docker-compose

3. Test to make sure the installation worked:

        sudo docker-compose --version

    If it worked, you should see something like this:
    
        docker-compose version 1.18.0, build 8dd22a9
        docker-py version: 2.6.1
        CPython version: 2.7.13
        OpenSSL version: OpenSSL 1.0.1t  3 May 2016
    
### Set up the Voyant repository

1. Make sure `git` is installed:

        sudo apt install git
        
2. Clone (i.e. download) this repository:

        git clone https://github.com/senderle/voyant-docker
    
3. Put your corpora in the `corpora` folder. Each corpus should be a single `zip` file
containing text files (or any other kind of file that Voyant can load -- including word documents
and html files). There is already one example corpus in the folder, called `three-by-mary-shelley.zip`.

Unfortunately this stage can't be condensed into a simple step. You will probably need to use a command like 
[`scp`](http://www.hypexr.org/linux_scp_help.php) or set up
[`sftp`](https://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server)
to do this. You could also fork this repository (if you do that kind of thing), add your corpora to the fork,
and clone that instead in step 2.

4. Build the docker images. To run this command, you'll need to move into the `voyant-docker` directory:

        cd voyant-docker
        sudo docker-compose build
        
5. Finally, run the server:

        sudo docker-compose up -d

    This runs the server in detatched mode, so you can log off and everything will keep working. To shut down
    the server, make sure you're in the `voyant-docker` folder and run this command:
    
        sudo docker-compose down
        
    Finally, if you think there are errors and want to see the messages, make sure you're in the `voyant-docker
    and run this command:
    
        sudo docker-compose up
        
    This attaches the server to your current terminal, so that you can't exit without shutting down
    the server. (There are ways to detatch again, but that's beyond the scope of this readme!)


