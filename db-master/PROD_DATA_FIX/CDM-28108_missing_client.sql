/*
   Issue Description: CDM-28108
   Category/ Module : Missing client
*/

update actor  
set activeflag = 1, updatedon = now(),  updatedby = 'CDM-28108'
where actorid = '23d04477-a46b-49ba-af2f-09ad89da9dd3';

update intakeservreqchildremoval
set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', updatedon = now(),  updatedby = 'CDM-28108'
where removalid = 253418 and activeflag = 1 ;

update tb_client_eligibility	
set case_id = 3293269, update_user_id = 'CDM-28108', update_ts = now()
where removal_id = 253418 and delete_sw = 'N';	

-- Program Assignment
update personprogramarea
set objectid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', entityid = '3293269', updatedon = now(),  updatedby = 'CDM-28108'	
where personprogramid = '007d8ef6-6ad2-4561-a1d8-f24e77646466' ;
