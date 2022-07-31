
pipeline {
  agent { node { label 'docker' } }
  environment {
    NEXUS_CREDS = credentials('nexus-devops-user')
    NEXUS_USER = "$NEXUS_CREDS_USR"
    NEXUS_PASSWORD = "$NEXUS_CREDS_PSW"
  }
  stages {
    stage('tag repo') {
      steps {
        script {
          pom = readMavenPom file: 'pom.xml'
          tag = pom.version + '-' + $BUILD_NUMBER
          println tag
        }
        // sh "mvn -Dtag=<tag name> scm:tag "
        sh "echo ${tag}"
      }
    }

    // stage('build') {
    //   steps {
    //     withMaven(maven: 'maven386') {
    //       sh 'mvn -s mvn-settings.xml clean install'
    //     }
    //   }
    //   post {
    //     failure {
    //       emailext to: 'deerao.in@gmail.com',
    //       subject: "FAILED $JOB_NAME Build No: $BUILD_NUMBER, Stage build",
    //       body: 'Build result:' + currentBuild.result + '. Check: ' + currentBuild.absoluteUrl
    //     }
    //   }
    // }

    // stage('deploy') {
    //   steps {
    //     script {
    //       pom = readMavenPom file: 'pom.xml' // requires 'Pipeline Utility Steps' plugin
    //       println pom.version
    //       options = ' -DgroupId=com.example -DartifactId=testing-web-complete' +
    //           " -Dversion=${pom.version}-${BUILD_NUMBER} -Dpackaging=jar" +
    //           " -Dfile=target/testing-web-complete-${pom.version}.jar " +
    //           ' -Durl=http://139.59.53.53:8081/repository/demo-maven2-repo' +
    //           ' -DrepositoryId=nexus.repo'
    //     }

    //     sh "echo mvn deploy:deploy-file ${options}"
    //     withMaven(maven: 'maven386') {
    //       sh "mvn -s mvn-settings.xml deploy:deploy-file ${options}"
    //     }
        
    //   }
    //   post {
    //     failure {
    //       emailext to: 'deerao.in@gmail.com',
    //       subject: "FAILED $JOB_NAME Build No: $BUILD_NUMBER, Stage deploy",
    //       body: 'Build result:' + currentBuild.result + '. Check: ' + currentBuild.absoluteUrl
    //     }
    //   }
    // }

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
  }
}
