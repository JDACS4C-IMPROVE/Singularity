

FAKE_ROOT="--fakeroot"

BUILD_DIR = ./images
TEST_DIR = ./tests
DEPLOY_DIR = ./container

DEF_FILES := $(wildcard ./definitions/*.def)

SIF_FILES := $(DEF_FILES:./definitions/%.def=$(BUILD_DIR)/%.sif)
TEST_LOGS := $(patsubst $(BUILD_DIR)/%.sif,$(TEST_DIR)/%.log,$(SIF_FILES))

all: build test deploy

configure:
	mkdir -p $(BUILD_DIR) $(TEST_DIR) $(DEPLOY_DIR)

build: configure $(SIF_FILES)
	echo Start building $?

$(BUILD_DIR)/%.sif: ./definitions/%.def
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

