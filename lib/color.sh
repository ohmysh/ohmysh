## blue to echo 
function blue(){
    echo -e "\033[34m$1\033[0m"
}


## green to echo 
function green(){
    echo -e "\033[32m[ $1 ]\033[0m"
}

## Error to warning with blink
function bred(){
    echo -e "\033[31m\033[01m\033[05m$1\033[0m"
}

## Error to warning with blink
function byellow(){
    echo -e "\033[33m\033[01m\033[05m$1\033[0m"
}


## Error
function bred(){
    echo -e "\033[31m\033[01m$1\033[0m"
}

## warning
function byellow(){
    echo -e "\033[33m\033[01m$1\033[0m"
}

_error(){
  if [ -z $2 ]
  then
    tp="[ERROR] OhMySh"
  elif [ -z $3 ]
  then
    tp="[ERROR] OhMySh::$2"
  else
    tp="[ERROR $3] OhMySh::$2"
  fi
  bred " $tp : $1"
}

_warn(){
  if [ -z $2  ]
  then
    tp="[WARNING] OhMySh"
  else
    tp="[WARNING] OhMySh::$2"
  fi
  byellow " $tp : $1"
}

_info(){
    if [ -z $2  ]
    then
        tp="[INFO] OhMySh"
    else
        tp="[INFO] OhMySh::$2"
    fi
    blue " $tp : $1"
}

