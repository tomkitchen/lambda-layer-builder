# lambda-layer-builder

To generate the base lambda docker image

launch 2 instances from the ami listed here...
https://docs.aws.amazon.com/lambda/latest/dg/current-supported-versions.html

detach the root volume from one of the machines and attach it to the other
install docker
mount the volume and tar it up
sudo mount /dev/xvdf1 /mnt
cd /mnt
sudo tar -c . | docker import - docker_repo/image_name

docker build . -t tkitchen00/lambda-python3.7
docker run -d --mount type=bind,src=$(pwd),dst=/home/ec2-user/mount tkitchen00/lambda-python3.7:latest
