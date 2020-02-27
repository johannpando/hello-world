#!groovy
@Library('global-alm-pipeline-library') _
pipeline {
    agent { label 'terraform' }
    stages {
	stage ('TF Plan') {
	     steps {
		script {
	        almTerraform(
		     source:
			  sourceDirectory(directory: 'pro-common-architecture-m'), 
		     backend: stateless(), 
		     provider: azureProvider(credentialId: 'test-service-principal')
		    )
		}
	    }
	}
    }
}