pipeline {
     agent any
     environment {
        registry = 'ravitejachowdary/jenkins-pipeline'
        registryCredential = 'dockerhub_id'
        dockerImage = ''
        BUILD = 'YES'
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
         stage('Building the Docker Image') {
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
        stage('Perform Packer Build') {
            when {
                expression {
                    env.BUILD == 'YES'
                }
            }
            steps {
                    sh 'packer build -var-file packer-vars.json packer.json | tee output.txt'
                    sh "tail -2 output.txt | head -2 | awk 'match(\$0, /ami-.*/) { print substr(\$0, RSTART, RLENGTH) }' > ami.txt"
                    sh "echo \$(cat ami.txt) > ami.txt"
                    script {
                        def AMIID = readFile('ami.txt').trim()
                        sh "echo variable \\\"imagename\\\" { default = \\\"$AMIID\\\" } >> variables.tf"
                    }
            }
          }
        stage('Use Default Packer Image') {
            when {
                expression {
                    env.BUILD == 'NO'
                }
            }
            steps {
                    script {
                        def AMIID = 'ami-09ff810e7db18039d'
                        sh "echo variable \\\"imagename\\\" { default = \\\"$AMIID\\\" } >> variables.tf"
                    }
            }
        }

     }
}
