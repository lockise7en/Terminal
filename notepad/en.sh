#!/bin/bash
if [ ! -d /var/www/apache2 ]; then
	chmod -R 0755 /var/www/apache2
	service apache2 start
if
if [ ! -d /usr/sbin/sshd ]; then
	nohup service ssh start >/dev/null 2>&1 &
fi
if [ ! -d /usr/bin/lantern ]; then
rm -rf /root/.lantern/*
chmod +x /usr/bin/lantern
nohup /usr/bin/lantern -headless true -addr 0.0.0.0:8787 -startup true -clear-proxy-settings true -socksAddr 0.0.0.0:18787 -systemProxy true -autoLaunch false -autoReport false -proxyAll true >/dev/null 2>&1 &
fi
set -e

create_pid_dir() {
  mkdir -p /run/apt-cacher-ng
  chmod -R 0755 /run/apt-cacher-ng
  chown ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} /run/apt-cacher-ng
}

create_cache_dir() {
  mkdir -p ${APT_CACHER_NG_CACHE_DIR}
  chmod -R 0755 ${APT_CACHER_NG_CACHE_DIR}
  chown -R ${APT_CACHER_NG_USER}:root ${APT_CACHER_NG_CACHE_DIR}
}

create_log_dir() {
  mkdir -p ${APT_CACHER_NG_LOG_DIR}
  chmod -R 0755 ${APT_CACHER_NG_LOG_DIR}
  chown -R ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} ${APT_CACHER_NG_LOG_DIR}
}

create_pid_dir
create_cache_dir
create_log_dir

# allow arguments to be passed to apt-cacher-ng
if [[ ${1:0:1} = '-' ]]; then
  EXTRA_ARGS="$@"
  set --
elif [[ ${1} == apt-cacher-ng || ${1} == $(which apt-cacher-ng) ]]; then
  EXTRA_ARGS="${@:2}"
  set --
fi

# default behaviour is to launch apt-cacher-ng
if [[ -z ${1} ]]; then
  exec tini -- start-stop-daemon --start --chuid ${APT_CACHER_NG_USER}:${APT_CACHER_NG_USER} \
    --exec $(which apt-cacher-ng) -- -c /etc/apt-cacher-ng ${EXTRA_ARGS}
else
  exec tini -- "$@"
fi