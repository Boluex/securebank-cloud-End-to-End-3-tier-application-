pipeline {
    agent any
    parameters {
        string(name: 'IMAGE_TAG', defaultValue: 'latest', description: 'The tag of the Docker images to deploy')
    }
    environment {
        GITHUB_CREDS_ID = '1'
        REPO_URL = 'github.com/Boluex/securebank-cloud-End-to-End-3-tier-application-.git'
    }

    stages {
        stage('Checkout Manifests') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/Boluex/securebank-cloud-End-to-End-3-tier-application-.git',
                    credentialsId: "${GITHUB_CREDS_ID}"
            }
        }

        stage('Update Image Tags') {
            steps {
                script {
                    echo "Updating backend image tag to: ${params.IMAGE_TAG}"
                    sh "sed -i -E 's#image: (securebank-be-1|boluex/securebank-backend:.*)#image: boluex/securebank-backend:${params.IMAGE_TAG}#' depl.yaml"

                    echo "Updating frontend image tag to: ${params.IMAGE_TAG}"
                    sh "sed -i -E 's#image: (securebank-fe-1|boluex/securebank-frontend:.*)#image: boluex/securebank-frontend:${params.IMAGE_TAG}#' depl.yaml"

                    sh "git diff depl.yaml"
                }
            }
        }

        stage('Commit and Push Changes') {
            steps {
                script {
                    def status = sh(script: "git status --porcelain depl.yaml", returnStdout: true).trim()
                    if (status != "") {
                        echo "Changes detected, committing and pushing..."
                        withCredentials([usernamePassword(credentialsId: "${GITHUB_CREDS_ID}", usernameVariable: 'GIT_USER', passwordVariable: 'GIT_TOKEN')]) {
                            sh "git add depl.yaml"
                            sh "git commit -m 'chore: update image tags to version ${params.IMAGE_TAG} [skip ci]'"
                            sh "git push"
                        }
                    } else {
                        echo "No changes detected. Skipping git push."
                    }
                }
            }
        }
    }
}