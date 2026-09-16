/* 
    Issue Description: CJAMS-58274
   Category/ Module  : GAP Subsidy rate
   Root cause: User requested to update subsidy rate dates
   Pull request# for code fix: 
   Reason why no related code fix: User Error
*/

update gapagreementrate 
set paymentamout = '1043.46',
	updatedby = 'CJAMS-58274',
	updatedon = now()
where gapagreementid = '2b54dd3b-4e05-449d-b71f-d660d5e88f93'
	and gapagreementrateid = '165358aa-0528-48d9-8e65-02276b5af898'
	and activeflag = 1;

update gapratesrevision 
set paymentamt = '1043.46',
    approvaldate= now(),
    updatedby = 'CJAMS-58274',
    updatedon = now()
where  gaprateid = '165358aa-0528-48d9-8e65-02276b5af898'
	and activeflag = 1;  