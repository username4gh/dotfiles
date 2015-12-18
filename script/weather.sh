#! /usr/bin/env bash

# http://zourbuth.com/tools/woeid/
yahoo_weather() {
    curl --silent "http://weather.yahooapis.com/forecastrss?w=$1&u=c" | awk -F '- ' '
    /<title>/ { sub("</title>", "", $2) && l=$2 }
    /<b>Forecast/ { getline; gsub("<.*", "", $2); printf("%s: %s\n", l, $2); exit }'
}

yahoo_weather 2132925
yahoo_weather 2151330
