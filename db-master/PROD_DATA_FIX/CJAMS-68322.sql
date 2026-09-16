/*
   Issue Description:CJAMS-68322-Placement/LA status missing due to supervisor role not being present
   Category/ Module  : Placement 
   Root cause::Status column in placement/LA section of CJAMS not populating this is because assigned supervisor is no longer active and is no longer with agnecy 
   Fix provided: Data fix is done to update the routing records to their supervisors who are active
   Is code fix required: N 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/



---- Updating supervisors as the current supervisors are inactive---------------------

update userprofile set supervisorid='9b057c26-9c53-4aeb-b375-d6feb535a53f',
updatedby ='CJAMS-68322',updatedon =now()
where securityusersid='99b655f2-0de7-49eb-b1bf-95be617d8c54' and activeflag=1;


update userprofile set supervisorid='3d552e33-4a0d-45c1-9116-b93c242a4fd0',
updatedby ='CJAMS-68322',updatedon =now()
where securityusersid='7ca5718d-cc3f-4884-934c-6769a4d00eed' and activeflag=1;

---------------------------------------------------------------------------------------



update routing 
set tosecurityusersid ='3d552e33-4a0d-45c1-9116-b93c242a4fd0',toroleid ='CWSP',updatedby ='CJAMS-68322',updatedon =now()
where routingid ='ad39da0b-63f5-43fe-9cf7-a0b4d4fa781d' and eventcode ='PLTR' and activeflag =1;

update routing 
set tosecurityusersid ='3d552e33-4a0d-45c1-9116-b93c242a4fd0',toroleid ='CWSP',updatedby ='CJAMS-68322',updatedon =now()
where routingid ='c5a9520b-d504-40cd-94a8-bcedc72e92d9' and eventcode ='PLTR' and activeflag =1;

update routing 
set tosecurityusersid ='3d552e33-4a0d-45c1-9116-b93c242a4fd0',toroleid ='CWSP',updatedby ='CJAMS-68322',updatedon =now()
where routingid ='dc7d9961-35aa-4252-8a2a-03826f2c9fcc' and eventcode ='PLTR' and activeflag =1;

update routing 
set tosecurityusersid ='a8697c62-f071-4c0f-a583-7e1a6b011a63',toroleid ='CWSP',
updatedby ='CJAMS-68322',updatedon =now()
where routingid ='657dc249-d421-4209-a712-5753af445e2d' and eventcode ='PLTR' and activeflag =1;

update routing 
set tosecurityusersid ='9b057c26-9c53-4aeb-b375-d6feb535a53f',toroleid ='CWSP',
updatedby ='CJAMS-68322',updatedon =now()
where routingid ='b38a48a2-a566-416d-b499-b5d47a35eec2' and eventcode ='PLTR' and activeflag =1;

update routing 
set tosecurityusersid ='92e7ff56-753f-438d-af02-025074c4906c',toroleid ='CWSP',
updatedby ='CJAMS-68322',updatedon =now()
where routingid ='18d73380-328a-4c58-aa65-4a3f4fb4406f' and eventcode ='PLTR' and activeflag =1;



---Updating fromsecurityuserid to  Lorpu Kragbe  and tosecurityusersid to  dana.harris@maryland.gov--------------

update routing 
set fromsecurityusersid ='99b655f2-0de7-49eb-b1bf-95be617d8c54',tosecurityusersid ='9b057c26-9c53-4aeb-b375-d6feb535a53f',
updatedby ='CJAMS-68322',updatedon =now()
where routingid ='e3a23fea-ca0b-4e07-9e41-a627f93bd2ca' and eventcode ='PLTR' and activeflag =1;

update routing 
set fromsecurityusersid ='99b655f2-0de7-49eb-b1bf-95be617d8c54',tosecurityusersid ='9b057c26-9c53-4aeb-b375-d6feb535a53f',toroleid ='CWSP',
updatedby ='CJAMS-68322',updatedon =now()
where routingid ='76ec7013-25d6-46aa-9dcc-5f8f362601d0' and eventcode ='PLTR' and activeflag =1;

update routing 
set fromsecurityusersid ='99b655f2-0de7-49eb-b1bf-95be617d8c54',tosecurityusersid ='9b057c26-9c53-4aeb-b375-d6feb535a53f',toroleid ='CWSP',
updatedby ='CJAMS-68322',updatedon =now()
where routingid ='17d93cd4-6ab4-4051-8819-9a0dedb09f77' and eventcode ='PLTR' and activeflag =1;