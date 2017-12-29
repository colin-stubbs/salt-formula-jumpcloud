{# if using kickstart script method provided by jumpcloud.com #}

jumpcloud:
  linux:
    config_method: 'kickstart'
  connect_key: 'TheLongHexStringFromJumpCloudPortal'

{# if using sssd/LDAP method provided by jumpcloud.com LDAP service #}

jumpcloud:
  linux:
    config_method: 'sssd'
  connect_key: 'TheLongHexStringFromJumpCloudPortal'
