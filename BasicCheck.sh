#!/bin/#!/bash
program=$2
res=0
comp="Fail"
memory="Fail"
race="Fail"


  make

  if [ $? -eq 0 ]; then
    echo "Compilation Succeeded"
    comp="Pass"
    valgrind --leak-check=full --error-exitcode=1 ./$program

    if [ $? -eq 0 ]; then
      echo "Memory leaks Succeeded"
      memory="Pass"
      valgrind --tool=helgrind --error-exitcode=1 ./$program

      if [ $? -eq 0 ]; then
        echo "Thread race Succeeded"
        race="Pass"
      else
        echo "Thread race Fail"
        res=$(($res+1))
      fi

    else
      echo "Memory leaks Fail"
      res=$(($res+2))
      valgrind --tool=helgrind --error-exitcode=1 ./$program
      if [ $? -eq 0 ]; then
        echo "Thread race Succeeded"
      else
        echo "Thread race Fail"
        res=$(($res+1))

      fi
    fi
  else
    echo "Compilation Fail"
    res=$(($res+7))

  fi


echo -e "------------------------------------------"
echo -e "Compilation |  Memory leaks |  Thread race"
echo -e "$comp        |   $memory        |    $race"
echo -e "------------------------------------------"
echo -e "$res"
exit $res
