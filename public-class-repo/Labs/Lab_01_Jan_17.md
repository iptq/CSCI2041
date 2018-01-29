# Lab 1: Getting started with GitHub and OCaml

*CSci 2041: Advanced Programming Principles, Spring 2017*

**Due:** Friday, January 20 at 5:00pm.  You should be able to complete
lab work during the lab.   But occasionally some work may not get
completed, thus this due date. 

# Introduction

### Goals of this lab:

+ In this lab you will set up your University of Minnesota GitHub
repository that will be used to turn in your homework assignments for
this course.

+ You will also install the OCaml compilers and associated tools that we
will be using in this class.

+ Finally, you will modify an OCaml program, run it, and turn it in
via GitHub. 


+ There should be enough computers for each person to have their own.

+ If you have a laptop, please feel free to use it for this if you want.  But keep in mind that your homework is graded on the lab machines and must work there.


### GitHub:

* The University of Minnesota has its own GitHub installation that we
  will be using in the course.  We **are not** using
  https://github.com.

* Git is a software version control system that we will be using in
  the class.  You will turn your work in using GitHub, not Moodle.  We
  will provide feedback on your work using GitHub as well.


### Set up your CSE Labs account if you do not have one

If you do not yet have a CSE Labs account (and thus your partner had
to log into the computer) perhaps because your are a College of
Liberal Arts student, then create that account now.

To do so, go to this web site and fill in the requested information:

https://wwws.cs.umn.edu/account-management/


# Lab Steps to Complete

## Working with GitHub and Git

### Initialize your GitHub account

