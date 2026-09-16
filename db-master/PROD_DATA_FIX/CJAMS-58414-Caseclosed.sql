/*
Issue Description: the CPS IR case is closed/completed but there is no closing record available in the decision tab.
Category/Module: Decision
Root cause: User can only  view records, but they  are unable to  creat decision records in the decision tab             
Fix provided: Data fix has been done to insert into intakeservicerequestdispositioncode,routing tables
Data/Code fix ticket#: CJAMS-58414
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Migration issue and correction is needed as a data fix for the issue.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/


delete from routing where updatedby = 'CJAMS-58414';
delete from intakeservicerequestdispositioncode where updatedby = 'CJAMS-58414';

insert into intakeservicerequestdispositioncode
(intakeservicerequestdispositioncodeid,intakeserviceid,insertedby,insertedon,
updatedby,updatedon,statusdate,effectivedate ,
activeflag ,intakeserreqstatustypeid,requestdate,servicerequesttypeconfigiddispostionid)
values
(gen_random_uuid(),'39a7a8e4-7ccf-4e06-b4a3-41ea6924069c','fb74bb50-fada-4647-83d0-766635c57d80','2025-03-11',
'CJAMS-58414', now(),'2025-03-11','2025-03-11',
1,'7995cecb-062d-406c-8ea9-b1da4b1877d8', '2025-03-11','d90db0d3-f665-49db-b3ad-0edb468bc02d');



--insert routing Review 
insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,
teamid,fromroleid,toroleid,
objectid,
routingstatustypeid,activeflag,insertedby,insertedon,
updatedby ,updatedon ,isreviewrequest,remarks,
routeddescription,servicerequestnumber,objecttypekey,approveddate)
values
(gen_random_uuid(),'INDR','fb74bb50-fada-4647-83d0-766635c57d80','fb74bb50-fada-4647-83d0-766635c57d80',
'a51845a5-e87d-4e94-82db-c34b4523bd82','CWCW',	'CWSP',
(select intakeservicerequestdispositioncodeid   from intakeservicerequestdispositioncode where updatedby = 'CJAMS-58414')
,15,0,'CJAMS-58414','2025-03-11',
'CJAMS-58414',now(),true,null,
null,'241022971819','Servicecase','2025-03-11');

--insert routing Approve 
insert into routing 
(routingid,eventcode,fromsecurityusersid,tosecurityusersid,
teamid,fromroleid,toroleid,
objectid,
routingstatustypeid,activeflag,insertedby,insertedon,
updatedby ,updatedon ,isreviewrequest,remarks,
routeddescription,servicerequestnumber,objecttypekey,approveddate)
values
(gen_random_uuid(),'INDR','fb74bb50-fada-4647-83d0-766635c57d80','fb74bb50-fada-4647-83d0-766635c57d80',
'a51845a5-e87d-4e94-82db-c34b4523bd82','CWSP',	'CWCW',
(select intakeservicerequestdispositioncodeid   from intakeservicerequestdispositioncode where updatedby = 'CJAMS-58414')
,16,1,'CJAMS-58414','2025-03-11',
'CJAMS-58414',now(),true,null,
'Disposition Approved','241022971819','Servicecase','2025-03-11');
