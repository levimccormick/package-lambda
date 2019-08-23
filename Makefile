build:
	docker build -t package-lambda .
	
	
run:
	docker run --rm -it \
		-v `pwd`/code:/code:ro \
		-v `pwd`/output:/output \
		package-lambda