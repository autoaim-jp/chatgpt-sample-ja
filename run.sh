#! /bin/bash

# node app.js | jq .choices[0].message.content | tr -d '"' | tr '$$' '\n' | sed '/^ *$/d' | awk '{ print "~/Documents/Voicepeak\\ Downloads/Voicepeak/voicepeak -s \"" $0 "\" && aplay ./output.wav && sleep $(soxi -d output.wav | tr -d \"00:00:\")" }' | bash
# rm -rf ./voice/message_*.wav && cat output.json | jq .choices[0].message.content | tr -d '"' | tr '$$' '\n' | sed '/^ *$/d' | awk '{ print "~/Documents/Voicepeak\\ Downloads/Voicepeak/voicepeak -s \"" $0 "\" -o ./voice/message_" NR ".wav" }' | bash && sox $(ls ./voice/message_*.wav) ./message_all.wav && aplay ./message_all.wav
JSON_FILE_NAME_PREFIX=$(date "+%Y%m%d_%H%M%S")
JSON_FILE_NAME=./response/${JSON_FILE_NAME_PREFIX}.json
rm -rf ./voice/message_*.wav && node app.js ${1} ${JSON_FILE_NAME} && cat ${JSON_FILE_NAME} | jq .choices[0].message.content | tr -d '"' | tr '$$' '\n' | sed '/^ *$/d' | awk '{ print "~/Documents/Voicepeak\\ Downloads/Voicepeak/voicepeak -s \"" $0 "\" -o ./voice/message_" NR ".wav" }' | bash && sox $(ls ./voice/message_*.wav) ./message_all.wav && aplay ./message_all.wav
# rm -rf ./voice/message_*.wav && cat ./response/20230918_014335.json | jq .choices[0].message.content | tr -d '"' | sed 's/。/\n/g' | tr '$$' '\n' | sed '/^ *$/d' | awk '{ print "~/Documents/Voicepeak\\ Downloads/Voicepeak/voicepeak -s \"" $0 "\" -o ./voice/message_" NR ".wav"}' | bash 
# rm -rf ./voice/message_*.wav && cat ./response/20230918_014335.json | jq .choices[0].message.content | tr -d '"' | sed 's/。/\n/g' | tr '$$' '\n' | sed '/^ *$/d'

