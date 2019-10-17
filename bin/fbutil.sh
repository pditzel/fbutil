#!/bin/bash

################################################################################
#                                                                              #
#    Author: Patrick Ditzel (patrick@central-computer.de)                      #
#                                                                              #
#    License: GPLv3                                                            #
#                                                                              #
################################################################################

main () {

  #----------------------------------------------------------------------------#
  # Bibliotheken einbinden
  for LIB in $(find ./lib -maxdepth 1 -type f -printf '%f\n'); do
    # Debugging-Ausgabe
    #echo "lib to include: $LIB"\
    #| /usr/bin/logger -s -i -t pshome
    source ./lib/"${LIB}"
  done

  #----------------------------------------------------------------------------#

  # Konfiguration einlesen
  setConfig

  #----------------------------------------------------------------------------#

  # Session starten und SessionID bereitstellen
  FBSID=$(getFBSID)

  #============================================================================#

  # Module ausführen

    #
    # Nutzbare Variablen:
    # ${FRITZBOXFQDN}     -   Die Adresse der Firtzbox
    # ${FBSID}            -   Die aktuell gültige SessionID
    #

  # Alle Devices an der FB ausgeben
  fbshdevinfo

  # Backup FRITZBOX
  fbbackupcfg

  # Capture FB NetworDeviceTraffic
  fbcapture

  # Read SmartHomeDevices und write to MQTT
  fbsh2mqttdevinfo

  #============================================================================#




  # Session beenden
  closeSession "$FBSID"

  #----------------------------------------------------------------------------#

}

main
