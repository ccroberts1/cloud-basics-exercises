#!/bin/bash
username=$1
passwd=$2

curl -u both-user1:Gaillimh2@ -X GET 'http://64.23.211.117:8081/service/rest/v1/components?repository=npm-test&sort=version' | jq "." > artifact.json

artifactDownloadUrl=$(jq '.items[].assets[].downloadUrl' artifact.json --raw-output)

tar_name=$(jq '.items[].assets[].npm.name' artifact.json --raw-output)
tar_version=$(jq '.items[].assets[].npm.version' artifact.json --raw-output)
tar_file=$tar_name"-"$tar_version".tgz"

wget --http-user=$user --http-password=$passwd $artifactDownloadUrl

tar -xvzf $tar_file

cd package

npm i

npm start
