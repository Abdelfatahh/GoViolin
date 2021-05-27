pipeline {
    environment {
    registry = "abdelfata7/go-violin-instabug"
    registryCredential = 'dockerhub'
    dockerImage = ''
    }
    agent any
    stages {
    stage('Initialize'){
        steps {
            script{
                def dockerHome = tool 'myDocker'
                env.PATH = "${dockerHome}/bin:${env.PATH}"
            }
        }
    }
    stage('Cloning our Git') {
        steps {
        git 'https://github.com/abdelfatahh/goviolin.git'
        }
    }      
    stage('Building our image') {
        steps{
            script {
                try{
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    emailtext body: 'Your images was built successfully', subject: "Your Docker image build with #${BUILD_NUMBER}", to: 'abduelfata7@gmail.com'
                }
                catch(Exception e){
                    script{
                        echo 'There is an Error in the build process!' + e.toString()
                        sh 'Handle the Exception!'
                        emailtext body: 'Error in your Docker build.', subject: "Your Docker image build # ${BUILD_NUMBER} has failed.", to: 'abduelfata7@gmail.com'
                    }
                } 
            }
        }
    }
    stage('Deploy our image') {
        steps{
            script {
                try{
                    docker.withRegistry( "" , registryCredential ) {
                        dockerImage.push("latest")
                    }
                    emailtext body: 'Your images was deployed successfully', subject: "Your Docker image deploy with #${BUILD_NUMBER} was deployed successfully.", to: 'abduelfata7@gmail.com'
                }
                catch(Exception e) {
                    script{
                        echo 'There is an Error in the deployment process!' + e.toString()
                        sh 'Handle the Exception!'
                        emailtext body: 'Error in your Docker deployment.', subject: "Your Docker image deploy with # ${BUILD_NUMBER} has failed.", to: 'abduelfata7@gmail.com'
                    }
                }
            }
        }
    }
    stage('Cleaning up') {
        steps{
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
    
}
