/*
 Issue Description: CJAMS-65243 Remove case connection and Delete service case
 Category/ Module  : Placement
 Root cause: User error - Adoption and foster case conneted
 fix: Datafix has been added to remove the service case from cps case.
 Pull request# for code fix: 
 Reason why no related code fix: 

 */


update servicecase 
set activeflag = 0, updatedby = 'CJAMS-65243', updatedon = now()
where servicecaseid in ('455ccea6-0f62-44e6-8a36-c2d0b5a05ddd',
'd37585e3-32e8-450f-a343-74f5d0d1a570',
'18f4e545-d097-4965-869e-514ed83438e8',
'8032172d-ff5c-4380-9385-17f840dcff20') and activeflag = 1;


update servicecasedisposition 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-65243' 
where servicecaseid in ('455ccea6-0f62-44e6-8a36-c2d0b5a05ddd',
'd37585e3-32e8-450f-a343-74f5d0d1a570',
'18f4e545-d097-4965-869e-514ed83438e8',
'8032172d-ff5c-4380-9385-17f840dcff20') and activeflag = 1;


update routing 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-65243' 
where objectid  in ('455ccea6-0f62-44e6-8a36-c2d0b5a05ddd',
'd37585e3-32e8-450f-a343-74f5d0d1a570',
'18f4e545-d097-4965-869e-514ed83438e8',
'8032172d-ff5c-4380-9385-17f840dcff20') and activeflag = 1;

