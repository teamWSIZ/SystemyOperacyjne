
###########################
# Batch user creation script
#
###########################

###########################
# Variables
###########################
$userPrefix = "User"
$range=1..45
$password = ""

###########################
# Functions
###########################
function setupUser {
    $username = $args[0]
    $pass = $args[1]
    net user $username $pass #/add
    net user $username /logonpasswordchg:no /passwordchg:no
    #net localgroup "Remote Desktop Users" $username /add
}


###########################
# Main
###########################

foreach($i in $range) {
    #echo $userPrefix+$i
    setupUser ($userPrefix+$i) $password
}






