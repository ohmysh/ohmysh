oms -h
ohmysh -h

count=0
declare -a array
for i in `ls $OMS_DIR/usr/theme`;do
  echo ${count}
  array[${count}]=${i}
  count=$(expr ${count} + 1)
done
echo ${#array[*]}
for j in ${array[*]}
do
  if [ ${j} != "readme.md" ]
  then
    oms -p enable ${j}
  fi
done

