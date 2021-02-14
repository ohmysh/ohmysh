<center><h1><img src="https://516wjy.xyz:516/OhMySh-width.png" alt="OhMySh Icon"></h1>

<b>The SH Shell Framework</b></center>

[GitHub](https://github.com/ohmysh/ohmysh) | [FAQ](https://github.com/ohmysh/ohmysh/blob/main/FAQ.md) | [Getting Started](https://github.com/ohmysh/ohmysh#getting-started) | [Using OhMySh](https://github.com/ohmysh/ohmysh#using-ohmysh) | [View the  License](https://github.com/ohmysh/ohmysh/blob/main/LICENSE)

OhMySh is an excellent configuration tool for **SH** that allows you to change the theme of SH. OhMySh supports plugins. You can get them from the repository. OhMySh also supports plugins. You can get them from the repository too. For advanced users, OhMySh also supports customized themes and plugins!

# Getting Started

## Preparation

OhMySh works with [SH shell (Bourne shell)](https://en.wikipedia.org/wiki/Bourne_shell) and GNU-Bash. 

So make sure `sh (>=5.x.x)` was installed. There are some dependences: `curl` `git` .

## Installation

Run the following commands with SH.

```sh
curl https://raw.githubusercontent.com/ohmysh/ohmysh/main/install.sh > OMSInstaller.sh
sh OMSInstaller.sh
```

## Checking the Installation

Run the following script with **any** shell.

```sh
sh --login
```

> ### Why with `--login` option
> 
> If you run SH with the `--login` option, SH will run OMS automatically.

## Getting ready to use

If you didn't change default shell to SH while installing the OMS, you can run this comand and reboot your machine after that:

```sh
chsh -s /bin/sh
```

**Or** run command `sh --login` if you want to use it.

# Using OhMySh

## Themes

OhMySh has various themes for you.

### Getting the Theme

All the themes of OMS are installed at `$OMS_DIR/usr/theme`. Run the following command to get a list of them:

```sh
oms --themelist
```

You can also make a customized theme by yourself. Read [This page](https://github.com/ohmysh/ohmysh/blob/main/usr/theme/readme.md).

### Changing the Theme

Run the following command:

```sh
oms -t THEME-NAME
```

> `THEME-NAME` is the name of the theme you want.

## Plugins

### Getting Plugins

All the plugins of OMS are installed at `$OMS_DIR/usr/plugin` folder. Run the following command to get a list of them.

```sh
oms --pluginlist
```

You can also make a customized plugin by yourself. Read [This page](https://github.com/ohmysh/ohmysh/blob/main/usr/plugin/readme.md).

### Running Plugins

Run the following command:

```sh
oms -p TYPE PLUGIN-NAME
```

- `TYPE` : There are 3 options, `enable` (Enable a plugin), `disable` (Disable a plugin), `restart` (Restart a **ENABLED** plugin).
- `PLUGIN-NAME` : The plugin name you want.

## Aliases

If you want to modify the aliases settings, run `oms --alias` (and edit it with `vi`) or `oms --alias EDITOR` (edit it with the custom `EDITOR`)

# OhMySh FAQ

[FAQ](https://github.com/ohmysh/ohmysh/blob/main/FAQ.md)

# OhMySh Command Line Interface (CLI)

OhMySh Command Line Interface (CLI) is a command line tool for OhMySh. You can use it to change the theme, run plugins and do more things!

See `ohmysh --help` or `oms --help` .

# Uninstalling OhMySh

- If you want to remove OhMySh (TwT), uninstall it with the following command.

```sh
ohmysh --uninstall
```

- Changing back to the default shell

```sh
chsh -l                   getting list of shells
chsh -s SHELL-FROM-LIST   changing the default shell
```

# License

OhMySh is under MIT-License.

# Contributors

OhMySh is not the best. We need your help. Contact us by the following ways:

- Email `wjy@516wjy.xyz`
- PullRequest GitHub Repo `ohmysh/ohmysh`

Thanks!
