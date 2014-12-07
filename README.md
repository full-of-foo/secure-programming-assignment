secure-programming
==================


http://magazine.redhat.com/2007/08/21/a-step-by-step-guide-to-building-a-new-selinux-policy-module/

Usefull Link

http://insecure.org/stf/smashstack.html


proceedure like below to get the shell code?

http://insecure.org/stf/smashstack.html


more detailed

http://wwwtenouk.com/Bufferoverflowc/Bufferoverflow5.html


Selinux Policy Module
*********************

Need to be Root User

To check what SELinux packages are installed 

#rpm -qa | grep selinux

libselinux-utils-2.0.94-5.8.el6.i686
libselinux-2.0.94-5.8.el6.i686
selinux-policy-targeted-3.7.19-260.el6.noarch
libselinux-python-2.0.94-5.8.el6.i686
selinux-policy-3.7.19-260.el6.noarch

Checking SELinux Modes and Status

#getenforce

Enforcing


#sestatus

SELinux status:                 enabled
SELinuxfs mount:                /selinux
Current mode:                   enforcing
Mode from config file:          enforcing
Policy version:                 24
Policy from config file:        targeted


# cat /etc/sysconfig/selinux

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#	enforcing - SELinux security policy is enforced.
#	permissive - SELinux prints warnings instead of enforcing.
#	disabled - SELinux is fully disabled.
     SELINUX=enforcing
# SELINUXTYPE= type of policy in use. Possible values are:
#	targeted - Only targeted network daemons are protected.
#	strict - Full SELinux protection.
SELINUXTYPE=targeted

The SELINUXTYPE directive determines the policy that will be used. The default value is targeted. With a targeted policy, SELinux allows you to customize and fine tune access control permissions. 

check Policys in memory

semodule -l | less


