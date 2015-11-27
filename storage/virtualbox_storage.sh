
#Storage

VBoxManage createhd --filename aa.vdi --size 150
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Disk image created. UUID: 3276525e-dfbf-4226-8d00-6c10cbb2e352


VBoxManage list runningvms

VBoxManage showvminfo "Cenos7 Zajecia"

(zawsze VBoxManage)

VBoxManage showhdinfo aa.vdi
UUID:           3276525e-dfbf-4226-8d00-6c10cbb2e352
Parent UUID:    base
State:          created
Type:           normal (base)
Location:       /home/mareckip/VirtualBox VMs/Storage/aa.vdi
Storage format: VDI
Format variant: dynamic default
Capacity:       150 MBytes
Size on disk:   2 MBytes


## Dołączanie storage'u aa.vdi do VM "Cenos7 Zajecia"
#   wpierw: VBoxManage showhdinfo "Cenos7 Zajecia"
#   odnaleźć nazwę kontrolera:
Default Frontend:
Storage Controller Name (0):            SATA            #nazwa kontrolera
Storage Controller Type (0):            IntelAhci
Storage Controller Instance Number (0): 0
Storage Controller Max Port Count (0):  30
Storage Controller Port Count (0):      2
Storage Controller Bootable (0):        on
SATA (0, 0): /home/mareckip/VirtualBox VMs/Cenos7 Zajecia/Cenos7 Zajecia.vdi (UUID: 4854da1e-b2a3-4c98-87a7-2a9eca240f75)

## Dodanie dysku do vm i kontrolera (na działającej VM; tego nie ma w GUI):

VBoxManage storageattach "Cenos7 Zajecia" --storagectl SATA --port 1 --type hdd --medium aa.vdi

# ponowne sprawdzenie kontrolera pokaże:
SATA (0, 0): /home/mareckip/VirtualBox VMs/Cenos7 Zajecia/Cenos7 Zajecia.vdi (UUID: 4854da1e-b2a3-4c98-87a7-2a9eca240f75)
SATA (1, 0): /home/mareckip/VirtualBox VMs/Storage/aa.vdi (UUID: 3276525e-dfbf-4226-8d00-6c10cbb2e352)

## Wewnątrz maszyny widać dysk: fdisk -l | grep /dev
Disk /dev/sda: 8589 MB, 8589934592 bytes, 16777216 sectors
/dev/sda1   *        2048     1026047      512000   83  Linux
/dev/sda2         1026048    16695295     7834624   8e  Linux LVM
Disk /dev/mapper/centos-root: 7159 MB, 7159676928 bytes, 13983744 sectors
Disk /dev/mapper/centos-swap: 859 MB, 859832320 bytes, 1679360 sectors
Disk /dev/sdb: 157 MB, 157286400 bytes, 307200 sectors          ##ten jest dodany

fdisk /dev/sdb
n next next next ...
w

mkfs.ext4 /dev/sdb1

blkid --> pokazuje UUID partycji (i jej typ; teraz jest)

/dev/sdb1: UUID="091ddada-8538-45c3-879a-5bbc04954a4c" TYPE="ext4"

# <file system>        <dir>         <type>    <options>             <dump> <pass>
/dev/sda1              /             ext4      defaults,noatime      0      1
/dev/sda2              none          swap      defaults              0      0
/dev/sda3              /home         ext4      defaults,noatime      0      2

## w /etc/fstab dodano:
UUID=091ddada-8538-45c3-879a-5bbc04954a4c /media/n150   ext4    defaults,users 0 2

... teraz użytkownik (niekoniecznie) może montować partycję o zadanym UUID poprzez 
mount /media/n150

(trzeba nadać odpowiednie prawa, by mógł tam zapisywać)



