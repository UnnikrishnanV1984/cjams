/*
Issue Description:CJAMS-67624-MULTIPLE PID
Category/Module: persons tab
Root cause: user has requested to remove the wrong person( CJAMS PID: 3639099, Nathaniel Young,CJAMS PID: 3639105, Tearra Young) added in case by error
Fix provided: Data fix has been done to remove the person from case  ( CJAMS PID: 3639099, Nathaniel Young,CJAMS PID: 3639105, Tearra Young)
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error
*/

update actor
set
    activeflag = 0,
    updatedby = 'CJAMS-67624',
    updatedon = now ()
where
    actorid in ('92d0244b-864b-45ca-ad61-b7d8c9215907','116a74e2-25c3-4203-910f-18737ec3e0ac')
    and personid in ('a13dab36-f45e-4ed8-86ec-d9ce9abb9e60','6fa6c994-f60a-477a-a40c-5c842bcb7310')
    and activeflag = 1;

update intakeservicerequestactor
set
    activeflag = 0,
    updatedby = 'CJAMS-67624',
    updatedon = now ()
where
    intakeservicerequestactorid in ('b68667a3-ea83-4a63-a347-45ff4d5ebb45','d93da20e-c16b-4565-af46-101c70bf746f','c9fe71d9-25fa-4043-869f-e392bd03d350')
    and actorid  in ('116a74e2-25c3-4203-910f-18737ec3e0ac','92d0244b-864b-45ca-ad61-b7d8c9215907','92d0244b-864b-45ca-ad61-b7d8c9215907')
    and activeflag = 1;

update personrole
set
    activeflag = 0,
    updatedby = 'CJAMS-67624',
    updatedon = now ()
where
    personroleid in ('7f2a13c9-5452-4489-b639-a4292be785df','b80bcd5c-ce35-446b-9d7a-2932de4101ed')
    and personid in ('a13dab36-f45e-4ed8-86ec-d9ce9abb9e60','6fa6c994-f60a-477a-a40c-5c842bcb7310')
    and activeflag = 1;
   

update personroletype
set
    activeflag = 0,
    updatedby = 'CJAMS-67624',
    updatedon = now ()
where
    personroleid in ('7f2a13c9-5452-4489-b639-a4292be785df','b80bcd5c-ce35-446b-9d7a-2932de4101ed')
    and personroletypeid in ('ba148fff-e4fc-4e80-9468-ef5047da1a9e','12881817-346e-491d-b769-123d5cbc7091','2e76cee2-1c89-49fc-bc44-80ab0b8a34c9')
    and activeflag = 1;

update actorrelationship
set
    activeflag = 0,
    updatedby = 'CJAMS-67624',
    updatedon = now ()
where
    intakeservicerequestactorid in ('b68667a3-ea83-4a63-a347-45ff4d5ebb45','d93da20e-c16b-4565-af46-101c70bf746f','c9fe71d9-25fa-4043-869f-e392bd03d350')
    and activeflag = 1;

update personprogramarea
set
    activeflag = 0,
    updatedby = 'CJAMS-67624',
    updatedon = now ()
where
    personid in ('a13dab36-f45e-4ed8-86ec-d9ce9abb9e60','6fa6c994-f60a-477a-a40c-5c842bcb7310')
    and personprogramid in ( '5e32ef37-6007-4360-967d-c6d174756251','6b4d5dab-37ce-40e8-801d-55e750d5b354')
    and activeflag = 1;