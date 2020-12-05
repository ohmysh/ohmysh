<center><h1><img src="https://516wjy.xyz:516/OhMySh-width.png" alt="OhMySh Icon"></h1></center>

- OhMySh Main Repository.
- OhMySh Dev is a part of [LanGong Dev](https://github.com/langong-dev).

# Getting OhMySh

## Prepare

OhMySh is for SH, so every SH in **all platform** can run OMS!

You have to install `curl` `sh` `git` , because OhMySh need them.

## Getting OhMySh

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

## Install error code

- **Error code `1`** OMS cannot found some application for run OMS, you can read "Prepare" to fix
- **Cannot run OMS** run Install Script again to fix it.

# Config

## Themes

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
