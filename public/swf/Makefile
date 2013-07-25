# set an environment variable to override this to your location. export SWF_COMPILER = /My/Location/bin/mxmlc
SWF_COMPILER ?= ${MXMLC} -static-link-runtime-shared-libraries=true

all: \
	ZeroClipboard.swf \

ZeroClipboard.swf: src/flash/ZeroClipboard.as
	@rm -f $@
	$(SWF_COMPILER) -output $@ $^ -source-path src/flash
	@chmod a-w $@

clean:
	rm -rf ./ZeroClipboard*

.PHONY: all clean
