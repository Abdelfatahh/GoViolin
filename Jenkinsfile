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
            dockerImage = docker.build registry + ":$BUILD_NUMBER"
            }
        }
    }
    stage('Deploy our image') {
        steps{
            script {
                docker.withRegistry( "" , registryCredential ) {
                dockerImage.push()
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