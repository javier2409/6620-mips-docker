FROM debian

RUN apt-get update

RUN apt-get install --yes qemu-system-mips

RUN mkdir /qemu

WORKDIR /qemu

RUN apt-get install --yes wget

RUN wget https://people.debian.org/~jcowgill/qemu-mips/debian-stretch-mips.qcow2

RUN wget https://people.debian.org/~jcowgill/qemu-mips/initrd.img-4.9.0-4-5kc-malta.mips.stretch

RUN wget https://people.debian.org/~jcowgill/qemu-mips/vmlinux-4.9.0-4-5kc-malta.mips.stretch

CMD qemu-system-mips64\
 -M malta -cpu MIPS64R2-generic -m 2G\
 -append 'root=/dev/vda console=ttyS0 mem=2048m\
 net.ifnames=0 nokaslr'\
 -device virtio-net,netdev=user.0\
 -netdev user,id=user.0,hostfwd=tcp::5555-:22 -net nic\
 -device usb-kbd -device usb-tablet\
 -kernel vmlinux-* -initrd initrd.img-*\
 -drive file=$(echo debian-*.qcow2),if=virtio -nographic\
 -virtfs local,path=/project,mount_tag=host0,security_model=passthrough,id=host0
