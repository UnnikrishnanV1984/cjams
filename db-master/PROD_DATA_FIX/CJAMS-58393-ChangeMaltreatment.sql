/*
Issue Description:241022073173:The maltreatment needs to be changed to Unsubstantiated Neglect per OAH's order
Category/Module: User Error
Root cause: User request modify the finding from unsubstantiated sexual abuse to unsubstantiated child neglect.
Fix provided: DB query to insert missing intakeservicerequestsdm into the note
Data/Code fix ticket#: CJAMS-58393
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
select * from servicerequesttypeconfigdispositioncode where intakeserreqstatustypeid =  '7995cecb-062d-406c-8ea9-b1da4b1877d8';
delete from intakeservicerequestsdm where  updatedby  = 'CJAMS-58393';
delete  from investigationfinding i   where updatedby  = 'CJAMS-58393';
delete from intakeservicerequestactor i where updatedby = 'CJAMS-58393';
delete from investigationallegation where   updatedby = 'CJAMS-58393';
*/

insert into intakeservicerequestsdm (intakeservicerequestsdmid, 	intakeserviceid, 	ismaltreatment, 	referraldob, 	
ismalpa_insjury, 	ismalpa_childtoxic, 	ismalpa_caregiver, 	isnegab_abandoned, 	ismenab_psycologicalability, 
ismenng_psycologicalability, 	isrecsc_screenout, 	isrecsc_scrrenin, 	officerfirstname, 	officerlastname, 	badgenumber, 
recordnumber, 	activeflag, 	updatedby, 	updatedon, 	insertedby, 	insertedon, 	effectivedate, 	issexualabuse, 	isoutofhome, 
isdeathorserious, 	isrisk, 	isreportmeets, 	issignordiagonises, 	isar, 	isir, 	isnoimmed_physicalabuse, 	isnoimmed_sexualabuse, 
isnoimmed_neglectresponse, 	isnoimmed_mentalinjury, 	isfinalscreenin, 	intakenumber, 	comments, 	status, 	isfcplacementsetting, 	
isprivateplacement, 	islicenseddaycare, 	isschool, 	ischildfatality, 	lawenfmtactiveflag, 	duplicatereportflag, 	screeningactiveflag, 
isnoimmed_risk_harm, 	isnegrh_treatmenthealthrisk, 	isfclivingarrangement, 	confirmtrafficking 	)
 values( gen_random_uuid(), '26dcfaf6-27f7-4f71-9063-31adf6e54925', true, '2025-04-16 00:00:00.000', false, false, false, false, false, 
false, false, false, 'Officer', 'Lizama', '1047/K496', '250404795', 1, 'CJAMS-58393', '2025-06-16 12:59:19.925', 
'7f6bd981-7fba-430a-a290-c4fabe0c1f93', '2025-06-16 12:59:19.925', '2025-06-16 12:59:19.925', false, true, false, true, false, false, false, true,
false, false, true, false, true, 'I241012241262', 'New Version created as per the CJAMS Ticket S2025076065348', 16, false, false, false, true, false,	 1,	 0, 1, false, true, false,	 'NO' 	);
  
update investigationallegation
set allegationid  = 'e11fc4b5-1edf-4f17-af54-b536bbf6df31', updatedby  = 'CJAMS-58393', updatedon  = now()
where investigationallegationid  in ('0255df06-8c6d-4f91-8a13-10e998efe2b8','1f03ed71-61dc-400c-bfd6-24f3b859adda') and activeflag =1;


  