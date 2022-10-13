#!/bin/bash
PIDS=
trap signal_handler SIGTERM
signal_handler()
{
  echo "Caught kill signal, stopping applications"
  for item in "${PIDS[@]}"; do
    kill -9 "${item}"
  done
}

PID=$(go run main.go > output.log 2>&1 & | awk '{print $2}')
PIDS[0]=PID

PID=$(go run main2.go > output.log 2>&1 & | awk '{print $2}')
PIDS[1]=PID

PID=$(go run main3.go > output.log 2>&1 & | awk '{print $2}')
PIDS[1]=PID

PID=$(go run main4.go > output.log 2>&1 & | awk '{print $2}')
PIDS[1]=PID
