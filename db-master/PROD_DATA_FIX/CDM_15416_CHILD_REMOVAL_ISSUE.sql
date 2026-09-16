/*
   Issue Description: CDM-15416
   Category/ Module  :Child removal
   Root cause: user wants to change
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   
*/


-- Tyonni L Lewis
update intakeservreqchildremoval 
set exitdate = '2021-04-29 19:27:41', 
	updatedby = 'CDM-15416', 
	updatedon = now() 
where intakeservreqchildremovalid = '24c0a394-e288-4ac0-aa1b-23252ff8e276';

update placement 
set enddatetime = '2021-04-29 00:00:00', updatedon = now(), updatedby = 'CDM-15416' 
where placementid = 'b154bd52-56de-4e7a-a519-9629d7072f96';

update livingarrangement 
set livingenddate = '2021-04-29 00:00:00', updatedon = now(), updatedby = 'CDM-15416' 
where placementid = 'b154bd52-56de-4e7a-a519-9629d7072f96';

update personprogramarea set enddate = '2021-04-29 00:00:00', updatedby = 'CDM-15416', updatedon = now() 
where personprogramid = 'be642c0d-6700-4a9b-97ed-ec178fa10629';

--Khalif Marvin-Jad Farra
-- No need to update the OOH personprogramarea
update intakeservreqchildremoval 
set activeflag = 0, 
	updatedby = 'CDM-15416', 
	updatedon = now() 
where intakeservreqchildremovalid = '24ed0bf3-1ec7-4a65-90b0-9f0d6a5dace5';

