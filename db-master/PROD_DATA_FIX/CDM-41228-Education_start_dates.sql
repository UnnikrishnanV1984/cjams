/*
   Issue Description: CDM-41228
   Category/ Module  : Education
   Root cause:user requested to change start date.
   Pull request# for code fix: N/A
   Reason why no related code fix: User error, By mistake entered wrong education start date.
*/

update personeducation 
set startdate ='2023-08-23 00:00:00',updatedby='CDM-41228',updatedon=now()
where personeducationid='0cdae5b9-8caf-47ed-a4cc-aa6eceec385d' and personid='b309a12f-b2bc-4356-be6a-67430efb0da1' and activeflag=1;

update personeducation 
set startdate ='2023-08-23 00:00:00',updatedby='CDM-41228',updatedon=now()
where personeducationid='cba78804-6bb7-4c31-a8dd-267153370fd7' and personid='90f52ccf-e70d-463c-bb74-35ec5a88232e' and activeflag=1;

update personeducation 
set startdate ='2023-08-23 00:00:00',updatedby='CDM-41228',updatedon=now()
where personeducationid='9e605647-e2b6-45ef-8c5a-6d1dacfa64a2' and personid='30291d11-a443-4cb2-8e22-5391863c5520' and activeflag=1;

update personeducation 
set startdate ='2023-08-23 00:00:00',updatedby='CDM-41228',updatedon=now()
where personeducationid='bea37776-261a-43fa-8260-8518e0b6b3fe' and personid='87699d03-df9c-46ca-ae65-a4935386cd22' and activeflag=1;
