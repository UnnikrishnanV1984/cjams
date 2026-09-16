/*
-- CDM-21481 - 

-- Issue Description: Incorrect placement enddate
  
-- Root cause: Data fix
-- Pull request#: N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update placement set enddatetime = '2022-02-09T00:00:00', updatedby = 'CDM-21481', updatedon = now()
where placementid = 'fd62424f-aeba-4185-a160-e06d6135c0ab';
