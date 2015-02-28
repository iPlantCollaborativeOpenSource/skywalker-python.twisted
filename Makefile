.DEFAULT_GOAL =	all

.PHONY =	all clean clean-autogen clean-gen wget gen gen-thrift copy copy-gen

LOC	=	https://raw.githubusercontent.com/iPlantCollaborativeOpenSource/skywalker.thrift/master/skywalker.thrift
IDL_FILE =	./skywalker.thrift
WGET	=	wget
THRIFT	=	thrift
COPY	=	cp
CHOWN	=	chown
USER	=	root
GROUP	=	root
GENLANG	=	py
GENTYPE	=	twisted
ifdef GENTYPE
	GENNAME = $(GENLANG):$(GENTYPE)
	GENDIR	= gen-$(GENLANG).$(GENTYPE)
else
	GENNAME = $(GENLANG)
	GENDIR = gen-$(GENLANG)
endif

all : wget gen copy

clean : clean-gen clean-autogen

clean-autogen :
	rm -rf ./build
	rm -rf ./skywalker

clean-gen :
	rm -rf ./$(GENDIR)
	rm -f ./skywalker.thrift

wget :
	$(WGET) -O $(IDL_FILE) $(LOC)

gen : gen-thrift

gen-thrift :
	$(THRIFT) --gen $(GENNAME) ./skywalker.thrift

copy : copy-gen

copy-gen :
	$(COPY) -r $(GENDIR)/skywalker/ ./skywalker

chown :
	$(CHOWN) -R $(USER):$(GROUP) .
