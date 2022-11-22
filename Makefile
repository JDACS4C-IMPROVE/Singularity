


DEF_FILES := $(wildcard ./definitions/*.def)
#TEST_LOGS := $(patsubst ./images/%.sif,./tests/%.log,$(SIF_FILES))
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
	echo Pull all images from github

test: $(TEST_LOGS) 

tests/%.log: images/%.sif
	singularity run $< test.sh > $@ 

	
	

deploy:

clean:
	rm images/*.sif tests/*.log
	# clean singularity cache as well ?	



