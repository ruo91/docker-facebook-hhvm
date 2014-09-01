# Facebook HHVM FastCGI

**- Build**

    root@ruo91:~# git clone https://github.com/ruo91/docker-facebook-hhvm.git /opt/docker-facebook-hhvm
    root@ruo91:~# docker build --rm -t hhvm:packages /opt/docker-facebook-hhvm

**- Container run**

    root@ruo91:~# docker run -d --name="hhvm-packages" \
    -p 9000:9000 -v /tmp:/tmp -v /home:/home hhvm:packages
