function newjira ()
{
    local content="{
    \"fields\": {
       \"project\":
       {
          \"key\": \"SCRAPPY\"
       },
       \"labels\": [\"DevOps\"],
       \"summary\": \"$*\",
       \"description\": \"_\",
       \"issuetype\": {
          \"name\": \"Story\"
        }
      }
    }";
    tempFile=`mktemp`;
    curl -s -d "$content" -u $USER -H "Content-type:application/json" -X POST https://jira.msciapps.com/rest/api/2/issue/ -o ${tempFile};
    /c/Program\ Files/Google/Chrome/Application/chrome.exe "https://jira.msciapps.com/browse/$(jq -r '.key' ${tempFile})"
}
