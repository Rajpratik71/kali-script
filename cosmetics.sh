# Cosmetics (in order of appearance!)
image="/usr/share/wallpapers/backtrack/BT5-R3-wp-grey.png"
#identify $image

# GRUB menu
convert -resize 1024x768! "$image" /usr/share/images/desktop-base/moreblue-orbit-grub.png
update-grub2

# Framebuffer Bootsplash
cd /usr/local/src/
if [ ! -e /usr/local/src/bootsplash-3.1.tar.bz2 ]; then wget ftp://ftp.bootsplash.org/pub/bootsplash/rpm-sources/bootsplash/bootsplash-3.1.tar.bz2; fi
tar xvjf bootsplash-3.1.tar.bz2
cd bootsplash-*/Utilities/
make splash
convert "$image" -resize 1024x768! /tmp/bootsplash.jpg 
mogrify -density 72x72 -units PixelsPerInch /tmp/bootsplash.jpg
echo -e '# config file version\nversion=3\n\n# should the picture be displayed?\nstate=1\n\n# fgcolor is the text forground color.\n# bgcolor is the text background (i.e. transparent) color.\nfgcolor=7\nbgcolor=0\n\n# (tx, ty) are the (x, y) coordinates of the text window in pixels.\n# tw/th is the width/height of the text window in pixels.\ntx=80\nty=140\ntw=865\nth=560\n\n# name of the picture file (full path recommended)\njpeg=/tmp/bootsplash.jpg\nsilentjpeg=/tmp/bootsplash.jpg\n\nprogress_enable=0\noverpaintok=1' > /tmp/bootsplash.cfg
if [ ! -e /opt/bootsplash/bootsplash.bkup ]; then cp -f /opt/bootsplash/bootsplash{,.bkup}; fi
./splash -s -f /tmp/bootsplash.cfg > /opt/bootsplash/bootsplash
#fix-splash

# Plymouth Bootsplash
if [ ! -e /lib/plymouth/themes/simple/bt5_1024x768.png.bkup ]; then cp -f /lib/plymouth/themes/simple/bt5_1024x768.png{,.bkup}; fi
convert -resize 1024x768! "$image" /lib/plymouth/themes/simple/bt5_1024x768.png
update-alternatives --auto default.plymouth #update-alternatives --config default.plymouth
update-initramfs -u
fix-splash