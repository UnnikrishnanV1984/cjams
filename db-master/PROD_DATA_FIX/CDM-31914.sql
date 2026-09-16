/*
   Issue Description: CDM-31914
   Category/ Module  : 
   Root cause: user want to update end dated for reunification and GAP should have  with 05/03/2013  
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    . Need to do data fix
*/
update permanencyplan set enddate=null,updatedby='CDM-31914',updatedon=now()
where permanencyplanid='106a38d9-3827-4521-9cbb-5dc3aba1e1ed';

update permanencyplan set enddate='2013-05-03 00:00:00',updatedby='CDM-31914',updatedon=now()
where permanencyplanid='b2e28243-3af2-4b0e-9b7d-db1947f770c7';