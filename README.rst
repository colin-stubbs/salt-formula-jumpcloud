jumpcloud
====

Formula to set up and configure the JumpCloud based authentication services.

.. note::

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

NOTE:
Tested on MacOS (Sierra 10.12.6)
Yet to be tested on Windows
Yet to be tested on Linux

TODO:
Breakdown official kickstart script to provide cleaner/safer installation method

``jumpcloud.sssd``
-------

At this point all this does is try to pull in states from the sssd forumula,
available here: https://github.com/colin-stubbs/salt-formula-sssd