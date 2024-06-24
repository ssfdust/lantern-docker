run:
	podman run -d --name lantern -p 39331:1080 -p 39332:8080 docker.io/ssfdust/lantern

start:
	podman start lantern

stop:
	podman stop lantern

rm:
	podman rm lantern

build:
	podman build -t docker.io/ssfdust/lantern:latest .
