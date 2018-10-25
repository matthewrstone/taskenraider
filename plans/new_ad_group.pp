plan taskenraider::new_ad_group(
  TargetSpec $server,
  String $group,
  Enum['Distribution', 'Security'] $category,
  Enum['Global', 'DomainLocal' , 'Universal'] $scope,
  String $members,
) {
  $group_add = run_task('taskenraider::adgroup', $server,
    action   => add,
    group    => $group,
    category => $category,
    scope    => $scope 
  )
  $member_add = run_task('taskenraider::adgroupmember', $server,
    action  => add,
    group   => $group,
    members => $members
  )
  return $member_add
}
