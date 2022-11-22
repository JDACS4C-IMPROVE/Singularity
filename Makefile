

DESTINATION = ./container
DEF_FILES := $(wildcard ./definitions/*.def)
#TEST_LOGS := $(patsubst ./images/%.sif,./tests/%.log,$(SIF_FILES))
SIF_FILES := $(DEF_FILES:./definitions/%.def=$(DESTINATION)/%.sif)


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
	echo Pull all images from github

test: $(TEST_LOGS) 

tests/%.log: images/%.sif
	singularity run $< test.sh > $@ 

	
	

deploy:

clean:
	rm images/*.sif tests/*.log
	# clean singularity cache as well ?	



