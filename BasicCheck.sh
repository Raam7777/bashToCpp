#!/bin/#!/bash
folderName=$1
program=$2
currentfolder=$(pwd)
res=0
comp="Fail"
memory="Fail"
race="Fail"

cd $folderName
make

if [[ $? -eq 0 ]]; then
  comp="Pass"
  valgrind --leak-check=full --error-exitcode=1 ./$program > /dev/null 2>&1

  if [[ $? -ne 1 ]]; then
    memory="Pass"
    valgrind --tool=helgrind --error-exitcode=1 ./$program > /dev/null 2>&1

    if [[ $? -ne 1 ]]; then
      race="Pass"
    else
      res=$(($res+1))
    fi

  else
    res=$(($res+2))
    valgrind --tool=helgrind --error-exitcode=1 ./$program > /dev/null 2>&1
    if [[ $? -ne 1 ]]; then
    else
      res=$(($res+1))

    fi
  fi
else
    res=$(($res+7))

  fi

cd $currentfolder
echo -e "------------------------------------------"
echo -e "Compilation |  Memory leaks |  Thread race"
echo -e "$comp        |   $memory        |    $race"
echo -e "------------------------------------------"
exit $res
