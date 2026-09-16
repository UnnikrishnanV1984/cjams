/*
Issue Description:231030066935:The GAP rate of $887 is incorrect for 2/25/25. The actual rate should be $1008.00.
Category/Module: Gap payment adjustment
Root cause: User is unable to correct previous subsidy rate which was already approved and data fix is needed to update it.
Fix provided: Data fix has been done to update the GAP rate from $887 to 1008$
Regression Impacts: N/A
Is Code fix Required?: NO
Code fix ticket#: N/A 
Reason why no related code fix: User error and data fix is needed.
*/

--  Provider id:5090840
update gapagreementrate 
    set paymentamout = '1008', 
        updatedby = 'CJAMS-59581', 
        updatedon = now() , 
        isoverride = TRUE , 
        negotiateddate = '2025-02-25 05:00:00.000', 
        ssaapprovaldate = '2025-02-25 05:00:00.000'
where gapagreementrateid = 'b21510b9-b4c0-4de5-ac57-d1cb23a8aef8'
and activeflag=1;

update gapratesrevision 
    set paymentamt = '1008', 
        approvaldate = now() , 
        updatedby = 'CJAMS-59581',
        updatedon = now() 
where gaprateid = 'b21510b9-b4c0-4de5-ac57-d1cb23a8aef8' and activeflag = 1;


update gapratesrevision 
    set approvaldate = now() , 
        updatedby = 'CJAMS-59581',
        updatedon = now() 
where gaprateid = '2d553c0c-89fa-4428-a429-17091b99d181' and activeflag = 1;
