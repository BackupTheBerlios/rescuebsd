# recueBSD - an advanced 'fixit' version of FreeBSD5
# Copyright (c) 2005	- Gordon Bergling
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
# $Id: Makefile,v 1.3 2005/03/28 11:31:17 mindtrap Exp $

.include "${.CURDIR}/cfg/main.cfg"

all:	build

build:
	@echo "-------------------------------------------------------------------"
	@echo "                                      ____ ____  ____  "
	@echo "        _ __ ___  ___  ___ _   _  ___| __ ) ___||  _ \ "
	@echo "       | '__/ _ \/ __|/ __| | | |/ _ \  _ \___ \| | | |"
	@echo "       | | |  __/\__ \ (__| |_| |  __/ |_) |__) | |_| |"
	@echo "       |_|  \___||___/\___|\__,_|\___|____/____/|____/ "
	@echo "             -- an advanced 'fixit' version of FreeBSD5"
	@echo ""
	${_+_}@cd ${.CURDIR}; ${MAKE} stage1
	@echo ""
	${_+_}@cd ${.CURDIR}; ${MAKE} stage2
	@echo ""
	${_+_}@cd ${.CURDIR}; ${MAKE} stage3
	@echo ""
	${_+_}@cd ${.CURDIR}; ${MAKE} stage4
	@echo ""
	${_+_}@cd ${.CURDIR}; ${MAKE} stage5

###############################################################################
# Stage 1
#
# Simply buildworld and buildkernel
#
stage1:	
	@echo "-------------------------------------------------------------------"
	@echo ">>>> Stage1: Building everything from the source"
	@echo "-------------------------------------------------------------------"
	${_+_}@cd ${.CURDIR}; ${MAKE} stage11
	${_+_}@cd ${.CURDIR}; ${MAKE} stage12
stage11:
	@echo "---> Stage 1.1: building the world"
.if !exists(${.CURDIR}/state/stage11)
	( cd ${SRCD} && \
	  make -s buildworld __MAKE_CONF=${.CURDIR}/cfg/make.conf > ${.CURDIR}/logs/buildworld.log 2>&1 && \
	  touch ${.CURDIR}/state/stage11 \
	)
.else
	@echo "--> Stage 1.1 allready finished"
.endif
	
stage12:
	@echo "---> Stage 1.2: building the kernel"
.if !exists(${.CURDIR}/state/stage12)
	(cd ${SRCD} && \
	 KERNCONFDIR=${.CURDIR}/cfg make -s buildkernel __MAKE_CONF=${.CURDIR}/cfg/make.conf \
	 KERNCONF=RESCUEBSD > ${.CURDIR}/logs/buildkernel.log 2>&1 && \
	 touch ${.CURDIR}/state/stage12 \
	)
.else
	@echo "--> Stage 1.2 allready finished"
.endif

###############################################################################
# Stage 2
#
# setup the chroot environment
#   -> create the neccessary directories
#   -> populating /etc
#   -> install the world
#   -> install the kernel
#
stage2:
	@echo "-------------------------------------------------------------------"
	@echo ">>>> Stage2: Installing everything into a chroot"
	@echo "-------------------------------------------------------------------"
	${_+_}@cd ${.CURDIR}; ${MAKE} stage21
	${_+_}@cd ${.CURDIR}; ${MAKE} stage22
	${_+_}@cd ${.CURDIR}; ${MAKE} stage23
	${_+_}@cd ${.CURDIR}; ${MAKE} stage24

stage21:
	@echo "---> Stage 2.1: making the directories"
.if !exists(${.CURDIR}/state/stage21)
	(cd ${SRCD}/etc && \
	 make -s distrib-dirs DESTDIR=${CHROOT} \
	 __MAKE_CONF=${.CURDIR}/cfg/make.conf > ${.CURDIR}/logs/instdirs.log 2>&1 && \
	 touch ${.CURDIR}/state/stage21 \
	)
.else
	@echo "--> Stage 2.1 allready finished"
.endif
	
stage22:
	@echo "---> Stage 2.2: populating /etc"
.if !exists(${.CURDIR}/state/stage22)
	(cd ${SRCD}/etc && \
	 make -s distribution DESTDIR=${CHROOT} \
	 __MAKE_CONF=${.CURDIR}/cfg/make.conf > ${.CURDIR}/logs/distribution.log 2>&1 && \
	 touch ${.CURDIR}/state/stage22 \
	)
