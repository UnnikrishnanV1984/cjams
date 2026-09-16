/*
   Issue Description: CDM-25890
   Category/ Module  : placement validations
   Root cause: user wants to remove incorrect placement validations
   Pull request# for code fix: 7639
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
  Need to do data fix
  */

Update cjams.tb_placement_validation 
set delete_sw = 'Y',
    comment_tx = 'This record was removed as per the user''s request as these placement vlaidations erroneously transferred from Chessie to CJAMS',
    update_ts = now(),
    update_user_id = 'CDM-25890'
where placement_validation_id in ( 706978,713574,713576,641318,647884)
    and delete_sw = 'N';