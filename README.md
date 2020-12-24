<center><h1><img src="https://516wjy.xyz:516/OhMySh-width.png" alt="OhMySh Icon"></h1>

<b>The SH Shell Framework</b></center>

[GitHub](https://github.com/ohmysh/ohmysh) | [FAQ](https://github.com/ohmysh/ohmysh/blob/main/FAQ.md) | [Getting Start](https://github.com/ohmysh/ohmysh#getting-started) | [Using OhMySh](https://github.com/ohmysh/ohmysh#using-ohmysh) | [View License](https://github.com/ohmysh/ohmysh/blob/main/LICENSE)

OhMySh is an excellent configuration tool for **SH** that allows you to change the theme of your SH to a good looking one, OhMySh also supports plugins, so you can search for them in the repository. OhMySh also supports plugins and you can search for them in the repository. Of course, OhMySh allows you to write your own themes and plugins!

# Getting Started

## Prepare

OhMySh works on [SH shell (Bourne shell)](https://en.wikipedia.org/wiki/Bourne_shell) or GNU-Bash. 

So `sh (>=5.x.x)` should be installed, some other tools we need: `curl` `git` .

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

All theme of OMS is in `$OMS_DIR/usr/theme` folder, run this command to get list of themes:

```sh
oms --themelist
```

You can also creat a theme by yourself, look [This page](https://github.com/ohmysh/ohmysh/blob/main/usr/theme/readme.md).

### Change Theme

Run this command:

```sh
oms -t THEME-NAME
```

> `THEME-NAME` is your new theme name

## Plugin

### Get Plugin

All plugins of OMS is in `$OMS_DIR/usr/plugin` folder, run this command to get list of plugins.

```sh
oms --pluginlist
```

You can also creat a plugin by yourself, look [This page](https://github.com/ohmysh/ohmysh/blob/main/usr/plugin/readme.md).

### Run Plugin

Run this command:

- `TYPE` : There are 3 types, `enable` (Enable a plugin), `disable` (Disable a plugin), `restart` (Restart a **ENABLED** plugin).
- `PLUGIN-NAME` : The plugin name you want to run or stop.

```sh
oms -p TYPE PLUGIN-NAME
```

## Aliases

If you want to add some aliases, run `oms --alias` (and edit with `vi`) or `oms --alias EDITOR` (edit with `EDITOR`)


# OhMySh FAQ

[FAQ](https://github.com/ohmysh/ohmysh/blob/main/FAQ.md)

# OhMySh Command Line Interface (CLI)

OhMySh Command Line Interface (CLI) is a command line tool for OhMySh. You can use it to change theme, run plugin and do more things!

See `ohmysh --help` or `oms --help` .

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

