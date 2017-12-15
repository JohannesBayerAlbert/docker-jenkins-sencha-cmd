# docker-jenkins-sencha-cmd
A docker file based on Jenkins for Sencha-CMD



Build with
docker build . --label "jenkins-sencha" -t jbalbert/jenkins-sencha


Run with
docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home jbalbert/jenkins-sencha
