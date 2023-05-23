#!/usr/bin/env python3
#
# coding=utf-8
#

import random,sys,getopt
import os

def build_csmith():
    os.system('wget -c -t 3 -T 120 ftp://11.163.23.134/Test/Test/dl/csmith-2.3.0.tar.gz')
    os.system('[ -d csmith-2.3.0 ] || tar -xzf csmith-2.3.0.tar.gz')
    os.system('if [ ! -f install-csmith/bin/csmith ];then cd csmith-2.3.0 && ./configure --prefix=`pwd`/../install-csmith && make -j8 && make install ;fi')
def install_gcc(compiler_path):
    os.system('wget -c -t 3 -T 120 '  + compiler_path)
    cc_name=os.path.basename(compiler_path)
    os.system(' mkdir -p ./install_gcc && tar -xvf ' + cc_name + ' -C ./install_gcc')
def install_qemu(qemu_path):
    os.system('wget -c -t 3 -T 120 ' + qemu_path)
    qemu_name=os.path.basename(qemu_path)
    os.system('mkdir -p ./install_qemu && tar -xvf ' + qemu_name + ' -C ./install_qemu ' )

def usage():
    print ("Usage:")
    print ("python "+ sys.argv[0] + " [ -l loop ] [ -s csmith_args ] [ -h ]")
    print (" -h           help version")
    print (" -l          genarate case num,such as: 10")
    print (" -c         set compiler path ")
    print (" -q         set qemu path ")
    print (" -t         set cpu type ")
    print (" Example:    python3 "+sys.argv[0]+" -l 30 -c ftp://eu95t-iotsoftwareftp01.eng.t-head.cn/Test/Test/Toolschain/gnu-riscv/V2.6.1/Xuantie-900-gcc-linux-5.10.4-glibc-x86_64-V2.6.1.tar.gz \
                     -q ftp://eu95t-iotsoftwareftp01.eng.t-head.cn/Test/Test/qemu/V4.0.0/xuantie-qemu-x86_64-Ubuntu-18.04.tar.gz  -t c908v ")

if __name__ == "__main__":
    outdir = ''
    try:
        opts,args = getopt.getopt(sys.argv[1:],"hl:c:q:t:")
        if len(opts) == 0:
            raise Exception('')
    except:
        usage()
        sys.exit(2)
    for opt,arg in opts:
        if opt == '-h':
            usage()
            sys.exit()
        elif opt in ("-l"):
            loop = arg
        elif opt in ("-c"):
            compiler_site = arg
        elif opt in ("-q"):
            qemu_site= arg 
        elif opt in ("-t"):
            cpu_type = arg 
#    install_gcc(compiler_site)
    install_qemu(qemu_site)
