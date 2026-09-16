/*
   Issue Description: CDM-16622
   Category/ Module  :  approvals
   Root cause: user have a pending approval 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-16622',
    updatedon = now()
where
    routingid in (
        '471a9041-96fe-4d0f-ac55-4a7def2e0862',
        '6b6d87f2-3dfb-438c-ae6f-beea7cceb6df',
        'd5ac60e8-c2b5-4deb-b4af-2f94b0c0b449',
        '34280e7c-5bdf-4683-9acb-ec1ced40335e',
        'c19f571e-cf5d-401a-a0b7-99ef5a2a3542',
        '90df3387-f2f4-442e-9504-e950b3255610',
        '6c21a230-cbe5-4887-8a6d-e0e43bb6fbc8',
        '1b8b3fa7-b1fc-4bc2-bf31-650a2a3bd82f',
        'd7adb255-2639-4868-9c67-5a80d9360643',
        '47f8dd12-cb17-42a2-a5bd-25bca7d7a7b8',
        'ed902a30-2a83-4556-b7bf-97e380966c38'
    )