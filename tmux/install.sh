#!/usr/bin/env bash
printf "config tmux...  "
cd $HOME
git clone --depth=1 https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

printf "\t done.\n"
