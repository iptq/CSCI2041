# Setup Git to use SSH

By now you are probably sick of typing in your username and password every time
you need to pull or push to the Git repo. You can avoid this by using SSH to
connect to GitHub. With HTTPS, you must authenticate with a username and
password every time you want to connect to your repo on GitHub. With SSH, you
authenticate via file stored on your computer.

*Note: Please use your internet id (i.e. smith082) in place of
"YOUR_INTERNET_ID" throughout this tutorial*

### Creating an SSH identity

To use SSH to connect to GitHub, you must first create an SSH identity (key).
This is done with the `ssh-keygen` command.

```shell
$ ssh-keygen -t rsa -b 4096 -C "YOUR_INTERNET_ID@umn.edu"
```

The following will show up in your terminal. Press enter when you are asked
where to save your SSH key. This will save it in the default location.

```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/YOUR_INTERNET_ID/.ssh/id_rsa):
Created directory '/home/YOUR_INTERNET_ID/.ssh'.
```

When you are prompted to enter a passphrase, press enter again.

```
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

You should now have two keys saved in `/home/YOUR_INTERNET_ID/.ssh`.

`id_rsa` - This is your **private** key and should be kept secret. Do not share
this with anyone or put this on the internet.

`id_rsa.pub` - This is your public key. It is safe to share this, and it can be
used to identify you uniquely when logging in.

### Configuring GitHub to recognize your SSH identity

Go to https://github.umn.edu/settings/keys and click on *New SSH key*.
You should now be prompted to enter in a Title and Key. The title can be
whatever you want (e.g. "main"). The Key should be your SSH **public** key. Your
public key can be found by with the command below:

```shell
$ cat ~/.ssh/id_rsa.pub
```

Copy the output from this command into the Key section and click *Add SSH key*.

### Changing Git remote

To switch over from HTTPS to SSL, cd into your private repo and run this
command.

```shell
$ git remote set-url origin git@github.umn.edu:umn-csci-2041S17/repo-YOUR_INTERNET_ID.git
```
