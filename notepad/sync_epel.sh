#!/bin/bash

function sync_epel() {
	repo_url="$1"
	repo_dir="$2"

	[ ! -d "$repo_dir" ] && mkdir -p "$repo_dir"
	cd $repo_dir
	lftp "${repo_url}/" -e "mirror --verbose -P 5 --delete; bye"
}

sync_epel "https://dl.fedoraproject.org/pub/epel/7/x86_64/" "${TUNASYNC_WORKING_DIR}/centos/7/x86_64/epel"
