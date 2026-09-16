/* 
   Issue Description: CDM-40696 Payment issue
   Category/ Module  : Adoption subsidy
   Root cause: Finance needs a adjustment payment for William Boggs for 11/30/2023 to offset an overpayment.Data fix needed to change  suspension start date to 12/1/2023 
   Fix Provided : Data fix has been provided to update the suspension start date to 12/1/2023
   Pull request# for code fix: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A
*/

update adoptioncasesuspension
set suspensionbegindate = '2023-12-01 05:00:00.000',
	approvaldate = now(),
	updatedby = 'CDM-40696',
	updatedon = now()
where adoptionsuspensionid = '20a5dbfb-772d-407e-b23d-4f1aca098bfa'
	and activeflag = 1 ;	


update adoptioncasesuspensionrevision
set suspensionbegindate = '2023-12-01 05:00:00.000',
	approvaldate = now(),
	updatedby = 'CDM-40696',
	updatedon = now()
where adoptionsuspensionid = '20a5dbfb-772d-407e-b23d-4f1aca098bfa' 
	and activeflag = 1 ;	