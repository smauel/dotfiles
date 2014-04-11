install:
	ansible-playbook -i hosts local_setup.yml -c local

dotfiles:
	ansible-playbook -i hosts dotfiles.yml -c local
