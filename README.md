<center><h1><img src="https://516wjy.xyz:516/OhMySh-width.png" alt="OhMySh Icon"></h1>

<b>The SH Shell Framework</b></center>

OhMySh is an excellent configuration tool for **SH** that allows you to change the theme of your SH to a good looking one, OhMySh also supports plugins, so you can search for them in the repository. OhMySh also supports plugins and you can search for them in the repository. Of course, OhMySh allows you to write your own themes and plugins!

# Getting Started

## Prepare

OhMySh works on [SH shell (Bourne_shell)](https://en.wikipedia.org/wiki/Bourne_shell). 

So `sh` should be installed, some other tools we need: `curl` `git` .

## Installation

Run scripts below here in SH.

```sh
curl https://raw.githubusercontent.com/ohmysh/ohmysh/main/install.sh > OMSInstaller.sh
sh OMSInstaller.sh
```

## Checking Install

Run script below here in **any** shell.

```sh
sh --login
```

> ### Why with `--login` option
> 
> If you add `--login` option, SH will run OMS. If you don't, SH will not run OMS.

## Change Shell and Start to use

If you had not change sh when Install Script asked you, you can run this script:

```sh
chsh -s /bin/sh
```

And then : restart computer!

**Or** you can run command-line `sh --login` when you want use SH and OMS.

# Using OhMySh

## Themes

OhMySh have a lot of themes for you.

### Get Themes

All theme of OMS is in `$OMS_DIR/usr/theme` folder.

You can also creat a theme by yourself, look [This page](https://github.com/ohmysh/ohmysh/blob/main/usr/theme/readme.md).

### Change Theme

Edit `.profile` file in **home** directory (`~` or `$HOME`).

Change variable `OMS_THEME` to new theme name.

## Plugin

### Get Plugin

All plugins of OMS is in `$OMS_DIR/usr/plugin` folder.

You can also creat a plugin by yourself, look [This page](https://github.com/ohmysh/ohmysh/blob/main/usr/plugin/readme.md).

### Run Plugin

Edit `.profile` file in **home** directory (`~` or `$HOME`).

Change array `OMS_PLUGIN` to plugins name. Like:

```sh
...
OMS_PLUGIN=(helloworld wttr ...)
...
```

# OhMySh Command Line Interface (CLI)

See `ohmysh --help` .

# Uninstalling OhMySh

- If you don't like OhMySh, you can uninstall OhMySh.

```sh
ohmysh --uninstall
```

- If you don't want to use SH, you can change shell.

```sh
chsh -l                   to get list of your shells
chsh -s SHELL-FROM-LIST   to change shell
```

# License

OhMySh is under MIT-License.

# Contributors

OhMySh is not a best project, We need you to help us.

- Email `wjy@516wjy.xyz`
- PullRequest GitHub Repo `ohmysh/ohmysh`

Thanks so much!
