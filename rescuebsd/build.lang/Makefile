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
# $Id: Makefile,v 1.1 2005/03/16 12:23:22 mindtrap Exp $

.include "../cfg/main.cfg"

all: generic lang_en lang_de lang_ru lang_ch

generic:
.if !exists(../cdroot/rescueBSD/lang)
	mkdir -p ../cdroot/rescueBSD/lang
.endif
	@echo "--> generating language packages"

lang_en:
	@echo "-> english"
	${_+_}@cd en/ ; tar -cypf ../../cdroot/rescueBSD/lang/lang_en.tbz etc
	
lang_de:
	@echo "-> german"
	${_+_}@cd de/ ; tar -cypf ../../cdroot/rescueBSD/lang/lang_de.tbz etc
	
lang_ru:
	@echo "-> russian"
	${_+_}@cd ru/ ; tar -cypf ../../cdroot/rescueBSD/lang/lang_ru.tbz etc
	
lang_ch:
	@echo "-> swiss"
	${_+_}@cd ch/ ; tar -cypf ../../cdroot/rescueBSD/lang/lang_ch.tbz etc

clean:
	@rm -f ../cdroot/rescueBSD/lang/*
