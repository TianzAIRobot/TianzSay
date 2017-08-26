#The control makefile.
#Auther: Tianz
#Copyright: ElegantRobot 22 Aug 2017

#The name of target you want.
TARGRT = image

#The path of stoll target file.
TARGETDIR = $(shell pwd)/target

#The file of stool temporary object files.
export OBJSDIR = $(shell pwd)/objs

#The global include files.
export GLOBALINC = \
	-I$(shell pwd)/controller/include \
	-I$(shell pwd)/sender/include \
	-I$(shell pwd)/receiver/include\
	-I$(shell pwd)/tools/include\
	-I/usr/local
	
#The global libs.
export GLOBALLIBS = \
	-L/usr/local/lib -llog4cpp \
	-lpthread

#The path of sub dir makefiles.
SUBMAKEFILES += controller/application
SUBMAKEFILES += controller/src
SUBMAKEFILES += sender/src
SUBMAKEFILES += receiver/src
SUBMAKEFILES += tools/src

#The compiler.
export GXX = g++

#The g++ compile flags.
export GXXFLAGS = -O2

#Start to compile the targrt.
$(TARGRT):$(OBJSDIR) $(TARGETDIR)
#To run all of sub dir makefile.
	$(foreach temMake,$(SUBMAKEFILES),$(MAKE) -C $(temMake);)
#Generate the targrt.
	$(GXX) -o $(TARGETDIR)/$@ $(OBJSDIR)/*.o $(GLOBALINC) $(GLOBALLIBS)
#Then remove the all of temporary object files.
	$(RM) -r $(OBJSDIR)
	@echo "\nCompile seccussfully!\n"

#Make the objs file.
$(OBJSDIR):
	mkdir -p $@

#Make the file to stoll target.
$(TARGETDIR):
	mkdir -p $@

.PHONY:clean
#The clean work.
clean:
	$(RM) -r $(TARGETDIR)

