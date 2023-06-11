#! /bin/sh

. ./prepare_env.sh

file="./data/admins"
[[ ! -e $file ]] && echo "File '${file}' not found"  | tee -a ${LOG_FILE} && exit 1

echo "Inviting admins to repositories" | tee -a ${LOG_FILE}
echo "  Parsing "$file | tee -a ${LOG_FILE}
for ((i=1; i<=${NB_GROUPS}; i++));
do
  while IFS= read -r line
  do
    [[ "${line:0:1}" == \#* ]] && continue;
    REPO=$PROMO'-group-'`printf %02d $i`
    echo "  User '${line}' to repo '${REPO}'" | tee -a ${LOG_FILE}
    curl \
    -X PUT \
    -u ${GITHUB_CREDENTIALS} \
    -H "Accept: application/vnd.github.v3+json" \
    https://api.github.com/repos/${GITHUB_USERNAME//\./-}/${REPO}/collaborators/${line} \
    -d '{"permission":"push"}' &>> ${LOG_FILE}
  done < "$file"
done