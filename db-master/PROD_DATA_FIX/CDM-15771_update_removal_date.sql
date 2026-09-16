/*
    CDM-15771
    Removal date to be updated as per user request in Child removal, OOH, Placement
*/

UPDATE intakeservreqchildremoval 
SET removaldate = '2021-08-02 00:00:00',  
	removaltime = '2021-08-02 11:43:00',
	updatedby = 'CDM-15771',
	updatedon = now() 
WHERE intakeservreqchildremovalid = 'cc9b2e04-6333-488f-9607-9914d7ddf6db';

UPDATE personprogramarea 
SET startdate = '2021-08-02 00:00:00', 
	updatedby = 'CDM-15771', 
	updatedon = now() 
WHERE personprogramid = 'e84adccd-2ed6-4cc7-8700-81aa5a926695';
	
UPDATE livingarrangement 
SET livingstartdate = '2021-08-02 00:00:00', updatedon = now(), updatedby = 'CDM-15771' 
WHERE placementid = '3d774cb4-04b3-459b-b755-3bfd1a1a42d4';

UPDATE placement 
SET startdatetime = '2021-08-02 00:00:00', 
	updatedon = now(), 
	updatedby = 'CDM-15771' 
WHERE placementid = '3d774cb4-04b3-459b-b755-3bfd1a1a42d4';
