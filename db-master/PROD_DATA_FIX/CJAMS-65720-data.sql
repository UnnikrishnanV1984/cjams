/*
-- Issue Description: 
	I261013890976:Requested to remove savannah allen   from case.
   


-- Category/ Module: Persons
-- Root cause: Requested to remove savannah allen   from case 
-- Resolution: Removed a person from the persons other tab by setting active flag to 0.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/



update intakeservicerequestactor set activeflag = 0, updatedby = 'CJAMS-65720', updatedon = now() 
where personid in ('369d44c5-7c59-43d3-b2de-5725d35ba413','71129d11-45ad-415a-bc44-1681acb0cc7a','8fa0778c-35fe-4a24-86b2-674ed905c4e1','953cb96b-96db-4c7d-b56f-7b716b0667a4') and activeflag = 1;

update actor set activeflag = 0, updatedby = 'CJAMS-65720', updatedon = now() 
where  personid in ('369d44c5-7c59-43d3-b2de-5725d35ba413','71129d11-45ad-415a-bc44-1681acb0cc7a','8fa0778c-35fe-4a24-86b2-674ed905c4e1','953cb96b-96db-4c7d-b56f-7b716b0667a4') and activeflag = 1;

update personrole set activeflag = 0, updatedby = 'CJAMS-65720', updatedon = now() 
where  personid in ('369d44c5-7c59-43d3-b2de-5725d35ba413','71129d11-45ad-415a-bc44-1681acb0cc7a','8fa0778c-35fe-4a24-86b2-674ed905c4e1','953cb96b-96db-4c7d-b56f-7b716b0667a4') and activeflag = 1;

update personroletype set activeflag = 0, updatedby = 'CJAMS-65720', updatedon = now()
where personroletypeid in ('95585b72-1540-49f2-ab69-c1608b8f27fc',
'9c01f230-4a40-451e-b95a-218af4f5d5cd',
'd8506181-6b6a-417b-ab56-39ef73944904',
'1506e290-dea3-4052-8af0-2469375b0169')
and activeflag = 1;