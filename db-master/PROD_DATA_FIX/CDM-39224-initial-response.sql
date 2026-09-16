/*
   Issue Description:231020552987:This child, 201253748, was added to the case after the intake. 
                     The worker chose "no" for the answer to the question if they were in the home 
                     at the time of the referral. The answer should have been "yes", but we are not able to change it. 
                     This is causing the response timer to not stop because that child is the only alleged victim
   Category/ Module  :  Person
   Root cause: User want to change yes for "Was this child an active member of the household at the start of the case but not included on the referral?*"
   Fix Provided: Data fix has been promoted to update  Was this child an active member of the household at the start of the case but not included on the referral? to yes" 
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
*/


update personrole set initialresponse=1,updatedby='CDM-39224',updatedon=now() where personroleid='c8bfda0a-3308-4000-8adb-2086424e80b2';

select * 
from cjams.cpsresponsetimerupdate( '62ebae92-3002-4a3e-90d2-e1df2b0d7c7e'::uuid, 'CDM-39224'::character varying ) ;