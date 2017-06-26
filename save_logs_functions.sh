export TODAY=`date +%Y%m%d`
# Arrays are called differently in ksh88
LOG_FILES=(AGG_TMS* mttrapd.* G_JDBC*)
CAP_FILES=(mttrapd.cap tivoli_eif.cap)
#
# 
#Define functions
# 
# Copy capture file
cp_caps() {
  for i in "${CAP_FILES[@]}"
  do
    cp $OMNIHOME/var/$i $OMNIHOME/raw_cap_save || echo "Can not copy cap files"
  done
}
# check for existance of capture files, if there are there
# call the copy captures function
check_for_caps() {
  count=`ls -1 $OMNIHOME/var/*.cap 2>/dev/null | wc -l`
  if [ $count != 0 ]; then
    echo "Files exist!"
    cp_caps
  fi
}
# Copy log files somewhere
cp_logs() {
  for i in "${LOG_FILES[@]}"
  do
    cp $OMNIHOME/log/$i $OMNIHOME/log/bkup.$TODAY || echo "Error can not copy files"
  done
}
# Check for target dir, if it doesn't exists create and time stamp
check_dir() {
  if [ ! -d $OMNIHOME/log/bkup.$TODAY ]; then
  mkdir $OMNIHOME/log/bkup.$TODAY || echo "Error can not make directory"
fi
}
