#!/bin/bash

# set directories
cd ~/Desktop/GitHub/radiant
dirsource=../radiant_miniCRAN/src/contrib/
dirmac=../radiant_miniCRAN/bin/macosx/contrib/3.2/
dirmac_mav=../radiant_miniCRAN/bin/macosx/mavericks/contrib/3.2/
dirwin=../radiant_miniCRAN/bin/windows/contrib/3.2/

# updating gh packages
# cd ../DT
# git pull

# removing all files in miniCRAN
# rm $dirsource/*
# rm $dirmac/*
# rm $dirmac_mav/*
# rm $dirwin/*

# delete older version of radiant
rm $dirsource/radiant*
rm $dirmac/radiant*
rm $dirmac_mav/radiant*
rm $dirwin/radiant*

# rm $dirsource/DT*
# rm $dirmac/DT*
# rm $dirmac_mav/DT*
# rm $dirwin/DT*

# rm $dirsource/shiny*
# rm $dirmac/shiny*
# rm $dirmac_mav/shiny*
# rm $dirwin/shiny*
#
# rm $dirsource/knitr*
# rm $dirmac/knitr*
# rm $dirmac_mav/knitr*
# rm $dirwin/knitr*

# build source and mac version
R --save < build/build_mac_source.R 2>&1

# move packages to radiant_miniCRAN. must package in Windows first
mv ../*.tar.gz $dirsource
cp ../*.tgz $dirmac
mv ../*.tgz $dirmac_mav
mv ../*.zip $dirwin

# write package files for CRAN structure
R --save < build/write_package_files.R 2>&1

# commit to repo
cd ../radiant_miniCRAN
git add --all .
# from http://stackoverflow.com/questions/4654437/how-to-set-current-date-as-git-commit-message
git commit -m "radiant package update: `date +\"%m-%d-%Y\"`"
git push
cd ../radiant
