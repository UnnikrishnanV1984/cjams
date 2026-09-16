
/*
   Issue Description: CDM-32302
   Category/ Module  :Investigation Findings
   Root cause:Missing investigationfindings and comar sections
   Pull request# for code fix: 
   Reason why no related code fix: 
   requested a data fix to resolve:
*/
update investigationfinding set activeflag =1,updatedby ='CDM-32302',updatedon =now()
where investigationfindingid 
    in (    '4ed9ba06-ed0f-4c27-9f92-90089206f943',
            '44368e92-d055-4f2a-83bc-c3d743517a8c',
            '049fdccb-3cc5-430a-a884-96f2fb24d866',
            '4206a93a-3b53-4660-a833-2cac5eb67bbd'
        )
    and activeflag = 0 
;