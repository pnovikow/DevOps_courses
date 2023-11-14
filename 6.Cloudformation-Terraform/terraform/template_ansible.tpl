[ubuntu_nodes]
%{ for  ip  in ubuntu_hosts ~}
${ip}
%{ endfor ~}

[all:vars]
ansible_ssh_private_key_file=~/.ssh/id_rsa.pub
ansible_user=ubuntu
mysql_password=${db_pass}
mysql_root_password=${db_pass}
mysql_user=${db_user}
database_host=${db}
mysql_db=${db_name}
http_host_url=${dns_name}
http_port=80
http_port_gatsby=90