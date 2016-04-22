#! /usr/bin/env sh

# stolen from https://gist.github.com/matt448/8200821
# ==[ printSlack ]=============================================================
# Function to send output from the commandline to Slack.
#
# @parameter string $LEVEL   INFO/ERROR/WARNING message. Changes emoji
# @parameter string $MESSAGE Message to send to slack. 
printSlack() {
    SLACK_HOSTNAME=${SLACK_HOSTNAME-'oops.slack.com'};
    SLACK_TOKEN=${SLACK_TOKEN-'oops'};
    SLACK_CHANNEL=${SLACK_CHANNEL-'#devops'};
    SLACK_BOTNAME=${SLACK_BOTNAME-$(hostname -s)};
    SLACK_BOTEMOJI=${SLACK_BOTEMOJI-':computer:'}

    SEVERITY=${1-'INFO'};
    ICON=':slack:';

    case "$SEVERITY" in
        INFO)
            ICON=':page_with_curl:';
            shift;
            ;;
        WARN|WARNING)
            ICON=':warning:';
            shift;
            ;;
        ERROR|ERR)
            ICON=':bangbang:';
            shift;
            ;;
        *)
            ICON=':slack:';
            ;;
    esac

    MESSAGE=$@;

    PAYLOAD="payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\": \"${SLACK_BOTNAME}\", \"text\": \"${ICON} ${MESSAGE}\", \"icon_emoji\": \"${SLACK_BOTEMOJI}\"}";
    CURL_RESULT=$(curl -s -S -X POST --data-urlencode "$PAYLOAD" https://${SLACK_HOSTNAME}/services/hooks/incoming-webhook?token=${SLACK_TOKEN});

    if [ -z "$CURL_RESULT" ]; then
        return 0;
    else
        return 1;
    fi

}
