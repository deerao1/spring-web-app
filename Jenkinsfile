pipeline {
  agent { node { label 'docker' } }
  stages {
    stage('build') {
      steps {
        withMaven(maven: 'maven386') {
          sh 'mvn clean install'
        }
      }
    }
    stage('SonarQube Analysis') {
      steps {
        withSonarQubeEnv(installationName: 'sonarqube_server') {
            withMaven(maven:'maven386') {
                sh 'mvn sonar:sonar'
            }
        }
      }
    }
    stage('SonarQube Gate') {
      steps {
        // sleep(60)
        timeout(time: 2, unit: 'MINUTES') {
          waitForQualityGate abortPipeline: true
        }
      }
      post {
        aborted {
          emailext to: 'deerao.in@gmail.com',
          subject: "ABORTED $JOB_NAME Build No: $BUILD_NUMBER ",
          body: 'Build result:' + currentBuild.result + ' took ' + currentBuild.duration + ' milliseconds.'
        }
        failure {
          emailext to: 'deerao.in@gmail.com',
          subject: "FAILED $JOB_NAME Build No: $BUILD_NUMBER ",
          body: 'Build result:' + currentBuild.result + ' took ' + currentBuild.duration + ' milliseconds.'
        }
        success {
          emailext to: 'deerao.in@gmail.com',
          subject: "SUCCESS $JOB_NAME Build No: $BUILD_NUMBER ",
          body: 'Build result:' + currentBuild.result + ' took ' + currentBuild.duration + ' milliseconds.'
        }
      }
    }
  }
}
