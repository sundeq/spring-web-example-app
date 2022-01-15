pipeline {
    agent any

    stages {
        stage('Build jar') {
            steps {
                echo 'Building...'
                sh './gradlew clean build --no-daemon' 
            }
        }
        stage('Build docker image') {
            steps {
                echo 'Building docker image...'
                sh 'docker build -t micsnbricks/cool-spring-app'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
