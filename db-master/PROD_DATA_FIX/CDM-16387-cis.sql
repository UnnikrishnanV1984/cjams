/*
   Issue Description: CDM-16387
   Category/ Module  : Person  
   Root cause: User requested to update clsclientid 
   Pull request# for code fix: 
   Reason why no related code fix: checked the proc changes everything is good seems to be it's a glitch
*/


-- checked personidentifier table as well with MDM_ID and record is there 

--select personidentifiervalue, * from personidentifier where personid ='a88e2c92-5705-4c66-a05b-ca2dacbe4b58' and personidentifiertypekey='MDM_ID';


update cjams.person set cisclientid='476022924', updatedby='CDM-16387', updatedon = now ()

where cjamspid='1324750' and  personid ='a88e2c92-5705-4c66-a05b-ca2dacbe4b58';
