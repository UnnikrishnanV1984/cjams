/*
   Issue Description: CIDM-9812
   Category/ Module  : Prod data fix to Remove Living arrangement
   Root cause: Due recent sonar qube changes CSMSReferralid is not getting updated in outbound table
   Pull request# for code fix: https://source.mdthink.maryland.gov/projects/DHSCJAMS/repos/cjams_welfare_api/pull-requests/3014/overview
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update ivecsesoutbounddata set csmsreferralid = (outputjson ->> 'referralId')::varchar, updatedon = now() ,csmsretryuser = 'CIDM-9812'
where insertedon::date in ('2024-11-18','2024-11-19','2024-11-20') and (outputjson ->> 'message')::character varying = 'Successfully Created Referral' and (outputjson ->> 'referralId') is not null and csmsreferralid is null;
