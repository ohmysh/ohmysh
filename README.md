<center><h1><img src="https://516wjy.xyz:516/OhMySh-width.png" alt="OhMySh Icon"></h1>

<b>The Shell Framework</b></center>

[GitHub](https://github.com/ohmysh/ohmysh) | [FAQ](https://ohmysh.github.io/docs-v2/#/other/faq) | [Getting Started](https://ohmysh.github.io/docs-v2/#/getting-started/install) | [View the  License](https://github.com/ohmysh/ohmysh/blob/main/LICENSE)

OhMySh is an excellent configuration tool for **SH** that allows you to change the theme of SH. OhMySh supports plugins. You can get them from the repository. OhMySh also supports plugins. You can get them from the repository too. For advanced users, OhMySh also supports customized themes and plugins!

# Getting Started

[More in our docs](https://ohmysh.github.io/docs/?file=001-Getting%20Started/001-Installation%20Guide)

## Preparation

OhMySh works with [SH shell (Bourne shell)](https://en.wikipedia.org/wiki/Bourne_shell) and GNU-Bash. 

So make sure `sh (>=5.x.x)` was installed. There are some other dependences: `curl` `git` .

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

> ### Running SH with `--login` option
> 
> If you run SH with the `--login` option, SH will run OMS automatically.

## Getting ready to use

If you didn't change default shell to SH while installing the OMS, you can run this comand and reboot your machine after that:

```sh
chsh -s /bin/sh
```

**Or** run command `sh --login` if you want to use it.

# Using OhMySh

[See in Docs](https://ohmysh.github.io/docs)

# OhMySh FAQ

[FAQ](https://ohmysh.github.io/docs/index.html?file=003-FAQ/001-FAQ)

# OhMySh Command Line Interface (CLI)

OhMySh Command Line Interface (CLI) is a command line tool for OhMySh. You can use it to change the theme, run plugins and do more things!

See `ohmysh --help` or `oms --help` .

# More

[Our Docs](https://ohmysh.github.io/docs)

# License

OhMySh is under MIT-License.

# Contributors

OhMySh is not the best. We need your help. Contact us by the following ways:

- Email `wjy@516wjy.xyz`
- PullRequest GitHub Repo `ohmysh/ohmysh`

Thanks!
