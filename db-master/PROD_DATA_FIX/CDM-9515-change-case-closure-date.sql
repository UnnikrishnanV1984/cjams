update routing r set insertedon = '2020-11-10 15:00:48', updatedon = now(), updatedby = 'CDM-9515'
			WHERE r.routingid = 'a529cf1e-1850-4bce-b6d2-0f91dd2e21f7';

update intakeservicerequestdispositioncode 
set statusdate = '2020-11-10 15:00:48', updatedon = now(), updatedby = 'CDM-9515'
where intakeservicerequestdispositioncodeid = 'b690da4c-1f59-4e53-9c78-87cf617c6549';

update caseassignment set enddate = '2020-11-10 15:00:48', updatedby = 'CDM-9515',updatedon = now() where caseassignmentid = '3d0af1d6-47a7-4285-8506-166a3c71e72e';
