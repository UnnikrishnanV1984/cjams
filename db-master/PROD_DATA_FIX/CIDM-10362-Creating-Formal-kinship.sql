/*
   Issue Description: CIDM-10362 Placement selection wont work
   Category/ Module  : Placement
   Root cause:Formal Kinship placement is removed from the system and we need a data fix to insert backdated formal kinship.
   Fix Provided: Data fix has been provided to create a back date formal kinship placement as SSA has given their approval for Brandon Ortega-Wright with below information.
                1. Type - Provider Placement
                2. Provider ID - 6148350 (Name: Glenn Wright)
                3. Placement Structure - Formal Kinship Care
                4. Response Accepted - Yes 
                5. Reason for Decline - NA
                6. Referral sent date - Current Date
                7. Start date and Time - 06/26/2024
                8. Comments -
                9. Child has been placed with a provider outside his/her jurisdiction - No
                10. Explain why this is the Least Restrictive Placement for the child - this placement is the least restrictive as Brandon will be placed with his grandfather
                11. Luggage Indicator - Did the child have luggage at the time of their placement? - Yes 
                12. Approved On - Current Date  
                13. Approved By - Kim Compton
                14. Requested On - Current Date   
                15. Requested By - Melissa Wetters
           The Formal Kinship Care placement record should allow to Edit and Exit the placement. 
   Data/Code fix ticket#: CIDM-10362
   Regression Impacts: N/A
   Is Code fix Required?: No
   Code fix ticket#: N/A
   Reason why no related code fix: Know issue and data fix should resolve it
*/

delete from placement where updatedby = 'CIDM-10362';

delete from placementrevision where updatedby = 'CIDM-10362';

INSERT INTO cjams.placement 
	(placementid ,intakeservicerequestactorid , startdatetime, remarks , activeflag, effectivedate, insertedby , insertedon, updatedby , updatedon,intakeservreqchildremovalid , servicecaseid ,placementtypekey, service_id, starttime, providersentdate, responseacceptedkey, rejectreasonkey, isssaapproval, altproviderid, personid , ratestructureid, primaryrelationship, leastrestrictiveplacement , placementluggage) 
values (cjams.gen_random_uuid(),'bd7f7dc7-88c3-4109-9fa3-25596254fd87', '2024-06-26' , null, 1 ,'2024-06-26' , '49101562-c4b7-4996-9292-6ba66a05654e', now() ,'CIDM-10362', now() ,'c00190a5-adb6-437f-86c6-1a4d66779b3b', '8d3d5646-d8b3-432e-a798-9def7b15add2','PRPL' ,'8 ','00:00' , now(),'4612' , null , '0' , '6148350' , '6376563b-06b7-4b46-97e7-9bcdeef64f8b', null , '' , 'This placement is the least restrictive as Brandon will be placed with his grandfather', 'true' );

-- Placement Revision

INSERT INTO cjams.placementrevision 
	(placementrevisionid , placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedon, insertedby , updatedon, updatedby , activeflag,alternateid, remarks, isvoided, requestedby ,requesteddate,approvedby ,approveddate, status, leastrestrictiveplacement , placementluggage) 
select cjams.gen_random_uuid(), placementid, now() , now() , '00:00' , 3045 , 1 , now() , '49101562-c4b7-4996-9292-6ba66a05654e', now() , 'dc7166df-699d-4c20-a8a8-c8e00fb6866d' , 0 , nextval('sequence_placementrevision'::regclass) , '' , 0 , '49101562-c4b7-4996-9292-6ba66a05654e', now() ,'dc7166df-699d-4c20-a8a8-c8e00fb6866d',now() ,'Approved', 'This placement is the least restrictive as Brandon will be placed with his grandfather.', 'true' 
from cjams.placement where updatedby = 'CIDM-10362' order by updatedon desc limit 1; 

INSERT INTO cjams.placementrevision 
	(placementrevisionid , placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedon, insertedby , updatedon, updatedby , activeflag,alternateid, remarks, isvoided, requestedby , requesteddate,approvedby ,approveddate, status, leastrestrictiveplacement , placementluggage) 
select cjams.gen_random_uuid(), placementid, now() , now() , '00:00' , 3047 , 1 , now() , '49101562-c4b7-4996-9292-6ba66a05654e', now() , 'dc7166df-699d-4c20-a8a8-c8e00fb6866d' , 1 , nextval('sequence_placementrevision'::regclass) , '' , 0 , '49101562-c4b7-4996-9292-6ba66a05654e', now() ,'dc7166df-699d-4c20-a8a8-c8e00fb6866d',now() ,'Approved', 'This placement is the least restrictive as Brandon will be placed with his grandfather', 'true' 
from cjams.placement where updatedby = 'CIDM-10362' order by updatedon desc limit 1;

-- Routing Insert

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid , teamid , fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription , servicerequestnumber,objecttypekey) 
	select cjams.gen_random_uuid(), 'PLTR' , '49101562-c4b7-4996-9292-6ba66a05654e::uuid', 'dc7166df-699d-4c20-a8a8-c8e00fb6866d::uuid', '8ec81864-e227-4763-8927-3da344eeeee9', 'CWCW' , 'CWSP' , placementid, 15 , 0 , '49101562-c4b7-4996-9292-6ba66a05654e', now() , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now() , true , 'Provider placement submitted for review', '3257194','Servicecase' 
from cjams.placement where updatedby = 'CIDM-10362' order by updatedon desc limit 1; 

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid , teamid , fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription , servicerequestnumber,objecttypekey) 
	select cjams.gen_random_uuid(), 'PLTR' , '49101562-c4b7-4996-9292-6ba66a05654e', 'dc7166df-699d-4c20-a8a8-c8e00fb6866d', '8ec81864-e227-4763-8927-3da344eeeee9', 'CWCW' , 'CWSP' , placementid, 16 , 1 , '49101562-c4b7-4996-9292-6ba66a05654e', now() , '49101562-c4b7-4996-9292-6ba66a05654e', now() , true , 'Child PlacementApproved' , '3257194','Servicecase' 
from cjams.placement where updatedby = 'CIDM-10362' order by updatedon desc limit 1; 

INSERT INTO cjams.routing (routingid ,eventcode, fromsecurityusersid , tosecurityusersid, teamid, fromroleid, toroleid, objectid , routingstatustypeid, activeflag, insertedby , insertedon, updatedby , updatedon, isreviewrequest, routeddescription, servicerequestnumber,objecttypekey) 
select cjams.gen_random_uuid(), 'PLTR' , '49101562-c4b7-4996-9292-6ba66a05654e', null , null , 'CWCW' , 'IVESV', placementid , 16 , 1 , '49101562-c4b7-4996-9292-6ba66a05654e::uuid', now() , '49101562-c4b7-4996-9292-6ba66a05654e::uuid', now() , null , '' , '3257194','Servicecase' 
from cjams.placement where updatedby = 'CIDM-10362' order by updatedon desc limit 1;


-- tb_provider update
update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CIDM-10362'
where provider_id = 6148350 and delete_sw = 'N' ;