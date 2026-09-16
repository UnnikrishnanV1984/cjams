 /*Issue Description: CDM-38862
 Category/ Module: FinanceAccountsPayable/Funding approval
 Root cause: Funding approval history status showing as approval in stead of pending because of data error.
 Pull request# for code fix: 
 Reason why no related code fix: Data updation error
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */
update  routing set activeflag = 1, updatedby = 'CDM-38862', updatedon = now()
where routingid = '12051c3b-a85b-428d-8cae-07c3693021b7'
and objectid = '3123225' and activeflag = 0;