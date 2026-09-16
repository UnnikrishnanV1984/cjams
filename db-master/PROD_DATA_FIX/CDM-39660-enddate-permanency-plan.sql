/*
   Issue Description: CDM-39660 Permanency plan identified on old people
   Category/ Module  : Permanency Plan
   Root cause: Need to do a data fix to update permanency plan End date for the below clients as needed they are old and not eligible for the permanency plan.
               Case#: 3113685
               KIMBERLY S KING - 04/26/2000
               MICHELLE N KING - 04/26/2000
               KANDI L KING - 04/26/2000
   Fix provided : Data fix has been promoted to update the permanency plan end date for the above clients.
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date:  N/A
   Backup before update/ delete: N/A
*/


update permanencyplan set enddate='2000-04-26 00:00:00.000',updatedby='CDM-39660',updatedon=now()
where permanencyplanid in ('8740db56-fe98-4f31-9dba-890368b65b0b','aec0138a-4f80-4157-a05e-4fc03740a5bd','b1b7aef0-cf38-4b55-9a0c-ef7a9ab4979e');


