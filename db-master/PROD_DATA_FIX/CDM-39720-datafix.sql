/*
  Issue Description:  CDM-39720
   Category/ Module  :  Application
   Root cause: user requested to remove Checked SEN box
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/


UPDATE intakesnapshot 
SET updatedby  ='CDM-39720',
updatedon =now() ,
jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
 WHERE intakenumber = 'I241012600182' AND activeflag = 1;


 UPDATE intakedastaging 
SET updatedby  ='CDM-39720',
updatedon =now() ,
jsondata = replace(jsondata::text, '"isnegrh_exposednewborn": true', '"isnegrh_exposednewborn": false')::json
 WHERE intakenumber = 'I241012600182' AND activeflag = 1;

update intakeservicerequestsdm 
set drugexposednewbornflag=0,
updatedby = 'CDM-39720', 
updatedon = now()
where intakeserviceid='ea625c40-bcb1-4ca3-b22b-633e8b2bc798' and activeflag =1;


update person
set substanceexposednewbornflag = NULL,  -- 1
	substanceexposednewbornsourcetypekey = NULL, -- '2954'
	substanceexposednewbornsourceid = NULL, -- 'I241012574793'
	substanceexposednewborntimetamp = NULL, -- '2024-06-17 17:23:03'
	substanceclasses = NULL, -- '["BBS"]'
--	othersubstances = NULL, -- NULL
	senstatusflag = NULL, -- 1
	updatedby = 'CDM-39720', 
	updatedon = now()
where cjamspid = 203355199
	and activeflag = 1;