+ If you've never logged into https://github.umn.edu, then do so now.
Then give your University Internet Id (we'll call this UIID for short)
to a lab TA so that they can set up your repository.  This is the same
as the part of your University email address that comes before the
`@umn.edu` part of the address.

+ Note that this is **not** your student ID number that appears on
your student Id card.  We will never ask you for that number.

+ If you've already logged into https://github.umn.edu, then proceed
to the next step since your repository should already be set up.


### Verify that your 2041 repository is set up

+ If your University Internet Id is **user0123** then your repository
will be named **repo-user0123**.  In the examples and text below,
replace **user0123** with your University Internet Id.

+ Log into https://github.umn.edu and select the **umn-csci-2041S17**
organization and click on the repository named **repo-user0123**.

+ At the URL
  https://github.umn.edu/umn-csci-2041S17/repo-user0123 
  you should see a list of files in your repository.  This will
  include only a file named **README.md**.

If this file is not there, speak to a TA in your lab.

This repository is a database containing the files and the history of
all their changes made since they were added to the repository.  It is
much more than a simple copy of a set of files.


### Setting up Git in your CSE Labs account

+ Log into your CSE (College of Science and Engineering) account.

+ Verify Git is installed.  Execute the following:

(But don't type the `%`.  That is meant to symbolize the prompt you see in your terminal window.  It may be different that the `%` sign.  You'll just type `git --version`.  Don't type the `%` in any of the other examples below.) 
``` 
% git --version
```

+ Configure Git.

You need to tell Git what your name, email address and favorite
editor are. Below is the series of commands that you should
enter. Be sure to fill in the appropriate details for yourself 

```
% git config --global user.name "YOUR NAME HERE"
% git config --global user.email "YOUR UMN EMAIL ADDRESS"
% git config --global core.editor "nano"
```

If you have a favorite editor (for example `emacs` or `vim`) then you can enter the command to start that editor where you entered `nano` above.

Note that your name appears between double quotes since it has spaces
in it. Your email address doesn't, so it doesn't need to be in
quotes. If you would like "emacs -nw" as your editor (emacs such that
it doesn't open a new window but opens in the terminal) then you'll
want double quotes around that 2 word phrase. 

Check that these are set correctly; execute

```
git config -l
```


### Create a space for your Git workspaces

Create a directory in your CSE account named "csci2041" 
(You can use some other name, of course, but in the discussion we will assume that you used "csci2041").

```
% mkdir csci2041
% cd csci2041
```

In **csci2041** we will put copies of a "public" read-only repository
containing files that we want to distribute to you during the semester
and also space for your individual repository that only you and the
TAs and instructor have access to.


### Clone your individual repository

The Git "clone" operation makes a copy of a repository and places it
in your account.  This copy contains the files and also all the
history of changes---just like the repository stored on
https://github.umn.edu.

In your **csci2041** directory, execute the following
```
% git clone http://github.umn.edu/umn-csci-2041S17/repo-user1234.git
```

After entering your UIID credentials this will create the directory
called repo-user1234.  
It will contain a **README.md** file.

Execute the following:
```
% cd repo-user1234
% ls
```

When you clone your repository Git will create some hidden files
stored in the **.git** directory that contain the long name of this
repository, so that we won't need to type it anymore.  
This directory contains the copy of the repository with all the past
history of changes to the files and other information.  So now there
are two copies of your repository. 

These hidden files tell Git where the GitHub central server is so that
operations involving the server won't need this long name. 

Execute the following:
```
% ls -a
% ls .git/
```

Modifying these hidden **.git** files by hand, or creating them by
copying directories, is an extremely bad idea. It will cause you many
headaches with Git. **So don't do it!**  


*You only need to do this clone step once to initially install the
repository in your account.*

If you have another computer and want to do some of your homework on
that, then you will need to repeat this step for that computer as
well.


### Commands that access the repository

The following command reads these hidden files and will tell you the
URL of the central repository, and some other information.

Execute the following:
```
% git remote --verbose
```



A status operation will also tell you if you've made changes to your
workspace since the last time you updated it with files from the
repository. This is important because we grade your work by getting it
out of your repository. If it is in your workspace but not the central
GitHub repository we can't see it and it won't be graded.

Run the following: ``` % git status ``` Since the files in your
workspace (see below) and repositories (both local and the one on
https://github.umn.edu) are the same, Git tells you as much.


### Working files

So, if the hidden directory **.git** is another copy of the
repository, what are the files in this directory?

These files are copies of the files that you can edit.  You can create
new files and delete files that are no longer needed.  **But**, we
will need to "commit" any changes that we make to these files to the
repository, eventually, so that the repository and the "working files"
in your account are synchronized.

Create a `Lab_01` directory and change into it by executing the following:
```
% mkdir Lab_01
% cd Lab_01
```

Using the text editor of your choice, create a file named `fib.ml`
in your just-created `Lab_01` directory.  Copy the following OCaml
code into that file and save it.
```
(* Author: Eric Van Wyk
   Modified by: ... replace the text between the dots with your name ... *)

(* A function computing the Fibonacci sequence: 1, 1, 2, 3, 5, 8, ... *)

(* There is a bug in the following program.  Can you fix it? *)

let rec fib x =
  if x < 3 then 1 else fib (n-1) + fib (n-1)
```

Add your name into the comment on the second line of the file.

Don't worry about the rest of the file, we will learn how to read this
OCaml code soon enough.

### Adding files

Check the status of your working files and repository by executing the
following: 
```
% git status
```

This tells you that there is now an "untracked" file named `fib.ml`
and that Git is not tracking changes to this file.  To tell Git to do
so, we must `add` the file using the following command:
```
% git add fib.ml
```

Now run `git status` again and see what it says.  What is Git telling
you here?

### Committing changes

Git is now aware of this file and sees that changes have been made
that have not be "committed".  Only "committed" changes to the file
will be pushed up to the central GitHub server (http://github.umn.edu)
and thus it is only these that will be graded or assessed.

To commit the file changes you've made, execute the following
```
% git commit -a -m "Adding my name to the file"
```

Now go back to your browser and refresh the page showing your
repository.  Does this file show up there?

No, it doesn't.  The **commit** command adds your changes to your
local repository only.  We now need to **push** those changes from
your local repository up to the one stored on https://github.umn.edu.
We will do that next.

But first, run ``` % git status ``` What is it telling you?  Your
changes are committed to the local repository but not the "central"
one on https://github.umn.edu


### Pushing changes

Type
```
% git push
```
This pushes your changes from your local repository up to the central
one. 

Run
```
% git status
```
again.  It should now tell you that your working copy of the files and
both repositories are all synchronized. 


In your web browser, check that a file named `Lab_01_Feedback.md` has
been added to your repository.  You can click on the link to see its
contents.  These files will typically be generated for your
assignments as soon as you push changes to your programs up to GitHub.
If the results here are not what you expect then you need to either
fix the issues identified with your program, or, talk to a TA or post
a question on Moodle to see if there is a problem with the tools that
automatically generate these files.

In this case, these tools will verify that your program is in the
right directory, in the right file, but broken and not yet working.
Later in the lab you will fix the problems.


### Clone the public repository

Go back to your **csci2041** directory, by executing the following
command: 
```
% cd ../..
```

Now clone the public class repository by executing the following
command: 
```
% git clone http://github.umn.edu/umn-csci-2041S17/public-class-repo.git
```

In the directory `Labs` you will see the Markdown file
`Lab_01_Jan_17.md` from which this web page is generated.

When we add new files to the central repository you will be asked to
execute the following:
```
% git pull
```
This "pulls" changes from the central repository down to your local
one and updates the working copy of those files in your account with
the changes. 

Try it.  It doesn't have any effect, but it doesn't cause any harm
either.


## Working with OCaml

### Install OCaml

Go back to your account home directory:
```
% cd
```

Execute the following commands
```
% module add soft/ocaml
% module initadd soft/ocaml
```

The first makes the OCaml tools available for your current shell
session, the second makes them available for future shell sessions.

Execute the following:
```
% which ocaml
```
If it does not display the path to the ocaml compiler 
(it should be **/soft/ocaml-4.03.0/linux_x86_64/bin/ocaml**) 
then talk to your TA.



### Use OCaml

Go back to the `Lab_01` directory in your individual repository.
Perhaps by the following commands: 
```
% cd
% cd csci2041/repo-user0123/Lab_01
```

Start the OCaml interpreter:
```
% ocaml
```

At the Ocaml prompt (#) enter the following (do type "#use", not just
"use"): 
```
#  #use "fib.ml" ;;
```
Note that the prompt is "#" and directives to the interpreter to load
files and quit also begin with a "#". 

OCaml will report an error in the program:
> File "fib.ml", line 10, characters 30-31:
> Error: Unbound value n 

Quit OCaml using the "quit" command as illustrated below:
```
# #quit ;;
```

Use an editor of your choice (emacs, vim, gedit, etc.) to replace 
the variable `n` with the correct variable `x`.

Also, replace the text between dots in the comment with your name if
you've not already done so.

Save the file and repeat the steps above to start OCaml and load the file.

Now compute the 5th Fibonacci number by typing the following:
```
# fib 5 ;;
```


### Fix the sample file

Using a text editor edit the `fib.ml` file.

Fix the bug in the definition of the function `fib`.  You should just
need to replace a `1` with a `2` somewhere and replace the variable
`n` with the variable `x`.


There is a bug in this program.  It will return `16` instead of the
correct answer of `5`.  Let's fix that bug now.

Also, `fib 0` will return `1` instead of `0`.  You will need an additional
if-then-else expression to check if `x = 0` and then evaluate to `0`.  The 'else' branch of this new
if-then-else expression will be the if-then-else expression that is there now.  It should look something like 
the following
```
let rec fib x =
  if x = 0 then 0 else
    if x < 3 then 1 else fib (n-1) + fib(n-2)
```

After you've saved the file, test it.  Fire up `ocaml` again and see
if you get the right answer. 


### Commit and push so that the corrected version is up on GitHub.  

Now you need to just turn in your work.  First, see what Git says
about the status of your files 
```
% git status
```
It tells you that a file has been modified.  
You now need to commit your changes and push them up to your central
GitHub repository. 

Execute the appropriate `git add` and `git commit` commands and the
run `git push`.  What is the error message that you get?

It is telling you that changes have been made to code up on the GitHub
server and that you need to "pull" those changes before you can "push"
new changes up to the repository.

Execute the following:
```
% git pull
```

The above command "should" work and seems to work for many of you.  If it doesn't you'll get a message about the need to "merge" the local repository in your account with the repository up on the https://github.umn.edu server.
You will be put into an editor window where you could enter a message to document this "merge" operation.  There is no need for this comment, so just save the file.   Now try `git pull` again.  It should tell you that your repository is already up to date.

You should now see that feedback file in your local directory (just
above your `Lab_01` directory.  Verify that it is there.


Now do a `git push` to see that your changed code is pushed up to the
Github server.  Also verify that the feedback file gets updated to
indicate that your code is now working properly.

Verify that this worked, by using your browser to see the changes on
https://github.umn.edu. 


This concludes Lab 01.


### **Due:** Friday, January 20 at 5:00pm.  

You should be able to complete lab work during the lab.  But
occasionally some work may not get completed, thus this due date.

Note that these changes must exist in your repository on
https://github.umn.edu.  Doing the work, but failing to push those
changes to your central repository cannot be assessed.

After the due date, we will typically run additional tests and the
results of this assessment will be put a file named
`Lab_01_Assessment.md` in your repository.  This file will have your
score for the lab.  A similar pattern will be repeated for other
assignments. 

