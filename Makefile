


DEF_FILES := $(wildcard ./definitions/*.def)
SIF_FILES := $(DEF_FILES:./definitions/%.def=%.sif)

DESTINATION = ./container

all: build test deploy

configure:
	mkdir -p $(DESTINATION)

build: $(SIF_FILES)
	echo $@
	echo Start building $?
	echo all $^





%.sif: ./definitions/%.def
	if [ -f /usr/subuid ] ; then echo Singularity with fakeroot ; singularity build --fakeroot container/$@ $< ; else echo Singularity without fakeroot ; singularity build container/$@ $< ; fi
	# singularity build --fakeroot container/$@ $<

pull:

test:

deploy:

clean:
	rm images/*.sif
	# clean singularity cache as well ?	



