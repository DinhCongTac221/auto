#!/bin/bash

################################################################################
# Helper Script for Movement Control
#
# This script provides functions and commands for controlling the Movement
# environment. It includes functions to start and stop AvalancheGo, the
# avalanche-network-runner server, and the subnet-request-proxy Node.js server.
#
# Usage: movementctl [start/stop] [fuji/local/subnet-proxy] [--foreground]
#
# Author: Liam Monninger
# Version: 2.0
################################################################################

VM_NAME="m1testnetv0"
SUBNET_ID="X9ntefVrtUgpve4UGSa87jq9VKwE5f8mkYigyFnUPfyXpu8jn"
PID_DIR="$HOME/.movement/pid"
mkdir -p "$PID_DIR"

RUN_IN_FOREGROUND="false"
if [[ "${@: -1}" == "--foreground" ]]; then
    RUN_IN_FOREGROUND="true"
fi

# Starts avalanchego with the specified network ID and subnet ID
function start_avalanchego() {
  network_id="$1"
  subnet_id="$2"
  
  if [[ $RUN_IN_FOREGROUND == "true" ]]; then
    avalanchego --network-id=fuji --public-ip=65.21.241.106 --http-port=9650 --staking-port=9651 --bootstrap-ips="18.192.93.241:9651,3.76.143.200:9651,16.163.84.252:9651,13.237.111.196:9651,18.167.242.179:9651,54.207.25.7:9651,15.184.214.136:9651,13.55.124.229:9651,3.99.55.15:9651,157.241.59.198:9651,52.29.72.46:9651,16.163.75.62:9651,34.248.69.195:9651,54.66.120.144:9651,3.97.132.61:9651,18.230.111.83:9651,52.67.156.131:9651,176.34.80.199:9651,176.34.97.64:9651,3.97.255.92:9651,15.184.142.50:9651" --bootstrap-ids="NodeID-2m38qc95mhHXtrhjyGbe7r2NhniqHHJRB,NodeID-JjvzhxnLHLUQ5HjVRkvG827ivbLXPwA9u,NodeID-LegbVf6qaMKcsXPnLStkdc1JVktmmiDxy,NodeID-HGZ8ae74J3odT8ESreAdCtdnvWG1J4X5n,NodeID-CYKruAjwH1BmV3m37sXNuprbr7dGQuJwG,NodeID-4KXitMCoE9p2BHA6VzXtaTxLoEjNDo2Pt,NodeID-LQwRLm4cbJ7T2kxcxp4uXCU5XD8DFrE1C,NodeID-4CWTbdvgXHY1CLXqQNAp22nJDo5nAmts6,NodeID-4QBwET5o8kUhvt9xArhir4d3R25CtmZho,NodeID-JyE4P8f4cTryNV8DCz2M81bMtGhFFHexG,NodeID-EDESh4DfZFC15i613pMtWniQ9arbBZRnL,NodeID-BFa1padLXBj7VHa2JYvYGzcTBPQGjPhUy,NodeID-CZmZ9xpCzkWqjAyS7L4htzh5Lg6kf1k18,NodeID-FesGqwKq7z5nPFHa5iwZctHE5EZV9Lpdq,NodeID-84KbQHSDnojroCVY7vQ7u9Tx7pUonPaS,NodeID-CTtkcXvVdhpNp6f97LEUXPwsRD3A2ZHqP,NodeID-hArafGhY2HFTbwaaVh1CSCUCUCiJ2Vfb,NodeID-4B4rc5vdD1758JSBYL1xyvE5NHGzz6xzH,NodeID-EzGaipqomyK9UKx9DBHV6Ky3y68hoknrF,NodeID-NpagUxt6KQiwPch9Sd4osv8kD1TZnkjdk,NodeID-3VWnZNViBP2b56QBY7pNJSLzN2rkTyqnK" --track-subnets "X9ntefVrtUgpve4UGSa87jq9VKwE5f8mkYigyFnUPfyXpu8jn"
  else
    avalanchego --network-id=fuji --public-ip=65.21.241.106 --http-port=9650 --staking-port=9651 --bootstrap-ips="18.192.93.241:9651,3.76.143.200:9651,16.163.84.252:9651,13.237.111.196:9651,18.167.242.179:9651,54.207.25.7:9651,15.184.214.136:9651,13.55.124.229:9651,3.99.55.15:9651,157.241.59.198:9651,52.29.72.46:9651,16.163.75.62:9651,34.248.69.195:9651,54.66.120.144:9651,3.97.132.61:9651,18.230.111.83:9651,52.67.156.131:9651,176.34.80.199:9651,176.34.97.64:9651,3.97.255.92:9651,15.184.142.50:9651" --bootstrap-ids="NodeID-2m38qc95mhHXtrhjyGbe7r2NhniqHHJRB,NodeID-JjvzhxnLHLUQ5HjVRkvG827ivbLXPwA9u,NodeID-LegbVf6qaMKcsXPnLStkdc1JVktmmiDxy,NodeID-HGZ8ae74J3odT8ESreAdCtdnvWG1J4X5n,NodeID-CYKruAjwH1BmV3m37sXNuprbr7dGQuJwG,NodeID-4KXitMCoE9p2BHA6VzXtaTxLoEjNDo2Pt,NodeID-LQwRLm4cbJ7T2kxcxp4uXCU5XD8DFrE1C,NodeID-4CWTbdvgXHY1CLXqQNAp22nJDo5nAmts6,NodeID-4QBwET5o8kUhvt9xArhir4d3R25CtmZho,NodeID-JyE4P8f4cTryNV8DCz2M81bMtGhFFHexG,NodeID-EDESh4DfZFC15i613pMtWniQ9arbBZRnL,NodeID-BFa1padLXBj7VHa2JYvYGzcTBPQGjPhUy,NodeID-CZmZ9xpCzkWqjAyS7L4htzh5Lg6kf1k18,NodeID-FesGqwKq7z5nPFHa5iwZctHE5EZV9Lpdq,NodeID-84KbQHSDnojroCVY7vQ7u9Tx7pUonPaS,NodeID-CTtkcXvVdhpNp6f97LEUXPwsRD3A2ZHqP,NodeID-hArafGhY2HFTbwaaVh1CSCUCUCiJ2Vfb,NodeID-4B4rc5vdD1758JSBYL1xyvE5NHGzz6xzH,NodeID-EzGaipqomyK9UKx9DBHV6Ky3y68hoknrF,NodeID-NpagUxt6KQiwPch9Sd4osv8kD1TZnkjdk,NodeID-3VWnZNViBP2b56QBY7pNJSLzN2rkTyqnK" --track-subnets "X9ntefVrtUgpve4UGSa87jq9VKwE5f8mkYigyFnUPfyXpu8jn" &
    echo $! >> "$PID_DIR/avalanchego.pid"
  fi
}

