/*
   Issue Description: CDM-43028 User Contact Info Incorrect
   Category/ Module  :  Assignments
   Root cause: contact information updates do not flow from sailpoint to cjams.This is a known issue and data fix needs to be done to update the contact number.
   Fix provided : Data fix has been promoted to update the phone number in userprofile.
   Data / Code fix ticket#: CDM-43028
   Reason why no related code fix: This is a known issue from sailpoint side and data fix should fix the issue. 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A

*/


update userprofilephonenumber 
set phonenumber = '443-826-1094',
    updatedby = 'CDM-43028',
    updatedon = now()
where securityusersid = 'aebcf612-ecc8-4881-97d8-c884ce3b75d3';