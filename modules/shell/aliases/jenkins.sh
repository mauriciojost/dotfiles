function qjenkinsfile-runner() {
  rm -fr /tmp/jenkins
  wget http://mirrors.jenkins.io/war-stable/latest/jenkins.war
  unzip jenkins.war -d /tmp/jenkins
  JENKINS_HOME=/tmp/jenkins_home java -jar /tmp/jenkins.war
  wget https://repo.jenkins-ci.org/releases/io/jenkins/jenkinsfile-runner/jenkinsfile-runner/1.0-beta-15/jenkinsfile-runner-1.0-beta-15.jar
  mv jenkinsfile-runner-*.jar jenkinsfile-runner.jar
}
