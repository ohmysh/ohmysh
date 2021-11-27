checkcommand curl wttr
if [ -n "$?" ]
then
  alias wttr="curl wttr.in"
fi

