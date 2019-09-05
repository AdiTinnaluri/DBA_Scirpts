cd $ADMIN_SCRIPTS_HOME
adapcctl.sh stop
adoacorectl.sh stop
sleep 20
adoacorectl.sh status
adoacorectl.sh start
adapcctl.sh start
adapcctl.sh status
