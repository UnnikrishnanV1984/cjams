/*
   Issue Description: CDM-37953
   Category/ Module  : 3 OHP Program assignments were closed
   Root cause: Case Tychell Mack ID # 221030016422 3 Childrens OHP Program assignments were closed in error. WE need these reopen since the children remain in care.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update personprogramarea set enddate = null, updatedby='CDM-37953',updatedon=now()
where personprogramid ='3e3ee28b-0866-4afc-a28a-77689b7ba9ef' and personid='b8563ced-c467-4795-8964-b5c553d08d52';

update personprogramarea set enddate = null, updatedby='CDM-37953',updatedon=now()
where personprogramid ='0a168eae-3351-4c3a-9069-92f322ce0ac8' and personid='523251bb-fe0b-4ad9-8c4d-fcf5145e30f3';


update personprogramarea set enddate = null, updatedby='CDM-37953',updatedon=now()
where personprogramid ='bedc6b07-ebca-4016-9782-dff2b81c18d5' and personid='9f2060f1-cc2d-43d4-826b-f3b5daa268da';