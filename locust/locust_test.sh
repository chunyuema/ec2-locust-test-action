#!/usr/bin/bash

# get the instance id
declare -r instance_id=$(curl http://169.254.169.254/latest/meta-data/instance-id)

curl -X POST -H 'Content-type: application/json' --data '{"text":"Test Begins"}' ${slack_webhook_url}

# send to slack
send_to_slack() {
    message=$1
    curl -X POST -H 'Content-type: application/json' --data '{"text":"test"}' ${slack_webhook_url}
}

# prepare environment
prepare_environment() {
    apt update
    apt install -y python3-pip wget
}

# install pip dependencies
install_dependencies(){
    pip install jina
    pip3 install locust
}


#########################
# calling all functions #
#########################
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

shutdown -h now
send_to_slack "Scheduled to be terminated."

