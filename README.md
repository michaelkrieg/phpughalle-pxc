Percona XtraDB Cluster (MySQL 5.6)
==================================

Es gibt 3 Cluster Nodes:

    172.23.77.11 pxc1  
    172.23.77.12 pxc2  
    172.23.77.13 pxc3  

Achja, das MySQL root Passwort lautet "ficken100".


Cluster initialisieren
======================

    ### zunächst alle Knoten starten
    vagrant up

    ### dann einmalig auf der ersten Node (pxc1) das Percona Cluster initialisieren:
    vagrant ssh -c "sudo /root/bootstrap-pxc.sh" pxc1

    ### hiernach dann die beiden Knoten "pxc2" und "pxc3" ins Cluster bringen:
    vagrant ssh -c "sudo service mysql start" pxc2
    vagrant ssh -c "sudo service mysql start" pxc3

    ### Prüfen, ob auch wirklich 3 Knoten im Cluster sind:
    vagrant ssh <pxc1 | pxc2 | pcx3>
    mysql -uroot -pficken100 -e "show global status like 'wsrep_cluster_size'"


VirtualBox Guest Additions
--------------------------

Wer automatisch die VB Guest Additions aktuell halten möchte, braucht lediglich einmal das Vagrant Plugin "vbguest" installieren:

    vagrant plugin install vagrant-vbguest

