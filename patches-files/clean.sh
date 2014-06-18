#! /bin/sh

make config-clean
rm -rvf .config*
rm -rvf ./bin/


rm -rf ./build_dir/target*
rm -rf ./staging_dir/target*
rm -rf ./tmp/
rm -rf ./scripts/config/mconf_check

