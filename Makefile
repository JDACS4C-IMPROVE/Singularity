# run make from inside /path/to/Singularity/
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
DISABLE_CACHE="--disable-cache"

# Pass variables on the command line to overwrite the defaults e.g. make PREFIX=/homes/joe
PREFIX    := .
BUILD_DIR := ./build
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
	echo "DEF_FILES: "$(DEF_FILES)


configure:
	mkdir -p $(BUILD_DIR) $(TEST_DIR) $(DEPLOY_DIR)

$(BUILD_DIR)/%.sif: $(DEF_DIR)/%.def
	singularity build $(DISABLE_CACHE) $(FAKE_ROOT) $@ $<


pull:
	echo Pull all images from github

test: $(TEST_LOGS)

$(TEST_DIR)/%.log: $(BUILD_DIR)/%.sif
	log=`basename $@` ;\
	    singularity exec --bind $(TEST_DIR):/candle_data_dir $< sh -c "echo \`date\` > /candle_data_dir/$${log}" ;\
	    sh test/test_container.sh $? '' $(TEST_DIR) 2> $(TEST_DIR)/$${log}.error 1> $(TEST_DIR)/$${log}.tests
	

deploy: $(SIF_FILES)
	cp -v $? $(DEPLOY_DIR)/ 
	chmod -R g+w $(DEPLOY_DIR)

.PHONY: clean
clean:
	rm $(BUILD_DIR)/*.sif $(TEST_DIR)/*.log 
	# clean singularity cache as well ?	

