#!/bin/sh
ORACLE_SID=$1
export ORACLE_SID 
export SCRIPT_NAME=`basename "$0"`
export ORACLE_HOME=/app/oracle/product/11.2.0.4
export PATH=$PATH:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$PATH
export NLS_DATE_FORMAT="DD-MON-YYYY:HH24:MI:SS"
export DATE=`date '+%d%m%y_%H%M%S'`

export ORACLE_SID=$1
export ORACLE_HOME=/app/oracle/product/11.2.0.4


if [ "$#" -ne 1 ]
then
        echo " Usage : sh backup.sh  <db name>"
        exit;
fi

if [ ${ORACLE_SID} == "obid1" ]
then
$ORACLE_HOME/bin/expdp \'/ as sysdba\' tables=SYSTEM.SCHEMA_VERSION_REGISTRY$  directory=PART_DIR dumpfile=expdp_SCHEMA_VERSION_REGISTRY_$DATE.dmp  logfile=expdp_SCHEMA_VERSION_REGISTRY_$DATE.log
else
echo "Cannot change directory!"
exit;
fi
