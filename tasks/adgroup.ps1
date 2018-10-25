Param(
    $action,
    $group,
    $scope,
    $category
)


function GetADGroup(){
    $g = Get-ADGroup -Filter { name -eq $Group }

    return @{
        Name = $g.Name
        DistinguishedName = $g.DistinguishedName
    } | ConvertTo-Json    
}

function AddADGroup(){
    New-ADGroup -Name $group -GroupCategory $category -GroupScope $scope
        $g = Get-ADGroup -Filter { name -eq $group }

        return @{
            Name = $g.Name
            DistinguishedName = $g.DistinguishedName
        } | ConvertTo-Json
}

switch ($action) {
    "add" { AddADGroup }
    "get" { GetADGroup }
    default { Write-Output 'You are a eaten by a grue.'} 
}