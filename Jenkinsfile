
pipeline {
  agent { node { label 'docker' } }
  // agent {
  //   docker {
  //     image 'maven:3.8.6-openjdk-11'
  //     args '-v /tmp:/root/.m2/repository'
  //   }
  // }
  environment {
    NEXUS_CREDS = credentials('nexus-devops-user')
    NEXUS_USER = "$NEXUS_CREDS_USR"
    NEXUS_PASSWORD = "$NEXUS_CREDS_PSW"

    GH_PAT = credentials('github-pat')
  }
  tools {
    maven 'maven386'
  }
  stages {
    stage('build') {
      steps {
          sh 'mvn -s mvn-settings.xml clean install'
      }
      post {
        failure {
          emailext to: 'deerao.in@gmail.com',
          subject: "FAILED $JOB_NAME Build No: $BUILD_NUMBER, Stage build",
          body: 'Build result:' + currentBuild.result + '. Check: ' + currentBuild.absoluteUrl
        }
      }
    }

    stage('build docker image') {
      steps {
        script {
          pom = readMavenPom file: 'pom.xml' // requires 'Pipeline Utility Steps' plugin
          version = pom.version
        }
        sh "docker build -t myrepo/myapp:${version} --build-arg ver=${version} ."
      }
    }
    // stage('SonarQube Analysis') {
    //   steps {
    //     withSonarQubeEnv(installationName: 'sonarqube_server') {
    //       sh 'mvn sonar:sonar'
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
    //     subject: "ABORTED $JOB_NAME Build No: $BUILD_NUMBER ",
    //     body: 'Build result:' + currentBuild.result + ' took ' + currentBuild.duration + ' milliseconds.'
    //     }
    //     failure {
    //       emailext to: 'deerao.in@gmail.com',
    //     subject: "FAILED $JOB_NAME Build No: $BUILD_NUMBER ",
    //     body: 'Build result:' + currentBuild.result + ' took ' + currentBuild.duration + ' milliseconds.'
    //     }
    //   }
    // }

    // stage('deploy') {
    //   options {
    //     timeout(time: 1, unit: 'MINUTES')
    //   }
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

    //     sh "mvn -s mvn-settings.xml deploy:deploy-file ${options}"
    //   }
    //   post {
    //     failure {
    //       emailext to: 'deerao.in@gmail.com',
    //       subject: "FAILED $JOB_NAME Build No: $BUILD_NUMBER, Stage deploy",
    //       body: 'Build result:' + currentBuild.result + '. Check: ' + currentBuild.absoluteUrl
    //     }
    //   }
    // }

  // stage('tag repo') {
  //   steps {
  //     script {
  //       pom = readMavenPom file: 'pom.xml'
  //       tag = pom.version + '-' + env.BUILD_NUMBER
  //       sh """
  //         echo tag is ${tag}
  //         git remote set-url origin https://$GH_PAT@github.com/deerao1/spring-web-app.git
  //         git tag -a ${tag} -m "Generated by: ${env.JENKINS_URL}"
  //         git push origin ${tag}
  //       """
  //     }
  //   }
  // }
  }
    post {
      success {
          emailext to: 'deerao.in@gmail.com',
          subject: "SUCCESS $JOB_NAME Build No: $BUILD_NUMBER",
          body: 'Build result:' + currentBuild.result + '. Check: ' + currentBuild.absoluteUrl
      }
    }
}
