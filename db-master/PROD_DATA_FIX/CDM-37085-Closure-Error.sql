/*
 CDM-37085 - Closure Error
 Issue Description: 
 231021569349: Worker is attempting to close case. Initial contact was not made as family did not allow worker or pg county 
 			   officers inside of the home on multiple occasions. Case is due to be closed.	
 Case#: 231021569349 (e1b9646a-0fc1-44d0-a7bf-e9c68af799cb)
 Root cause: The worker is not able to send the case for closure. 
 Resolution: Data fix is provided to close the case.
*/

select * from intakeservicerequest where intakeserviceid = 'e1b9646a-0fc1-44d0-a7bf-e9c68af799cb';

update intakeservicerequest 
set    intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-37085', updatedon = now() 
where  intakeserviceid = 'e1b9646a-0fc1-44d0-a7bf-e9c68af799cb';
  
  
select intakeservicerequestdispositioncodeid  
from   intakeservicerequestdispositioncode 
where  intakeserviceid = 'e1b9646a-0fc1-44d0-a7bf-e9c68af799cb' and 
	   intakeserreqstatustypeid = '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690';
 
select * from intakeservicerequestdispositioncode 
where intakeservicerequestdispositioncodeid = '1ce00b7a-350e-4bb1-a86c-38953194c9fc';

select * from intakeservicerequestdispositioncode 
where intakeserviceid = 'e1b9646a-0fc1-44d0-a7bf-e9c68af799cb' and updatedby = 'CDM-37085';
       
select * from routing 
where servicerequestnumber = '231021569349' and activeflag = 1 and eventcode in ('INDR', 'INVT');


insert into intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, 
insertedon, updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid,
servicerequesttypeconfigiddispostionid, reviewcomments, reasonfordelay) 
values (gen_random_uuid(), 'e1b9646a-0fc1-44d0-a7bf-e9c68af799cb', '70d83cb8-e49d-4c9f-9a5f-654c82446c38', 
'2024-02-01 12:00:00', 'CDM-37085', NOW(), '2024-02-12 12:00:00', 'Completed', '2024-02-12 12:00:00', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8',
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 'Reasonable efforts were made to ensure the safety and welfare of the child.', '');
   
insert into routing (routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
teamid, fromroleid, toroleid, objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
isreviewrequest, remarks, routeddescription, servicerequestnumber) 
values (cjams.gen_random_uuid(), 'INDR', '70d83cb8-e49d-4c9f-9a5f-654c82446c38', '1e72fd87-c3f0-4c21-a67f-39099dea4843',
		'02f1f1a8-b46a-42e2-afbf-6b83fe1ad5cd', 'CWSP', 'CWSP', (select intakeservicerequestdispositioncodeid 
																 from intakeservicerequestdispositioncode 
																 where intakeserviceid = 'e1b9646a-0fc1-44d0-a7bf-e9c68af799cb' and updatedby = 'CDM-37085'), 
		16, 1, '70d83cb8-e49d-4c9f-9a5f-654c82446c38', '2024-02-12 12:00:00.000', 'CDM-37085', now(), 
		true, '', '', '231021569349');
  
select * from caseassignment where objectid = 'e1b9646a-0fc1-44d0-a7bf-e9c68af799cb' and enddate is null;
   
update caseassignment 
set    enddate = '2024-02-12 00:00:00.000', updatedby = 'CDM-37085', updatedon = now() 
where  caseassignmentid = '3cdd2484-8201-49f1-81a9-08861b5c7a60';
  
  
update personprogramarea 
set	   enddate = '2024-02-12 00:00:00.000', updatedby = 'CDM-37085', updatedon = now()
where  entityid = '231021569349' and activeflag = 1 and enddate is null;