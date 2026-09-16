-- CDM-37540 - Phone Number in CJAMS
/*
-- Category/ Module: User Profile Phone Number 
-- Root cause: User Phone number is wrong in userprofilephonenumber
-- Fix Provided: Datafix has been done with the phonenumber provided by user 
-- User: taylor.camp2@maryland.gov (522f7ac3-46d2-455e-afcf-70e00de9152d)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

select phonenumber, * 
	from userprofilephonenumber 
	where securityusersid = '522f7ac3-46d2-455e-afcf-70e00de9152d'
		and activeflag = 1;

update userprofilephonenumber 
	set phonenumber = '443-758-0908',
		updatedby ='CDM-37540',
		updatedon =now() 
	where userprofilephonenumberid ='6f48db2d-e912-4452-b6cb-5cba43ae0f6b';
	

