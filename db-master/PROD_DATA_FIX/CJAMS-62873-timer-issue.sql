/* 
    Issue Description: CJAMS-62873
   Category/ Module  :Response Timer
   Root cause:This is not a defect. As per system design, the alleged victim must identified as an active member in the household.
   In this case, both alleged Victim are identified as Not an active member of the household at the start of the case but not included on the referral.
    Data fix needed to modify the answer for the below question in the person card for 
    Client ID # 204145575 (JOSEPH H Capwell)
    Client ID # 204145577 (Lukas Rejrat)
      "Was this child an active member of the household at the start of the case but not included on the referral?*" - From No to Yes
   Regression Impact : N/A
   Is Code fix needed : No
   Reason why no related code fix: This is not a defect and as the per the system design. Data fix should resolve it.
*/

-- select initialresponse, * 
--     from personrole 
--     where intakeserviceid = '39928e30-9feb-4ac3-a8bf-408d2fe5ecf7' 
--         and personid in ('0fadbf85-07de-4908-8ed0-9cf3064b9312','352fc61a-0f3f-474d-8d92-5e74c0e0b9e3');

update personrole 
    set initialresponse = 1,
        updatedby='CJAMS-62873',
        updatedon=now() 
    where personroleid in ('dc1c7f2c-608c-42f1-a4d1-73a8c247d9a1','22c6b925-90a7-4ba5-9652-27c29e4ab04e');
    
-- To Stop the timer
-- Before 
-- select responsetimer, responsetimerdetails, updatedby, updatedon 
--     from intakeservicerequest 
-- where servicerequestnumber = '251023143564'
--     and activeflag = 1 ;
    
select * 
from cjams.cpsresponsetimerupdate( '39928e30-9feb-4ac3-a8bf-408d2fe5ecf7'::uuid, 'CJAMS-62873'::character varying ) ;


-- -- After 
-- select responsetimer, responsetimerdetails, updatedby, updatedon 
--     from intakeservicerequest 
-- where servicerequestnumber = '251023143564'
--     and activeflag = 1 ;