# package-lambda
A very opinionated lambda packaging Docker image. Why opinionated? I like to run my projects with app code and infra deployed from the same repo. I was versioning my app code with the git-sha of the project, but I didn't like how it would re-deploy my lambda functions. This packager will generate a zip file named after the sha of the code. That way, if the code doesn't change, the hash will remain the same and the lambda won't update on a deployment.

# How to build

'make build'

This will build the named container and make it available to your system.

# How to use it

In your automation, use the docker run command:

'docker run --rm -it \
		-v `pwd`/code:/code:ro \
		-v `pwd`/output:/output \
		package-lambda'
		
This will mount a code directory in the current working directory to the container at /code in read only. It also mounts an output directory for the resulting package. If your lambda code is in a different directory, change that line to '-v `pwd`/[lambda dir]'. Upload the zip file to your S3 location and deploy your lambda. Done.