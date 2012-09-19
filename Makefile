all: openhrp

VERSION     = 3.1.3
TARBALL     = build/OpenHRP-$(VERSION)-2.zip
#TARBALL_URL = \
#https://openrtp.jp/openhrp3/script-jp/download_file.php?fname=OpenHRP-$(VERSION).zip
TARBALL_URL=http://homepages.laas.fr/tmoulard/OpenHRP-$(VERSION)-2.zip
UNPACK_CMD  = unzip
SOURCE_DIR  = build/OpenHRP-$(VERSION)
MD5SUM_FILE = OpenHRP-$(VERSION)-2.zip.md5sum

INSTALL_DIR = install

CMAKE_FLAGS = \
	-DCMAKE_INSTALL_PREFIX:STRING=`rospack find openhrp`/$(INSTALL_DIR)/ \
	-DCMAKE_BUILD_TYPE:STRING=Release \
	-DOPENRTM_DIR:STRING=`rospack find openrtm`/install \
	-DCOLLADA_DOM_DIR:STRING=`rospack find colladadom`

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
