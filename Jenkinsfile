pipeline {
    agent any
    
    stages {
        stage ('Install Berks files') {
            steps {
                sh 'berks install'
            }
        }

        stage ('Update Berks files') {
            steps {
                sh 'berks update'
            }
        }

        stage ('Upload cookbook to chef server') {
            steps {
                sh 'berks upload'
            }
        }
    }
}