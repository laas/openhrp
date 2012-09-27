all: openhrp

VERSION     = 3.1.3
TARBALL     = build/OpenHRP-$(VERSION)-2.zip
TARBALL_URL= \
https://github.com/downloads/laas/openhrp/OpenHRP-$(VERSION)-2.zip
UNPACK_CMD  = unzip
SOURCE_DIR  = build/OpenHRP-$(VERSION)
MD5SUM_FILE = OpenHRP-$(VERSION)-2.zip.md5sum

INSTALL_DIR = install

CMAKE_FLAGS = \
	-DCMAKE_INSTALL_PREFIX:STRING=`rospack find openhrp`/$(INSTALL_DIR)/ \
	-DCMAKE_BUILD_TYPE:STRING=RelWithDebInfo		\
	-DOPENRTM_DIR:STRING=`rospack find openrtm_cpp`/install \
	-DCOLLADA_DOM_DIR:STRING=`rospack find colladadom` 	\
	-DENABLE_INSTALL_RPATH:BOOL=ON 				\
	-DENABLE_INSTALL_RPATH_TO_SELF:BOOL=ON

include $(shell rospack find mk)/download_unpack_build.mk

openhrp: $(INSTALL_DIR)/installed

$(INSTALL_DIR)/installed: $(SOURCE_DIR)/unpacked
	cd $(SOURCE_DIR)	  		\
	&& cmake . ${CMAKE_FLAGS}		\
	&& make			  		\
	&& make install
	touch $(INSTALL_DIR)/installed

clean:
	rm -rf $(SOURCE_DIR) $(INSTALL_DIR)

wipe: clean
	rm -rf build
