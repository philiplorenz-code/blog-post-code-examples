# Check connection:
```
ansible win -i hosts.ini -m win_ping
```

# Run test playbook:
```
ansible-playbook -i hosts_winrm.ini simple_playbook.yaml
```

# Run test playbook w/ debugging:
```
ansible-playbook -i hosts.ini simple_playbook.yaml -vvv
```
# On MacOS:
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES