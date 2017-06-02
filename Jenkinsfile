#!/usr/bin/groovy
podTemplate(label: 'docker-test-pipeline', containers: [
    containerTemplate(name: 'jnlp', image: 'jenkinsci/jnlp-slave:2.62', args: '${computer.jnlpmac} ${computer.name}', workingDir: '/home/jenkins', resourceRequestCpu: '200m', resourceLimitCpu: '200m', resourceRequestMemory: '256Mi', resourceLimitMemory: '256Mi'),
    containerTemplate(name: 'docker', image: 'docker:1.12.6',         command: 'cat', ttyEnabled: true)
],
volumes:[
    hostPathVolume(mountPath: '/var/run/docker.sock', hostPath: '/var/run/docker.sock'),
]){
  node ('docker-test-pipeline'){
    container('docker') {
      def app
      stage('Clone repository') {
          /* Let's make sure we have the repository cloned to our workspace */
          checkout scm
      }
      stage('Build image') {
          /* This builds the actual image; synonymous to
           * docker build on the command line */
          app = docker.build('eigokor/hellonode', '.')
      }
      stage('Test image') {
          /* Ideally, we would run a test framework against our image.
           * For this example, we're using a Volkswagen-type approach ;-) */
          //app.inside {
          //    sh 'echo "Tests passed"'
          //}
      }
      stage('Push image') {
          /* Finally, we'll push the image with two tags:
           * First, the incremental build number from Jenkins
           * Second, the 'latest' tag.
           * Pushing multiple tags is cheap, as all the layers are reused. */
          docker.withRegistry('https://registry.hub.docker.com', 'eigokor-docker-hub-credentials') {
              app.push("${env.BUILD_NUMBER}")
              app.push("latest")
          }
      }
    }
  }
}
