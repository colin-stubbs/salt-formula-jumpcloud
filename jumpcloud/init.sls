{# jumpcloud #}

{% from "jumpcloud/map.jinja" import jumpcloud_settings with context %}

include:
{% if grains.kernel == 'Linux' and jumpcloud_settings.linux.config_method == 'sssd' %}
  - jumpcloud.sssd
{% else %}
  - jumpcloud.agent
{% endif %}

{# EOF #}
