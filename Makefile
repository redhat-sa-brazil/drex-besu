.PHONY: aro rosa

aro:
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=managed-csi" playbooks/pre_deploy.yml
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=managed-csi"  --extra-vars "loadbalancer=azure: stdlb" playbooks/deploy_besu.yml

rosa:
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=gp3-csi" playbooks/pre_deploy.yml
	ansible-playbook --extra-vars "@vars.yml" --extra-vars "storage_class=gp3-csi" --extra-vars "service=service.beta.kubernetes.io/aws-load-balancer-type" --extra-vars loadbalancer="external" playbooks/deploy_besu.yml
