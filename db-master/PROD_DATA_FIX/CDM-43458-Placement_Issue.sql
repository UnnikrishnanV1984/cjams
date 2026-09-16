/* 
    Issue Description: CDM-43458
   Category/ Module  : Placement
   Root cause: User requested add placement record
   Pull request# for code fix: 
   Reason why no related code fix: Formal Kinship Care is not supported in system
*/


-- Placement Insert
INSERT INTO cjams.placement 
		(placementid            ,intakeservicerequestactorid		   , startdatetime,  remarks, activeflag, effectivedate, insertedby							   , insertedon, updatedby , updatedon,intakeservreqchildremovalid			  , servicecaseid						  ,placementtypekey, service_id,  starttime,  providersentdate,  responseacceptedkey, rejectreasonkey, isssaapproval,  altproviderid,  personid								, ratestructureid,  primaryrelationship, leastrestrictiveplacement												, placementluggage)
values	(cjams.gen_random_uuid(),'49df1bfb-4a43-41c6-ac84-38e0e0b9c986', '2024-02-11' , ''	    , 1			,'2024-02-11'  , 'fa6c7906-97af-4f35-8987-dbc6add7090d',  now() 	,'CDM-43458', now()	   ,'4696f548-dce3-4ec8-912d-e696b98ce5e8', 'f6b06ee0-bb84-4ff2-af28-b68576160d98','PRPL'		   ,'8		   ','17:01'   , 'now()			 ', '4612'				, 'null'		 , '0'			,  '6174901'	, 'b76c5eaa-e46c-40ee-b1b2-448cf304d24a', null			 , ''			  	   , 'There is no change in placement, but a change in placement structure.', 'true'		  );

-- Placement Revision
INSERT INTO cjams.placementrevision
	   (placementrevisionid	  , placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedon, insertedby							, updatedon, updatedby								, activeflag,alternateid, remarks, isvoided,  requestedby						   ,requesteddate,approvedby							,approveddate, status, leastrestrictiveplacement											  ,  placementluggage)
select cjams.gen_random_uuid(), placementid, now()		  	, now()    , '17:01'	, '3045'				, 1		  	, now()   , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now()	   , 'fa6c7906-97af-4f35-8987-dbc6add7090d'	, 0			, '6174901'	, ''	 , 0	   , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now() 		 ,'362086ed-9366-451c-b7c1-b623d6de193b',now()		 ,'Approved', 'There is no change in placement, but a change in placement structure.', 'true'
	from cjams.placement where updatedby = 'CDM-43458' order by updatedon desc limit 1;

INSERT INTO cjams.placementrevision
	   (placementrevisionid	  , placementid, transactiondate, entrydate, entrytime, approvalstatustypkey, isoriginal, insertedon, insertedby							, updatedon, updatedby								, activeflag,alternateid, remarks, isvoided,  requestedby						   , requesteddate,approvedby							,approveddate,  status, leastrestrictiveplacement											  ,  placementluggage)
select cjams.gen_random_uuid(), placementid, now()		  	, now()    , '17:01'	, '3047'				, 1		  	, now()   , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now()	   , 'fa6c7906-97af-4f35-8987-dbc6add7090d'	, 1			, '6174901'	, ''	 , 0	   , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now()		  ,'362086ed-9366-451c-b7c1-b623d6de193b',now()		 ,'Approved', 'There is no change in placement, but a change in placement structure.', 'true'
	from cjams.placement where updatedby = 'CDM-43458' order by updatedon desc limit 1;

-- Routing Insert

INSERT INTO cjams.routing
	     (routingid			   ,eventcode, fromsecurityusersid					 , tosecurityusersid					 , teamid								 , fromroleid, toroleid, objectid	, routingstatustypeid, activeflag, insertedby							 , insertedon, updatedby							 , updatedon, isreviewrequest,  routeddescription	   					, servicerequestnumber)
select  cjams.gen_random_uuid(), 'PLTR'	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d::uuid', '362086ed-9366-451c-b7c1-b623d6de193b::uuid', 'f701408a-e888-4f22-97e5-3cc6363df239', 'CWCW'  	 , 'CWSP'  , placementid, 15				 , 0	  	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now()	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now()    , true	 		 , 'Provider placement submitted for review', '231030099114'
	from cjams.placement where updatedby = 'CDM-43458' order by updatedon desc limit 1;

INSERT INTO cjams.routing
	     (routingid			   ,eventcode, fromsecurityusersid					 , tosecurityusersid					 , teamid								 , fromroleid, toroleid, objectid	, routingstatustypeid, activeflag, insertedby							 , insertedon, updatedby							 , updatedon, isreviewrequest,  routeddescription	   					, servicerequestnumber)
select  cjams.gen_random_uuid(), 'PLTR'	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d', '362086ed-9366-451c-b7c1-b623d6de193b', 'a2311121-a429-497b-91ad-18fdc1574819', 'CWCW'  	 , 'CWSP'  , placementid, 16				 , 1	  	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now()	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d', now()    , true	 		 , 'Child PlacementApproved'				, '231030099114'
	from cjams.placement where updatedby = 'CDM-43458' order by updatedon desc limit 1;

INSERT INTO cjams.routing
	     (routingid			   ,eventcode, fromsecurityusersid					 , tosecurityusersid, teamid, fromroleid, toroleid, objectid	, routingstatustypeid, activeflag, insertedby							 , insertedon, updatedby							 , updatedon, isreviewrequest,  routeddescription, servicerequestnumber)
select  cjams.gen_random_uuid(), 'PLTR'	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d', null				, null	, 'CWCW'  	 , 'IVESV', placementid , 16				 , 1	  	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d::uuid', now()	 , 'fa6c7906-97af-4f35-8987-dbc6add7090d::uuid', now()    , null	 		 , ''				 , '231030099114'
	from cjams.placement where updatedby = 'CDM-43458' order by updatedon desc limit 1;

-------

update prov.tb_provider set vacancy_no = vacancy_no - 1, update_ts = now(), update_user_id = 'CDM-43458'
where provider_id = 6174901 and delete_sw = 'N' ;