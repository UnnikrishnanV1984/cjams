/*
   Issue Description: CDM_25012
   Category/ Module  : Prod data fix to case connect issue fix
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/



--c6761e3e-2372-47e5-b069-ac7eabbd9b43
update intakeservicerequestpetition set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', updatedby = 'CDM-25012',updatedon = now()
where intakeservicerequestpetitionid  in ('8e419cba-2389-48a1-910f-1ec36368466f',
'f4b65905-449d-4535-a978-f9e9932d10c9', '1b0ea2b1-d446-4134-9650-3e5363f2e3ce');


--c6761e3e-2372-47e5-b069-ac7eabbd9b43
update intakeservicerequestcourthearing set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', updatedby = 'CDM-25012',updatedon = now()
where intakeservicerequestpetitionid  in ('8e419cba-2389-48a1-910f-1ec36368466f',
'f4b65905-449d-4535-a978-f9e9932d10c9') and activeflag = 1;


-- CANS OUT OF HOME PLACMENT
update assessment set objectid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
updatedby = 'CDM-25012', updatedon = '2022-02-08 11:05:56.000', objectname = 'servicecase'
where assessmentid in ('0129d598-6767-42fc-8561-2f5ee5b5102c') 
and objectid = 'c6761e3e-2372-47e5-b069-ac7eabbd9b43';

-- SAFEC OHP
update assessment set objectid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
updatedby = 'CDM-25012', updatedon = '2022-01-28 14:56:31.000', objectname = 'servicecase'
where assessmentid in ('a2540160-8373-4680-b5ae-192783d55f11') 
and objectid = 'c6761e3e-2372-47e5-b069-ac7eabbd9b43';


-- Moving the Contact Notes
-- 5eb3ee86-72e3-4ace-8b13-00a60c2388d1
update progressnote set entitytypeid  = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c', updatedby = 'CDM-25012',updatedon = now()
where entitytypeid  = '5eb3ee86-72e3-4ace-8b13-00a60c2388d1'
and intakeserviceid = '5eb3ee86-72e3-4ace-8b13-00a60c2388d1'
and activeflag = 1; 


-- Reverting CDM-22664
UPDATE servicecase 
SET statustypekey ='Closed', dispositioncode = 'Closed', enddate = '2021-11-30 00:00:00', updatedby = 'CDM-25012',updatedon = now() 
WHERE servicecaseid = 'c6761e3e-2372-47e5-b069-ac7eabbd9b43';

update servicecasedisposition set activeflag = 0 , updatedon = now(), updatedby = 'CDM-25012' 
where servicecasedispositionid = 'fc6bfa84-3d89-41a4-b7c7-1432b08c9bd5';

update routing set activeflag = 0, updatedon = now(), updatedby = 'CDM-25012' 
where objectid = 'fc6bfa84-3d89-41a4-b7c7-1432b08c9bd5';


--2018-10-09 09:20:58.000
update servicecase set insertedon = '2021-11-02 13:33:27.825', updatedon = now(), updatedby = 'CDM_25012' 
where servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c';


-- Removal FIxes
update intakeservreqchildremoval set activeflag = 0 , updatedby = 'CDM-25012' ,  updatedon = now()  
where intakeservreqchildremovalid = '4a707265-450c-4e03-bbb0-9a5b2f653bf6';

-- c6761e3e-2372-47e5-b069-ac7eabbd9b43
update intakeservreqchildremoval set servicecaseid  = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c' , updatedby = 'CDM-25012' ,  updatedon = now()  
where intakeservreqchildremovalid = '5dd285e6-165f-43cc-b29c-37525ad3c44d';

-- 3122284	c6761e3e-2372-47e5-b069-ac7eabbd9b43
update personprogramarea set entityid = '3293269', objectid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c' , updatedby = 'CDM-25012' ,  updatedon = now()
where personprogramid = '007d8ef6-6ad2-4561-a1d8-f24e77646466';


-- c6761e3e-2372-47e5-b069-ac7eabbd9b43
update placement set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c',
updatedby = 'CDM-25012',  updatedon = now()
where placementid in ('c7e774f5-fa0a-4dc4-8f9a-6123dcfa80b7','a09ff9ff-2d7d-4181-8df9-674c2d3c0632');

-- c6761e3e-2372-47e5-b069-ac7eabbd9b43
update permanencyplan set servicecaseid = 'a61bd6c0-f1d7-429d-b3b6-8bdddf5dd06c' , updatedby = 'CDM-25012' ,  updatedon = now() 
 where permanencyplanid = 'e91880e6-e01b-41d6-9861-ec0278fca1b0' and
servicecaseid =  'c6761e3e-2372-47e5-b069-ac7eabbd9b43';
