# Successfully boots
menuentry "wimboot DaRT70-x64.iso" {
	set iso_path="/bootisos/DaRT70-x64.iso"
	loopback loop $iso_path
	linux16 /boot/grub/wimboot
	initrd16 \
		newc:bootmgr:(loop)/bootmgr \
		newc:bcd:(loop)/boot/bcd \
		newc:boot.sdi:(loop)/boot/boot.sdi \
		newc:boot.wim:(loop)/sources/boot.wim
}
menuentry "wimboot en_windows_7_enterprise_n_with_sp1_x64_dvd_u_677704.iso" {
	loopback loop /bootisos/en_windows_7_enterprise_n_with_sp1_x64_dvd_u_677704.iso
	linux16 /boot/grub/wimboot
	initrd16 \
            newc:bootmgr:(loop)/bootmgr \
            newc:bcd:(loop)/boot/bcd \
            newc:boot.sdi:(loop)/boot/boot.sdi \
	    newc:boot.wim:(loop)/sources/boot.wim \
	    newc:install.wim:(loop)/sources/install.wim
}

menuentry 'Windows GPT bootmgr wimboot' { 
    linux16 /wimboot 
    initrd16 \     
        newc:bootmgr.exe:(hd0,gpt1)/bootmgr.exe \
        newc:bcd:(hd0,gpt1)/Boot/BCD  
}


if loadfont /boot/grub/font.pf2 ; then
	set gfxmode=auto
	insmod efi_gop
	insmod efi_uga
	insmod gfxterm
	terminal_output gfxterm
fi

set menu_color_normal=white/black
set menu_color_highlight=black/light-gray

set timeout=5
menuentry "Try Ubuntu without installing" {
	set gfxpayload=keep
	linux	/casper/vmlinuz  file=/cdrom/preseed/ubuntu.seed boot=casper quiet splash ---
	initrd	/casper/initrd.lz
}
menuentry "Install Ubuntu" {
	set gfxpayload=keep
	linux	/casper/vmlinuz  file=/cdrom/preseed/ubuntu.seed boot=casper only-ubiquity quiet splash ---
	initrd	/casper/initrd.lz
}
menuentry "winpe" {
	linux16 /boot/grub/wimboot
	initrd16 \
            newc:bootmgr:/bootmgr
}
menuentry "Check disc for defects" {
	set gfxpayload=keep
	linux	/casper/vmlinuz  boot=casper integrity-check quiet splash ---
	initrd	/casper/initrd.lz
}
	kernel /boot/vmlinuz
	initrd /boot/initrd.img