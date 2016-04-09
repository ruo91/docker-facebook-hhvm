# Facebook - HHVM
### - Build
 ```sh
 root@ruo91:~# docker build --rm -t hhvm:packages https://github.com/ruo91/docker-facebook-hhvm.git
```

# - Container run
```sh
root@ruo91:~# docker run -d --name="hhvm" -h "hhvm" -p 9000:9000 -v /tmp:/tmp -v /home:/home hhvm:packages
```
