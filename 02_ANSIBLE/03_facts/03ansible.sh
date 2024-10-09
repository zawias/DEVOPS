- name: lab03  
  remote_user: root
  hosts: all

  tasks:
  - name: install nxinx
    ansible.builtin.apt:
      name: nginx
      update_cache: yes
    when:
      - ansible_facts['distribution'] == "Ubuntu"
      - ansible_facts['distribution_major_version'] == "22.04"
  
  - name: remove nginx conf
    ansible.builtin.file:
      path: /var/www/html/index.nginx-debian.html
      state: absent

  - name: copy nginx conf
    ansible.builtin.copy:
      src: /root/DEVOPS/02_ANSIBLE/02_playbook/website/index.html
      dest: /var/www/html/
      owner: root
      group: root
      mode: '0644'

  - name: show date
    ansible.builtin.shell:
      cmd: date > /root/date.txt

  - name: downloand file
    ansible.builtin.fetch:
      src: /root/date.txt
      dest: /root/DEVOPS/02_ANSIBLE/03_facts/
      flat: true