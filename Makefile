tar: $(shell find .)
	echo $(tagname)
	mkdir happynlinux
	ls |grep -v happynlinux |xargs -I@ cp -r @ happynlinux/
	tar -zcvf happynet-linux-x86-x64-dynamic-all-$(tagname).tar.gz happynlinux

clean:
	rm -rf happynlinux
