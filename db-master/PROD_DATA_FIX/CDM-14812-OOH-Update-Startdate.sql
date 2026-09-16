
/*
-- CDM-14812 - 

-- Issue Description: 
 Update OOH start Date
  
-- Customer Email ID:teresa.boston@maryland.gov

-- Root cause: Data fix to updated the end date
-- Pull request# 5083
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update personprogramarea set startdate = '2020-07-21 00:00:00', updatedby = 'CDM-14812', updatedon = now() 
where personprogramid = '993ceffd-7f71-4f7c-9ab1-eb9c3147c0a8'; 
