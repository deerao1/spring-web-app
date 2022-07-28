pipeline {
  agent { node { label 'docker' } }
  environment {
    NEXUS_CREDS = credentials('nexus-devops-user')
    NEXUS_USER = "$NEXUS_CREDS_USR"
    NEXUS_PASSWORD = "$NEXUS_CREDS_PSW"
  }
  stages {
    stage('build') {
      steps {
        withMaven(maven: 'maven386') {
          // sh 'mvn -s mvn-settings.xml clean install'
          sh 'mvn clean deploy'
        }
      }
    }
    // stage('SonarQube Analysis') {
    //   steps {
    //     withSonarQubeEnv(installationName: 'sonarqube_server') {
    //         withMaven(maven:'maven386') {
    //             sh 'mvn sonar:sonar'
    //         }
    //     }
    //   }
    // }
    // stage('SonarQube Gate') {
    //   steps {
    //     timeout(time: 2, unit: 'MINUTES') {
    //       waitForQualityGate abortPipeline: true
    //     }
    //   }
    //   post {
    //     aborted {
    //       emailext to: 'deerao.in@gmail.com',
    //       subject: "ABORTED $JOB_NAME Build No: $BUILD_NUMBER ",
    //       body: 'Build result:' + currentBuild.result + ' took ' + currentBuild.duration + ' milliseconds.'
    //     }
    //     failure {
    //       emailext to: 'deerao.in@gmail.com',
    //       subject: "FAILED $JOB_NAME Build No: $BUILD_NUMBER ",
    //       body: 'Build result:' + currentBuild.result + ' took ' + currentBuild.duration + ' milliseconds.'
    //     }
    //     success {
    //       emailext to: 'deerao.in@gmail.com',
    //       subject: "SUCCESS $JOB_NAME Build No: $BUILD_NUMBER ",
    //       body: 'Build result:' + currentBuild.result + ' took ' + currentBuild.duration + ' milliseconds.'
    //     }
    //   }
    // }
    // stage('Upload to Nexus') {
    //   steps {
    //     // sh "echo $NEXUS_USER / $NEXUS_CREDS_USR"
    //     // sh "echo $NEXUS_PASSWORD / $NEXUS_CREDS_PSW"
    //     withMaven(maven: 'maven386') {
    //       sh 'mvn deploy:deploy'
    //     }
    //   }
    // }
  }
}
