/*
Issue Description: Please provide a data fix to create a new placement based on the below information
Category/Module: Support
Root cause: user could not abe to create a  placement
Fix provided: DB queries change  placement exit type
Data/Code fix ticket#: CDM-43504
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Support
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/
insert into placement 
(placementid,intakeservicerequestactorid ,startdatetime ,enddatetime ,remarks,activeflag,effectivedate,insertedby,insertedon,
updatedby,updatedon,exitreasontypekey,exittypekey,isvoided,intakeservreqchildremovalid,servicecaseid,placementtypekey,
service_id,starttime,endtime,providersentdate,responseacceptedkey,isssaapproval,alternateid,altproviderid,personid,overunderflag,
paymentheaderid,ratestructureid,voidapprovaldate,primaryrelationship,leastrestrictiveplacement,ischildplacedoutside,
placementluggage,plluggagepurchased)
values
(gen_random_uuid(),'54e62cdb-5366-410d-8606-54d221c358d6','2023-07-12 08:00:00.000','2025-01-02 00:00:00.000',null,1,
'2023-07-12 08:00:00.000','CDM-43504',now(),'CDM-43504',now(),null,null,null,'ffc8098b-5177-48a2-bb7c-4ed35927f869',
'8516b108-e840-4286-8620-7c9d952bed43','PRPL',10,'08.00',null,'2023-07-12 08:00:00.000','4612',0,190001,6046660,
'f673e5f6-1a39-4421-b4aa-13d03d481a41','0',null,10,null,'Non-Relative',
'Child was sheltered and no family members or kinship supports available.',true,null,null);


insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag, alternateid, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
leastrestrictiveplacement, placementluggage, plluggagepurchased)
values
(gen_random_uuid(), (select placementid from placement where alternateid = 190001), '2023-07-12 08:00:00.000',
'2023-07-12 08:00:00.000','08:00', '3045', 1, 'CDM-43504', now(), 'CDM-43504', now(),0, 190001, 0,
'754f3896-f2f5-43f3-a91f-e624b23690c2', '2023-07-12 08:00:00.000', '330d12cd-f428-41b9-b332-36e53fe5f16a', null, '2024-03-22 13:00:00.000',
'Approved', 'Child was sheltered and no family members or kinship supports available.', null, null);

insert into placementrevision
(placementrevisionid, placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedby, insertedon,
updatedby, updatedon, activeflag, alternateid, isvoided, requestedby, requesteddate, approvedby, approvaldate, approveddate, status,
leastrestrictiveplacement, placementluggage, plluggagepurchased)
values
(gen_random_uuid(), (select placementid from placement where alternateid = 190001), '2023-07-12 08:00:00.000',
'2023-07-12 08:00:00.000','08:00', '3047', 1, 'CDM-43504', now(), 'CDM-43504', now(),1, 190001, 0,
'754f3896-f2f5-43f3-a91f-e624b23690c2', '2023-07-12 08:00:00.000', '330d12cd-f428-41b9-b332-36e53fe5f16a', null, '2024-03-22 13:00:00.000',
'Approved', 'Child was sheltered and no family members or kinship supports available.', null, null);

insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','15178b6f-0e39-4a3e-89af-27724ace74e2','330d12cd-f428-41b9-b332-36e53fe5f16a',
'da6e89a1-82e1-46f7-a90e-d41a3987591d','CWCW',	'CWSP',(select placementid   from placement where alternateid = 190001)
,15,0,'CDM-43504',now(),'CDM-43504',now(),true,null,null,'3189677','Servicecase');

insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,
activeflag,insertedby,insertedon,updatedby ,updatedon ,isreviewrequest,remarks,routeddescription,servicerequestnumber,objecttypekey)
values
(gen_random_uuid(),'PLTR','9a1c8c5c-cc81-4c3f-8c25-65089b46afca','15178b6f-0e39-4a3e-89af-27724ace74e2',
'da6e89a1-82e1-46f7-a90e-d41a3987591d','CWSP',	'CWCW',(select placementid   from placement where alternateid = 190001)
,16,1,'CDM-43504',now(),'CDM-43504',now(),true,null,null,'3189677','Servicecase');