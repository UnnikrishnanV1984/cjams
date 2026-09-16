/*
-- CDM-20472 - 

-- Issue Description: 
 Remove Case from My Intakes Pending Dashboard
  
-- Customer Email ID:anthony.carter@montgomerycountymd.gov

-- Root cause: Data fix updated the toteamid
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- ba7d007f-6f00-43a5-ad02-d82f8e556d68
update caseassignment set toteamid = '6416ae81-d787-494c-9aab-354b3ba128dd', updatedby = 'CDM-20472', updatedon = now() where caseassignmentid = '463d2778-25b2-4b58-9912-f608791d3122';