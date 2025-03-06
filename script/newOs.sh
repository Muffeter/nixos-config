#!/bin/bash
set -euo pipefail

# 警告提示
read -p "sure to continue? y/n" confirm
if [[ "$confirm" != "y" ]]; then
    echo "cancel"
    exit 1
fi

# 分区操作
parted --script /dev/sda -- \
    mklabel gpt \
    mkpart ESP fat32 1MiB 256MiB \
    set 1 esp on \
    mkpart primary 256MiB -8GiB \
    mkpart primary linux-swap -8GiB 100%

# 格式化文件系统
mkfs.fat -F 32 /dev/sda1
mkfs.btrfs -L nixos /dev/sda2 -f
mkswap -L swap /dev/sda3

# 临时挂载创建子卷
mount /dev/sda2 /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
umount /mnt

# 永久挂载
mount -o compress=zstd,subvol=root /dev/sda2 /mnt
mkdir -p /mnt/{home,nix,boot}
mount -o compress=zstd,subvol=home /dev/sda2 /mnt/home
mount -o compress=zstd,noatime,subvol=nix /dev/sda2 /mnt/nix
mount /dev/sda1 /mnt/boot

# 启用交换空间
swapon /dev/sda3

echo "操作完成！请继续安装系统。"

