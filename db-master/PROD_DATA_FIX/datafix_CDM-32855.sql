/*
 * Issue Description CDM-32855 - Case Plan Stuck in Approvals
   Category Module   Approval Inbox - case pending approval
   Customer Email ID:amanda.bates1@maryland.gov
   Description - Dashboard:This case plan was deleted and now it is suck in my approvals. 
   Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/cjams-dashboard/cw-approval
   Root cause user wants to delete the record form pending approval tab
   Pull request# for data fix 
   Reason why no related code fix 
   Status of the code fix if already submitted and expected prod fix date Need data fix
 * 
 */


-- search the case, click on the case and go to approval inbox, in getpendingreviewda api get the object id
-- inspect the page u will get object id from that you will get routing id
-- servicerequestnumber='3285641' and objectid='b9ead1d3-a193-4c93-a407-0ea88ff44b00'
   
    
    select distinct routingid,* from routing where servicerequestnumber='3285641' and objectid = 'b9ead1d3-a193-4c93-a407-0ea88ff44b00' and activeflag=1;
    update routing 
	set  updatedby = 'CDM-32855',updatedon = now(), activeflag = 0
	where  routingid in (
		'bebf9b61-1962-4513-afd0-6a781c56c08b');