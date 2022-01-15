pipeline {
    agent { node { label 'kubernetesWorkerAgent2' } }
    environment {
        DOCKER_IMAGE_NAME = "micsnbricks/cool-spring-app"
    }
    stages {
        stage('Build jar') {
            when {
                branch 'main'
            }
            steps {
                echo 'Building...'
                sh './gradlew clean build --no-daemon' 
            }
        }
        stage('Build docker image') {
            when {
                branch 'main'
            }
            steps {
                script {
                    app = docker.build(DOCKER_IMAGE_NAME)
                }
            }
        }
        stage('Push docker image to docker hub') {
            when {
                branch 'main'
            }
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
                branch 'main'
            }
            steps {
                input 'Deploy to Production?'
                milestone(1)
                sshagent(['k8s_master_ssh_key']) {
                    sh 'ssh -o StrictHostKeyChecking=no cloud_user@34.203.194.184 date'
                }
            }
        }
    }
}