.else
	@echo "--> Stage 2.2 allready finished"
.endif
		
stage23:
	@echo "---> Stage 2.3: installing the world"
.if !exists(${.CURDIR}/state/stage23)
	(cd ${SRCD} && \
	 make -s installworld DESTDIR=${CHROOT} \
	 __MAKE_CONF=${.CURDIR}/cfg/make.conf > ${.CURDIR}/logs/installworld.log 2>&1 && \
	 touch ${.CURDIR}/state/stage23 \
	)
.else
	@echo "--> Stage 2.3 allready finished"
.endif

stage24:
	@echo "---> Stage 2.4: installing the kernel"
.if !exists(${.CURDIR}/state/stage24)
	(cp ${SRCD}/sys/i386/conf/GENERIC.hints ${CHROOT}/boot/device.hints && \
	 cd ${SRCD} && \
	 KERNCONFDIR=${.CURDIR}/cfg make -s installkernel DESTDIR=${CHROOT} \
	 KERNCONF=RESCUEBSD __MAKE_CONF=${.CURDIR}/cfg/make.conf > ${.CURDIR}/logs/installkernel.log 2>&1 && \
	 touch ${.CURDIR}/state/stage24 \
	)
.else
	@echo "--> Stage 2.4 allready finished"
.endif

###############################################################################
# Stage 3
#
# XXX: - remove not needed directories and files
#      - delete all not neccessary symlinks and so on
#
stage3: 
	@echo "--------------------------------------------------------------------"
	@echo ">>>> Stage3: Customize Environment"
	@echo "--------------------------------------------------------------------"
	${_+_}@cd ${.CURDIR}; ${MAKE} stage31
	${_+_}@cd ${.CURDIR}; ${MAKE} stage32
	${_+_}@cd ${.CURDIR}; ${MAKE} stage33

stage31:
	@echo "---> Stage 3.1: removing not necessary files and directories"
