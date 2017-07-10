#!/usr/bin/env bash

echo "*****************Start install_ruby.sh*****************"

RUBY_TARBALL_DIR=$TRAVIS_BUILD_DIR/dist
mkdir -p $RUBY_TARBALL_DIR

echo "Configure environment variables..."
. $HOME/bedroom/script/osx/util/env_vars.sh
. $APP_SCRIPT_ROOT/dotfiles/home/.profile

echo "Determine MacOS version..."
. $SCRIPT_UTIL_ROOT/determine_system_version.sh
echo "MacOS version: $SYSTEM_VERSION"

echo "Install rbenv dependencies..."
. $SCRIPT_UTIL_ROOT/install_rbenv_dependencies.sh

echo "Install rbenv..."
. $SCRIPT_UTIL_SHARE/install_rbenv.sh

if ! [ -z ${RUBY_2_VERSION+x} ]; then
    . $SCRIPT_UTIL_SHARE/rbenv_install_ruby.sh $RUBY_2_VERSION true false
    export RUBY_2_TARBALL_SAVE_NAME=rbenv_ruby_${RUBY_2_VERSION}_${OS_NAME}_${SYSTEM_VERSION}.tar.gz

    echo "Compressing ruby2 folder to '$RUBY_2_TARBALL_SAVE_NAME'..."
    tar -czf $RUBY_2_TARBALL_SAVE_NAME --directory=$RBENV_VERSIONS/$RUBY_2_VERSION .
    
    echo "Moving $RUBY_2_TARBALL_SAVE_NAME to $RUBY_TARBALL_DIR..."
    mv $RUBY_2_TARBALL_SAVE_NAME $RUBY_TARBALL_DIR/
else
    echo "RUBY_2_VERSION is not set thus will not install ruby2."
fi

echo "Output of 'ls -alh $RBENV_VERSIONS':"
ls -alh $RBENV_VERSIONS

echo "Output of 'rbenv versions':"
rbenv versions

echo "Output of 'ls -alh $RUBY_TARBALL_DIR':"
ls -alh $RUBY_TARBALL_DIR

echo "-----------------Done install_ruby.sh-----------------"
