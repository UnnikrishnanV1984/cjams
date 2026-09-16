/*
   Issue Description: CDM-29583-incorrect-approval-name
   Category/ Module  : CDM
   Pull request# for code fix: 
   Reason why no related code fix: User wants an update user name
   Status of the code fix if already submitted and expected prod fix date: 
*/

update usernotificationmap set updatedby = 'CDM-29583', updatedon = now(),
fromsecurityusersid = '9496daef-d05f-4677-835d-bb560e12e145' 
where usernotificationid = 'c630647d-5eb2-446f-82ad-b1124aa714cb';

update usernotificationmap set updatedby = 'CDM-29583', updatedon = now(),
fromsecurityusersid = '991e43ab-c06b-4195-b446-c4f80ef8433a' 
where usernotificationid = '332539b1-d5c3-45d7-a76b-2842deb01ae2';
