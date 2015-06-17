From http://code.google.com/p/support/wiki/ImportingFromGit

Introduction
You can have Google Code act as a stable read-only Subversion mirror of a Git project. In this model, patches are first applied to the central Git repository and exported to Google Code later.

Instead of merely providing a link to your repository, why not widen your audience with just a handful of commands? Open up your Git-hosted project to all Subversion users, whose patches can be integrated via Git.

We presume some familiarity with Git, though blindly typing the commands below should produce acceptable results.

1. Create Subversion-aware Git clone
Naturally, your official source tree lives on some Git-capable server, which we denote by $GIT_REPO. http://code.google.com/hosting/createProject creating a new Google Code project, initialize an intermediary repository and fetch the Git tree:

 $ git svn clone --username you https://your-project.googlecode.com/svn/trunk
 $ cd trunk
 $ git fetch $GIT_REPO
The Subversion repository must be nonempty. A new Google Code project contains one revision by default, but if you reset it, you should also create a first revision.

Create a temporary branch for the fetched repository, and tag its head:

 $ git branch tmp $(cut -b-40 .git/FETCH_HEAD)
 $ git tag -a -m "Last fetch" last tmp
2. Apply initial commit
Unfortunately, Git treats the initial commit specially, and in particular, cannot rebase it. Work around this as follows:

 $ INIT_COMMIT=$(git log tmp --pretty=format:%H | tail -1)
 $ git checkout $INIT_COMMIT .
 $ git commit -C $INIT_COMMIT
3. Rebase and submit
Apply all the other commits to the temporary branch, and make it the new master branch:

 $ git rebase master tmp
 $ git branch -M tmp master
Lastly, commit the changes to Google Code:

 $ git svn dcommit
To more faithfully represent deleted subdirectories and copies of unmodified files, run dcommit with the options \--rmdir and \--find-copies-harder. Be aware the latter option can be expensive.

4. Update Google Code
Later, export Git repository updates to Google Code as follows:

 $ git fetch $GIT_REPO
 $ git branch tmp $(cut -b-40 .git/FETCH_HEAD)
 $ git tag -a -m "Last fetch" newlast tmp
 $ git rebase --onto master last tmp
 $ git branch -M tmp master
 $ git svn dcommit
 $ mv .git/refs/tags/newlast .git/refs/tags/last
For simplicity, we've exported directly to Google Code. It may be faster to first export to a local Subversion repository, and then mirror it to Google Code via svnsync.

The content on this page created by Google is licensed under the Creative Commons Attribution 3.0 License. User-generated content is not included in this license.


