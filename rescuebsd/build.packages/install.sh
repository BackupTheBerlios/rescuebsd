#!/bin/sh
#
# recueBSD - an advanced 'fixit' version of FreeBSD5
# Copyright (c) 2005    - Gordon Bergling
#
# All rights reserved.
#
#  Redistribution and use in source and binary forms, with or without
#  modification, are permitted provided that the following conditions
#  are met:
#  1. Redistributions of source code must retain the above copyright
#     notice, this list of conditions and the following disclaimer.
#  2. Redistributions in binary form must reproduce the above copyright
#     notice, this list of conditions and the following disclaimer in the
#     documentation and/or other materials provided with the distribution.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
#  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
#  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
#  ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
#  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
#  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
#  OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
#  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
#  LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
#  OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
#  SUCH DAMAGE.
#
# $Id: install.sh,v 1.1 2005/04/04 20:22:47 mindtrap Exp $

echo "  installing temporary resolv.conf..."
echo "nameserver 127.0.0.1" > ../chroot/etc/resolv.conf

echo "  checking installed packages..."

chroot ../chroot /usr/sbin/pkg_info -Qoa | /usr/bin/awk \
'{ 
  split($1,info,":"); 
  split(info[2],tcat,"/"); 
  print tcat[2]; 
}' > pkg_inst

cat pkg_list pkg_inst | sort -nr | uniq -c | grep '1 ' | \
awk '{print $2}' > to_install

for package in `cat to_install`
do
 chroot ../chroot /usr/sbin/pkg_add -r $package
done

echo "  deleting temporary resolv.conf..."
echo -n "" > ../chroot/etc/resolv.conf
