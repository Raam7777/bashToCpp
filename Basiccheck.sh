#!/bin/#!/bash
dirPath=$1
program=$2

if [ ! -f Makefile ]; then
  echo "Makefile not exist"
  exit 7
else
  make

  if [ $? -eq 0 ]; then
    echo "Compilation Succeeded"
    valgrind --leak-check=full --error-exitcode=1 ./$program $res

    if [ $? -eq 0 ]; then
      echo "Memory leaks Succeeded"
      valgrind --tool=helgrind --error-exitcode=1 ./$program $res

      if [ $? -eq 0 ]; then
        echo "Thread race Succeeded"
        exit 0
      else
        echo "Thread race Fail"
        exit 1
      fi

    else
      echo "Memory leaks Fail"
      valgrind --tool=helgrind --error-exitcode=1 ./$program $res
      if [ $? -eq 0 ]; then
        echo "Thread race Succeeded"
        exit 2
      else
        echo "Thread race Fail"
        exit 3
      fi
    fi
  else
    echo "Compilation Fail"
    exit 7
  fi
fi
