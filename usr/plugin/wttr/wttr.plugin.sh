check-command curl wttr
if [ -n $? ]
then
  curl wttr.in
fi

