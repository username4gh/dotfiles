#! /usr/bin/env bash

# stolen from https://gist.github.com/matt448/8200821
_slack_print() {
    local SLACK_WEBHOOK_URL=$(_conf_read SLACK_WEBHOOK_URL);
    local SLACK_CHANNEL=${SLACK_CHANNEL-'#general'};
    local SLACK_BOTNAME=${SLACK_BOTNAME-$(hostname -s)};
    local SLACK_BOTEMOJI=${SLACK_BOTEMOJI-':computer:'}

    local SEVERITY=${1-'INFO'};
    local ICON=':slack:';

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

    local MESSAGE=$@;

    echo $SLACK_WEBHOOK_URL
    local PAYLOAD="payload={\"channel\": \"${SLACK_CHANNEL}\", \"username\": \"${SLACK_BOTNAME}\", \"text\": \"${ICON} ${MESSAGE}\", \"icon_emoji\": \"${SLACK_BOTEMOJI}\"}";
    local CURL_RESULT=$(curl -s -S -X POST --data-urlencode "$PAYLOAD" $SLACK_WEBHOOK_URL);

    if [ -z "$CURL_RESULT" ]; then
        return 0;
    else
        return 1;
    fi
}
