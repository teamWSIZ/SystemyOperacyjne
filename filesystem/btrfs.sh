http://www.oracle.com/technetwork/articles/servers-storage-admin/advanced-btrfs-1734952.html
http://marc.merlins.org/perso/btrfs/post_2014-05-04_Fixing-Btrfs-Filesystem-Full-Problems.html

losetup /dev/loop3 base4G 

mkfs.btrfs /dev/loop0
mount /dev/loop0 entry


alias bs='btrfs subvolume '
bs create pm
bs delete pm


[root@titan sysop]# btrfs device add /dev/loop1 entry
Performing full device TRIM (200.00MiB) ... while sleep 1; do echo 0; done > w

[root@titan sysop]# btrfs filesystem show     #== btrfs fi sh
Label: none  uuid: 5ff8e9f6-928e-4779-9ae4-757dbd9d3635
	Total devices 2 FS bytes used 144.00KiB
	devid    1 size 200.00MiB used 88.00MiB path /dev/loop0
	devid    2 size 200.00MiB used 0.00B path /dev/loop1

btrfs device delete /dev/loop1 entry	#takes some time

bs snapshot pm pm_s1	#as if copy, but fast

while sleep 1; do echo 0; done > w

df -hT   #shows the size as the sum of all drives which joined 
/dev/loop0              btrfs     1.4G   57M  1.3G   5% /home/pm/wykopki/sysop/entry

#exercise: move a filesystem, online, to a drive
---------------
create dir "eee",
#ll
  entry
  eee
-----
mount -o subvol=s2 /dev/loop0 eee
mount -o subvol=<subvol_in_main_dir_of_devic> <device_where_btrfs> <mountpoint_path>
---------
can substitute different ---> similar to copy, `ln -s`

#change raid1 to raid0

btrfs device stats
(shows errors)

http://blog.programster.org/btrfs-cheatsheet/

https://news.ycombinator.com/item?id=11240741

using raid1 on a single drive means the data will be stored in two locations on that one drive (to protect against corruption) and will reduce your storage space (its a really really good idea for the metadata).

removing raid:
btrfs balance start -f -mconvert=single -dconvert=single entry

performance problems:
https://blog.pgaddict.com/posts/friends-dont-let-friends-use-btrfs-for-oltp








