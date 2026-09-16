/*
 Issue Description: CDM-40987
-- Category/ Module: Person Profile
-- Root cause: Person role is not able update. Code fix already provided for the same
-- Fix Provided: Datafix has been promoted to update the person role.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update actor 
set servicecaseid = null, updatedon = now(), updatedby ='CDM-40987'
where actorid = 'f0de86fb-4b11-4b1b-99df-11c8f63fcc0e'
	  and servicecaseid ='ad95b162-b310-48b0-aa6a-0e037c0ac25a';
      
