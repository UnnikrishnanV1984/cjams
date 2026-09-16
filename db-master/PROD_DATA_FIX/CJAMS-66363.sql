/*
   Issue Description: CJAMS-66363 - Updated the provider middle name and lastname to displayed on pdf
   Category/ Module  :PDF
   Root cause: In Purchase Authorization Print (Funding Request Form), Last Name is not getting printed against Provider Name.  
   Fix Provided : Data fix has been provided by updating the middle name and last name
   Pull request# for code fix:  N/A
   Reason why no related code fix: N/A
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update tb_slpa_snapshot 
set provider_name ='Chanel Joyner', update_ts=now(), update_user_id='CJAMS-66363'
where authorization_id ='4258987' and  provider_name ='Chanel';