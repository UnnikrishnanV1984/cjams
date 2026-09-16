/*
  Issue Description:  CDM-42737
   Category/ Module  :  Assignments
   Root cause:User request to change the Phone number. updated the phone number in userprofilephonenumber table
   Pull request# for code fix: NA
   Reason why no related code fix: For deactivating the users from CJAMS data fix is needed
   Status of the code fix if already submitted and expected prod fix date: NO
   Backup before update/ delete: NA
*/

update userprofilephonenumber 
set phonenumber = '410-897-7223',
	updatedby = 'CDM-42737',
	updatedon = now()
where userprofilephonenumberid = '9943ba76-5773-4887-91cf-6d97a89c5042'
and activeflag = 1;