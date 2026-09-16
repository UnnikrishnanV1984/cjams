/*
Issue Description: CJAMS-61667 GAP subsidy rate
Category/Module: GAP
Root cause: Worker attempted to edit GAP rate and sent two rates for approval in error. Both rates were accidentally approved. The system has generated two adjustment checks, one for a partial June subsidy and one for July subsidy. The July adjustment is at the correct daily rate and the partial June adjustment is at the incorrect daily rate
              Data fix needed to remove e incorrect subsidy rate slab with amount $816 and run the finance batch to verified CJAMS generating new system adjustment payment.
Fix provided: Data fix has been done to remove the incorrect GAP agreement rate and trigger payment batch
Data/Code fix ticket#: CJAMS-61667
Regression Impacts: N/A
Is Code fix Required?: N/A
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix is needed to generate correct payments
*/

update gapagreementrate
set activeflag = 0 , 
    updatedon = now(),
    updatedby = 'CJAMS-61667'
where gapagreementrateid = '2d111a56-924a-4afe-9a08-c6c7a38a4d29'    
and activeflag = 1;

update gapratesrevision
set activeflag = 0 , 
    updatedon = now(),
    updatedby = 'CJAMS-61667'
where gaprateid = '2d111a56-924a-4afe-9a08-c6c7a38a4d29'    
and activeflag = 1;

update routing
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-61667'
where objectid = '2d111a56-924a-4afe-9a08-c6c7a38a4d29'    
and activeflag = 1;



-- To Trigger the payments batch
update gapratesrevision
set approvaldate = now(),
    updatedby = 'CJAMS-61667'
where gaprateid = '53b84c15-b516-457a-9ac7-533298a9b357'
and activeflag = 1;