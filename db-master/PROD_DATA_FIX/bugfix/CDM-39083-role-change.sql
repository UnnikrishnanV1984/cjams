/*
  Issue Description:CDM-39083 241022101938:Worker name doesnt come back for assignment- Intake & Assessment #12Ashanti Allenwilliamsashanti.allenwilliams@maryland.gov.
                    Try to assigned her case- 241022101938  
  Category/ Module : User Management
  Root cause: Case worker ashanti.allenwilliams@maryland.gov doesn't have roles for case assignment
  Fix Provided: Data fix has been provided to provide correct roles to the user for case assignment
  Pull request# for code fix: N/A
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: N/A
*/

update rolemapping
set activeflag = 0,
    updatedby = 'CDM-39083',
    updatedon = now()
where principalid = '35077'
and roleid = 125
and activeflag = 1;



update userresource 
set activeflag = 0,
    updatedby = 'CDM-39083',
    updatedon = now()
where userid = 35077
and roleid in(71, 132)and activeflag = 1;


update teammember
set roletypekey = 'CWCW',
    updatedby = 'CDM-39083',
    updatedon = now()
where teammemberid = 'cf4f9792-a7cf-4364-88e4-825601c1642b';


INSERT INTO cjams.rolemapping
(id, principaltype, principalid, roleid, activeflag, insertedby, updatedby, insertedon, updatedon, old_id, teamtypekey)
VALUES(nextval('rolemapping_id_seq'), 'USER', '35077', 71, 1, 'CDM-39083', 'CDM-39083', now(), now(), '', 'CW');
