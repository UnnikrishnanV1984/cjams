/*
   Issue Description: CDM-17820
   Category/ Module  :   Case #211020136524 does not appear in the Assign Case screen
   Root cause:  Case #211020136524 does not appear in the Assign Case screen 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update intakeservicerequest set isrouted = true ,updatedby ='CDM-17820' , updatedon =now() where intakeserviceid = '2b42bdb7-3818-4d99-bbad-f021fb9b2528'