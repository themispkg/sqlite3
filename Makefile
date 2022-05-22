LIBDIR	= /usr/local/lib/bash
BINDIR	= /usr/bin

define build
	cd ./sqlite3 ; bash ./configure ; make
endef

define setup
	mkdir -p ${LIBDIR}
	install -m 750 ./sqlite3/sqlite3 ${BINDIR}/sqlite3
	install -m 750 ./lib/sqlite3.sh ${LIBDIR}
endef

define remove
	rm -rf ${BINDIR}/sqlite3 ${LIBDIR}/sqlite3.sh
endef

build:
	$(build)

setup:
	$(setup)

install:
	$(build)
	$(setup)

uninstall:
	$(remove)

reinstall:
	$(remove)
	$(build)
	$(setup)