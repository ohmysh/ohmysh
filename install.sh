#/bin/sh

# OhMySh

# config
OMS="$HOME/.ohmysh"
OMS_RC="#
# CREATED BY OhMySh <https://github.com/ohmysh/ohmysh>
# OhMySh
#

# OhMySh work dir. Please don't edit it!
OMS_DIR='$OMS'

# OhMySh theme
OMS_THEME='colorshell'
OMS_PLUGIN=(helloworld)

# OhMySh main script
source \"\$OMS_DIR/main.sh\"

# Global defines
# Such as 'alias XXXX=\"XXXX\"'
"
OMS_RC_D="$HOME/.profile"

# install
echo ' Welcome to OhMySh installer script! '
echo '   OhMySh <https://github.com/ohmysh/ohmysh>'
echo ' >> Getting scripts'
git clone https://github.com/ohmysh/ohmysh.git "$OMS"
echo ' >> Putting config file'
echo $OMS_RC > "$OMS_RC_D"

echo ' OhMySh is already installed! '

# config
echo ' Configing... '
echo ' >> Checking shell'
if [ $SHELL != "/bin/sh" ] ; then
  echo '    -> Do you want to change shell to "sh"? It will work with OhMySh (Y/N)'
  read ch
  if [ "$ch" = 'Y' ] || [ "$ch" = 'y' ] ; then
    echo '    -> Change shell to "sh" '
    chsh -s /bin/sh || echo '    -> Change ERROR!!! Try to run "chsh -s /bin/sh" when script exit'
  else
    echo '    -> You chose NO'
  fi
fi

echo ' Installed OhMySh! '


