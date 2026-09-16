/*
  Issue Description:  CDM-39681
   Category/ Module  : Education tab 
   Root cause: Data fix for Enrollment date in Education Tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update personeducation set 
enrollmentdate='2023-08-26 00:00:00',updatedby='CDM-39681',updatedon=now()
where personeducationid='5768ea95-33a7-4f44-86d7-a9df5305a987'
and personid='4f2dd70d-d905-4c3d-befb-77cc5db8da78' and activeflag=1;
