chr=$HOME/chroot/

progs="
	/bin/mkdir
	/bin/rmdir
	/bin/ls
	/bin/rm
	/bin/touch
	/bin/bash
	/bin/sed
	/bin/vi
	/usr/bin/openssl
	/usr/bin/tar
	/usr/bin/mv
	/usr/bin/chown
	/usr/bin/chmod
	/usr/bin/cat
	/usr/bin/gzip
"
set +x
for prog in $progs; do
	cp -nv --parents "$prog" "$chr"
	for i in $(ldd "$prog" | egrep -o '/lib.*\.[0-9]+'); do 
		cp -nv --parents "$i" "$chr";
	done
done

sudo chroot $HOME/chroot /bin/bash
