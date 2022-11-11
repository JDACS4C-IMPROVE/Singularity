


DEF_FILES := $(wildcard ./definitions/*.def)
TMP_FILES := $(DEF_FILES:.def=.sif)
SIF_FILES := $(patsubst ./definitions/%.def,./images/%.sif,$(DEF_FILES))
TEST_LOGS := $(patsubst ./images/%.sif,./tests/%.log,$(SIF_FILES))
all: build test deploy

build: $(SIF_FILES)
	echo $@
	echo Start building $?
	echo all $^





images/%.sif: definitions/%.def
	echo $@
	singularity build --fakeroot $@ $<

pull:
	echo Pull all images from github

test: $(TEST_LOGS) 

tests/%.log: images/%.sif
	singularity run $< test.sh > $@ 

	
	

deploy:

clean:
	rm images/*.sif tests/*.log
	# clean singularity cache as well ?	



