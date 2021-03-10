qubes-gentoo
===

**This is an unofficial gentoo [ebuild repository](https://wiki.gentoo.org/wiki/Ebuild_repository)**

## List of Packages ##

* **app-text/pandoc-bin**. Compiling and updating *app-text/pandoc* can be tedious, particularly if you are not interested in other Haskell packages (see [1](https://bugs.gentoo.org/565364) and [2](https://forums.gentoo.org/viewtopic-t-1111514-highlight-pandoc.html)). This package provides a binary package for *app-text/pandoc*.


## Installation ##


**Add qubes repository**:

\# mkdir /var/db/repos/qubes

Edit the file */etc/portage/repos.conf*. For example: 
```
    [qubes]
    location = /var/db/repos/qubes
    auto-sync = yes
    sync-type = git
    sync-uri = https://github.com/fepitre/qubes-gentoo
```

\# emaint sync --repo qubes

**Emerge package**

For example, to install *app-text/pandoc-bin*:

\# echo "app-text/pandoc-bin ~amd64" >> /etc/portage/package.accept_keywords/pandoc-bin

\# emerge -av app-text/pandoc-bin
