# README.md
_(Updated February 2018)_

Daniel Alexander <xandernaut@gmail.com>

### Overview
These are the scripts I like to keep handy -- my setup scripts for my 
computers, and scripts I use to manage my git repositories -- and some config
files.

My setup is a bit idiosyncratic, as I have a set of specific tools that I like
for my various projects. Some of the things I use on all of my computers:
  * Wordgrinder (writing projects)
  * pandoc (document conversion)
  * Atom (coding projects)
  * MuseScore (music composition)
  * Free Pascal (current coding project)
  * some basic development stuff

### Scripts

#### setup.sh (and wordgrinder-install)

This is my basic setup script for all of my computers. It installs the
stuff listed above, plus the Firefox tarball from Mozilla's site.

Firefox gets installed to `~/.local/applications`, which is added to the PATH 
variable in `~/.bashrc`. (Well, as a technicality, it's in the `firefox`
subdirectory, which also gets added to $PATH.) It then builds Wordgrinder from
source (using the `wordgrinder-install` script), then cleans up after itself.

It needs to be run with superuser privileges, because typing "sudo" all the
time gets on my nerves.

`wordgrinder-install` just installs the necessary dependencies, clones the
Wordgrinder repository, builds it, and installs the ncurses release binary
to `~/.local/applications`.


#### commit
_(Requires: wordgrinder, git, pandoc)_

Pretty much what it sounds like; a script to make my commit workflow a little 
easier in my writing projects.

In essence, it does the following things:
  * retrieves names of all Wordgrinder files at top level
  * exports specified documents from each file into proper folders for backup
  * retrieves the name of the current branch and generates a log message
  * commits changes to current branch

Wordgrinder organizes its files as "document sets" -- each file can contain a
large number of separate documents. However, it doesn't easily allow for
exporting the entire document set in one shot, just one document at a time. As
such, `commit` requires a dotfile with a name matching the Wordgrinder project
(for example, `.currentstory`, matching the file `currentstory.wg`), which 
should contain the document names of each document that you want to export.

As an example, my repository might contain these files at the top level:
  * `story.wg`
  * `.story`
  * `story-bible.wg`
  * `.story-bible`

The file `.story` might contain the following documents:
  * `main`
  * `outline`
  * `chapter1`
  * (...)
  * `chapterN`
  * `revision-notes`

Wordgrinder doesn't support Markdown export from the command line at the
moment (it does from inside the program), for the time being, I've written
a workaround.

The script will export each of them into `story/main.html`, etc (preserving
any formatting you've used), and then convert the HTML files to Markdown
using `pandoc` and delete the HTML files.


#### update
_(Requires: git)_

This is a companion to `commit`. It pulls changes to the current repository
from a remote (in my case, a server on my local network) and prints the last
line from `messages.log`.

_Note_: The remote is currently hard-coded as `giant`, the name of my server. 
I may or may not change this in the future, but if you happen to use this 
script, you'll have to change it.


### To-Do

  - [ ] add directory arguments to `commit` and `update` for global use
  - [ ] figure out a way to automatically pull newest stable Firefox tarball
  - [ ] create automatic backup script for git projects on server
