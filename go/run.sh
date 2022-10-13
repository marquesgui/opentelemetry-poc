#!/bin/sh
PIDS=
IS_RUNNING=1
signal_handler()
{
  echo ""
  echo "Caught kill signal, stopping applications"
  for item in "${PIDS[@]}"; do
    echo "Stopping process ${item}"
    kill -9 "${item}"
  done
  IS_RUNNING=0
}
trap signal_handler SIGINT

go run main.go > output1.log 2>&1 &
PIDS[0]=$!
echo "Process ${PIDS[0]} started."

go run main2.go > output2.log 2>&1 &
PIDS[1]=$!
echo "Process ${PIDS[1]} started."

go run main3.go > output3.log 2>&1 &
PIDS[2]=$!
echo "Process ${PIDS[2]} started."

go run main4.go > output4.log 2>&1 &
PIDS[3]=$!
echo "Process ${PIDS[3]} started."

while [ 1 = $IS_RUNNING ]; do
  sleep 1
done