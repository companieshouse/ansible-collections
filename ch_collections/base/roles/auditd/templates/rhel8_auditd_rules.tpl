-D
-b 8193
-f 2

# Self Auditing ---------------------------------------------------------------
## Audit the audit logs
### Successful and unsuccessful attempts to read information from the audit records
-w /var/log/audit/ -k auditlog

## Auditd configuration
### Modifications to audit configuration that occur while the audit collection functions are operating
-w /etc/audit/ -p wa -k auditconfig
-w /etc/libaudit.conf -p wa -k auditconfig
-w /etc/audisp/ -p wa -k audispconfig

## Monitor for use of audit management tools
-w /sbin/auditctl -p x -k audittools
-w /sbin/auditd -p x -k audittools


# Customer added Rules ---Please add below this line----------------------------


# Filters ---------------------------------------------------------------------

### We put these early because audit is a first match wins system.
## Ignore EOE records (End Of Event, not needed)
-a always,exclude -F msgtype=EOE

## This prevents chrony from overwhelming the logs
-a never,exit -F arch=b64 -S adjtimex -F subj_type=chronyd_t

# Rules -----------------------------------------------------------------------
-a exit,always -F arch=b32 -S sethostname -S setdomainname -k  audit_network_modifications
-a exit,always -F arch=b32 -S clock_settime -k T1070.006_3
-a exit,always -F arch=b32 -S adjtimex -S settimeofday -S stime -k T1070.006_1
-a always,exit -F arch=b32 -S chmod -F auid>=500 -F auid!=4294967295 -k T1548.001_1
-a always,exit -F arch=b32 -S fchmod -F auid>=500 -F auid!=4294967295 -k T1548.001_3
-a always,exit -F arch=b32 -S fchmodat -F auid>=500 -F auid!=4294967295 -k T1548.001_4
-a always,exit -F arch=b32 -S chown -F auid>=500 -F auid!=4294967295 -k T1548.001_2
-a always,exit -F arch=b32 -S fchown -F auid>=500 -F auid!=4294967295 -k T1548.001_5
-a always,exit -F arch=b32 -S fchownat -F auid>=500 -F auid!=4294967295 -k T1548.001_6
-a always,exit -F arch=b32 -S lchown -F auid>=500 -F auid!=4294967295 -k T1548.001_9
-a exit,always -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
-a exit,always -F arch=b32 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
-a exit,always -F arch=b32 -S execve,execveat -k T1059_2
-a always,exit -F arch=b32 -S setxattr -F auid>=500 -F auid!=4294967295 -k T1548.001_13
-a always,exit -F arch=b32 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k T1548.001_11
-a always,exit -F arch=b32 -S fsetxattr -F auid>=500 -F auid!=4294967295 -k T1548.001_8
-a always,exit -F arch=b32 -S removexattr -F auid>=500 -F auid!=4294967295 -k T1548.001_12
-a always,exit -F arch=b32 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k T1548.001_10
-a always,exit -F arch=b32 -S fremovexattr -F auid>=500 -F auid!=4294967295 -k T1548.001_7
-a always,exit -F arch=b32 -S finit_module -S init_module -S delete_module -F auid!=-1 -k T1547.006_5
-a exit,always -F arch=b64 -S adjtimex -S settimeofday -k T1070.006_2
-a exit,always -F arch=b64 -S clock_settime -k T1070.006_4
-a always,exit -F arch=b64 -S chmod  -F auid>=500 -F auid!=4294967295 -k T1548.001_14
-a always,exit -F arch=b64 -S fchmod -F auid>=500 -F auid!=4294967295 -k T1548.001_16
-a always,exit -F arch=b64 -S fchmodat -F auid>=500 -F auid!=4294967295 -k T1548.001_17
-a always,exit -F arch=b64 -S chown -F auid>=500 -F auid!=4294967295 -k T1548.001_15
-a always,exit -F arch=b64 -S fchown -F auid>=500 -F auid!=4294967295 -k T1548.001_18
-a always,exit -F arch=b64 -S fchownat -F auid>=500 -F auid!=4294967295 -k T1548.001_19
-a always,exit -F arch=b64 -S lchown -F auid>=500 -F auid!=4294967295 -k T1548.001_22
-a exit,always -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access
-a exit,always -F arch=b64 -S creat -S open -S openat -S truncate -S ftruncate -F exit=-EPERM -F auid>=1000 -F auid!=4294967295 -k access
-a exit,always -F arch=b64 -S execve,execveat -k T1059_1
-a always,exit -F arch=b64 -S finit_module -S init_module -S delete_module -F auid!=-1 -k T1547.006_4
-a exit,always -F arch=b64 -S mount -F auid>=500 -F auid!=4294967295 -k T1052.001_2
-a exit,always -F arch=b64 -S rmdir -S unlink -S unlinkat -S rename -S renameat -F auid>=500 -F auid!=4294967295 -k T1070.004_2
-a exit,always -F arch=b64 -S sethostname -S setdomainname -k change-hostname
-a always,exit -F arch=b64 -S setxattr -F auid>=500 -F auid!=4294967295 -k T1548.001_26
-a always,exit -F arch=b64 -S lsetxattr -F auid>=500 -F auid!=4294967295 -k T1548.001_24
-a always,exit -F arch=b64 -S fsetxattr -F auid>=500 -F auid!=4294967295 -k T1548.001_21
-a always,exit -F arch=b64 -S removexattr -F auid>=500 -F auid!=4294967295 -k T1548.001_25
-a always,exit -F arch=b64 -S lremovexattr -F auid>=500 -F auid!=4294967295 -k T1548.001_23
-a always,exit -F arch=b64 -S fremovexattr -F auid>=500 -F auid!=4294967295 -k T1548.001_20
-w /etc/group -p wa -k T1087.001_1
-w /etc/gshadow -p wa -k T1087.001_3
-w /etc/hosts -p wa -k audit_network_modifications
#-w /etc/issue.net -p wa -k system-locale
-w /etc/issue -p wa -k audit_network_modifications
-w /etc/localtime -p wa -k T1070.006_5
-w /etc/passwd -p wa -k T1087.001_2
-w /etc/security/opasswd -p wa -k T1087.001_5
-w /etc/selinux/ -p wa -k selinux_changes
-w /etc/shadow -p wa -k T1087.001_4
-w /etc/sudoers -p wa -k T1548.003_3
-w /etc/sysconfig/network -p wa -k audit_network_modifications
-a always,exit -F perm=x -F auid!=-1 -F path=/sbin/insmod -k T1547.006_1
-a always,exit -F perm=x -F auid!=-1 -F path=/sbin/modprobe -k T1547.006_2
-a always,exit -F perm=x -F auid!=-1 -F path=/sbin/rmmod -k T1547.006_3
-w /etc/cron.allow -p wa -k T1053.003_1
-w /etc/cron.deny -p wa -k T1053.003_2
-w /etc/cron.d/ -p wa -k T1053.003_3
-w /etc/cron.daily/ -p wa -k T1053.003_4
-w /etc/cron.hourly/ -p wa -k T1053.003_5
-w /etc/cron.monthly/ -p wa -k T1053.003_6
-w /etc/cron.weekly/ -p wa -k T1053.003_7
-w /etc/crontab -p wa -k T1053.003_8
-w /var/spool/cron/crontabs/ -k T1053.003_9
-w /etc/init.d/ -p wa -k T1037_2
-w /etc/init/ -p wa -k T1037_3
-w /sbin/init -k T1037_4
-w /etc/at.allow -p wa -k T1053.001_14
-w /etc/at.deny -p wa -k T1053.001_15
-w /var/spool/at/ -p wa -k T1053.001_16
-w /etc/anacrontab -p wa -k T1053.003_17
-w /var/log/btmp -p wa -k T1136.001_3
-w /var/log/lastlog -p wa -k T1082_7
-w /var/log/wtmp -p wa -k T1136.001_2
-w /var/run/faillock/ -p wa -k T1082
-w /var/run/utmp -p wa -k T1136.001_1
-a always,exit -F arch=b32 -S ptrace -k T1055.008_1
-a always,exit -F arch=b64 -S ptrace -k T1055.008_2
-a always,exit -F arch=b32 -S ptrace -F a0=0x4 -k T1055.008_3
-a always,exit -F arch=b64 -S ptrace -F a0=0x4 -k T1055.008_4
-a always,exit -F arch=b32 -S ptrace -F a0=0x5 -k T1055.008_5
-a always,exit -F arch=b64 -S ptrace -F a0=0x5 -k T1055.008_6
-a always,exit -F arch=b32 -S ptrace -F a0=0x6 -k T1055.008_7
-a always,exit -F arch=b64 -S ptrace -F a0=0x6 -k T1055.008_8
-w /etc/ld.so.preload -k T1548.001_33


{% if ansible_os_family == "RedHat" -%}
# RPM (Redhat/CentOS)
-w /usr/bin/rpm -p x -k T1072_1
-w /usr/bin/yum -p x -k T1072_2
{% endif -%}
{% if ansible_os_family == "Debian" -%}
# DPKG / APT-GET (Debian/Ubuntu)
-w /usr/bin/dpkg -p x -k T1072_7
-w /usr/bin/apt-add-repository -p x -k T1072_8
-w /usr/bin/apt-get -p x -k T1072_9
-w /usr/bin/aptitude -p x -k T1072_10
-e 2
{% endif -%}
