#!/bin/bash
#Create SSH tunnels to the server using ngrok to stablish them with the remote server

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NGROK_APIKEY=$(cat "${SCRIPT_DIR}/apikey")

##Declare SSH ports
## name=local_port,remote_port
ssh=("22" "2022")
web=("8000" "2080")

active_tunnels=("ssh" "web")

function get_endpoints(){
  curl \
  -X GET \
  -H "Authorization: Bearer ${NGROK_APIKEY}" \
  -H "Ngrok-Version: 2" \
  https://api.ngrok.com/endpoints > ${SCRIPT_DIR}/endpoints.tmp  
}

#extract ip
function get_hostport(){
  HOSTPORT=$(cat ${SCRIPT_DIR}/endpoints.tmp| jq -r .endpoints[0].hostport)
  echo $HOSTPORT
}

function extract_ip(){
  IP=$(echo $HOSTPORT | cut -d: -f1)
  echo $IP
}

function extract_port(){
  PORT=$(echo $HOSTPORT | cut -d: -f2)
  echo $PORT
}

function create_ssh_tunnel(){
  for tunnel in "${active_tunnels[@]}"; do
    declare -n array="$tunnel"
    echo -e "\n\033[32mStarting service '$tunnel' remote port: ${array[0]} redirected to local port: ${array[1]}\033[0m"
    ssh -o StrictHostKeyChecking=no -p $PORT ansible@$IP -L ${array[1]}:localhost:${array[0]} -N & 
    pids+=($!)
  done
}

function close_ssh_tunnels(){

  for pid in "${pids[@]}"; do
    echo -e "\n\033[31mClosing tunnel $pid\033[0m"
    kill -9 $pid
  done
}

function clean_up(){
  rm ${SCRIPT_DIR}/endpoints.tmp
}

function manage_exit(){
  echo -e "Press Ctrl+C to close tunnels..."
  trap close_ssh_tunnels INT
  wait
  clean_up
  exit 0
}

function main(){
  get_endpoints
  get_hostport
  extract_ip
  extract_port
  create_ssh_tunnel
  manage_exit
}

main


