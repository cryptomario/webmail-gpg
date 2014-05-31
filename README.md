webmail-gpg
===========

Using gpg with webmail.

Requirements
------------

You need to have the following installed:
* perl
* gpg
* firefox
* [It's all text!](https://addons.mozilla.org/en-us/firefox/addon/its-all-text/)	(plugin for firefox)
* gvim
* [gnupg.vim](http://www.vim.org/scripts/script.php?script_id=3645)	(plugin for gvim)

You should also have created a keypair and exchanged public keys with people, making sure the keys you have actually do belong to the people you believe they belong to. These steps are explained in the [GPG manual](http://gnupg.org/documentation/guides.en.html).

Installation
------------

Run "make install" to install files in ~/bin and bind the Fx keys in ~/.vimrc (see below).
Configure It's all text! to use ~/bin/webenc/reply.sh as the editor and add the .asc file extension.

Use
---

To write an encrypted email: 
* Edit the body with It's all text! using the .asc extension
* Before writing anything, press F3 to write an encrypted mail
* After you are finished, save (:w) and press F5 to sign the mail
* If you want to edit after signing, remove the signature with F6

To reply to an encrypted mail:
* Edit the body with It's all text! using the .asc extension
* If the mail starts with a signature, verify and remove it by pressing F6
* After you are finished, save (:w) and press F5 to sign the mail
* If you want to edit after signing, remove the signature with F6

