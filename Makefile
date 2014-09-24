
##############################################################################
# GLOBAL COMPILER FLAGS
##############################################################################

include Global.defs

##############################################################################
# LOCAL COMPILER FLAGS
##############################################################################

LOCAL_FLAGS = -D_FILE_OFFSET_BITS=64 -Iglx -IbigFile -IPpm

LINK  = -Lglx -lGlx -LPpm -lPPM -LbigFile -lBF \
	-lGLw -lGL -lXm -lXt -lXext -lX11 \
	-lpthread -lm $(GLBL_LINK)

OBJS = glerr.o PageManager.o PageReader.o threadedQueue.o Net.o
APPS = showPaged genPaged browse browser

default: sublibs $(OBJS) 
	$(MAKE) $(APPS)

sublibs:
	$(MAKE) -C bigFile
	$(MAKE) -C Ppm
	$(MAKE) -C glx

showPaged: showPaged.o $(OBJS)
	$(CPLUSPLUS) -o $@ $(GLBL_FLAGS) showPaged.o $(OBJS) $(LINK)

genPaged: genPaged.o $(OBJS)
	$(CPLUSPLUS) -o $@ $(GLBL_FLAGS) genPaged.o $(OBJS) $(LINK)

browse: browse.o $(OBJS)
	$(CPLUSPLUS) -o $@ $(GLBL_FLAGS) browse.o $(OBJS) $(LINK)

browser: browser.o $(OBJS)
	$(CPLUSPLUS) -o $@ $(GLBL_FLAGS) browser.o $(OBJS) $(LINK)

SRCS = -name '*.[cChf]' \
	-o -name '*.cxx' \
	-o -name '*.pl' \
	-o -name README \
	-o -name NOSA \
	-o -name Makefile \
	-o -name Global.defs 

tar:
	cd ../; \
	FILES=`find bigView -follow \( $(SRCS) \) -print`; \
	/bin/tar chvofz bigView.tar.gz $$FILES; \
	/bin/mv bigView.tar.gz bigView


##############################################################################
# Standard rules: clean, co, install
##############################################################################
new: c default
c: clean
clean: 
	$(MAKE) -C glx clean
	$(MAKE) -C bigFile clean
	$(MAKE) -C Ppm clean	
	/bin/rm -fr junk* *.o *~ *.rpt *.gz *.out core* $(APPS) $(OBJS)
	/bin/rm -fr `file * | grep ELF | awk -F: ' {print $$1}'`

distclean: clean
	find . -name localDepend -delete
	find . -name Global.defs -delete
	rm -rf lib
	rm -rf include
	rm -rf dist

tag:
	TAG="BIGVIEWSTABLE_"`date +%m_%d_%y`;\
	cvs tag $$TAG .


.PHONY: dist

dist: clean
	mkdir -p dist
	( cd .. ; tar cjf /tmp/bigView.tar.bz2 bigView )
	mv /tmp/bigView.tar.bz2 dist

