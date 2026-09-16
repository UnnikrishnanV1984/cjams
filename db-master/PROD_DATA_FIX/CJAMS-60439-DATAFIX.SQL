/*
   Issue Description: CJAMS-60439
         Wrong service case associated with intake
   Category/ Module  :  Wrong service case associated with intake
   Root cause: user wants to do a data fix to delete the service case # 251030530619 associated with intake I251013315147 
    and connect service case # 3291659 for the intake.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/

select * from cjams.createservicecase('fc697240-5ad4-40da-af11-555f56ead5c0', '495005e1-fc57-46d9-ac19-aa03ead6d02a', 0, 'bacaf254-49bb-4df0-9ea1-c23cfd696d2a', '{}');

update servicecase
  set activeflag =0, 
      updatedby = 'CJAMS-60439', 
      updatedon = now() 
where servicecaseid = '2610a25d-6b6d-4ee7-9081-c2685f40eb4f'
  and activeflag = 1;

update servicecasedisposition 
  set activeflag = 0, 
      updatedby = 'CJAMS-60439', 
      updatedon = now() 
where servicecaseid = '2610a25d-6b6d-4ee7-9081-c2685f40eb4f'
  and activeflag = 1;

update caseassignment 
  set activeflag = 0,
      updatedby = 'CJAMS-60439',
      updatedon = now()
where objectid = '2610a25d-6b6d-4ee7-9081-c2685f40eb4f'
  and activeflag = 1;

update routing
 set activeflag = 0,
     updatedby = 'CJAMS-60439',
     updatedon = now()
where objectid = '2610a25d-6b6d-4ee7-9081-c2685f40eb4f'
  and activeflag = 1;

