/*
   Issue Description: CJAMS-59358 GAP placement issue
   Category/ Module  : Placement
   Root cause:Formal Kinship placement is removed from the system as the part of user story  and we need a data fix to insert backdated formal kinship.
   Fix Provided: Data fix has been provided to create a back date formal kinship placement as SSA has given their approval for Brandon Ortega-Wright with below information.
                1. Type - Provider Placement
                2. Provider ID -5061455 ( Provider Name )
                    Placement Structure -Formal Kinship Care
                    Response Accepted -Yes
                    Reason for Decline - NA
                    Referral sent date - Current Date (System Date)
                    Start date, time  –7/31/24 10:00 am and End Date and Time  1/28/2025 - 07.59am
                    Comments -
                    Child has been placed with a provider outside his/her jurisdiction -yes
                    Explain why this is the Least Restrictive Placement for the child –Placement in the kinship home of her maternal grandmother is the most appropriate and least restrictive placement for Devina. This allows her to remain in the care of her family.
                    Luggage Indicator - Did the child have luggage at the time of their placement? -Yes
                    Approved On - Current Date (System Date)  
                    Approved By -    Laura Joiner
                    Requested On - Current Date (System Date)
                    Requested By –Hannah Barber 
   Data/Code fix ticket#: CJAMS-59358
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Formal Kinship placement is removed from the system and we need a data fix to enteriing a backdated formal kingship
*/



INSERT INTO cjams.placement 
	(placementid ,intakeservicerequestactorid , startdatetime, enddatetime, exittypekey, ischildplacedoutside, remarks , activeflag, effectivedate, insertedby , insertedon, updatedby , updatedon,intakeservreqchildremovalid , servicecaseid ,placementtypekey, service_id, starttime, endtime, providersentdate, responseacceptedkey, rejectreasonkey, isssaapproval, altproviderid, personid , ratestructureid, primaryrelationship, leastrestrictiveplacement , placementluggage) 
values (cjams.gen_random_uuid(),'1e5edd66-4f1a-4dc7-9c9f-4cf5c1142f91', '2024-07-31 10:00:00', '2025-01-28 07:59:00', 'CIPS', true, null, 1 ,'2024-07-31 10:00:00' , '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', now() ,'CJAMS-59358', now() ,'6297f754-c567-4ab1-ad97-e29987e86ebc', '5fcfb54d-1346-4b9a-a645-84051f9da1e5','PRPL' ,'8 ','10:00', '07:59', now(),'4612' , null , '0' , '5061455' , '0fff8e29-5c51-4953-811e-c239d52592c3', null , '' , 'Placement in the kinship home of her maternal grandmother is the most appropriate and least restrictive placement for Devina. This allows her to remain in the care of her family', 'true' );

-- Placement Revision

INSERT INTO cjams.placementrevision 
	(placementrevisionid , placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypekey, approvalstatustypkey, isoriginal, insertedon, insertedby , updatedon, updatedby , activeflag,alternateid, remarks, isvoided, requestedby ,requesteddate,approvedby ,approveddate, status, leastrestrictiveplacement , placementluggage) 
select cjams.gen_random_uuid(), placementid, now() , '2024-07-31' , '10:00' , '2025-01-28', '07:59','CIPS', 3045 , 1 , now() , '1b943456-7fbb-4071-9314-e8876ffd6563', now() , '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b' , 0 , nextval('sequence_placementrevision'::regclass) , '' , 0 , '1b943456-7fbb-4071-9314-e8876ffd6563', now() ,'5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b',now() ,'Approved', 'Placement in the kinship home of her maternal grandmother is the most appropriate and least restrictive placement for Devina. This allows her to remain in the care of her family.', 'true' 
from cjams.placement where updatedby = 'CJAMS-59358' order by updatedon desc limit 1; 

INSERT INTO cjams.placementrevision 
	(placementrevisionid , placementid, transactiondate, entrydate, entrytime, exitdate, exittime, exittypekey, approvalstatustypkey, isoriginal, insertedon, insertedby , updatedon, updatedby , activeflag,alternateid, remarks, isvoided, requestedby , requesteddate,approvedby ,approveddate, status, leastrestrictiveplacement , placementluggage) 
select cjams.gen_random_uuid(), placementid, now() , '2024-07-31' , '10:00' , '2025-01-28', '07:59','CIPS', 3047 , 1 , now() , '1b943456-7fbb-4071-9314-e8876ffd6563', now() , '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b' , 1 , nextval('sequence_placementrevision'::regclass) , '' , 0 , '1b943456-7fbb-4071-9314-e8876ffd6563', now() ,'5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b',now() ,'Approved', 'Placement in the kinship home of her maternal grandmother is the most appropriate and least restrictive placement for Devina. This allows her to remain in the care of her family.', 'true' 
from cjams.placement where updatedby = 'CJAMS-59358' order by updatedon desc limit 1;

-- Routing Insert

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid , teamid , fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription , servicerequestnumber,objecttypekey) 
	select cjams.gen_random_uuid(), 'PLTR' , '1b943456-7fbb-4071-9314-e8876ffd6563::uuid', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b::uuid', '8ec81864-e227-4763-8927-3da344eeeee9', 'CWCW' , 'CWSP' , placementid, 15 , 0 , '1b943456-7fbb-4071-9314-e8876ffd6563', now() , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now() , true , 'Provider placement submitted for review', '3254504','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-59358' order by updatedon desc limit 1; 

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid , teamid , fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription , servicerequestnumber,objecttypekey) 
	select cjams.gen_random_uuid(), 'PLTR' , '1b943456-7fbb-4071-9314-e8876ffd6563', '5ad6741c-2fc0-4f0a-879a-0a2e9dfd173b', '8ec81864-e227-4763-8927-3da344eeeee9', 'CWCW' , 'CWSP' , placementid, 16 , 1 , '1b943456-7fbb-4071-9314-e8876ffd6563', now() , '1b943456-7fbb-4071-9314-e8876ffd6563', now() , true , 'Child PlacementApproved' , '3254504','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-59358' order by updatedon desc limit 1; 

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid, teamid, fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription, servicerequestnumber,objecttypekey) 
select cjams.gen_random_uuid(), 'PLTR' , '1b943456-7fbb-4071-9314-e8876ffd6563', null , null , 'CWCW' , 'IVESV', placementid , 16 , 1 , '1b943456-7fbb-4071-9314-e8876ffd6563::uuid', now() , '1b943456-7fbb-4071-9314-e8876ffd6563::uuid', now() , null , '' , '3254504','Servicecase' 
from cjams.placement where updatedby = 'CJAMS-59358' order by updatedon desc limit 1;


-- -- tb_provider not running this query as placement is already endated
-- update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CJAMS-59358'
-- where provider_id = 5061455 and delete_sw = 'N' ;