_CACHE_P=${_CACHE_PLUGIN[*]}
sed -n '/OMS_PLUGIN=/p' $HOME/.profile | sed "s/$_CACHE_P//g" $HOME/.profile > $OMS_CACHE/profile
rm "$HOME/.profile"
mv "$OMS_CACHE/profile" "$HOME/.profile"

#for i in "${_CACHE_PLUGIN[*]}"
#do
#    sed -n "/OMS_PLUGIN=(/p" $HOME/.profile | sed "s/(/(\"$i\" /" $HOME/.profile > "$OMS_CACHE/profile"
#done

#rm "$HOME/.profile"
#mv "$OMS_CACHE/profile" "$HOME/.profile"

