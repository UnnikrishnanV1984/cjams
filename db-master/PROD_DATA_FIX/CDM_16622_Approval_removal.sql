/*
   Issue Description: CDM-16622
   Customer Email ID: jenny.sibila@maryland.gov
   Category/ Module  : pending approvals
   Root cause: user wants to remove pending approvals
   Pull request# for code fix: N/A
   explanantion: user wants to delete the pending approvals which are already approved
*/

update routing  set activeflag = 0 , updatedby ='CDM-16622',updatedon = now() 
	where routingid in (
         'ed902a30-2a83-4556-b7bf-97e380966c38', '1b8b3fa7-b1fc-4bc2-bf31-650a2a3bd82f',
         'd7adb255-2639-4868-9c67-5a80d9360643', '471a9041-96fe-4d0f-ac55-4a7def2e0862',
         '6b6d87f2-3dfb-438c-ae6f-beea7cceb6df', '47f8dd12-cb17-42a2-a5bd-25bca7d7a7b8',
         'd5ac60e8-c2b5-4deb-b4af-2f94b0c0b449', '34280e7c-5bdf-4683-9acb-ec1ced40335e',
         'c19f571e-cf5d-401a-a0b7-99ef5a2a3542', '03988410-ce9e-4db1-b88e-b721501a1f02',
         'c1cc1f9b-9f93-4077-9f5b-d9fb6d9f7f88', 'ff7a6f22-4d4e-4250-b9f5-d1ca233304ab',
         '90df3387-f2f4-442e-9504-e950b3255610', '6c21a230-cbe5-4887-8a6d-e0e43bb6fbc8'
   );