# Starts the avalanche-network-runner server
function start_avalanche_network_runner() {

    cd $HOME/.movement/M1/m1
    $HOME/.movement/M1/m1/run.debug.sh
    
}

# Starts the subnet-request-proxy Node.js server
function start_subnet_proxy() {
  cd "$HOME/.movement/M1/ecosystem/subnet-request-proxy"
  npm i
  
  if [[ $RUN_IN_FOREGROUND == "true" ]]; then
    node app.js
  else
    node app.js &
    echo $! >> "$PID_DIR/subnet_proxy.pid"
  fi
}

function start_mevm(){

  cd "$HOME/.movement/M1/ecosystem/evm-runtime"
  npm i

  if [[ $RUN_IN_FOREGROUND == "true" ]]; then
    npm run start
  else
    npm runs start  &
    echo $! >> "$PID_DIR/mevm.pid"
  fi

}

# Stops a process based on the provided PID file
function stop_process() {
  local process_name="$1"
  local pid_file="$PID_DIR/$process_name.pid"

  if [ -f "$pid_file" ]; then
    while read -r pid; do
      kill "$pid" || true
    done < "$pid_file"
    rm "$pid_file"
  else
    echo "No $process_name process found."
  fi
}

# Handle the start command
function start() {
  case $1 in
    fuji)
      start_avalanchego "fuji" $SUBNET_ID
      ;;
    local)
      start_avalanche_network_runner
      ;;
    subnet-proxy)
      start_subnet_proxy
      ;;
    mevm)
      start_mevm
      ;;
    *)
      echo "Invalid start command. Usage: movementctl start [fuji/local/subnet-proxy] [--foreground]"
      exit 1
      ;;
  esac
}

# Handle the stop command
function stop() {
  case $1 in
    fuji)
      stop_process "avalanchego"
      ;;
    local)
      stop_process "avalanche_network_runner"
      ;;
    subnet-proxy)
      stop_process "subnet_proxy"
      ;;
    mevm)
      stop_process "mevm"
      ;;
    *)
      echo "Invalid stop command. Usage: movementctl stop [fuji/local/subnet-proxy/mevm]"
      exit 1
      ;;
  esac
}

# Handle the provided command
case $1 in
  start)
    start "${@:2}"
    ;;
  stop)
    stop "${@:2}"
    ;;
  *)
    echo "Invalid command. Usage: movementctl [start/stop] [fuji/local/subnet-proxy] [--foreground]"
    exit 1
    ;;
esac
