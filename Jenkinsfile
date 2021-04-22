node {
    checkout scm

    stage('Build images') {
        files = findFiles(glob: '*.Containerfile')
        files.each {
            Containerfile ->
                withEnv(["Containerfile=${Containerfile.replace('.Containerfile', '')}"]) {
                    sh 'buildah bud --tag ${Containerfile} --file ${Containerfile}.Containerfile'
                }
        }
    }
}
