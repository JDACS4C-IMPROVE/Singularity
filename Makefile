


# defined in case we want to omit fakeroot
FAKE_ROOT="--fakeroot"

# use IHOME to make it compatible with bootstrap.sh, if IHOME is not defined set it to ./
export IHOME:=$(shell if [ ${IHOME} ] ; then echo ${IHOME} ; else echo . ; fi )

DEF_DIR := $(IHOME)/definitions
BUILD_DIR = $(IHOME)/images
TEST_DIR = $(IHOME)/tests
DEPLOY_DIR = $(IHOME)/container

DEF_FILES := $(wildcard ./definitions/*.def)

SIF_FILES := $(DEF_FILES:$(DEF_DIR)/%.def=$(BUILD_DIR)/%.sif)
TEST_LOGS := $(patsubst $(BUILD_DIR)/%.sif,$(TEST_DIR)/%.log,$(SIF_FILES))

all: build test deploy

debug:
	env
	echo $(DEF_DIR)
	echo $(IHOME)


configure:
	mkdir -p $(BUILD_DIR) $(TEST_DIR) $(DEPLOY_DIR)

build: configure $(SIF_FILES)
	echo Start building $?

$(BUILD_DIR)/%.sif: $(DEF_DIR)/%.def
	singularity build $(FAKE_ROOT) $@ $<
	# src/bootstrap.sh -s -n $(shell basename -s .def $<) -d $<

pull:
	echo Pull all images from github

test: $(TEST_LOGS) 

$(TEST_DIR)/%.log: $(BUILD_DIR)/%.sif
	singularity run $< test.sh 2>&1 i | tee $@ 

	
	

deploy: $(BUILD_DIR)/*.sif
	cp -v $< $(DEPLOY_DIR)/ 
clean:
	rm $(BUILD_DIR)/*.sif $(TEST_DIR)/*.log 
	# clean singularity cache as well ?	

