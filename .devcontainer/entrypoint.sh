#!/bin/bash -e

REPO_PATH=/repo

echo "Configuring SSH ..."
cp -R /tmp/.ssh /root
echo " Done."
echo

echo "Configuring .config/git"
mkdir -p /root/.config/
cp -R /tmp/.config/git/ /root/.config/
echo " Done."
echo

cd ${REPO_PATH}

if [[ -z "$*" ]]; then
    echo
    echo "Starting bash..."
    echo
    exec "/bin/bash"
else
    echo "Running command '$*'..."
    echo
    exec "$@"
fi