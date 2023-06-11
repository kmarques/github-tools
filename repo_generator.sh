#! /bin/sh

. ./prepare_env.sh

# Create the repo list file
echo "Generating ${NB_GROUPS} repositories" | tee -a ${LOG_FILE}
echo "Repo list file: ${REPO_LIST}" | tee -a ${LOG_FILE}
echo "# "${NB_GROUPS}" groupes" > ${REPO_LIST}
for ((i=1; i<=${NB_GROUPS}; i++));
do
  REPO_NAME=${PROMO}'-GROUP-'`printf %02d $i`
  curl \
    -X POST \
    -u ${GITHUB_CREDENTIALS} \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/user/repos \
    -d '{"private": true, "name":"'${REPO_NAME}'", "description":"Repo for group '${i}}'"}' &>> ${LOG_FILE}
  if [[ $? -eq 0 ]]; then
    echo ${REPO_NAME}";" >> ${REPO_LIST}
    echo "Repo '${REPO_NAME}' created" | tee -a ${LOG_FILE}
  else
    echo "Repo '${REPO_NAME}' creation failed" | tee -a ${LOG_FILE}
  fi
done
