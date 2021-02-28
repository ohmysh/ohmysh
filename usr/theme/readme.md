# `/usr/theme` of OhMySh

`/usr/theme` directory is for save themes

## Creat a new theme by yourself

1. Creat a folder and named with your theme name in `$OMS_DIR/usr/local/theme`.
2. Creat a file and named `YOUR-THEME-NAME.theme.sh`
3. Edit it

## Theme config file guide

`...@... $` The command prompt will be stored here in the variable `OMS_THEME_PS`. Here are some shortcuts.

- `\d` the date in “Weekday Month Date” format (e.g., “Tue May 26”)
- `\D{format}` : the format is passed to strftime(3) and the result is inserted into the prompt string; an empty format results in a locale-specific time representation. The braces are required
- `\h` : the hostname up to the first ‘.’
- `\H` : the hostname
- `\j` : the number of jobs currently managed by the shell
- `\l` : the basename of the shellâ€™s terminal device name
- `\n` : newline
- `\r` : carriage return
- `\s` : the name of the shell, the basename of $0 (the portion following the final slash)
- `\t` : the current time in 24-hour HH:MM:SS format
- `\T` : the current time in 12-hour HH:MM:SS format
- `\@` : the current time in 12-hour am/pm format
- `\A` : the current time in 24-hour HH:MM format
- `\u` : the username of the current user
- `\v` : the version of bash (e.g., 2.00)
- `\V` : the release of bash, version + patch level (e.g., 2.00.0)
- `\w` : the current working directory, with $HOME abbreviated with a tilde
- `\W` : the basename of the current working directory, with $HOME abbreviated with a tilde
- `\!` : the history number of this command
- `\#` : the command number of this command
- `\$` : if the effective UID is 0, a #, otherwise a $
- `\nnn` : the character corresponding to the octal number nnn
- `\\`: a backslash
- `\[` : begin a sequence of non-printing characters, which could be used to embed a terminal control sequence into the prompt
- `\]` : end a sequence of non-printing characters

### Examples

```sh
OMS_THEME_PS='\u@\h \w \$ '
```

It will be: `USERNAME@HOSTNAME PATH $ `

### Colors

See `/lib/theme.sh`

## Publish to OhMySH official theme group

If you want to publish to our official theme group, you may have to do this:

1. Pull a request on `ohmysh/ohmysh` of GitHub repo.
2. Move your theme folder into `$OMS_DIR/usr/theme/`


