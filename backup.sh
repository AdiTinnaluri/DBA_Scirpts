#!/bin/sh
#Script Name : backup.sh
#Purpose : Perform RMAN FULL/INCR/ARCH Backup
#Usage : sh backup.sh <backup type> <db name>
#Author : INFOSYS DBA
set -x
BKP_TYPE=$1
ORACLE_SID=$2
export ORACLE_SID BKP_TYPE
export SCRIPT_NAME=`basename "$0"`
#export ORACLE_HOME=/u02/oracle/product/12102

V_BKP_COUNT=0
export V_BKP_COUNT=`ps -eaf | grep -i catalog | grep -iw $ORACLE_SID | wc -l`
if [ ${V_BKP_COUNT} -ge 1 ]; then
    exit;
else
export PATH=$PATH:$ORACLE_HOME/bin
export LD_LIBRARY_PATH=$ORACLE_HOME/lib:$PATH
export NLS_DATE_FORMAT="DD-MON-YYYY:HH24:MI:SS"
export DATE=`date '+%d%m%y_%H%M%S'`
export SCRIPT_LOG=/tmp/$SCRIPT_NAME.log
export RMAN_LOG=/u02/oracle/backup/$ORACLE_SID/rman/rman_${ORACLE_SID}_${BKP_TYPE}_${DATE}.log
touch $RMAN_LOG
export RMAN_LOG1=/u02/oracle/backup/$ORACLE_SID/rman/rman1_${ORACLE_SID}_${BKP_TYPE}_${DATE}.log
touch $RMAN_LOG1
if [ "$#" -ne 2 ]
then
        echo " Usage : sh backup.sh <backup type> <db name>"
        exit;
fi

if [ ${BKP_TYPE} == "FULL" ]
then
        echo "\n\n ****RMAN FULL BACKUP****" >> $SCRIPT_LOG
        echo "\n rman full startup time: `date`" >> $SCRIPT_LOG
        NB_ORA_SERV=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^$ORACLE_SID|awk -F ':' '{printf $2}'`
        NB_ORA_CLIENT=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^$ORACLE_SID|awk -F ':' '{printf $3}'`
        NB_ORA_POLICY=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^$ORACLE_SID|awk -F ':' '{printf $4}'`
        $ORACLE_HOME/bin/rman target / nocatalog log=$RMAN_LOG << EOF1
        run {
        CONFIGURE DEVICE TYPE SBT_TAPE Backup TYPE to BACKUPSET;
        allocate channel t1 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup1_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t2 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup2_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t3 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup3_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t4 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup4_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t5 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup5_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t6 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup6_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t7 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup7_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t8 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup8_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t9 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup9_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t10 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup10_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t11 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup11_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t12 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup12_$ORACLE_SID_%s_%p_%U.bck';
        
	set command id to 'RMAN-BKUPFULL-NBU';
        backup incremental level 0 filesperset 10 database tag = 'full_open_backup_nbu';
        release channel t1;
        release channel t2;
        release channel t3;
	release channel t4;
        release channel t5;
        release channel t6;
	release channel t7;
        release channel t8;
        release channel t9;
	release channel t10;
        release channel t11;
        release channel t12;

        sql 'alter system archive log current';
        allocate channel t13 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)';
        backup archivelog all format 'arch_open_backup13_$ORACLE_SID_%t_%s_%p_%U.bck' tag 'archivelog_backup_nbu';
        delete noprompt archivelog until time 'sysdate-1' backed up 1 times to device type SBT_TAPE;
        backup current controlfile format 'ctrl_open_backup13_$ORACLE_SID_%t_%s_%p_%u.bck' tag 'Controlfile_backup_nbu';
         release channel t13;
}
        EXIT;
EOF1
elif [ ${BKP_TYPE} == "INCR" ]
then
        echo "\n\n ****RMAN INCRL BACKUP****" >> $SCRIPT_LOG
        echo "\n rman incr startup time: `date`" >> $SCRIPT_LOG
        NB_ORA_SERV=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^$ORACLE_SID|awk -F ':' '{printf $2}'`
        NB_ORA_CLIENT=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^$ORACLE_SID|awk -F ':' '{printf $3}'`
        NB_ORA_POLICY=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^$ORACLE_SID|awk -F ':' '{printf $4}'`
        $ORACLE_HOME/bin/rman target / nocatalog log=$RMAN_LOG << EOF1
	run {
        CONFIGURE DEVICE TYPE SBT_TAPE Backup TYPE to BACKUPSET;
        allocate channel t1 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup1_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t2 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup2_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t3 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup3_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t4 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup4_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t5 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup5_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t6 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup6_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t7 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup7_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t8 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup8_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t9 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup9_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t10 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup10_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t11 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup11_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t12 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'incr_open_backup12_$ORACLE_SID_%s_%p_%U.bck';
        set command id to 'RMAN-BKUPINCR-NBU';
        backup incremental level 1 database tag = 'incr_open_backup_nbu';
        release channel t1;
        release channel t2;
        release channel t3;
        release channel t4;
        release channel t5;
        release channel t6;
        release channel t7;
        release channel t8;
        release channel t9;
        release channel t10;
        release channel t11;
        release channel t12;

        sql 'alter system archive log current';
        allocate channel t13 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)';
        backup archivelog all format 'arch_open_backup13_$ORACLE_SID_%t_%s_%p_%U.bck' tag 'archivelog_backup_nbu';
        delete noprompt archivelog until time 'sysdate-1' backed up 1 times to device type SBT_TAPE;
        release channel t13;
}
        EXIT;
