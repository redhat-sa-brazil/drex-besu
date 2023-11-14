.PHONY: aro rosa vsphere agnostic-odf

aro:
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=managed-csi" playbooks/pre_deploy.yml
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=managed-csi"  --extra-vars "loadbalancer=azure: stdlb" playbooks/deploy_besu.yml

rosa:
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=gp3-csi" playbooks/pre_deploy.yml
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=gp3-csi" --extra-vars "service=service.beta.kubernetes.io/aws-load-balancer-type" --extra-vars loadbalancer="external" playbooks/deploy_besu.yml

vsphere:
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=thin" playbooks/pre_deploy.yml
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=thin" --extra-vars "service=service.beta.kubernetes.io/aws-load-balancer-type" --extra-vars "loadbalancer=NodePort" playbooks/deploy_besu.yml

agnostic-odf:
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=ocs-storagecluster-cephfs" playbooks/pre_deploy.yml
	ansible-playbook --extra-vars "@vars.yml"  --extra-vars "storage_class=ocs-storagecluster-cephfs"  --extra-vars "service=agnostic" --extra-vars "loadbalancer=agnostic" playbooks/deploy_besu.yml
