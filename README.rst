=================
Salt Vagrant Demo
=================

A Salt Demo using Vagrant.


Instructions
============

Run the following commands in a terminal. Git, VirtualBox and Vagrant must
already be installed.

.. code-block:: bash

    git clone https://github.com/UtahDave/salt-vagrant-demo.git
    cd salt-vagrant-demo
    vagrant up

.. code-block:: bash

    vagrant ssh master
    sudo salt \* test.ping
    salt minion1 state.apply services.backend pillarenv=dev
    salt minion1 state.apply services.backend pillarenv=qa

    salt minion2 state.apply services.frontend pillarenv=dev
    salt minion2 state.apply services.frontend pillarenv=qa
