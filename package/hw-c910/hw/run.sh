#!/bin/bash


if [ $# -lt 1 -o $# -gt 4 ] ; then
	echo "Usage:  run.sh <DebugServer_ip:port>  <soc_platform>  <core_pattern>"
	echo ""
	echo "<soc_platform>:  Choose one from [ ice_fpga2 | x908 | xiaohui ] etc."
	echo "<core_pattern> :  binary format, each bit per core, 10011 mean enable core 0,1,4"
	exit 1
fi



GDBRESET="noreset"

for idx in "$@"
do
if [ $idx == "an" ]; then
	BOARD="an"
elif [ $idx == "d1_nfs" ]; then
	BOARD="d1_nfs"
elif [ $idx == "lw" ]; then
	BOARD="lw"
elif [ $idx == "lw_nfs" ]; then
	BOARD="lw_nfs"
elif [ $idx == "lw1" ]; then
	BOARD="lw1"
elif [ $idx == "lw2" ]; then
	BOARD="lw2"
elif [ $idx == "lw3" ]; then
	BOARD="lw3"
elif [ $idx == "lw_fm" ]; then
	BOARD="lw_fm"
elif [ $idx == "lw_fm1" ]; then
	BOARD="lw_fm1"
elif [ $idx == "lw_fm2" ]; then
	BOARD="lw_fm2"
elif [ $idx == "lw_fm3" ]; then
	BOARD="lw_fm3"
elif [ $idx == "ice_evb" ]; then
	BOARD="ice_evb"
	GDBRESET="noreset"
elif [ $idx == "ice_evb_nfs" ]; then
	BOARD="ice_evb_nfs"
	GDBRESET="noreset"
elif [ $idx == "ice_fpga" ]; then
	BOARD="ice_fpga"
	GDBRESET="noreset"
elif [ $idx == "ice_fpga2" ]; then
	BOARD="ice_fpga2"
	GDBRESET="noreset"
elif [ $idx == "xiaohui" ]; then
	BOARD="xiaohui"
	GDBRESET="noreset"
elif [ $idx == "x908" ]; then
	BOARD="x908"
	GDBRESET="noreset"
elif [ $idx == "ice2" ]; then
	BOARD="ice2"
	GDBRESET="noreset"
elif [ $idx == "th" ]; then
	BOARD="th"
elif [ $idx == "eg" ]; then
	BOARD="eg"
elif [ $idx == "eg2" ]; then
	BOARD="eg2"
elif [ $idx == "ve" ]; then
	BOARD="ve"
	GDBRESET="noreset"
fi
done

NRCORE=$3

set -e

SOCINIT=$BOARD.socinit.txt
GDBINIT=$BOARD.gdbinit.txt
DTS=$BOARD.dts.txt

echo "======== launch info ========"
echo "platform:" $BOARD
echo "socinit :" $SOCINIT
echo "gdbinit :" $GDBINIT
echo "dts     :" $DTS
echo "cores   :" $NRCORE
echo "==== ==== ==== ==== ==== ===="
if [ ! -f $GDBINIT -o ! -f $SOCINIT -o ! -f $DTS ]; then
		echo "Error: init file or dts not exist !"
		exit 1
fi

enable_dts_cores() {

	binary=$1
	decimal=$((2#$binary))
	length=${#binary}

	for (( i=0; i<${length}; i++ )); do
	if ((decimal & 1 == 1)); then
		y=`awk '/cpu@'$i' \{/{getline a;print NR}' .hw.dts`
		let y=$y+2
		sed -i ''$y','$y's/fail/okay/g' .hw.dts
	fi
	decimal=$((decimal >> 1))
	done
}

# patching device tree file
cp $DTS .hw.dts
enable_dts_cores $NRCORE

ROOTFS_BASE=`cat .hw.dts | grep initrd-start | awk -F " " '{print $4}' | awk -F ">" '{print $1}'`
ROOTFS_SIZE=`ls -lt ../rootfs.cpio.gz | awk '{print $5}'`
((ROOTFS_END= $ROOTFS_BASE + $ROOTFS_SIZE))
ROOTFS_END=`printf "0x%x" $ROOTFS_END`
sed -i "s/linux,initrd-end = <0x0 .*/linux,initrd-end = <0x0 $ROOTFS_END>;/g" .hw.dts

set -x
# compile device tree file
./dtc -I dts -O dtb .hw.dts > hw.dtb

# reset
if [ $GDBRESET == "reset" ]; then
./riscv64-elf-gdb -ex "tar remote $1" -ex "reset" -ex "set confirm off" -ex "q"
fi

# SoC related initialization
if [ $BOARD == "eg" -o $BOARD == "eg2" ]; then
./riscv64-elf-gdb -ex "tar remote $1" -x $SOCINIT ddr_init_eg_elf -ex "c" -ex "q" > /dev/null
else
./riscv64-elf-gdb -ex "tar remote $1" -x $SOCINIT -ex "q"
fi

# boot linux with gdbinit
./riscv64-elf-gdb -ex "tar remote $1" -x $GDBINIT -ex "c" -ex "q"
