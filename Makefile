name = l2_box

all: $(name).ova

$(name).ova: vagrant configure export

# construction de la machine
vagrant:
	NAME=$(name) vagrant plugin install vagrant-vbguest
	NAME=$(name) vagrant up
	NAME=$(name) vagrant provision
	NAME=$(name) vagrant halt

# configuration avant l'export de l'image
configure:
	VBoxManage modifyvm $(name) --vram 128 --audio pulse --clipboard bidirectional --draganddrop bidirectional --mouse usbtablet --largepages on --pae off --x2apic on --graphicscontroller vboxsvga
#	VBoxManage storageattach $(name) --storagectl "SATA Controller" --type dvddrive --port 1 --medium emptydrive

export:
	VBoxManage export $(name) --output $(name).ova

clean:
	rm "$(name).ova" || yes

# suppression de la machine
destroy:
	vagrant destroy --graceful --force