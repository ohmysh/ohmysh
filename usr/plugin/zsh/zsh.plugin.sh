#!/bin/bash

echo $PS1 > $OMS_CACHE/zsh-temp
isperl=$(checkcmd perl)
if [ $isperl != "1" ]
then
	_error 'Cannot found command "perl", please install it!'
	exit 1
fi
if [ $OMS_OTHER_SHELL = "zsh" ]
then
	autoload -U colors && colors
	unset PS1
	PROMPT=$(perl $OMS_DIR/usr/plugin/zsh/prompt $OMS_CACHE/zsh-temp)
	#unset PS1
else
	echo 'Run command "chsh -s /usr/bin/zsh" to change your shell to zsh!'
fi
