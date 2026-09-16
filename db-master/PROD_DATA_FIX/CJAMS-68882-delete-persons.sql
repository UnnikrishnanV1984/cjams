/*
   Issue Description: CJAMS-68882
   Category/ Module: person & Contacts
   Root cause: User requested to data fix to remove SAMMIE L CARROLL IIICJAMS PID#:200768699, PHILLIP A JOHNSONCJAMS PID#:1646516
   Fix Provided: Data fix was done by removing SAMMIE L CARROLL IIICJAMS PID#:200768699, PHILLIP A JOHNSONCJAMS PID#:1646516
   Code Fix: Not Needed
*/


update actor 
set activeflag =0, updatedby ='CJAMS-68882', updatedon =now()
where actorid in ('8ad2824b-a5cc-4d12-8ab8-805758dfa038', '80004905-ccfd-415c-b16e-deb25a4a7c85') and activeflag =1;

update intakeservicerequestactor 
set activeflag =0, updatedby ='CJAMS-68882', updatedon =now()
where intakeservicerequestactorid in ('cb4961b9-3f33-4d66-9400-da048c43eeac', '45f43ba7-3434-4d6f-b995-09ffc3897226') and activeflag =1;

update personprogramarea 
set activeflag =0, updatedby ='CJAMS-68882', updatedon =now()
where personprogramid in ('ea9a6bf2-fce8-45fd-9bf7-aa09c1299160', 'c2008a75-c5fa-4f45-bc71-f43e242479ec') and activeflag =1;

update personrole 
set activeflag =0, updatedby ='CJAMS-68882', updatedon =now()
where personroleid  in ('9de48618-6789-4253-9c90-63dbd4166d74', '32c91f76-2732-4c81-8ebd-c3ff79655cdf') and intakeserviceid ='714ff532-2d69-4039-bce5-e11689f5dce4' and activeflag =1;

update personroletype 
set activeflag =0, updatedby ='CJAMS-68882', updatedon =now()
where personroletypeid in ('e52728c5-13ab-4826-b658-7ca4cbb2eb8c', 'dc2d7131-e409-4f6f-b454-84ad2b7f86fc') and activeflag =1;

update actorrelationship 
set activeflag =0, updatedby ='CJAMS-68882', updatedon =now() 
where intakeservicerequestactorid in ('cb4961b9-3f33-4d66-9400-da048c43eeac', '45f43ba7-3434-4d6f-b995-09ffc3897226') and activeflag =1;