EOF1
elif [ ${BKP_TYPE} == "ARCH" ]
then
        echo "\n\n ****RMAN ARCH BACKUP****" >> $SCRIPT_LOG
        echo "\n rman arch startup time: `date`" >> $SCRIPT_LOG
        NB_ORA_SERV=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^ARCH_$ORACLE_SID|awk -F ':' '{printf $2}'`
        NB_ORA_CLIENT=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^ARCH_$ORACLE_SID|awk -F ':' '{printf $3}'`
        NB_ORA_POLICY=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^ARCH_$ORACLE_SID|awk -F ':' '{printf $4}'`
        $ORACLE_HOME/bin/rman target / nocatalog log=$RMAN_LOG << EOF1
	run {
        CONFIGURE DEVICE TYPE SBT_TAPE Backup TYPE to BACKUPSET;
        configure retention policy to recovery window of 30 days;
        allocate channel t1 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)';
        backup archivelog all not backed up 1 times format 'arch_backup_$ORACLE_SID_%t_%s_%p_%U.bck' tag 'archivelog_backup_nbu';
        delete noprompt archivelog until time 'sysdate-1' backed up 1 times to device type SBT_TAPE;
        release channel t1;
}
        EXIT;
EOF1
elif [ ${BKP_TYPE} == "COLD" ]
then
        echo "\n\n ****RMAN COLD BACKUP****" >> $SCRIPT_LOG
        echo "\n rman cold backup startup time: `date`" >> $SCRIPT_LOG
        NB_ORA_SERV=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^ARCH_$ORACLE_SID|awk -F ':' '{printf $2}'`
        NB_ORA_CLIENT=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^ARCH_$ORACLE_SID|awk -F ':' '{printf $3}'`
        NB_ORA_POLICY=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^ARCH_$ORACLE_SID|awk -F ':' '{printf $4}'`
        $ORACLE_HOME/bin/rman target / nocatalog log=$RMAN_LOG << EOF1
	run {
        shutdown immediate;
        startup mount;
        CONFIGURE DEVICE TYPE SBT_TAPE Backup TYPE to BACKUPSET;
        allocate channel t1 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup1_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t2 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup2_$ORACLE_SID_%s_%p_%U.bck';
        allocate channel t3 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)' format 'full_open_backup3_$ORACLE_SID_%s_%p_%U.bck';
        set command id to 'RMAN-BKUPFULL-NBU';
        backup full database tag = 'full_consistent_backup_nbu';
        release channel t1;
        release channel t2;
        release channel t3;
        allocate channel t4 type SBT_TAPE maxopenfiles=1 PARMS 'ENV=(NB_ORA_SERV=$NB_ORA_SERV,NB_ORA_CLIENT=$NB_ORA_CLIENT,NB_ORA_POLICY=$NB_ORA_POLICY)';
        backup current controlfile format 'ctrl_open_backup5_$ORACLE_SID_%t_%s_%p_%u.bck' tag 'Controlfile_backup_nbu';
        release channel t4;
        alter database open;
}
        EXIT;
EOF1
fi

$ORACLE_HOME/bin/rman target / catalog RMAN12C/rm4n12c@rmanrep log=$RMAN_LOG1 << EOF1
resync catalog; 
EOF1
EMAIL_LIST=`cat /u02/oracle/backup/$ORACLE_SID/rman/bkp_config.lst|grep ^EMAIL|awk -F ':' '{printf $2}'`

ERROR_COUNT=`cat $RMAN_LOG |egrep 'ORA-|RMAN-'|wc -l`

if [ ${ERROR_COUNT} -eq 0 ]
then
        echo "RMAN $BKP_TYPE Backup of database $ORACLE_SID is successfull on server $HOSTNAME" >> $SCRIPT_LOG
        cd /u02/oracle/backup/$ORACLE_SID/rman
        echo "logfile is = $SCRIPT_LOG" >> $SCRIPT_LOG
        if [ "$?" = "0" ]; then
                find . -name "rman*_$ORACLE_SID*log" -mmin +43200 -exec ls -l {} \; -exec rm -rf {} \; >> $SCRIPT_LOG
        else
                echo "Cannot change directory!" 1>&2
                exit 1
        fi
else
        cat $RMAN_LOG |mailx -s "RMAN  $BKP_TYPE Backup of database $ORACLE_SID Failed on server $HOSTNAME" $EMAIL_LIST
#       cat $RMAN_LOG |mailx -s "RMAN  $BKP_TYPE Backup of database $ORACLE_SID Failed on server $HOSTNAME" alakh_niranjan@infosys.com
        exit;
fi
fi
