#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
	exit -1
fi
PROJECT=${1}

BASE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

cd "$PWD"

if [ "$#" -gt 1 ]; then
	ENVS_INPUT=${2}
else
	ENVS_INPUT="${BASE_DIR}/envs"
fi

if [ "$#" -gt 2 ]; then
	ENVS_DIR=${3}
else
	ENVS_DIR="/miniconda3/envs"
fi

while read -r env_name
do 
	python_bin="${ENVS_DIR}/${env_name}/bin/python"
	pip_bin="${ENVS_DIR}/${env_name}/bin/pip"
	if [ -x "${python_bin}" ] &&  [ -x "${pip_bin}" ] ; then
		echo "${env_name} env"
    	echo
    	${pip_bin} uninstall ${PROJECT} -y
    	${python_bin} setup.py install --force; ${python_bin} setup.py test
    	echo "--------------------------------------------------------------------------------"
    	echo
	fi
done < ${ENVS_INPUT}
