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
    sudo apt install -y git
}

# install pip dependencies
install_dependencies(){
    pip install jina
    pip3 install locust
}

# clone git repository
clone_repo(){
  cd /tmp
  git clone https://github.com/chunyuema/jina-locust-load-testing.git
  cd jina-locust-load-testing
}

# run load test
run_test(){
  export HOST_ENDPOINT=${host_endpoint}
  locust -f load_test.py --headless -u 2 -t 1m --html result.html
}

# send test result to slack channel
send_test_result(){
  curl -F file=@result.html -F "initial_comment=Load testing result:" -F channels=$slack_channel -H "Authorization: Bearer $slack_app_token" https://slack.com/api/files.upload
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
  run_test
else
  send_to_slack "Failed to clone the repo."
fi

if send_test_result; then
  send_to_slack "Please see the test result."
else
  send_to_slack "Unable to send test result."
fi

shutdown -h now
send_to_slack "EC2 Instannce scheduled to be terminated."