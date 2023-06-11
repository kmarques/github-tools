#! /bin/sh

. ./prepare_env.sh

[[ ! -e ${REPO_LIST} ]] && echo "File '${REPO_LIST}' not found" && exit 1

echo "Inviting mantainers to repositories" | tee -a ${LOG_FILE}
echo "  Parsing "$REPO_LIST | tee -a ${LOG_FILE}
while IFS= read -r line
do
  [[ "${line:0:1}" == \#* ]] && continue;
  IFS=';' read -ra ADDR <<< "$line"
  echo "  User '${ADDR[1]}' to repo '${ADDR[0]}'" | tee -a ${LOG_FILE}
  [[ "${ADDR[1]}" == "" ]] && echo "    User not found" | tee -a ${LOG_FILE} && continue;
  [[ "${ADDR[0]}" == "" ]] && echo "    Repo not found" | tee -a ${LOG_FILE} && continue;
  curl \
   -X PUT \
   -u ${GITHUB_CREDENTIALS} \
   -H "Accept: application/vnd.github.v3+json" \
   https://api.github.com/repos/${GITHUB_USERNAME//\./-}/${ADDR[0]}/collaborators/${ADDR[1]} \
   -d '{"permission":"push"}' &>> ${LOG_FILE}
  if [[ $? -eq 0 ]]; then
    echo "    User '${ADDR[1]}' invited to repo '${ADDR[0]}'" | tee -a ${LOG_FILE}
  else
    echo "    User '${ADDR[1]}' invitation to repo '${ADDR[0]}' failed" | tee -a ${LOG_FILE}
  fi
done < "$REPO_LIST"
