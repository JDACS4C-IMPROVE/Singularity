


DEF_FILES := $(wildcard ./definitions/*.def)
SIF_FILES := $(DEF_FILES:.def=.sif)

all: build test deploy

build: $(SIF_FILES)
	echo $@
	echo Start building $?
	echo all $^





%.sif: %.def
	singularity build container/$@ $<

pull:

test:

deploy:

clean:
	rm images/*.sif
	# clean singularity cache as well ?	



