/*
  Issue Description: CDM-24470 Missing worker
   Category/ Module  :  user management
   Root cause: Incorrect role in the DB, the user was having Case Management Supervisor,CW instead of Case Worker,CW
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 0
*/

update userresource
set activeflag =0 , updatedon = now(), updatedby = 'CDM-24470'
where userresourceid = '4b8dc273-9450-4018-9fe2-e86c107e402c' and userid = 13318 and activeflag=1;

--old role : 136
update rolemapping 
set roleid=71 , updatedon = now(), updatedby = 'CDM-24470'
where id =96401627 and roleid = 136 and activeflag=1;

-- old roletypekey :CWCMSV
update teammember 
set roletypekey = 'CWCW' ,updatedon = now(), updatedby = 'CDM-24470'
where teammemberid = '6369046a-c122-4036-a976-a71f852ebe2b';