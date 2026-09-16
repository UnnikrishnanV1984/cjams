/*
-- CDM-25948 - 

-- Issue Description: 
 This case has been closed since 9/30/21 but still appearing on my validation. This youth has aged out since 9/30/21. 
 I would like for it to be removed from the validation page.
  
-- Customer Email ID:

-- Root cause: Data fix updated the activeflag to 0
-- Pull request# 4934
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/


update tb_placement_validation set delete_sw = 'Y', update_user_id = 'CDM-25948', update_ts = now()  
where placement_validation_id in ('1977763', '1977762');