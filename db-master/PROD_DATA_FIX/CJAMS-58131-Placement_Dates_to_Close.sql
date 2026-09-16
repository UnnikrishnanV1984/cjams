/* 
    Issue Description: CJAMS-58131
   Category/ Module  : Placement
   Root cause: User requested add placement record
   Pull request# for code fix: 
   Reason why no related code fix: Formal Kinship Care is not supported in system
*/

INSERT INTO cjams.placement 
	(placementid ,intakeservicerequestactorid , startdatetime, remarks , activeflag, effectivedate, insertedby , insertedon, updatedby , updatedon,intakeservreqchildremovalid , servicecaseid ,placementtypekey, service_id, starttime, providersentdate, responseacceptedkey, rejectreasonkey, isssaapproval, altproviderid, personid , ratestructureid, primaryrelationship, leastrestrictiveplacement , placementluggage) 
values (cjams.gen_random_uuid(),'85796865-6183-4f90-9003-bd14b52d9d02', '2024-02-05' , null, 1 ,'2024-02-05' , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() ,'CJAMS-58131', now() ,'8d93030a-f21f-4566-b8e4-df08ea6f692e', '74d0bbb0-3788-4da4-a018-0bbacdc47cdb','PRPL' ,'8 ','17:00' , now(), '4612' , null , '0' , '6175707' , '7bd35d46-6937-4263-a3a6-ac568a556331', null , '' , 'The caregiver remains committed to meet the childs needs. This is the least restrictive placement.', 'true' );

-- Placement Revision

INSERT INTO cjams.placementrevision 
	(placementrevisionid , placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedon, insertedby , updatedon, updatedby , activeflag,alternateid, remarks, isvoided, requestedby ,requesteddate,approvedby ,approveddate, status, leastrestrictiveplacement , placementluggage) 
select cjams.gen_random_uuid(), placementid, now() , '2024-02-05' , '17:00' , 3047 , 1 , now() , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , '95e6c82b-912c-4d89-81a9-078d920c3b97' , 0 , '6175707' , '' , 0 , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() ,'0f21b527-afbb-4a4f-94b7-ce0ade354f99',now() ,'Review', 'The caregiver remains committed to meet the childs needs. This is the least restrictive placement.', 'true' 
from cjams.placement where updatedby = 'CJAMS-58131' order by updatedon desc limit 1; 

INSERT INTO cjams.placementrevision 
	(placementrevisionid , placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedon, insertedby , updatedon, updatedby , activeflag,alternateid, remarks, isvoided, requestedby , requesteddate,approvedby ,approveddate, status, leastrestrictiveplacement , placementluggage) 
select cjams.gen_random_uuid(), placementid, now() , '2024-02-05' , '17:01' , 3045 , 1 , now() , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , '95e6c82b-912c-4d89-81a9-078d920c3b97' , 1 , '6175707' , '' , 0 , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() ,'0f21b527-afbb-4a4f-94b7-ce0ade354f99',now() ,'Approved', 'The caregiver remains committed to meet the childs needs. This is the least restrictive placement.', 'true' 
from cjams.placement where updatedby = 'CJAMS-58131' order by updatedon desc limit 1;

-- Routing Insert

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid , teamid , fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription , servicerequestnumber,objecttypekey) 
	select cjams.gen_random_uuid(), 'PLTR' , '95e6c82b-912c-4d89-81a9-078d920c3b97::uuid', '0f21b527-afbb-4a4f-94b7-ce0ade354f99::uuid', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWCW' , 'CWSP' , placementid, 16 , 0 , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now() , true , 'Provider placement submitted for review', '2020036405048','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-58131' order by updatedon desc limit 1; 

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid , teamid , fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription , servicerequestnumber,objecttypekey) 
	select cjams.gen_random_uuid(), 'PLTR' , '95e6c82b-912c-4d89-81a9-078d920c3b97', '0f21b527-afbb-4a4f-94b7-ce0ade354f99', '0856e3c0-82d7-48fd-b8e2-7c8f6823e0bc', 'CWCW' , 'CWSP' , placementid, 16 , 1 , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , '95e6c82b-912c-4d89-81a9-078d920c3b97', now() , true , 'Child PlacementApproved' , '2020036405048','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-58131' order by updatedon desc limit 1; 

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid, teamid, fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription, servicerequestnumber,objecttypekey) 
select cjams.gen_random_uuid(), 'PLTR' , '95e6c82b-912c-4d89-81a9-078d920c3b97', null , null , 'CWCW' , 'IVESV', placementid , 16 , 1 , '95e6c82b-912c-4d89-81a9-078d920c3b97::uuid', now() , '95e6c82b-912c-4d89-81a9-078d920c3b97::uuid', now() , null , '' , '2020036405048','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-58131' order by updatedon desc limit 1;


-- tb_provider update
update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CJAMS-58131'
where provider_id = 6175707 and delete_sw = 'N' ;