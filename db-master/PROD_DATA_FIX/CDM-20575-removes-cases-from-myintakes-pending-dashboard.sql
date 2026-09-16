/*
-- CDM-20575 - 

-- Issue Description: 
 Remove Cases from My Intakes Pending Dashboard
  
-- Customer Email ID:candi.bennett@maryland.gov

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update intakedastaging set status = 'Complete', updatedby = 'CDM-20575', updatedon = now() where intakenumber in ('CW2468673','CW10248135') and activeflag = 1