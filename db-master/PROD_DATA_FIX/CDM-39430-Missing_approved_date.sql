/*
 Issue Description: CDM-39430
 Category/ Module: FinanceAccountsPayable/Funding approval
 Root cause: Funding is approved but not showing approved date.
 Pull request# for code fix: 
 Reason why no related code fix:
 Status of the code fix if already submitted and expected prod fix date: 
 Need to do data fix
 */


update routing 
set activeflag=1, updatedby='CDM-39430', updatedon=NOW()
where routingid='5f963c16-27b1-4802-ac05-daa6031989bd' and objectid='3109252';