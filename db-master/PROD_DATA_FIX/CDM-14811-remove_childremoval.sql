/*
	Issue Description: CDM-14811
	Category/ Module  :  Child removal and program assignment
	Root cause: user requeseted to remove child removal and update OOH start date
	Old Program Assignment Start Date: 2017-06-20 00:00:00
*/ 

UPDATE intakeservreqchildremoval 
SET 
	updatedby = 'CDM-14811', 
	updatedon = now(), 
	activeflag = 0
WHERE intakeservreqchildremovalid = 'd101b64a-334b-4ecf-af7d-89e49be430c9' AND activeflag=1;

UPDATE personprogramarea 
SET startdate = '2017-06-19 00:00:00', 
	updatedby = 'CDM-14811', 
	updatedon = now() 
WHERE personprogramid = '0cb135c6-bafc-4242-b4fa-de198af9b3f4';