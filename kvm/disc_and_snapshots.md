
### Disc resize operations:

(shutdown the VM first) 

`qemu-img info dohaDocker.qcow2 `

`qemu-img resize dohaDocker.qcow2 +10G`

`qemu-img check -r all dohaDocker.qcow2`

```
No errors were found on the image.
131072/294912 = 44.44% allocated, 0.00% fragmented, 0.00% compressed clusters
Image end offset: 8591572992
```

Potem wewnątrz VM trzeba rozszerzyć `lvm`, 
* `df -hT`
* `fdisk /dev/vda`
* n, primary, (max size), t, (partition 3, or other that was created), type: 8e (LVMe), w
* partprobe,
* `pvcreate /dev/vda3`
* `vgs` ; `vgextend centos /dev/vda3`
* `pvs` ; `lvextend -l +100%FREE /dev/centos/root`
* `resize2fs /dev/centos/root`
* `df -hT`




### Snapshots

