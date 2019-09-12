pipeline {
	agent any
	stages {
		
		stage('Build') {
			steps {
				script {
					try {
						fileExists '/var/www/html/jenkins/*.html'
					} catch (exc) {
						sh 'mkdir -p /var/www/html/jenkins'
					}

				}
				cleanWs()
				git 'https://github.com/designmodo/Flat-UI'
				sh 'cp -r $WORKSPACE/* /var/www/html/jenkins/'
			}
		}
		stage('Test') {
			steps {
				sh '''#!/bin/bash
					if [ $(($RANDOM%2)) == 0 ]; then
					  echo "Aplicação OK"
					  exit 0
					else
					  echo "Aplicação Falhou"
					  exit 1
					fi'''
			}
		}
		stage('Deploy') {
			steps {
				sh 'rpm -qa | grep https || sudo yum install https -y'
				sh 'sudo https -k restart'
			}
		}
	}
	post {
		always {
			chuckNorris()
		}
	}
}
































