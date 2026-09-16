/*
  Issue Description:  CDM-43897
   Category/ Module  :  Approval
   Root cause:User request to do a data fix to remove the current subsidy rate slab 
   Pull request# for code fix: NA
   Reason why no related code fix: NA
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: NA
*/

--Marisol

update gapagreementrate set 
activeflag = 0,
updatedby = 'CDM-43897',
updatedon = now() 
where gapagreementrateid = '3255b929-af7c-46a4-a912-652624e9337f'
and gapagreementid = '92b83e99-78e4-4dfd-a61a-c726919bfe71'
and activeflag = 1;

update gapratesrevision
set activeflag = 0,
updatedby = 'CDM-43897',
updatedon = now() 
where gaprateid = '3255b929-af7c-46a4-a912-652624e9337f'
and activeflag = 1;

update routing
set activeflag = 0,
updatedby = 'CDM-43897',
updatedon = now() 
where objectid = '3255b929-af7c-46a4-a912-652624e9337f'
and activeflag = 1;

--Natalia Banda's 

update gapagreementrate set 
activeflag = 0,
updatedby = 'CDM-43897',
updatedon = now() 
where gapagreementrateid = '0231c28f-1123-419f-94f8-c0003d585038'
and gapagreementid = 'c6b92886-7553-45db-a99f-29d2f68f3fa5'
and activeflag = 1;

update gapratesrevision
set activeflag = 0,
updatedby = 'CDM-43897',
updatedon = now() 
where gaprateid = '0231c28f-1123-419f-94f8-c0003d585038'
and activeflag = 1;

update routing
set activeflag = 0,
updatedby = 'CDM-43897',
updatedon = now() 
where objectid = '0231c28f-1123-419f-94f8-c0003d585038'
and activeflag = 1;