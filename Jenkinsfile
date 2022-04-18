pipeline {
     agent any
     stages {
         stage('Testing') {
              steps {
                 sh "bash build.sh"  
                 sh "ls -al"
                 echo ${BUILD_NUMBER}
              }
         }
     }
}
