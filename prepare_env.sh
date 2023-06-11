#! /bin/sh

echo "Preparing environment variables"

for file in ".env" ".env.local"
do
  if [ -e $file ]; then
     echo "  Parsing "$file;
     while IFS= read -r line
     do
        eval $line
     done < "$file"

  fi
done
GITHUB_CREDENTIALS=${GITHUB_USERNAME}:${PRIVATE_KEY}
LOG_FILE=${LOGS_DIR}/${PROMO}-$(date +%Y%m%d-%H%M%S).log
REPO_LIST=data/${PROMO}-invitations.csv

echo "  GITHUB_CREDENTIALS: "${GITHUB_USERNAME}":xxxxxx"
echo "  PROMO: "${PROMO}
echo "  NB_GROUPS: "${NB_GROUPS}
echo "  REPO_LIST: "${REPO_LIST}
echo "  LOGS_DIR: "${LOGS_DIR}
echo "  LOG_FILE: "${LOG_FILE}

[ ! -f ${REPO_LIST} ] && touch ${REPO_LIST} && echo "Repository invitations file '"${REPO_LIST}"' sample created"
[ ! -e ${LOGS_DIR} ] && mkdir ${LOGS_DIR} && echo "Logs directory '"${LOGS_DIR}"' created"