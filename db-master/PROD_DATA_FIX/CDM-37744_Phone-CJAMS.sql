/*
-- CDM-37744 - Phone Number in CJAMS
-- Category/ Module: User Profile Phone Number 
-- Root cause: User Phone number is wrong in userprofilephonenumber
-- Fix Provided: Datafix has been done with the phonenumber provided by user
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select * from userprofilephonenumber where securityusersid = '02810628-839a-40dc-9283-1b22e70ecd1b';

update userprofilephonenumber 
set phonenumber = '443-813-2886', 
	updatedby = 'CDM-37744', 
	updatedon = now() 
where userprofilephonenumberid = 'c167702d-6c11-46d1-9056-3f399e346ae5';