# https://github.com/MrSimonEmms/get-iplayer/blob/master/Makefile
TAG=abw-iplayer
docker:
	docker build . --tag ${TAG}
