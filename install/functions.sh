#!/usr/bin/env zsh

function info_message(){
  echo -e "\e[36m$1\e[m\n"
} 

function error_message(){
  echo -e "\e[31m$1\e[m\n"
}

function success_message(){
  echo -e "\e[32m$1\e[m\n"
}
