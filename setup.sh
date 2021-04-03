#!/usr/bin/env bash

for f in `ls $PWD` 
do
base=${f%.*}
ext=${f#$base.}
if [[ "$ext" == "zsh" ]]
then
	ln -sfn "$PWD/$f" "$HOME/.oh-my-zsh/custom/$f"
fi
done
