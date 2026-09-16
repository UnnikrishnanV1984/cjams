/*
   Issue Description: CDM-44189
   Category/ Module  : Prod data fix to remove change county.
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


--change county to Howard
update intakedastaging 
set jsondata = replace (jsondata::text,  '"countyid": "7665ca54-5374-4174-be07-a687b811a82c"', '"countyid": "bbce9638-24f9-4336-993c-007f6755c980"' )::jsonb,
    updatedby = 'CDM-44189', 
    updatedon = now()
where intakenumber = 'I251013217594' and activeflag = 1;

update intaketransfers
set receivingcountyworker = 'b9eddd96-fe57-4ef2-809e-9ca1a00b9c94', 
    updatedon = now(),
    updatedby ='CDM-44189'
where intaketransferid ='74489ef5-b828-4be4-af7c-dbca2ba5d4d0' and activeflag = 1;
