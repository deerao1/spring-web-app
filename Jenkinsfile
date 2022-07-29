def options = ' -DgroupId=com.example -DartifactId=testing-web-complete' +
              ' -Dversion=0.0.1-SNAPSHOT -Dpackaging=jar' +
              ' -Dfile=target/testing-web-complete-0.0.1-SNAPSHOT.jar ' +
              ' -Durl=http://139.59.53.53:8081/repository/demo-maven2-repo' +
              ' -DrepositoryId=nexus.repo'
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
          sh 'mvn -s mvn-settings.xml clean install'
        }
      }
    }
    stage('deploy') {
      steps {
        sh "echo `pwd`"
        sh "echo mvn deploy:deploy-file ${options}"
        withMaven(maven: 'maven386') {
          sh "mvn deploy:deploy-file ${options}"
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
