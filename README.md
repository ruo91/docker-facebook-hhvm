# Facebook HHVM FastCGI

**- Build**

    root@ruo91:~# git clone https://github.com/ruo91/docker-facebook-hhvm.git /opt/docker-facebook-hhvm
    root@ruo91:~# cd /opt/docker-facebook-hhvm
    root@ruo91:~# git checkout -b source origin/source
    root@ruo91:~# docker build --rm -t hhvm:source /opt/docker-facebook-hhvm

**- Container run**

    root@ruo91:~# docker run -d --name="hhvm-source" \
    -p 9000:9000 -v /tmp:/tmp -v /home:/home hhvm:source
