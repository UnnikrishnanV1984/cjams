/*
-- CDM-21464 - 

-- Issue Description: Incorrect placement enddate
  
-- Root cause: Data fix
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update Intakeservreqchildremoval set exitdate = '2022-02-01T00:00:00',
updatedby = 'CDM-21464', updatedon = now()
where removalid = 180860;
