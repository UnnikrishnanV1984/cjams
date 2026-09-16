/*
Issue Description:CJAMS-59311 :On PID 2444735, multiple CPS Cases were created off intake I251013274346. Please delete duplicate CPS Cases: 251023044622; 251023044625; 251023044627; 251023044616; 251023044621.
Category/Module: CPS Intake creation 
Root cause:Mutliple CPS cases are created for the intake I251013274346 and data fix needs to be done to delete it.
           CIDM-10445 has been created for analysis and code fix
Fix provided: Data fix to delete duplicate CPS cases.
Regression Impacts: N/A
Is Code fix Required?: yes
Code fix ticket#: CIDM-10445 
Reason why no related code fix: N/A
*/


update intakeservicerequest
    set activeflag = 0,
        updatedby = 'CJAMS-59311',
        updatedon = now()
    where servicerequestnumber in ('251023044622', '251023044625', '251023044627', '251023044616', '251023044621')
    and activeflag = 1;

update intakeservicerequestactor
    set activeflag = 0,
        updatedby = 'CJAMS-59311',
        updatedon = now()
    where intakeserviceid in ('91d26c7c-6d43-4eb9-b341-e04f2bc4c0f3','42caf967-51c7-4eac-975b-48f887875305','d45a6e1e-c073-40ae-aad6-02fa628762b6','3df9530b-0407-429c-b77a-0b5dc64ec4f1','9dc0c7c8-a794-42f7-9dab-000fb7bf847e')
    and activeflag = 1;

update actor
    set activeflag = 0,
        updatedby = 'CJAMS-59311',
        updatedon = now()
    where intakeserviceid in ('91d26c7c-6d43-4eb9-b341-e04f2bc4c0f3','42caf967-51c7-4eac-975b-48f887875305','d45a6e1e-c073-40ae-aad6-02fa628762b6','3df9530b-0407-429c-b77a-0b5dc64ec4f1','9dc0c7c8-a794-42f7-9dab-000fb7bf847e')
    and activeflag = 1;

update intakeservrequestsdmmaltreatment
    set activeflag=0,
        updatedby = 'CJAMS-59311',
        updatedon = now()
    where intakeservicerequestsdmid in (select intakeservicerequestsdmid from intakeservicerequestsdm
where intakeserviceid in ('91d26c7c-6d43-4eb9-b341-e04f2bc4c0f3','42caf967-51c7-4eac-975b-48f887875305','d45a6e1e-c073-40ae-aad6-02fa628762b6','3df9530b-0407-429c-b77a-0b5dc64ec4f1','9dc0c7c8-a794-42f7-9dab-000fb7bf847e')
    and activeflag = 1)
    and activeflag = 1;


update intakeservicerequestsdm
    set activeflag = 0,
        updatedby = 'CJAMS-59311',
        updatedon = now()
    where intakeserviceid in ('91d26c7c-6d43-4eb9-b341-e04f2bc4c0f3','42caf967-51c7-4eac-975b-48f887875305','d45a6e1e-c073-40ae-aad6-02fa628762b6','3df9530b-0407-429c-b77a-0b5dc64ec4f1','9dc0c7c8-a794-42f7-9dab-000fb7bf847e')
    and activeflag = 1;     

update personprogramarea
    set activeflag = 0,
        updatedby = 'CJAMS-59311',
        updatedon = now()
    where personid ='29b8bd90-ebe9-467a-9f58-d5bbb66e4818' 
    and objectid in('9dc0c7c8-a794-42f7-9dab-000fb7bf847e','42caf967-51c7-4eac-975b-48f887875305','91d26c7c-6d43-4eb9-b341-e04f2bc4c0f3')
    and activeflag = 1;    

update personprogramarea
    set activeflag = 0,
        updatedby = 'CJAMS-59311',
        updatedon = now()
    where personprogramid in ('a852568d-7477-4375-8199-5e5f4af8c2c1','4c4f5044-4756-43f8-9a2a-cec3e5c1b131','1d813733-c6ad-4400-967a-82772e7610a7','40224df0-2452-4aca-9a4e-bbc493e6ac14','5b1ee827-52eb-4f22-92d1-d543bb2c8cb1','a2d16f48-eed2-4e02-a040-5a753059d195','d8d90bb6-e9b0-42fb-bf22-7c4bad352d7f','7e14c478-40a3-4b67-b2ec-7548f466798f','6a3586bf-f8dc-416d-8ab8-0f9b2c90a979')
    and activeflag = 1;    
