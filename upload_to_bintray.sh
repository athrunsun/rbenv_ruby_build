#!/usr/bin/env bash

echo "*****************Start upload_to_bintray.sh*****************"

if ! [ -z ${RUBY_2_VERSION+x} ]; then
    echo "Uploading ruby2 binary tarball to bintray..."
    curl -v -u $BINTRAY_USER_NAME:$BINTRAY_API_KEY --upload-file $TRAVIS_BUILD_DIR/dist/$RUBY_2_TARBALL_SAVE_NAME "https://api.bintray.com/content/athrunsun/rbenv_ruby_build/ruby2/stable/$RUBY_2_TARBALL_SAVE_NAME?publish=1&override=1"
fi

echo "-----------------Done upload_to_bintray.sh-----------------"
