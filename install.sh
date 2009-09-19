#!/bin/bash
! [ -d ~/.virtualenvs/backup_scripts ] && mkdir ~/.virtualenvs/backup_scripts

cd global_scripts
for i in *; do
	if ! [ "$i" == "." ] && ! [ "$i" == ".." ] && ! [ "$i" == ".git" ]; then
		if [ -e ~/.virtualenvs/$i ]; then
			if ! ( cp ~/.virtualenvs/$i ~/.virtualenvs/backup_scripts/$i ) || ! ( rm ~/.virtualenvs/$i || unlink ~/.virtualenvs/$i ); then
				echo "Failed backup on $i" > /dev/stderr
				exit 1
			fi
		fi
		if ln -s $(pwd)/$i ~/.virtualenvs/$i; then
			echo "Linked: $i" > /dev/stderr
		else
		    echo "ln -s $(pwd)/$i ~/.virtualenvs/$i"
			echo "Failed on $i" > /dev/stderr
			exit 1
		fi
	fi
done

exit 0
