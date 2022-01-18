#! /bin/sh

. ./prepare_env.sh

file="./data/invitations"
[[ ! -e $file ]] && echo "File '${file}' not found" && exit 1

echo "Inviting mantainers to repositories"
echo "  Parsing "$file;
while IFS= read -r line
do
  [[ "${line:0:1}" == \#* ]] && continue;
  IFS=';' read -ra ADDR <<< "$line"
  echo "  User '${ADDR[1]}' to repo '${ADDR[0]}'"
  curl \
  -X PUT \
  -u ${GITHUB_CREDENTIALS} \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/${GITHUB_USERNAME//\./-}/${ADDR[0]}/collaborators/${ADDR[1]} \
  -d '{"permission":"push"}'

done < "$file"
