/*
 -- Issue Description:CJAMS-69561-Please do a datafix to correct the address in userprofileaddress table for the user
 -- Datafix: Two records were updated.
 -- Pull request# N/A 
 -- Reason why no related code fix: N/A
 -- Status of the code fix if already submitted and expected prod fix date: N/A
 */

update userprofileaddress 
set address='805 Brightseat Road',city='Landover',zipcode='20785', updatedon = now(), updatedby='CJAMS-69561'
where securityusersid='19e38454-17c2-41a0-830c-e6e1110ec820' and activeflag =1;
