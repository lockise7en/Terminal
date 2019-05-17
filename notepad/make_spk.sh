#!/bin/bash


#mkdir SugarCRM
#tar -xvf SugarCRM-6.5-0020.spk -C ./SugarCRM
#cd SugarCRM
#tar -xzvf package.tgz
rm -rf 2_create_project/* 1_create_package/*
mkdir 2_create_project 1_create_package
tar -xvf  Docker-GitLab-AllinOne-x64-11.0.4-0053.spk -C 2_create_project/
tar xzvf 2_create_project/package.tgz -C 1_create_package/

cd 1_create_package 
tar cvfz package.tgz *
mv package.tgz ../2_create_project/ 
cd ../2_create_project/ 
tar cvfz  DownloadStation-x86_64-3.7.1-3282.spk  2_create_project/*
rm -f package.tgz



