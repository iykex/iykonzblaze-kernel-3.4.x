#!/bin/bash
printf '\e[8;40;60t]'
#
# Custom build script
# Copyright © 2017, Nana Iyke Quame "iyke"
# <nanaquameallday@gmail.com>
#
#Android_Matrix_Development
#DroidPeepz™ Inc
#
# NOTE : This Is Meant For  The Good & Ease Of Kernel Development,
#  - Please You Are Free To Edit And Make It Better, But DO NOT STEAL !
#  - 
#
#START - HOME
START() {
printf '\e[8;40;60t]'
  clear
  echo
  echo
cecho C "" "================================="
 echo "================================="
cecho P "" "================================="
cecho Y ""  " **ANDROID MATRIX DEVELOPMENT**"
cecho C ""  "*MediaTek & Qualcomm Snapdragon*"
 echo "================================="
 cecho Y "" "================================="
 
echo "========*****************========"   
cecho G ""  "  ---> DroidPeepz™ Inc    "
cecho C "" "  ---> iykonzBlaze™ Kernel   "
cecho P ""  "  ---> by : Nana Iyke Quame   "
echo "========*****************========"
  cecho B "" "    Menu"    "  || "$(date +%b-%d-%Y-%H:%M)''
  echo
   cecho P "    a - " "About !"
  echo
   cecho G "    r - " "Refresh"
   echo
  cecho B "    w - " "Clean Already Compiled Kernel"
  echo
  cecho C "    s - " "Start Compiling Kernel"
  echo 
  cecho Y "    m - " "Make M-Proper"
  echo
  cecho W "    c - " "Make Menu Config"
  echo
  cecho R "    x - " "Exit"
  echo
}

 #MENU
EXT_MAIN() {
while :
do

  clear
  START
   read -p "           Enter option: " CHOICE
  case "$CHOICE" in
       A|a) ABT;;   #DONE
       R|r) refresh;;     #REFRESH
      W|w) RM_OUT;; #DONE                             
		S|s) BLAZE;;      #DONE
       M|m) MPROPER;;
        C|c) MENUCONFIG;;
		X|x) EXIT;;
		*) cecho R "" "     Invalid option"; sleep 0.3; continue;;
	esac

done
}

#MAKE_MPROPER
MPROPER(){
cd iykonzblaze-kernel-3.4.x
clear
cecho C "" " !! Exec M-Proper Now !! "
echo
echo
make mrproper
echo
echo
echo
cd ..
echo
sleep 3.0;
START " "
}


#MAKE_MENUCONFIG
MENUCONFIG(){
cd iykonzblaze-kernel-3.4.x
clear
cecho C "" " !! Exec Menu Configurations !! "
echo
echo
make menuconfig
echo
echo
echo
cd ..
echo
sleep 3.0;
START " "
}

#ABT
ABT(){
clear
echo
cecho C "" "  !! iykonzBlaze™ Kernel Had Its Initial Stage
      On TECNO W4, MediaTek Based Device !!"
echo
cecho C "" "  !! Chipset : MT6580!! "
cecho C "" "  !! OS : Android 6.0 Marshamallow !! "
sleep 3.0;
START " "
}                                                        

#EXIT
EXIT(){
printf '\e[8;40;60t]'
clear
 cecho C "" "Talent Is Nothing WIthout Ethics!!!"
 sleep 1.0;
 clear
exit 
}

#RM-OUT
RM_OUT(){
clear
cd iykonzblaze-kernel-3.4.x
if [ -f OUTPUT/BUILT-IYKONZBLAZE/iykonzblaze-Kernel*  ]
then
    cecho R "" 'Making Clean Output Directory'
    echo ""
    rm OUTPUT/BUILT-IYKONZBLAZE/iykonzblaze-Kernel*
    rm OUTPUT/BUILT-IYKONZBLAZE/dtb*
    rm OUTPUT/BUILT-IYKONZBLAZE/zImage*
fi
 sleep 1.0;
 clear
 echo ""
 echo " done !!! "
RELAX " "
}

#REFRESH
refresh() {
clear
sleep 0.3; continue;
START
}

