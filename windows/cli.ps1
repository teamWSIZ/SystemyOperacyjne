$un = newUser
$passwd = passwd

net user $un           # full user info:

# add user:
net user $un $passwd /add
# options
net user $un /logonpasswordchg:no /passwordchg:no

net user $un $newpasswd
net users
net user $un /fullname:"Xiao Wo"


#Groups
# add group:
net localgroup ggg /add
#add user to group:
net localgroup ggg <username> /add
# add comment of group:
net localgroup ggg /comment:"Some comment"
# list groups:
net localgroup 
# list users in group:
net localgroup $groupname


#run program as different user: 
runas /user:tttuuu $programname

#
#whoami

# Folder access rights cli:
#icacls ... /grant:r ...


