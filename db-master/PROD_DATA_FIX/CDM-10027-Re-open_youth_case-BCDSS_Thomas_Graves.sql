update intakeservreqchildremoval  set exitdate = null, removaldate = '2008-10-08 00:00:00', returntime = '2008-10-08 00:00:00', updatedby = 'CDM-10027', updatedon = now()  where intakeservreqchildremovalid ='c639324f-0611-4f4c-85e7-614a99510829' and intakeservicerequestactorid = '4b043f9a-fb78-41f9-8852-8b7503a11394';
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-10027', updatedon = now()  where servicecaseid = 'f65b553a-190d-476b-90e0-edb29e563b9f' and servicecasedispositionid = 'e0a253a7-cd2a-4ba9-8f7b-056b4c49cfc3';
update servicecase set statustypekey ='Open', dispositioncode = 'Open', enddate = null, updatedby = 'CDM-10027', updatedon = now() WHERE servicecaseid = 'f65b553a-190d-476b-90e0-edb29e563b9f' and servicecasenumber = '3166609';

-- new updated script to remove end on the Program Assignments
update personprogramarea set enddate = null, updatedby = 'CDM-10027', updatedon = now () where personprogramid ='dda728c7-067c-49a1-84c3-2db9148dfe5f';
