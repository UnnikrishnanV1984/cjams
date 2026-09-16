/*
-- CDM-23028 - 

-- Issue Description: 
 There is a service case with no information on my dashboard that I would like removed, if possible. 
 I believe I accidentally entered "new service case" and discovered an existing one when I case connected to an IR.
  
-- Customer Email ID:markeeta.dixon@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# 4934
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

---service case delete
update servicecase set activeflag = 0, updatedon = now(), updatedby = 'CDM-23028' 
   where servicecaseid = '024545b5-d26e-4d79-bd2b-25a145814cdd';

---servicecase Disposition removal
update servicecasedisposition set activeflag = 0, updatedby = 'CDM-23028', updatedon = now() 
where servicecaseid = '024545b5-d26e-4d79-bd2b-25a145814cdd';

---caseassignment removal
update caseassignment set activeflag = 0, updatedby = 'CDM-23028', updatedon = now() 
where objectid = '024545b5-d26e-4d79-bd2b-25a145814cdd' and activeflag = 1 ;

--routing removal
update routing set activeflag = 0, updatedby = 'CDM-23028', updatedon = now() 
where objectid = '024545b5-d26e-4d79-bd2b-25a145814cdd';

