#crumb=$(curl -u "jenkins:1234" -s 'http://dev-server:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
#crumb=$(curl -u "jenkins:1234" -s 'http://dev-server:8080/crumbIssuer/api/json')
#echo $crumb
#curl -u "winter:11019b12426dbf27ac8323d278ca97fd55" -X POST http://dev-server:8080/job/ENV/build?delay=0sec
curl -u "winter:11019b12426dbf27ac8323d278ca97fd55" -H "$crumb" -X POST  http://dev-server:8080/job/backup_db_to_aws/buildWithParameters?DB_HOST=db_host&DB_NAME=testdb&BUCKET_NAME=jenkins-udemy
