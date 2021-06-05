#!/bin/bash
mimic-deploy /host/bin/dmesg
mimic-deploy /host/bin/findmnt
mimic-deploy /host/bin/lsblk
mimic-deploy /host/bin/more
mimic-deploy /host/bin/mountpoint
mimic-deploy /host/bin/su
mimic-deploy /host/bin/wdctl
# not dynamic executable : /etc/init.d/hwclock.sh
# not dynamic executable : /lib/udev/hwclock-set
mimic-deploy /host/sbin/agetty
mimic-deploy /host/sbin/blkdiscard
mimic-deploy /host/sbin/blkid
mimic-deploy /host/sbin/blkzone
mimic-deploy /host/sbin/blockdev
mimic-deploy /host/sbin/chcpu
mimic-deploy /host/sbin/ctrlaltdel
mimic-deploy /host/sbin/findfs
mimic-deploy /host/sbin/fsck
mimic-deploy /host/sbin/fsck.cramfs
mimic-deploy /host/sbin/fsck.minix
mimic-deploy /host/sbin/fsfreeze
mimic-deploy /host/sbin/fstrim
mimic-deploy /host/sbin/hwclock
mimic-deploy /host/sbin/isosize
mimic-deploy /host/sbin/mkfs
mimic-deploy /host/sbin/mkfs.bfs
mimic-deploy /host/sbin/mkfs.cramfs
mimic-deploy /host/sbin/mkfs.minix
mimic-deploy /host/sbin/mkswap
mimic-deploy /host/sbin/pivot_root
mimic-deploy /host/sbin/raw
mimic-deploy /host/sbin/runuser
mimic-deploy /host/sbin/sulogin
mimic-deploy /host/sbin/swaplabel
mimic-deploy /host/sbin/switch_root
mimic-deploy /host/sbin/wipefs
mimic-deploy /host/sbin/zramctl
mimic-deploy /host/usr/bin/addpart
mimic-deploy /host/usr/bin/choom
mimic-deploy /host/usr/bin/chrt
mimic-deploy /host/usr/bin/delpart
mimic-deploy /host/usr/bin/fallocate
mimic-deploy /host/usr/bin/fincore
mimic-deploy /host/usr/bin/flock
mimic-deploy /host/usr/bin/getopt
mimic-deploy /host/usr/bin/ionice
mimic-deploy /host/usr/bin/ipcmk
mimic-deploy /host/usr/bin/ipcrm
mimic-deploy /host/usr/bin/ipcs
mimic-deploy /host/usr/bin/last
mimic-deploy /host/usr/bin/lscpu
mimic-deploy /host/usr/bin/lsipc
mimic-deploy /host/usr/bin/lslocks
mimic-deploy /host/usr/bin/lslogins
mimic-deploy /host/usr/bin/lsmem
mimic-deploy /host/usr/bin/lsns
mimic-deploy /host/usr/bin/mcookie
mimic-deploy /host/usr/bin/mesg
mimic-deploy /host/usr/bin/namei
mimic-deploy /host/usr/bin/nsenter
mimic-deploy /host/usr/bin/partx
mimic-deploy /host/usr/bin/prlimit
mimic-deploy /host/usr/bin/rename.ul
mimic-deploy /host/usr/bin/resizepart
mimic-deploy /host/usr/bin/rev
mimic-deploy /host/usr/bin/setarch
mimic-deploy /host/usr/bin/setpriv
mimic-deploy /host/usr/bin/setsid
mimic-deploy /host/usr/bin/setterm
mimic-deploy /host/usr/bin/taskset
mimic-deploy /host/usr/bin/unshare
mimic-deploy /host/usr/bin/utmpdump
mimic-deploy /host/usr/bin/whereis
mimic-deploy /host/usr/sbin/chmem
mimic-deploy /host/usr/sbin/fdformat
mimic-deploy /host/usr/sbin/ldattach
mimic-deploy /host/usr/sbin/readprofile
mimic-deploy /host/usr/sbin/rtcwake
