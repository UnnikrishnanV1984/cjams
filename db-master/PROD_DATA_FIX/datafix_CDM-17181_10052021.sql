-- CDM-17181 - PA Stuck on Funding Screen
/*
-- Issue Description: 
   Purchase Authorization with duplicate Pending routing record 

-- Case ID: 3174018
-- Client ID: 3998412 (ZOEY	GARBER) - 37b07dea-7dcc-4682-bdf8-6f7323ccb065  
-- Service Log ID: 2010515 - 06/28/2021 To Open - Mental Health-Counseling (Paid) 
-- Provider ID: 5038203 (Center for Adoption Support & Education, Inc.)
-- Authorization ID: 1795493
-- Payment ID: 3085809 Date: 2021-09-17 - $370.00
   
-- Category/ Module: Purchase Authorization Approval (Finance Management) 
-- Root cause: Data issue (Exception scenario)
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Delete 
-- 1	40	Forwarded to Funding Approval	58d26c18-79c9-41a9-8312-ef187f99e0e1	PCAUTHR
-- 1	43	Approved						7b9f989d-5372-4f47-b53e-4dd3a6664e4b	PCAUTHR

select *
	from routing 
where routingid  in
	(	'58d26c18-79c9-41a9-8312-ef187f99e0e1', 
		'7b9f989d-5372-4f47-b53e-4dd3a6664e4b'
	)
	and objectid = '1795493'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
delete from routing   
where routingid  in
	(	'58d26c18-79c9-41a9-8312-ef187f99e0e1', 
		'7b9f989d-5372-4f47-b53e-4dd3a6664e4b'
	)
	and objectid = '1795493'
	and eventcode in ( 'PCAUTHR', 'PCAUTH' )
	and activeflag = 1 ;
	
/*
INSERT INTO routing (routingid,eventcode,fromsecurityusersid,tosecurityusersid,teamid,fromroleid,toroleid,objectid,routingstatustypeid,activeflag,insertedby,insertedon,updatedby,updatedon,isreviewrequest,remarks,old_id,routeddescription,servicerequestnumber,objecttypekey,old_from_id,old_to_id,principaltype,actiondatetime,etl_userid,etl_load_date,entityid,reassignnotes) 
VALUES
	 ('58d26c18-79c9-41a9-8312-ef187f99e0e1'::uuid,'PCAUTHR','8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb','8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40','b1de819d-0f16-4f9e-a86d-d1b89d0474da'::uuid,'CWSP','FNSFS','1795493',40,1,'8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb','2021-09-17 12:15:34.924','8451ccf6-ceb6-4ce4-b888-b4f2ada4d9fb','2021-09-17 12:15:34.924',true,'Forwarded to Funding Approval',NULL,'Purchase Authorization Forwarded to Funding Approval','3174018','ServiceCase',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL),
	 ('7b9f989d-5372-4f47-b53e-4dd3a6664e4b'::uuid,'PCAUTHR','8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40','a7b7b759-341a-4604-a853-3a922c75fb4d','b1de819d-0f16-4f9e-a86d-d1b89d0474da'::uuid,'FNSFS','FNSFS','1795493',43,1,'8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40','2021-09-17 12:43:55.377','8ba0f2d2-c56d-4dee-a2f8-616f6d09ed40','2021-09-17 12:43:55.377',true,'Approved',NULL,'Purchase Authorization Forwarded to Payment Approval',NULL,'ServiceCase',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
*/	