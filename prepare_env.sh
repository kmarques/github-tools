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
