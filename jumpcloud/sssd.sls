{# jumpcloud.agent #}

{% from "jumpcloud/map.jinja" import jumpcloud_settings with context %}

{# at this point all this does is try to pull in states from the sssd forumula #}
{# available here: https://github.com/colin-stubbs/salt-formula-sssd #}
{# Should I bother using a minimal state to manage sssd independently as part of this formula???  #}

include:
  - sssd.sysauth

{# EOF #}
