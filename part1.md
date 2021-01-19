# Part1

## 1.1

```
CONTAINER ID   IMAGE                    COMMAND                  CREATED              STATUS                        PORTS                                            NAMES
71e38060b918   jenkins/jenkins:lts      "/sbin/tini -- /usr/…"   48 seconds ago       Exited (130) 39 seconds ago                                                    sharp_curie
f1495d4387b0   nginx                    "/docker-entrypoint.…"   About a minute ago   Up About a minute             80/tcp                                           compassionate_shtern
fc22886be7a1   nginx                    "/docker-entrypoint.…"   2 minutes ago        Exited (127) 2 minutes ago                                                     sleepy_wilson
fd44cd6c8bd9   nginx                    "/docker-entrypoint.…"   2 minutes ago        Exited (0) 2 minutes ago                                                       sad_payne
44f3be4a1e3f   jenkins/jenkins:lts      "/sbin/tini -- /usr/…"   6 weeks ago          Exited (255) 5 days ago       50000/tcp, 0.0.0.0:8081->8080/tcp                jenkins-local
58195db017d4   portainer/portainer-ce   "/portainer"             7 weeks ago          Up 4 hours                    0.0.0.0:8000->8000/tcp, 0.0.0.0:9000->9000/tcp   portainer
```

## 1.2 

```
➜  devops-doker git:(main) ✗ docker container ls -a                               
CONTAINER ID   IMAGE                    COMMAND                  CREATED       STATUS                    PORTS                                            NAMES
44f3be4a1e3f   jenkins/jenkins:lts      "/sbin/tini -- /usr/…"   6 weeks ago   Exited (255) 5 days ago   50000/tcp, 0.0.0.0:8081->8080/tcp                jenkins-local
58195db017d4   portainer/portainer-ce   "/portainer"             7 weeks ago   Up 4 hours                0.0.0.0:8000->8000/tcp, 0.0.0.0:9000->9000/tcp   portainer
```


```
➜  devops-doker git:(main) ✗ docker image ls             
REPOSITORY               TAG       IMAGE ID       CREATED        SIZE
jenkins/jenkins          lts       1920bf702d7d   6 weeks ago    713MB
portainer/portainer-ce   latest    a0a227bf03dd   4 months ago   196MB
```

## 1.3

```
➜  devops-doker git:(main) ✗ docker container run -it devopsdockeruh/pull_exercise
Unable to find image 'devopsdockeruh/pull_exercise:latest' locally
latest: Pulling from devopsdockeruh/pull_exercise
8e402f1a9c57: Pull complete 
5e2195587d10: Pull complete 
6f595b2fc66d: Pull complete 
165f32bf4e94: Pull complete 
67c4f504c224: Pull complete 
Digest: sha256:7c0635934049afb9ca0481fb6a58b16100f990a0d62c8665b9cfb5c9ada8a99f
Status: Downloaded newer image for devopsdockeruh/pull_exercise:latest
Give me the password: basic
basic is not the correct password, please try again

Give me the password: basics
You found the correct password. Secret message is:
"This is the secret message"
```

## 1.4

```
➜  devops-doker git:(main) ✗ docker container exec -it romantic_noyce bash
root@d8ffa72c394b:/usr/app# ps aux
USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root         1  0.0  0.2 620420 31948 pts/0    Ssl+ 14:20   0:00 node index
root        26  0.7  0.0  18188  3148 pts/1    Ss   14:23   0:00 bash
root        33  0.0  0.0  36636  2804 pts/1    R+   14:23   0:00 ps aux
root@d8ffa72c394b:/usr/app# tail -f ./logs.txt 
Secret message is:
"Docker is easy"
```

## 1.5
pull ubuntu image

```
docker image pull ubuntu:16.04
```

update repository, get curl, call websiste
--rm removes container on exit
```
docker container run -it --rm --name looper-it ubuntu:16.04 sh -c 'apt-get update; apt-get -y install curl; echo "Input website:"; read website; echo "Searching.."; sleep 1; curl http://$website;'
```

## 1.6
create Jenkins file
build docker

```
docker build . 
```

executing does changes the tag on container
```
docker build . -t docker-clock
```

Dockerfile

!!!CMD is not getting the linux command output date +%s, so clock could start

```
FROM devopsdockeruh/overwrite_cmd_exercise
CMD ["bin/bash"]
```

this starts clock on screen
```
docker container run --rm -it docker-clock --clock $(date +%s)
```
output:
```
➜  devops-doker git:(1-6) ✗ docker container run --rm -it docker-clock --clock $(date +%s)
1610868340
1610868341
1610868342
```

or Dockerfile can have following info, but not possible to use current epoch time
```
CMD ["--clock", "10000"]
```

## 1.7 

```
docker build . -t curler
```

```
docker container run --rm -it curler
```

## 1.8

make sure that `cat $(pwd)/user_app_logs/logs.txt` does does not state that this is directory

```
mkdir user_app_logs
touch logs.txt
docker container run -it --rm -v "$(pwd)/user_app_logs/logs.txt:/usr/app/logs.txt" devopsdockeruh/first_volume_exercise
```

```
Tue, 19 Jan 2021 19:01:19 GMT
Tue, 19 Jan 2021 19:01:22 GMT
Tue, 19 Jan 2021 19:01:25 GMT
Tue, 19 Jan 2021 19:01:28 GMT
Secret message is:
"Volume bind mount is easy"
```

## 1.9

```
docker container run -it --rm -p 80:80 devopsdockeruh/ports_exercise
```

```
js@NS1952:~/dev/devops-doker$ curl localhost
Ports configured correctly!!
```

## 1.10

```
docker build -t frontend-example-docker . 
```

```
docker container run -it -p 80:5000 frontend-example-docker
```

## 1.11

```
docker build -t backend-example-docker . 
```

with logs
```
docker container run -it -v "$(pwd)/user_app_logs/logs.txt:/js/backend-example-docker/logs.txt" -p 8000:8000 backend-example-docker
```

## 1.12

added to fronend Dockerfile :)

```
ENV LC_ALL=C.UTF-8
ENV API_URL=http://localhost:8000
```

CORS is not working, so changing backend

```
ENV LC_ALL=C.UTF-8
FRONT_URL=http://localhost:5000
```
