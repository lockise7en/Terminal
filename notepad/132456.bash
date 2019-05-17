cd /opt && git clone --recurse-submodules https://github.com/shibingli/webconsole.git && cd webconsole && git submodule update --init --recursive
cd /opt/webconsole/src/apibox.club/apibox
GOPATH=/opt/webconsole go install
cd /opt/webconsole
docker build -t webconsole:latest .
docker run -d -p 8080:8080 --restart=always --name webconsole webconsole:latest