
pipeline {
  agent { node { label 'docker' } }
  // agent {
  //   docker {
  //     image 'maven:3.8.6-openjdk-11'
  //     args '-v /tmp:/root/.m2/repository'
  //   }
  // }
  environment {
    NEXUS_CREDS = credentials('nexus-admin')
    NEXUS_USER = "$NEXUS_CREDS_USR"
    NEXUS_PASSWORD = "$NEXUS_CREDS_PSW"
    NEXUS_IP = "165.22.210.250"
    NEXUS_REPO = "maven2-training"

    GH_PAT = credentials('github-pat')

    AWS_REGION = "us-east-2"
    K8_CLUSTER_NAME = "eks-devops-trg"
  }
  tools {
    maven 'maven386'
  }
  stages {
    stage('build') {
      steps {
          sh 'mvn -s mvn-settings.xml clean install -Dmaven.test.skip=true' // skip tests to save pipeline testing time
      }
      post {
        failure {
          emailext to: 'deerao.in@gmail.com',
          subject: "FAILED $JOB_NAME Build No: $BUILD_NUMBER, Stage build",
          body: 'Build result:' + currentBuild.result + '. Check: ' + currentBuild.absoluteUrl
        }
      }
    }

    // manual way of building image, without the plugin
    // stage('build docker image') {
    //   steps {
    //     script {
    //       pom = readMavenPom file: 'pom.xml' // requires 'Pipeline Utility Steps' plugin
    //       version = pom.version
    //     }
    //     sh "docker build -t myrepo/myapp:${version}-${BUILD_NUMBER} ."
    //   }
    // }

    // stage('SonarQube Analysis') {
    //   steps {
    //     withSonarQubeEnv(installationName: 'sonarqube_trg') {
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

    // stage('archive to nexus') {
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
    //           " -Durl=http://${NEXUS_IP}:8081/repository/${NEXUS_REPO}" +
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

    stage('build docker image and push to registry') {
      steps {
        script {
          // code insdie script tag is groovy
          pom = readMavenPom file: 'pom.xml'
          version = pom.version
          docker.withRegistry(
            'https://059781990520.dkr.ecr.ap-south-1.amazonaws.com/',
            'ecr:ap-south-1:spashta-aws-credentials') {
              def myimage = docker.build('test_repo')
              myimage.push('latest')
              myimage.push("${version}-${BUILD_NUMBER}")
            }
        }
      }
    }

    stage('tag repo') {
      steps {
        script {
          // code insdie script tag is groovy
          pom = readMavenPom file: 'pom.xml'
          tag = pom.version + '-' + env.BUILD_NUMBER
          sh """
          echo tag is ${tag}
          git remote set-url origin https://$GH_PAT@github.com/deerao1/spring-web-app.git
          git tag -a ${tag} -m "Generated by: ${env.JENKINS_URL}"
          git push origin ${tag}
        """
        }
      }
    }

    stage('deploy to kubernetes') {
      agent { node { label 'k8' } }
      steps {
        sh """
        rm -f /root/.kube/config
        # configure kubectl to access eks
        aws eks update-kubeconfig --region $AWS_REGION  --name $K8_CLUSTER_NAME
        kubectl create ns demo-namespace
        kubectl apply -f manifest.yml
        sleep 60
        endpoint=$(kubectl get svc --namespace=demo-namespace | grep springboot | awk '{print $4}')
        curl --max-time 10 $endpoint
      """
      }
    }

  }
    post {
      success {
          emailext to: 'deerao.in@gmail.com',
          subject: "SUCCESS $JOB_NAME Build No: $BUILD_NUMBER",
          body: 'Build result:' + currentBuild.result + '. Check: ' + currentBuild.absoluteUrl
      }
      failure {
          emailext to: 'deerao.in@gmail.com',
          subject: "FAILURE $JOB_NAME Build No: $BUILD_NUMBER",
          body: 'Build result:' + currentBuild.result + '. Check: ' + currentBuild.absoluteUrl
      }
    }
}
