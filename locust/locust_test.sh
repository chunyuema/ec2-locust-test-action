#!/usr/bin/bash

# get the instance id
declare -r instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)

# send to slack
send_to_slack() {
    message=$1
    curl -s -X POST -H 'Content-type: application/json' --data '{"text":"'"*$instance_id*: $message"'"}' ${slack_webhook_url}
}

# prepare environment
prepare_environment() {
    apt update
    apt install -y python3-pip wget
    apt install git
}

# install pip dependencies
install_dependencies(){
    pip install jina
    pip3 install locust
}

# clone git repository
clone_repo(){
  send_to_slack "Start cloning the repository."
  git clone https://github.com/chunyuema/jina-locust-load-testing.git
}

# run load test
run_test(){
  export HOST_ENDPOINT = ${host_endpoint}
  locust -f load_test.py --headless -u 2 -t 1m --html result.html
}


#########################
# calling all functions #
#########################
send_to_slack "Load Testing has began."

if prepare_environment; then
  send_to_slack "Successfully prepared environment."
else
  send_to_slack "Preparing environment failed."
fi

if install_dependencies; then
  send_to_slack "Successfully installed dependencies."
else
  send_to_slack "Installing dependencies failed."
fi

if clone_repo; then
  send_to_slack "Successfully cloned the locust test repo."
else
  send_to_slack "Failed to clone the repo."

if run_test; then
  send_to_slack "Successfully ran locust test."
else
  send_to_slack "Load testing failed."

shutdown -h now
send_to_slack "EC2 Instannce scheduled to be terminated."