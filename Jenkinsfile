node {
    checkout scm

    stage('Build images') {
        files = findFiles(exclude: 'Jenkinsfile')
        files.each {
            Containerfile ->
                withEnv(["Containerfile=${Containerfile}"]) {
                    sh 'buildah bud --tag ${Containerfile} --file ${Containerfile}'
                }
        }
    }
}
