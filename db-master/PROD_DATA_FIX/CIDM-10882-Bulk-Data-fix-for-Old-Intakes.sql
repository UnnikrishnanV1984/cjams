/*
   Issue Description: The intake referrals from the legacy Chessie system are populating on the intake worker dashboard.
    This ticket created for bulk Data fix for Old Intakes from Chessie on current Dashboard
   Category/ Module  : CJAMS Intake worker dashboard.
   Root cause: System Error and Bulk datafix, Isreadonly flag is not set correctly as the submissionhistory is being filtered for chessei
   intakes leading to populate in dashboard and letting the status to be in pending.
   Pull request# 
   for code fix: CIDM-10878
   Reason why no related code fix: Codefix needed and deployed
   Status of the code fix if already submitted and expected prod fix date: 
*/

/*
* For adhoc report
select f_pdesc(up.primarycountycd , 104) as county,i.intakenumber ,up.email,up.activeflag as userStatus,i.updatedon,i.status
from IntakeDAStaging i
inner join intakeDAStatus ITDS on ITDS.intakenumber = i.intakenumber and ITDS.teamtypekey = 'CW' and ITDS.activeflag = 1
left join routing r on r.objectid = i.intakenumber and (r.activeflag = 1 or r.activeflag = 1) and r.eventcode in ('INTR', 'KINR')
left join routingstatustype RTs on RTs.sequencenumber = r.routingstatustypeid and rts.activeflag = 1
left join teammemberroletype rt on rt.roletypekey = r.toroleid and rt.activeflag = 1
join userprofile up on up.securityusersid = itds.insertedby --and up.activeflag =0
left join intakeservicerequest ISR on ISR.intakenumber = i.intakenumber and ISR.activeflag = 1
where i.IntakeNumber ilike '%CW%'
and i.Activeflag = 1
  AND EXTRACT(YEAR FROM i.updatedon) >= 2021
  and i.status = 'pending'
order by up.email  desc;*/

update intakedastaging i
set status='Complete', --pending
	updatedby='CIDM-10882', 
	updatedon = now() 
WHERE i.intakenumber ILIKE 'CW%'
  AND i.activeflag = 1
  --AND EXTRACT(YEAR FROM i.updatedon) >= 2021
  and status = 'pending';