

DESTINATION = ./container
DEF_FILES := $(wildcard ./definitions/*.def)
SIF_FILES := $(DEF_FILES:./definitions/%.def=$(DESTINATION)/%.sif)

DESTINATION = ./container

all: build test deploy

configure:
	mkdir -p $(DESTINATION)

build: configure $(SIF_FILES)
	echo $@
	echo Start building $?
	echo all $^





$(DESTINATION)/%.sif: ./definitions/%.def
	if [ -f /usr/subuid ] ; then echo Singularity with fakeroot ; singularity build --fakeroot container/$@ $< ; else echo Singularity without fakeroot ; singularity build $@ $< ; fi
	# singularity build --fakeroot container/$@ $<

pull:

test:

deploy:

clean:
	rm images/*.sif
	# clean singularity cache as well ?	



