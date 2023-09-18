.PHONY: aro rosa

aro:
	ansible-playbook --extra-vars "@vars.yml" playbooks/aro_pre_deploy.yml
	ansible-playbook --extra-vars "@vars.yml" playbooks/aro_deploy_besu.yml

rosa:
	ansible-playbook --extra-vars "@vars.yml" playbooks/rosa_pre_deploy.yml
	ansible-playbook --extra-vars "@vars.yml" playbooks/rosa_deploy_besu.yml
