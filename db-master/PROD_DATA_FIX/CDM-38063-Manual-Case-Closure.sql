/*
 CDM-38063 - Closing Checklist/Response Timer (Case Closure Error)
 Issue Description: 
 241021909279:This case will not allow me to close reporting the Initial contact has not been completed.
 The child nor mother were able to located. Notes appear to be input correctly. Safe C was completed that she could not be located. 
 Response timer was completed but appears that it is also not registering correctly.
 Case#: 241021909279 (e1b9646a-0fc1-44d0-a7bf-e9c68af799cb)
 Root cause: The worker is not able to send the case for closure. 
 Resolution: Data fix is provided to close the case.
*/


update intakeservicerequest 
set    intakeserreqstatustypeid = '7995cecb-062d-406c-8ea9-b1da4b1877d8', updatedby = 'CDM-38063', updatedon = now() 
where  intakeserviceid = '46b4e8c7-2a20-4179-8f77-f86395c3086f';
   

insert into intakeservicerequestdispositioncode (intakeservicerequestdispositioncodeid, intakeserviceid, insertedby, 
insertedon, updatedby, updatedon, statusdate, description, effectivedate, activeflag, intakeserreqstatustypeid,
servicerequesttypeconfigiddispostionid, reviewcomments, reasonfordelay) 
values (gen_random_uuid(), '46b4e8c7-2a20-4179-8f77-f86395c3086f', '2bc44bbe-5920-49a3-9e05-ef79c400bf9e', 
'2024-04-02 00:00:00', 'CDM-38063', NOW(), '2024-04-02 00:00:00', 'Completed', '2024-04-02 00:00:00', 1, '7995cecb-062d-406c-8ea9-b1da4b1877d8',
'd90db0d3-f665-49db-b3ad-0edb468bc02d', 'Case will not close due to reporting no initial face to face contact. Safe C was completed as unable to locate. 11 contact attempts completed between 2/23/2024-3/11/2024.', '');
   
insert into routing (routingid, eventcode, fromsecurityusersid, tosecurityusersid, 
teamid, fromroleid, toroleid, objectid, 
routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, 
isreviewrequest, remarks, routeddescription, servicerequestnumber) 
values (cjams.gen_random_uuid(), 'INDR', '2bc44bbe-5920-49a3-9e05-ef79c400bf9e', '130cf592-827f-4cc1-b448-5fcfeabc5d9f',
		'02f1f1a8-b46a-42e2-afbf-6b83fe1ad5cd', 'CWSP', 'CWSP', (select intakeservicerequestdispositioncodeid 
																 from intakeservicerequestdispositioncode 
																 where intakeserviceid = '46b4e8c7-2a20-4179-8f77-f86395c3086f' and updatedby = 'CDM-38063'), 
		16, 1, '70d83cb8-e49d-4c9f-9a5f-654c82446c38', '2024-04-02 00:00:00.000', 'CDM-38063', now(), 
		true, '', '', '241021909279');
  
   
update caseassignment 
set    enddate = '2024-04-02 00:00:00', updatedby = 'CDM-38063', updatedon = now() 
where  caseassignmentid = '6d088b97-bef2-4528-8514-4be2f389cb4a';
  
  
update personprogramarea 
set	   enddate = '2024-04-02 00:00:00', updatedby = 'CDM-38063', updatedon = now()
where  entityid = '241021909279' and activeflag = 1 and enddate is null;