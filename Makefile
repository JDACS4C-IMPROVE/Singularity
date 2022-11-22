

BUILD_DIR = ./images
TEST_DIR = ./tests
DEF_FILES := $(wildcard ./definitions/*.def)

SIF_FILES := $(DEF_FILES:./definitions/%.def=$(BUILD_DIR)/%.sif)
TEST_LOGS := $(patsubst $(BUILD_DIR/%.sif,$(TEST_DIR)/%.log,$(SIF_FILES))

all: build test deploy

configure:
	mkdir -p $(BUILD_DIR)

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

$(TEST_DIR)/%.log: images/%.sif
	singularity run $< test.sh > $@ 

	
	

deploy:

clean:
	rm images/*.sif tests/*.log
	# clean singularity cache as well ?	



