#!/bin/bash
echo Set Oracle Database Env
export ORACLE_SID=$1
export ORACLE_HOME=/app/oracle/product/11.2.0.4
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/usr/lib
export PATH=$ORACLE_HOME/bin:$PATH:/usr/local/bin
export TIMESTAMP=`date +%a%d%b%Y`

if [ obid1= $1]; then
echo =================
echo For OBID1 . Take below additional schema Backups
echo ==================
expdp system/pcastart schemas=infm_9 directory=PART_DIR dumpfile=expdp_${ORACLE_SID}_infm_9_`date +%m%d%y`.dmp logfile=expdp_infm_9_`date +%m%d%y`.log
expdp system/pcastart schemas=dac_9 directory=PART_DIR dumpfile=expdp_${ORACLE_SID}_dac_9_`date +%m%d%y`.dmp logfile=expdp_dac_9_`date +%m%d%y`.log
 else
 echo "DB NAME NOT A OBID1"
 exit 0
  fi
