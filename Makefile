
# IHOME is the build prefix, we can replace this with PREFIX if you want to.
# 	PREFIX can be . if you want to build the images in the Singularity directory
# 	It can be /anywhere/else if you want to deploy the images somewhere outside the Singularity Directory.
# 	Singularity/ is the build dir (this is always Singularity/)
# 	IHOME/ is the deploy dir (this can be Singularity/)

# run make from /path/to/Singularity/
# make : will build the images in ./images
# make test : will test images in the ./images directory
# make deploy : will copy images from ./images to PREFIX/images/

# auxillary targets
# make clean
# make all (make, make test, make deploy)

# set default target for make version > 3.80
.DEFAULT_GOAL := build


# defined in case we want to omit fakeroot
FAKE_ROOT="--fakeroot"

# From StackOverflow: It is generally considered a bad practice for makefiles to depend on environment
# variables because that may lead to non-reproducible builds. This is why passing variable overrides in
# make command line explicitly is recommended.
PREFIX    := .
BUILD_DIR := ./images
TEST_DIR  := ./tests

DEF_DIR    = ./definitions
DEPLOY_DIR = $(PREFIX)/images

DEF_FILES := $(wildcard ./definitions/*.def)
SIF_FILES := $(DEF_FILES:$(DEF_DIR)/%.def=$(BUILD_DIR)/%.sif)
TEST_LOGS := $(patsubst $(BUILD_DIR)/%.sif,$(TEST_DIR)/%.log,$(SIF_FILES))

build: configure $(SIF_FILES)
	echo Start building $?

all: build test deploy

debug:
	env
	echo "PREFIX: "$(PREFIX)
	echo "BUILD_DIR: "$(BUILD_DIR)
	echo "TEST_DIR: "$(TEST_DIR)
	echo "DEF_DIR: "$(DEF_DIR)
	echo "DEPLOY_DIR: "$(DEPLOY_DIR)


configure:
	mkdir -p $(BUILD_DIR) $(TEST_DIR) $(DEPLOY_DIR)

$(BUILD_DIR)/%.sif: $(DEF_DIR)/%.def
	singularity build $(FAKE_ROOT) $@ $<

pull:
	echo Pull all images from github

test: $(TEST_LOGS)

$(TEST_DIR)/%.log: $(BUILD_DIR)/%.sif
	singularity run $< test.sh 2>&1 i | tee $@ 
	# singularity --bind $(TEST_DIR):/candle_data_dir exec  "echo `date` > candle_data_dir/test.log"
	
	

deploy: $(BUILD_DIR)/*.sif
	cp -v $< $(DEPLOY_DIR)/ 

.PHONY: clean
clean:
	rm $(BUILD_DIR)/*.sif $(TEST_DIR)/*.log 
	# clean singularity cache as well ?	

