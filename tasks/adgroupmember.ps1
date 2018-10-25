# Import the data from STDIN
$data            = [Console]::In.ReadLine() | ConvertFrom-Json
$action          = $data.action
$group           = $data.group
$members         = $data.members.Split()
$groupObject     = Get-ADGroup -Filter { Name -eq $group }

function AddAdGroupMember(){
    foreach ($member in $members) { 
        Write-Output "Adding ${member}..."
        $groupObject | Add-ADGroupMember -Members $member 
    }
    return GetAdGroupMember
}
function GetAdGroupMember(){
    $userList = @()
    $users = Get-AdGroup -Filter { Name -eq $group } | Get-ADGroupMember 
    foreach ($user in $users) {
        $userList += $user.Name
    }
    return @{
        "group"   = $group
        "members" = $userList
    } | ConvertTo-Json

}


# Remove a group member.
function RemoveAdGroupMember(){
    foreach ($member in $members) {
        Write-Output "Removing ${member}..."
        $groupObject | Remove-ADGroupMember -Members $member -Confirm:$false
    }
    return GetAdGroupMember
}

switch ($action) {
    "add" {AddAdGroupMember}
    "get" {GetAdGroupMember}
    "remove" {RemoveAdGroupMember}
    default { Write-Output "You are eaten by a grue." }
}