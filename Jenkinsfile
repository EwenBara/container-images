class containerfile {
    String name
    Boolean built
    String depends_on
    String[] required_by

    containerfile(name) {
        this.name = name
        this.built = false
        this.depends_on = ''
        this.required_by = []
    }
}

def build(images, name) {
    withEnv(["Containerfile=${name}"]) {
        IMAGE_ID = sh(script: 'buildah bud --file ${Containerfile}.Containerfile', returnStdout: true)trim().split('\n')[-1]
        withEnv(["IMAGE_ID=${IMAGE_ID}"]) {
            sh 'buildah tag ${IMAGE_ID} ${Containerfile}:latest ${Containerfile}:$(date +%Y%m%d)'
        }
        images[name].built = true
    }
}

node {
    properties([
		pipelineTriggers([
			cron('@daily')
		])
	])

    checkout scm

    def images = [:]

    stage('Build dependencies tree') {
        files = findFiles(glob: '**/*.Containerfile')
        files.each {
            Containerfile ->
                name = Containerfile.path.replace('.Containerfile', '')
                images.putAt(name, new containerfile(name))
        }

        files.each {
            Containerfile ->
                name = Containerfile.name.replace('.Containerfile', '')
                withEnv(["Containerfile=${Containerfile}"]) {
                    depends_on = sh(script: 'grep -E "^FROM localhost/.+$" ${Containerfile} | sed \'s@FROM localhost/\\+@@\'', returnStdout: true).trim().split(' ')[0]
                }
                println("${name} depends on => ${depends_on}")
                if('' != depends_on) {
                    images[name].depends_on = depends_on
                    if(null != images[depends_on]) {
                        images[depends_on].required_by += name
                    }
                }
        }
    }

    def next = [:]
    images.each {
        key, image ->
            if(!images.containsKey(image.depends_on) || images[image.depends_on].built == true) {
                next[key] = { build(images, key) }
            }
    }

    def i = 0
    while(0 < next.size()) {
        i++
        stage("Build gen${i}") {
            parallel(next)
        }
        next = [:]
        images.each {
            key, image ->
                if(!image.built && (!images.containsKey(image.depends_on) || images[image.depends_on].built == true)) {
                    next[key] = { build(images, key) }
                }
        }
    }

    stage('Clean old images') {
        sh 'podman image prune --force --filter until=$(date -I -d "now-1day")'
    }
}
