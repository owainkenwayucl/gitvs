# This program wraps git to make it behave more like CVS.
# Dr Owain Kenway

# Where it is distributed, it is done so under the 4 clause,
# BSD-style license (see LICENSE.txt)

sources = gitvs.hs
installdir = $(HOME)/bin

all: gitvs

gitvs: $(sources)
	ghc gitvs.hs

install: gitvs
	cp gitvs $(installdir)/gitvs

clean:
	rm *.hi *.o gitvs
