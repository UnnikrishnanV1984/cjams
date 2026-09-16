/*
   Issue Description: CDM-19006
   Category/ Module  : Data fix for Missing Removal Information
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update intakeservreqchildremoval set servicecaseid = '2965649f-093e-4ccb-9fb2-f0f2c8828224', updatedby = 'CDM-19006', updatedon = now() where intakeservreqchildremovalid = 'c32db41e-187b-4c43-8822-7b8bb7b61bf1';