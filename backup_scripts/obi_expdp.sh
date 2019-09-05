#!/bin/bash
ORACLE_SID=$1
export ORACLE_SID 
export SCRIPT_NAME=`basename "$0"`
export ORACLE_HOME=/app/oracle/product/11.2.0.4
export PATH=$PATH:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$PATH
export NLS_DATE_FORMAT="DD-MON-YYYY:HH24:MI:SS"
export DATE=`date '+%d%m%y_%H%M%S'`
export EXP_DP_LOCATION=/backup/$ORACLE_SID/expdp

if [ "$#" -ne 1 ]
then
        echo " Usage : sh obi_expdp.sh  <db name>"
        exit;
fi

$ORACLE_HOME/bin/sqlplus -s "/as sysdba" << EOF 
CREATE OR REPLACE DIRECTORY PART_DIR AS '/backup/$ORACLE_SID/expdp';
exit
EOF
echo ==================
echo Schemas expdp
echo ==============
echo $ORACLE_HOME

$ORACLE_HOME/bin/expdp \'/ as sysdba\'  schemas=${ORACLE_SID}_MDS directory=PART_DIR dumpfile=expdp_${ORACLE_SID}_MDS_$DATE.dmp logfile=expdp_OBI${ORACLE_SID}_MDS_$DATE.log COMPRESSION=ALL
$ORACLE_HOME/bin/expdp \'/ as sysdba\' schemas=${ORACLE_SID}_BIPLATFORM directory=PART_DIR dumpfile=expdp_${ORACLE_SID}_BIPLATFORM_$DATE.dmp logfile=expdp_OBI${ORACLE_SID}_BIPLATFORM_$DATE.log COMPRESSION=ALL 
#$ORACLE_HOME/bin/expdp \'/ as sysdba\' schemas=FBI_BIA_ODIREPO directory=PART_DIR dumpfile=expdp_${ORACLE_SID}_FBI_BIA_ODIREPO_$DATE.dmp logfile=expdp_${ORACLE_SID}_FBI_BIA_ODIREPO_$DATE.log  COMPRESSION=ALL

echo ==================
echo tables expdp
echo ==================

$ORACLE_HOME/bin/expdp \'/ as sysdba\' tables=SYSTEM.SCHEMA_VERSION_REGISTRY$  directory=PART_DIR dumpfile=expdp_SCHEMA_VERSION_REGISTRY_$DATE.dmp  logfile=expdp_SCHEMA_VERSION_REGISTRY_$DATE.log
$ORACLE_HOME/bin/expdp \'/ as sysdba\'  TABLES=FBI_DW.W_LOCALIZED_STRING_G directory=PART_DIR dumpfile=expdp_W_LOCALIZED_STRING_G_$DATE.dmp logfile=expdp_W_LOCALIZED_STRING_G_$DATE.log 
$ORACLE_HOME/bin/expdp \'/ as sysdba\' TABLES=FBI_DW.WC_SECURITY_G directory=PART_DIR  dumpfile=expdp_WC_SECURITY_G_$DATE.dmp logfile=expdp_WC_SECURITY_G_$DATE.log 
$ORACLE_HOME/bin/expdp \'/ as sysdba\' TABLES=TREC.TREC_STATUS_MAIL_USERS  directory=PART_DIR  dumpfile=expdp_exp_TREC_STATUS_MAIL_USERS_$DATE.dmp logfile=expdp_TREC_STATUS_MAIL_USERS_$DATE.log 
$ORACLE_HOME/bin/expdp \'/ as sysdba\' TABLES=STG.RPNA_STATUS_MAIL_USERS  directory=PART_DIR  dumpfile=expdp_RPNA_STATUS_MAIL_USERS_$DATE.dmp logfile=expdp_RPNA_STATUS_MAIL_USERS_$DATE.log


if [ ${ORACLE_SID} == "obid1" ]
then
echo ==================
echo For OBID1 . Take below additional schema Backups
echo ==================
expdp system/pcastart schemas=infm_9 directory=PART_DIR dumpfile=expdp_${ORACLE_SID}_infm_9_$DATE.dmp logfile=expdp_infm_9_$DATE.log
expdp system/pcastart schemas=dac_9 directory=PART_DIR dumpfile=expdp_${ORACLE_SID}_dac_9_$DATE.dmp logfile=expdp_dac_9_$DATE.log
else
echo "DB NAME IS NOT OBID1!"
exit;
fi

cd /backup/$ORACLE_SID/expdp  > $EXP_DP_LOCATION/expdp_$ORACLE_SID_$DATE.txt
ls -ltr *.dmp |tail -10 >> $EXP_DP_LOCATION/expdp_$ORACLE_SID_$DATE.txt

 
echo SEND MAIL TO TEAM-3
echo =====================
mailx -s "$ORACLE_SID $DATE Export backups completed " adi.tinnaluri@datavail.com < $EXP_DP_LOCATION/expdp_$ORACLE_SID_$DATE.txt
#echo Export completed at $DATE
exit
