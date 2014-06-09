SHELL = /bin/bash	#for ${HOME} and if-constructions
BINDIR = ${HOME}/bin/webmail-gnupg
ENCRYPT = encrypt_in_place
SIGN = sign_in_place
VERIFY = verify_in_place
STRIP = strip_indent
REPLY = reply.sh
INSTVIM = install_vimrc
UNINSTVIM = uninstall_vimrc
MFILE = Makefile
README = README.md

install: test install_only

test:
	@if [ ! -x $(which perl) ]; then echo "perl not installed"; fi
	@if [ ! -x $(which gpg) ]; then echo "gpg not installed"; fi
	@if [ ! -x $(which gvim) ]; then echo "gvim not installed"; fi
	@if [ ! -x $(which firefox) ]; then echo "firefox not installed"; fi
	@if [ ! -f ~/.vim/plugin/gnupg.vim ]; then echo "gnupg.vim not found. If it's not installed, please visit http://www.vim.org/scripts/script.php?script_id=3645 and follow the instructions there."; fi

install_only: $(ENCRYPT) $(SIGN) $(VERIFY) $(STRIP) $(INSTVIM) $(UNINSTVIM) $(README)
	mkdir -p $(BINDIR)
	cp -t $(BINDIR) $(ENCRYPT) $(SIGN) $(VERIFY) $(STRIP) $(INSTVIM) $(UNINSTVIM) $(README) $(MFILE)
	echo -e "#!/bin/bash\n\n$(BINDIR)/$(STRIP) \x241 #bash\n/usr/bin/gvim \x241" > $(BINDIR)/$(REPLY)
	@if [ ! -f ~/.vimrc ]; then touch ~/.vimrc; fi
	chmod a+x $(BINDIR)/$(REPLY)
#add Fx key bindings to ~/.vimrc
	./$(INSTVIM) $(BINDIR)
	@echo ""
	@echo "Installation finished. Now configure It's_all_text! to use $(BINDIR)/reply.sh as the editor and add .asc to the file extensions."

tar: $(ENCRYPT) $(SIGN) $(VERIFY) $(STRIP) $(INSTVIM) $(UNINSTVIM) $(MFILE)
	tar cjf webenc.tbz2 $(ENCRYPT) $(SIGN) $(VERIFY) $(STRIP) $(INSTVIM) $(UNINSTVIM) $(MFILE)

clean:
	-rm $(ENCRYPT)
	-rm $(SIGN)
	-rm $(VERIFY)
	-rm $(STRIP)
	-rm $(REPLY)
	-rm $(INSTVIM)
	-rm $(UNINSTVIM)
	-rm $(README)
	-rm $(MFILE)

uninstall: $(UNINSTVIM)
# remove Fx key bindings from ~/.vimrc
	./$(UNINSTVIM) $(BINDIR)
	-rm $(BINDIR)/$(ENCRYPT)
	-rm $(BINDIR)/$(SIGN)
	-rm $(BINDIR)/$(VERIFY)
	-rm $(BINDIR)/$(STRIP)
	-rm $(BINDIR)/$(REPLY)
	-rm $(BINDIR)/$(INSTVIM)
	-rm $(BINDIR)/$(UNINSTVIM)
	-rm $(BINDIR)/$(README)
	-rm $(BINDIR)/$(MFILE)
	rmdir --ignore-fail-on-non-empty $(BINDIR)

.PHONY: clean uninstall tar installonly test
