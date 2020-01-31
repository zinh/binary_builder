.PHONY: musl

all: musl

musl:
	cd musl; ./configure; make & sudo make install
