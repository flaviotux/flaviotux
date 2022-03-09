#!/bin/bash

ping -q -w 3 -c 1 10.0.2.1>/dev/null \
&& echo '{"text":"Connected","class":"connected","percentage":100}' \
|| echo '{"text":"Disconnected","class":"disconnected","percentage":0}'