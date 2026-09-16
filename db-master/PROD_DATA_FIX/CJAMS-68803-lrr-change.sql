/*
Category/Module: Overdue Reason
Root cause:Data Entry error and user requested to update the overdue reason for Contact with Other Children Attempted or Completed  and Contact with Initial Contact Caregiver Attempted or Completed to "Family refused to cooperate with Department and Insufficient risk to warrant court involvement"
Fix provided: Data fix to update the over due reason for Contact with Other Children Attempted or Completed and Contact with Initial Contact Caregiver Attempted or Completed to "Family refused to cooperate with Department and Insufficient risk to warrant court involvement"
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error
*/

update cpsresponsetimeractions
set cpsresponsetimerreason4='OFCD', 
	cpsresponsetimerreason5='OIID', 
	cpsresponsetimerreason7='CFCD', 
	cpsresponsetimerreason8='CIID', 
	updatedby='CJAMS-68803', 
	updatedon=now()
where cpsresponsetimeractionsid='004de31b-576e-4b6f-8e68-00083533e108' and intakeserviceid='2e618b85-b72b-4ab5-932a-1a42cf021c07' and activeflag=1;