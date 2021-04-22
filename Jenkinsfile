node {
    stage('Build images') {
        files = findFiles(glob: '*')
        files.each {
            ContainerFile ->
                withEnv(["ContainerFile=${ContainerFile}"]) {
                    sh 'buildah bud -t ${ContainerFile} .'
                }
        }
    }
}