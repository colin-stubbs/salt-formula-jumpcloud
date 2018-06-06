jumpcloud
====

Formula to set up and configure the JumpCloud based authentication services.

.. note::

    Visit the `JumpCloud website <https://www.jumpcloud.com>`_ to find out more.

    Agent package installation is primarily based on the official documentation found `here <https://support.jumpcloud.com/customer/portal/articles/2389320-agent-deployment-via-command-line>`_

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``jumpcloud``
-------

Selectively includes jumpcloud.agent or jumpcloud.sssd states based on O/S type and pillar configuration.

``jumpcloud.agent``
-------

Installs agent package in various ways; configurable using pillar see pillar.example.sls for guidance.

.. note::

    - Tested on MacOS (10.12.6 / 10.13.0 )
    - Tested on Windows 10 Pro
    - Tested on CentOS 7, Ubuntu LTS and Debian

.. note::

    - TODO
        - Breakdown official kickstart script to provide cleaner/safer installation method ?

``jumpcloud.sssd``
-------

At this point all this does is try to pull in states from the sssd forumula,
available here: https://github.com/colin-stubbs/salt-formula-sssd


.. note::

    Q: Why would you want to use sssd instead of the full JumpCloud agent?

    A: Do you trust the JumpCloud agent to have full root level access to your system with an explicit ability to perform remote command execution   ?
