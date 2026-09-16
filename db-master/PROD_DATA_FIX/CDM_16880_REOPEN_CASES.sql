/*
   Issue Description: CDM-16880
   Category/ Module  :  pending assesment
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

UPDATE servicecase 
	SET statustypekey = 'Open', dispositioncode = 'Open',  enddate = null,  updatedby = 'CDM-16880', updatedon = now() 
	WHERE servicecaseid = '51a53996-dcbc-4d2c-924a-b1935f251d51';

	UPDATE servicecasedisposition 
	SET activeflag = 0,  updatedby = 'CDM-16880', updatedon = now() 
	WHERE servicecasedispositionid = 'bbe0c300-7477-4293-b804-b7e08f87a936';