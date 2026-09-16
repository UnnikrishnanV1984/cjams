/*
 * Issue Description: CDM-32937 - Remove From Pending Approval
 * Category Module   Approval Inbox - case pending approval
 * Customer Email ID:stacie.parker@maryland.gov
 * Customer Name:Stacie Parker
 * Dashboard:A CJAMS glitch caused the following request for approval to come to my inbox from a worker 
 * in another county: 3281049 (HOH KRISTIN MIRANDA HOY) 06/20/2023 04:09 PM Adoption Checklist Review. 
 * I need this removed from my approval inbox. Screen URL: https://cw.cjams.mdthink.maryland.gov/#/pages/cjams-dashboard/cw-approval
 */

-- inspect the approval inbox page u will get object id from that you will get routing id
-- objectid 45f7783a-9e5e-4bcd-8cd2-c2b027194884    
-- servicerequestnumber = 3281049
   
    
    select distinct routingid,* from routing where objectid = '45f7783a-9e5e-4bcd-8cd2-c2b027194884' and activeflag=1;
    update routing 
	set  updatedby = 'CDM-32937',updatedon = now(), activeflag = 0
	where  routingid in (
		'39b1e5b7-7936-4b99-a19b-71fcae635d0c');