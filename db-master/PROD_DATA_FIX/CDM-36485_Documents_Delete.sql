/*
   Issue Description: CDM-36485
   Category/ Module  : Documents 
   Root cause: User wants delete documents failed to upload. Total documents top be deleted: 130
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select distinct da.*
	FROM documentproperties dp 
		JOIN documentattachment da on da.documentpropertiesid = dp.documentpropertiesid and dp.activeflag=2
	WHERE dp.activeflag=2 
		and dp.servicecaseid='5ae34a24-5641-462b-a802-efc7e518dc21'; 
		
UPDATE documentattachment
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36485'
	WHERE documentattachmentid IN (select da.documentattachmentid
										FROM documentproperties dp 
											JOIN documentattachment da on da.documentpropertiesid = dp.documentpropertiesid and dp.activeflag=2
										WHERE dp.activeflag=2 
											and dp.servicecaseid ='5ae34a24-5641-462b-a802-efc7e518dc21');

select distinct dp.*
	FROM documentproperties dp 
	WHERE dp.activeflag=2 
		and dp.servicecaseid='5ae34a24-5641-462b-a802-efc7e518dc21'; 

		
UPDATE documentproperties
	SET activeflag = 0,
		updatedon = now(),
		updatedby = 'CDM-36485'
	WHERE documentpropertiesid IN (select documentpropertiesid
										FROM documentproperties dp 
										WHERE dp.activeflag=2 
											and dp.servicecaseid ='5ae34a24-5641-462b-a802-efc7e518dc21');											