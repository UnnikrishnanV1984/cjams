/*
   Issue Description: CDM-37143
   Category/ Module  : Documents 
   Root cause: User wants delete duplicate documents from pending upload. Total documents top be deleted: 148
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select distinct da.*
	FROM documentproperties dp 
		JOIN documentattachment da on da.documentpropertiesid = dp.documentpropertiesid and dp.activeflag=2
	WHERE dp.activeflag=2 
		and dp.servicecaseid='59326320-3c37-474e-98fe-dc415f8adbf0'; 
		
UPDATE documentattachment
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37143'
	WHERE documentattachmentid IN (select da.documentattachmentid
										FROM documentproperties dp 
											JOIN documentattachment da on da.documentpropertiesid = dp.documentpropertiesid and dp.activeflag=2
										WHERE dp.activeflag=2 
											and dp.servicecaseid ='59326320-3c37-474e-98fe-dc415f8adbf0');

select distinct dp.*
	FROM documentproperties dp 
	WHERE dp.activeflag=2 
		and dp.servicecaseid='59326320-3c37-474e-98fe-dc415f8adbf0'; 

		
UPDATE documentproperties
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-37143'
	WHERE documentpropertiesid IN (select documentpropertiesid
										FROM documentproperties dp 
										WHERE dp.activeflag=2 
											and dp.servicecaseid ='59326320-3c37-474e-98fe-dc415f8adbf0');		