.if !exists(${.CURDIR}/state/stage31)
	( cd ${CHROOT} && \
	  unlink sys && \
	  rmdir proc && \
	  rmdir usr/games && \
	  rmdir usr/obj && \
	  rmdir usr/src && \
	  rm -R etc/periodic && \
	  rm usr/lib/*.a && \
	  rm -R usr/share/doc && \
	  rm -R usr/share/openssl/man/man3 \
	) &&
	( cd ${CHROOT} && \
	  makewhatis -o usr/share/man/whatis usr/share/man && \
	  makewhatis -o usr/share/openssl/man/whatis usr/share/openssl/man \
        ) && touch ${.CURDIR}/state/stage31
.else
	@echo "--> Stage 3.1 allready finished"
.endif
		
stage32:
	@echo "---> Stage 3.2: "
.if !exists(${.CURDIR}/state/stage32)

.else
	@echo "--> Stage 3.2 allready finished"
.endif

stage33:
	@echo "---> Stage 3.3: building language packages"
.if !exists(${.CURDIR}/state/stage33)
	${_+_}@cd ${.CURDIR}/build.lang/ ; ${MAKE} all 
	touch ${.CURDIR}/state/stage33
.else
	@echo "--> Stage 3.3 allready finished"
.endif
		
###############################################################################
# Stage 4
#
# XXX: - install packages
#      - prepare a flag called NO_PACKAGES
#      - maybe customizing of packages configuration
#
stage4: 
	@echo "--------------------------------------------------------------------"
	@echo ">>>> Stage4: packages"
	@echo "--------------------------------------------------------------------"
	${_+_}@cd ${.CURDIR}; ${MAKE} stage41
	${_+_}@cd ${.CURDIR}; ${MAKE} stage42

stage41:
	@echo "---> Stage 4.1: installing packages"
.if !exists(${.CURDIR}/state/stage41)

.else
	@echo "--> Stage 4.1 allready finished"
.endif
		
stage42:
	@echo "---> Stage 4.2: configure and cleanup packages"
.if !exists(${.CURDIR}/state/stage42)

.else
	@echo "--> Stage 4.2 allready finished"
.endif

###############################################################################
# Stage 5 
#
# the final Stage
#    -> generate the mfsroot
#    -> put everything together in cdroot/
#
stage5: 
	@echo "--------------------------------------------------------------------"
	@echo ">>>> Stage5: final stage"
	@echo "--------------------------------------------------------------------"
	${_+_}@cd ${.CURDIR}; ${MAKE} stage51
	${_+_}@cd ${.CURDIR}; ${MAKE} stage52

stage51:
	@echo "---> Stage 5.1: generating mfs and filesystem images"
.if !exists(${.CURDIR}/state/stage51)
	( dd if=/dev/zero of=${MFSIMAGE} count=7k bs=1k > /dev/null 2>&1 && \
	  mdconfig -a -t vnode -f ${MFSIMAGE} -u 4 > /dev/null 2>&1 && \
	  bsdlabel -w /dev/md4 auto && \
	  newfs -i 4096 -m 0 -o space /dev/md4c > /dev/null 2>&1 && \
	  mount /dev/md4c ${TMP_MFS} \
	) && 
	
	${_+_}@cd ${.CURDIR}/build.bootstage; ${MAKE} -s build
	
	( mtree -deU -f ${.CURDIR}/cfg/mfsroot.run.dist -p ${TMP_MFS} && \
	  cp ${.CURDIR}/build.bootstage/rescuebsd_loader ${TMP_MFS}/sbin && \
	  cp -p ${.CURDIR}/build.bootstage/root/.cshrc ${TMP_MFS}/root && \
	  cp -p ${.CURDIR}/build.bootstage/root/.profile ${TMP_MFS}/root && \
	  cp -p ${.CURDIR}/build.bootstage/root/.cshrc ${TMP_MFS} && \
	  cp -p ${.CURDIR}/build.bootstage/root/.profile ${TMP_MFS} && \
	  cp -p ${CHROOT}/COPYRIGHT ${TMP_MFS} && \
	  cp -p ${CHROOT}/libexec/* ${TMP_MFS}/libexec && \
	  cp -Rp ${CHROOT}/lib/* ${TMP_MFS}/lib && \
	  cp -Rp ${.CURDIR}/build.bootstage/etc/* ${TMP_MFS}/etc \
	) &&
.for prg in ${FILE_LIST}
	${_+_}@cd ${TMP_MFS}; ln sbin/rescuebsd_loader sbin/${prg}
	${_+_}@cd ${TMP_MFS}; ln sbin/rescuebsd_loader bin/${prg}
.endfor
	${_+_}@cd ${TMP_MFS}; ln -s /var/tmp ./tmp 
	
	( umount ${TMP_MFS} && \
	  mdconfig -d -u 4 && \
	  gzip -f9 ${MFSIMAGE} && \
	  touch ${.CURDIR}/state/stage51 \
	 )
	
	${_+_}@cd ${.CURDIR}/build.bootstage; ${MAKE} -s clean
	  
.else
	@echo "--> Stage 5.1 allready finished"
.endif

stage52:
	@echo "---> Stage 5.2: generating final CD image"
.if !exists(${.CURDIR}/state/stage52)
	cp -R ${CHROOT}/boot ${CDROOT}/
	rm -f ${CDROOT}/boot/kernel/*.ko
	cp -R ${.CURDIR}/build.bootstage/loader.conf ${CDROOT}/boot/
.if !exists(${CDROOT}/rescueBSD)
	mkdir ${CDROOT}/rescueBSD
.endif
	mkisofs -lrJL -allow-leading-dots ${CHROOT}/bin | create_compressed_fs - 65536 > ${CDROOT}/rescueBSD/bin.uzip 
	mkisofs -lrJL -allow-leading-dots ${CHROOT}/boot | create_compressed_fs - 65536 > ${CDROOT}/rescueBSD/boot.uzip 
	mkisofs -lrJL -allow-leading-dots ${CHROOT}/lib | create_compressed_fs - 65536 > ${CDROOT}/rescueBSD/lib.uzip 
	mkisofs -lrJL -allow-leading-dots ${CHROOT}/sbin | create_compressed_fs - 65536 > ${CDROOT}/rescueBSD/sbin.uzip 
	mkisofs -lrJL -allow-leading-dots ${CHROOT}/usr | create_compressed_fs - 65536 > ${CDROOT}/rescueBSD/usr.uzip 

	${_+_}@cd ${CHROOT}; tar -cypf ${CDROOT}/rescueBSD/etc.tbz etc/
	${_+_}@cd ${CHROOT}; tar -cypf ${CDROOT}/rescueBSD/root.tbz root/
	${_+_}@cd ${CHROOT}; tar -cypf ${CDROOT}/rescueBSD/var.tbz var/
.else
	@echo "--> Stage 5.2 allready finished"
.endif

