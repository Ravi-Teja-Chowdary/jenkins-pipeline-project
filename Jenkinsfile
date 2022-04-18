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

          stage('Copying artifact to s3 bucket') {
              steps {
                 s3Upload consoleLogLevel: 'INFO', dontSetBuildResultOnFailure: false, dontWaitForConcurrentBuildCompletion: false, entries: [[bucket: 'my-practice1-bucket', excludedFile: '', flatten: false, gzipFiles: false, keepForever: false, managedArtifacts: false, noUploadOnFailure: true, selectedRegion: 'us-east-2', showDirectlyInBrowser: false, sourceFile: '*.war', storageClass: 'STANDARD_IA', uploadFromSlave: false, useServerSideEncryption: false]], pluginFailureResultConstraint: 'FAILURE', profileName: 'Amazon-s3-Access', userMetadata: []
              }
         }
     }
}