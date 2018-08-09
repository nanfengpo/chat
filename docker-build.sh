#!/bin/bash

# Build nanfengpo docker images

for line in $@; do
  eval "$line"
done

tag=${tag#?}

if [ -z "$tag" ]; then
    echo "Must provide tag as 'tag=v1.2.3'"
    exit 1
fi

# Convert tag into a version
ver=( ${tag//./ } )

if [[ ${ver[2]} != *"-rc"* ]]; then
  FULLRELEASE=1
fi

dbtags=( mysql rethinkdb )

# Build an images for various DB backends
for dbtag in "${dbtags[@]}"
do
  rmitags="nanfengpo/nanfengpo-${dbtag}:${ver[0]}.${ver[1]}.${ver[2]}"
  buildtags="--tag nanfengpo/nanfengpo-${dbtag}:${ver[0]}.${ver[1]}.${ver[2]}"
  if [ -n "$FULLRELEASE" ]; then
    rmitags="${rmitags} nanfengpo/nanfengpo-${dbtag}:latest nanfengpo/nanfengpo-${dbtag}:${ver[0]}.${ver[1]}"
    buildtags="${buildtags} --tag nanfengpo/nanfengpo-${dbtag}:latest --tag nanfengpo/nanfengpo-${dbtag}:${ver[0]}.${ver[1]}"
  fi
  docker rmi ${rmitags}
  docker build --build-arg VERSION=$tag --build-arg TARGET_DB=${dbtag} ${buildtags} docker/nanfengpo
done

# Build chatbot image
buildtags="--tag nanfengpo/chatbot:${ver[0]}.${ver[1]}.${ver[2]}"
rmitags="nanfengpo/chatbot:${ver[0]}.${ver[1]}.${ver[2]}"
if [ -n "$FULLRELEASE" ]; then
  rmitags="${rmitags} nanfengpo/chatbot:latest nanfengpo/chatbot:${ver[0]}.${ver[1]}"
  buildtags="${buildtags}  --tag nanfengpo/chatbot:latest --tag nanfengpo/chatbot:${ver[0]}.${ver[1]}"
fi
docker rmi ${rmitags}
docker build --build-arg VERSION=$tag ${buildtags} docker/chatbot
