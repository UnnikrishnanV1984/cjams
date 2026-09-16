/* 
   Issue Description: CDM-25676
   Category/ Module  : ARSUMMARY
   Root cause: user wants to delete duplicate records form ARSummary tab
   Pull request# for code fix: 6545
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
     Need to do data fix
*/
update investigationallegation set activeflag = 0, updatedon = now(), updatedby = 'CDM-25676' 
where investigationallegationid in ('bfe76951-f9f2-4a29-86d9-bbe22d846234', '91fda338-a06f-4c0d-9913-c632ee5e0083', '9dfc1446-67b2-4543-a238-0b409afbb5a1', '0efb2506-6ff0-427a-9895-f6d7ff6b425b');

update investigationallegationmaltreators set activeflag = 0, updatedon = now(), updatedby = 'CDM-25676' 
where investigationallegationid in ('bfe76951-f9f2-4a29-86d9-bbe22d846234', '91fda338-a06f-4c0d-9913-c632ee5e0083', '9dfc1446-67b2-4543-a238-0b409afbb5a1', '0efb2506-6ff0-427a-9895-f6d7ff6b425b') and activeflag = 1;
