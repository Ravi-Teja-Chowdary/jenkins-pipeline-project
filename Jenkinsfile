pipeline {
     agent any
     stages {
         stage('Testing') {
              steps {
                   sh "rm -f ROOT.war && bash build.sh && mv ROOT.war ROOT${BUILD_NUMBER}.war"  
                 sh "ls -al"
                 echo "${BUILD_NUMBER}"
              }
         }
     }
}
