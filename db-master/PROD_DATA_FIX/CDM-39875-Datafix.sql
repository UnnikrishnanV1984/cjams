/*
  Issue Description:  CDM-39875
   Category/ Module  : Education tab 
   Root cause: Data fix for Enrollment date in Education Tab
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update personeducation set 
enrollmentdate='2023-09-05 00:00:00',updatedby='CDM-39875',updatedon=now()
where personeducationid='42deb7e8-0837-4b7d-a939-3fc72e09edee'
and personid='8d2128c4-99a4-4f12-8f52-42e24792906f' and activeflag=1;