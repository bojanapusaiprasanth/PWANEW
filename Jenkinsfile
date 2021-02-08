pipeline {
  agent any
  tools {
    maven 'My maven'
    jdk 'My Java'
  }
  stages {
    stage('Clean Workspace') {
      steps {
        cleanWs()
      }
    }
    stage('GitCheckout') {
      steps {
        git 'https://github.com/bojanapusaiprasanth/PWANEW.git'
      }
    }
    stage('compile code') {
      steps {
        sh 'mvn compile'
      }
    }
    stage('code review') {
      steps {
        // Warnings Next gen plugin is required
        sh 'mvn -P metrics pmd:pmd'
      }
      post {
        always {
          recordIssues(tools: [acuCobol(pattern: '**/target/pmd.xml', reportEncoding: 'UTF-8')])
        }
      }
    }
    stage('junit test') {
      steps {
        sh 'mvn test'
      }
      post {
        always {
          junit '**/target/surefire-reports/*.xml'
        }
      }
    }
    stage('Metrics Check') {
      steps {
        // cobertura plugin should be installed
        sh 'mvn cobertura:cobertura -Dcobertura.report.format=xml'
      }
      post {
        always {
          cobertura autoUpdateHealth: false,
           autoUpdateStability: false,
            coberturaReportFile: '**/target/site/cobertura/coverage.xml',
             conditionalCoverageTargets: '70, 0, 0',
              failUnhealthy: false,
               failUnstable: false,
                lineCoverageTargets: '80, 0, 0',
                 maxNumberOfBuilds: 0,
                  methodCoverageTargets: '80, 0, 0',
                   onlyStable: false,
                    sourceEncoding: 'ASCII',
                     zoomCoverageChart: false
        }
      }
    }
    stage('Sonarqube Analysis') {
      steps {
        withSonarQubeEnv('mysonarqube') {
          sh 'mvn sonar:sonar'
        }
      }
    }
    stage('Build Package') {
      steps {
        sh 'mvn clean install package'
      }
    }
    stage('Push Artifacts to Nexus Repo') {
      steps {
        script {
          def mavenPom = readMavenPom file: 'pom.xml'
          nexusArtifactUploader artifacts: [
              [artifactId: 'pwa',
               classifier: '',
                file: "target/pwa-${mavenPom.version}.jar",
                 type: 'jar'
                 ]
         ],
          credentialsId: 'Nexus',
           groupId: 'pwa',
            nexusUrl: 'nexus.sidhuco.in',
             nexusVersion: 'nexus3',
              protocol: 'http',
               repository: 'pwanew',
                version: "${mavenPom.version}"
        }
      }
    }
    stage('Run Docker compose to start containers') {
      input {
        message "Please select YES or NO to proceed with Deployment"
        ok "Yes, We can Proceed"
        submitter "SaiPrasanth"
        parameters {
          string(name: 'PERSON', defaultValue: 'SaiPrasanth', description: 'Please provide name of person who is approving')
        }
      }
      steps {
        script {
          def mavenPom = readMavenPom file: 'pom.xml'
          sh "docker build -t 'Jenkinsbuildpwaimage' --build-arg POMVERSION=${mavenPom} ."
          sh 'docker-compose up -d'
        }
      }
    }
  }
}

