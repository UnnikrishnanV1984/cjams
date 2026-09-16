/*
   Issue Description: CDM-30430
   Category/ Module  : delete child removal and  Remove Child Removal end date
   Root cause: 
   Pull request# for code fix: 
   Status of the code fix if already submitted and expected prod fix date: Need to do data fix
*/


UPDATE intakeservreqchildremoval 
SET activeflag = 0
	, updatedby ='CDM-30430'
	, updatedon = now()
WHERE intakeservreqchildremovalid = '604e7dc6-29cd-45e9-9c00-cbb47b5a2a5f';

UPDATE tb_client_eligibility 
SET delete_sw = 'Y'
	, update_user_id = 'CDM-30430'
	, update_ts = now()
WHERE removal_id ='264982';

UPDATE personprogramarea 
SET activeflag = 0
	, updatedby ='CDM-30430'
	, updatedon = now() 
WHERE personprogramid  ='c7b6cb75-f2d9-4a50-97d7-35b322db2633';


------------------------------------------------------------------

update
    intakeservreqchildremoval
set
    exitdate = Null,
    updatedby = 'CDM-30430',
    updatedon = now()
where
    intakeservreqchildremovalid = '9e99e465-08dd-4925-8945-989f5582958d';


update
   tb_client_eligibility
set
   end_dt = null,
   update_user_id = 'CDM-30430',
   update_ts = now()
where
   removal_id = '254415';

update
   personprogramarea
set
   enddate = null,
   updatedby = 'CDM-30430',
   updatedon = now()
where
   personprogramid = 'badfb5b8-5bca-4ea5-bb33-7d291b323233';


update
    placement
set
    intakeservreqchildremovalid = '9e99e465-08dd-4925-8945-989f5582958d',
    updatedby = 'CDM-30430',
    updatedon = now()
where
    intakeservreqchildremovalid = '604e7dc6-29cd-45e9-9c00-cbb47b5a2a5f'
    and placementid in ('ecb6acf5-0919-4457-b081-c77f2d743476',
'c527e8ad-fceb-46ca-886b-b4deafb90773',
'1f82b789-0aa4-46f9-a9b1-dc0186b77a23');
  