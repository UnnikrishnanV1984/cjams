/*
   CDM-40246 - Education tab
   Description - Dashboard:User requested to upfate enrollement id for 3 PIDS.
   Fix:- Provided DB script as requested by user to update enrollment date.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
 */


update personeducation
set updatedby='CDM-40246', updatedon=now(), enrollmentdate='2023-08-23 00:00:00'
where personeducationid='cba78804-6bb7-4c31-a8dd-267153370fd7' and personid='90f52ccf-e70d-463c-bb74-35ec5a88232e';

update personeducation
set updatedby='CDM-40246', updatedon=now(), enrollmentdate='2023-08-23 00:00:00'
where personeducationid='9e605647-e2b6-45ef-8c5a-6d1dacfa64a2' and personid='30291d11-a443-4cb2-8e22-5391863c5520';

update personeducation
set updatedby='CDM-40246', updatedon=now(), enrollmentdate='2023-08-23 00:00:00'
where personeducationid='0cdae5b9-8caf-47ed-a4cc-aa6eceec385d' and personid='b309a12f-b2bc-4356-be6a-67430efb0da1';