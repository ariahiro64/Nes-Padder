# This is the default target, which will be built when
# you invoke make
.PHONY: all
all: padd

# This rule tells make how to build hello from hello.cpp
padd: nes-padder.d
	ldc2 nes-padder.d

# This rule tells make to copy hello to the binaries subdirectory,
# creating it if necessary
.PHONY: install
install:
	mkdir -p binaries
	cp -p nes-padder binaries

# This rule tells make to delete hello and hello.o
.PHONY: clean
clean:
	rm -f nes-padder