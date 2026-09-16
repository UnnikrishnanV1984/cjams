/*
   Issue Description: CDM-17101
   Category/ Module  : open service case
   Root cause: user wants to remove
   Pull request# for code fix: 
  explanantion:  user asked tp remove the clid removal record
*/


 UPDATE servicecase 
	SET statustypekey = 'Open', dispositioncode = 'Open',  enddate = null,  updatedby = 'CDM-17101', updatedon = now() 
	WHERE servicecaseid = '15f141a9-511d-4371-9658-c648b7ea9ea9';

	UPDATE servicecasedisposition 
	SET activeflag = 0,  updatedby = 'CDM-17101', updatedon = now() 
	WHERE servicecasedispositionid = 'ed6c502c-9a37-4ab7-9f5a-ddd95b68787b';