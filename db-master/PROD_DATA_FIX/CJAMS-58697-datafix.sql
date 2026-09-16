/* 
    Issue Description: CJAMS-58697
   Category/ Module  : Timer Still Counting
   Root cause:To modify the answer for the below question in the person card for Client ID: 201848940 (Jermod Williams)
      "Was this child an active member of the household at the start of the case but not included on the referral?*" - From No to Yes
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    
*/

update personrole 
    set initialresponse = 1,
        updatedby='CJAMS-58697',
        updatedon=now() 
    where personroleid='825fdae3-4ee9-41c0-906a-b5f89b8000eb';

select * 
from cjams.cpsresponsetimerupdate( 'd77b7cf9-77eb-43a9-af3a-dc89e8402c95'::uuid, 'CJAMS-58697'::character varying ) ;

