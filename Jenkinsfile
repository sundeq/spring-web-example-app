pipeline {
    agent any
    environment {
        DOCKER_IMAGE_NAME = "micsnbricks/cool-spring-app"
    }
    stages {
        stage('Build jar') {
            steps {
                echo 'Building...'
                sh './gradlew clean build --no-daemon' 
            }
        }
        stage('Build docker image') {
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                }
            }
        }
        stage('Push docker image to docker hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker_hub_login') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('DeployToProduction') {
            when {
                branch 'master'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                kubernetesDeploy(
                    kubeconfigId: 'kubeconfig',
                    configs: 'train-schedule-kube.yml',
                    enableConfigSubstitution: true
                )
            }
        }
    }
}
