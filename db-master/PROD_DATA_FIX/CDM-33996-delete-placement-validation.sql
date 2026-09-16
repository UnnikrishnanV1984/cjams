/*
   Issue Description: CDM-33996
   Category/ Module  : placement validations
   Root cause: user wants to remove incorrect placement validations
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */
  Update cjams.tb_placement_validation 
set delete_sw = 'Y',
    comment_tx = 'This record was removed as per the user''s request as itis wrong entry',
    update_ts = now(),
    update_user_id = 'CDM-33996'
where placement_validation_id = 2076467
    and delete_sw = 'N';