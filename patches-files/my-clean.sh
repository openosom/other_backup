#! /bin/sh

make config-clean
rm -rvf .config*
rm -rvf ./bin/

mv -vf ./build_dir/target-arm_v7-a_eglibc-2.8_eabi/qt* ./build_dir/

rm -rf ./build_dir/target-arm_v7-a_eglibc-2.8_eabi/*
rm -rf ./staging_dir/target*
rm -rf ./tmp/
rm -rf ./scripts/config/mconf_check

mv -vf ./build_dir/qt* ./build_dir/target-arm_v7-a_eglibc-2.8_eabi/
