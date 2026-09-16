/*
   Issue Description: CDM-29740
   Category/ Module  :  Permanency plan( Gap approval Subsidy rate )
   Root cause: User mistakenly added wrong date and amount
   Pull request# for code fix: 8434
   Reason why no related code fix: 
   user error - requested a data fix
*/
update gapagreementrate 
set startdate = '2023-02-10 00:00:00', paymentamout = 887.00,
	updatedby = 'CDM-29740',
	updatedon = now()
where gapagreementrateid = '0cc95f25-fdb8-4f4d-b520-885cbe1daacb'
	and activeflag = 1 ;
	
update gapratesrevision 
set ratestartdate = '2023-02-10 00:00:00', paymentamt = 887.00,
	approvaldate = now(),
	updatedby = 'CDM-29740',
	updatedon = now()
where gaprateid = '0cc95f25-fdb8-4f4d-b520-885cbe1daacb';