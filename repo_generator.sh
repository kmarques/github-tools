#! /bin/sh

. ./prepare_env.sh

for ((i=1; i<=${NB_GROUPS}; i++));
do
   curl \
  -X POST \
  -u ${GITHUB_CREDENTIALS} \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d '{"private": true, "name":"'${PROMO}'-group-'`printf %02d $i`'"}'
done
