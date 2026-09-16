/*
   Issue Description: CDM-27434
   Category/ Module  : Service Log
   Root cause: user role is not selecting
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/


update
    rolemapping
set
    activeflag = 0,
    updatedby = 'CDM-27434',
    updatedon = now()
where
    principalid = '9893'
    and activeflag = 1
    and roleid = 5987;


update
    rolemapping
set
    activeflag = 1,
    updatedby = 'CDM-27434',
    updatedon = now()
where
    principalid = '9893'
    and id = 106245507
    and roleid = 71;


update
    teammember
set
    roletypekey = 'CWCW',
    updatedby = 'CDM-27434',
    updatedon = now()
where
    teammemberid = '99119dda-1aa7-4ed3-ac99-b05559a8e195';