{# jumpcloud.agent #}

{% from "jumpcloud/map.jinja" import jumpcloud_settings with context %}

{# Based on https://support.jumpcloud.com/customer/portal/articles/2389320-agent-deployment-via-command-line #}

{% if grains.kernel == 'Linux' %}

{# Use official kickstart method to obtain package/s #}
jumpcloud_agent_install:
  cmd.run:
    - name: "curl --silent --show-error --header 'x-connect-key: {{ jumpcloud_settings.connect_key }}' {{ jumpcloud_settings.kickstart_url }} | sudo bash"
    - unless: 'test -d /opt/jc'

{% elif grains.os_family == 'MacOS' %}

/opt/jc:
  file.directory:
    - makedirs: True
    - user: root
    - group: _securityagent
    - mode: 0750

/opt/jc/agentBootstrap.json:
  file.managed:
    - source: salt://jumpcloud/files/agentBootstrap.json
    - template: jinja
    - context:
      connect_key: {{ jumpcloud_settings.connect_key }}
    - user: root
    - group: root
    - mode: 0644
    - require:
      - file: /opt/jc
    - unless: 'test -f /opt/jc/com.jumpcloud.darwin-agent.plist'

jumpcloud_agent_installer:
  file.managed:
    - name: '/tmp/jumpcloud-agent.pkg'
    - source: {{ jumpcloud_settings.lookup.pkg_url }}
    - skip_verify: {{ jumpcloud_settings.lookup.pkg_verify }}
    - source_hash: {{ jumpcloud_settings.lookup.pkg_hash }}
    - unless: 'test -f /opt/jc/com.jumpcloud.darwin-agent.plist'

jumpcloud_agent_install:
  cmd.run:
    - name: 'installer -pkg /tmp/jumpcloud-agent.pkg -target /'
    - unless: 'test -f /opt/jc/com.jumpcloud.darwin-agent.plist'
    - require:
      - file: /opt/jc/agentBootstrap.json
      - file: jumpcloud_agent_installer

remove_jumpcloud_agent_installer:
  file.absent:
    - name: '/tmp/jumpcloud-agent.pkg'
    - require:
      - cmd: jumpcloud_agent_install

{% elif grains.os_family == 'Windows' %}

jumpcloud_agent_installer:
  file.managed:
    - name: 'C:\\tmp\\JumpCloudInstaller.exe'
    - source: {{ jumpcloud_settings.lookup.pkg_url }}
    - skip_verify: {{ jumpcloud_settings.lookup.pkg_verify }}
    - source_hash: {{ jumpcloud_settings.lookup.pkg_hash }}
    - unless: 'IF EXIST "C:\\Program Files (x86)\\JumpCloud\\jumpcloud-agent.exe" ( exit 0 ) ELSE ( exit 1 )'

jumpcloud_agent_install:
  cmd.run:
    - name: "C:\\tmp\\JumpCloudInstaller.exe -k {{ jumpcloud_settings.connect_key }} /VERYSILENT /NORESTART"
    - unless: 'IF EXIST "C:\\Program Files (x86)\\JumpCloud\\jumpcloud-agent.exe" ( exit 0 ) ELSE ( exit 1 )'
    - require:
      - file: jumpcloud_agent_installer

remove_jumpcloud_agent_installer:
  file.absent:
    - name: 'C:\\tmp\\JumpCloudInstaller.exe'
    - require:
      - cmd: jumpcloud_agent_install

{% else %}

{# wrong O/S fool - we can do nothing for you.... #}

{% endif %}

{# EOF #}