#RELAX
RELAX(){
 read -p "Press enter key to continue . . ."
 echo
START " " 
}
 
 BLAZE() {
printf '\e[8;40;100t]'
clear
export KBUILD_BUILD_USER=iyke
export KBUILD_BUILD_HOST=AMD-Team

sleep 0.5;

cd iykonzblaze-kernel-3.4.x
echo ""
cecho P "" "Creating Directories..."
echo ""
sleep 0.6;
if [ -f OUTPUT/arch/arm/boot/zImage-dtb ]
then
    cecho R "" 'Remove Previous kernel If There Is Any...'
    echo ""
    rm OUTPUT/arch/arm/boot/zImage*
    rm OUTPUT/BUILT-IYKONZBLAZE/iykonzblaze-Kernel*
    rm OUTPUT/BUILT-IYKONZBLAZE/dtb*
    rm OUTPUT/BUILT-IYKONZBLAZE/zImage*
fi

#Change toolchain path before using build script!
cecho C "" "Export toolchains..."
export ARCH=arm
export CROSS_COMPILE=/home/iyke/arm-linux-androideabi-4.9/bin/arm-linux-androideabi-
echo ""

echo ""

cecho Y "" "Make defconfig..."
make -C $(pwd) O=OUTPUT iykonzblaze_d851_defconfig
 echo ""

#Edit the number according to the number of CPU you have in your PC :
clear
echo ""
echo ""
cecho C "" "Compiling iykonzBlaze™ Kernel..."
echo ""
echo ""
make -j6 -C $(pwd) O=OUTPUT ARCH=arm 
echo ""

if [ ! -f OUTPUT/arch/arm/boot/zImage-dtb ]
then
	echo "WARNING!  WARNING!! WARNING!!!"
	echo "Please Check & Trace Where Errors."
	echo 
    echo 
    cecho R "" "BUILD ERRORS!"
    echo
    cecho R "" "BUILD ERRORS!"
    echo
    cecho R "" "BUILD ERRORS!"
else
    echo 'Moving kernel...'
    cd OUTPUT
    BUILT-IYKONZBLAZE
    
    cp OUTPUT/arch/arm/boot/Image $(pwd)/arch/arm/boot/zImage

    cd ..
    chmod 777 cm-dt/dtbToolCM
    cm-dt/dtbToolCM -2 -o OUTPUT/arch/arm/boot/dt.img -s 2048 -p OUTPUT/scripts/dtc/ OUTPUT/arch/arm/boot/
    
    cp OUTPUT/arch/arm/boot/zImage OUTPUT/BUILT-IYKONZBLAZE/zImage

    cp OUTPUT/arch/arm/boot/dt.img OUTPUT/BUILT-IYKONZBLAZE/dtb

    echo ""
    echo ""
    cecho G "" "Putting iykonzBlaze™ Kernel in Recovery Flashable Zip"
    cd OUTPUT
    cd BUILT-IYKONZBLAZE
    zip -r9 iykonzblaze-Kernel-LOS14.1-V1.2-D851-$(date +%b-%d-%Y-%H:%M).zip * -x iykonzblaze-Kernel-LOS14.1-V1.2-D851-$(date +%b-%d-%Y-%H:%M).zip

    cd ..
    cd ..
    sleep 0.6;
    echo ""
    echo ""
    cecho G "" "Done Making Recovery Flashable Zip"
    echo ""
    echo ""
    cecho G "" "Locate iykonzBlaze™ Kernel in the following path : "
    cecho G "" "OUTPUT/BUILT-IYKONZBLAZE"
    echo ""
fi

echo
echo 
echo 
cecho G "" "============================="
echo "  !! PROCESS TIME !!      "
echo $[$SECONDS / 60]' minutes '$[$SECONDS % 60]' seconds' 
cecho C "" "============================="
echo
echo
echo
RELAX " "
}

#COLOR
#USAGE: cecho TYPE=R|G|Y|B|P|C|W "msg1" "color_msg2" "msg3"
cecho ()
   {
   #Case didn't work out for me in cygwin
   if [ "$1" == "R" ]
then
  echo -e "$2""\033[0;91m$3\033[0m""$4" # Red
elif  [ "$1" == "G" ]
then
  echo -e "$2""\033[0;92m$3\033[0m""$4" # Green
elif  [ "$1" == "Y" ]
then
  echo -e "$2""\033[0;93m$3\033[0m""$4" # Yellow
elif  [ "$1" == "B" ]
then
  echo -e "$2""\033[0;94m$3\033[0m""$4" # Blue
elif  [ "$1" == "P" ]
then
  echo -e "$2""\033[0;95m$3\033[0m""$4" # Purple
elif  [ "$1" == "C" ]
then
  echo -e "$2""\033[0;96m$3\033[0m""$4" # Cyan
elif  [ "$1" == "W" ]
then
  echo -e "$2""\033[0;97m$3\033[0m""$4" # White
 fi
}

#EXTRA_COLOR_OPTIONS
blue='\033[0;34m'
cyan='\033[0;36m'
yellow='\033[0;33m'
red='\033[0;31m'
nocol='\033[0m'

#DEPLOYING function
EXT_MAIN
