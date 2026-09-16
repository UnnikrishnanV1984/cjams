/*
-- Issue Description:
-- Category/ Module: Investigation Finding   
-- Root cause:  User request to Remove duplicated system error Investigation findings
Reviewed in Production / persons, we only have one Alleged Maltreater and one Victim need to investigate on the duplication of Investigation Findings
--Fix provided: data fix has been done to remove the additional investigation findings
--Is code fix required: 
-- Pull request :
-- Reason why no related code fix: Issue is not replicable in stage3, code fix ticket has been raised 
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update investigationallegation 
set activeflag =0, updatedby ='CJAMS-67239', updatedon =now() 
where investigationallegationid ='7bdef37d-0bff-4144-95cc-b8e7f8b6aaee' and activeflag =1;

update investigationallegationmaltreators 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67239' 
where investigationallegationid in ('7bdef37d-0bff-4144-95cc-b8e7f8b6aaee') and activeflag = 1;


update investigationallegation 
set activeflag =0, updatedby ='CJAMS-67239', updatedon =now() 
where investigationallegationid ='29d74095-a4ec-4c17-b898-1c65eef6f94c' and activeflag =1;

update investigationallegationmaltreators 
set activeflag = 0, updatedon = now(), updatedby = 'CJAMS-67239' 
where investigationallegationid in ('29d74095-a4ec-4c17-b898-1c65eef6f94c') and activeflag = 1;


