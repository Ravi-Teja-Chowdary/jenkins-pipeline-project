pipeline {
     agent any
     environment {
        registry = 'ravitejachowdary/jenkins-pipeline'
        registryCredential = 'dockerhub_id'
        dockerImage = ''
    }
     stages {
         stage('Building Java Code') {
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
         stage('Building Docker Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Push the Docker image') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
     }
}