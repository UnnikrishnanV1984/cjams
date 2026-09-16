/*
Issue: CJAMS-69660 - Case 3247738: unable to send decision to close the case due to an open service log,
       and the service log cannot be end dated 
Category/Module: Service Log / Purchase Authorization
Root Cause: The three purchase authorizations were fully approved in 2016 - in tb_service_purchase_authorization all four approval statuses are 3047 (Approved) with
            payment_approval_dt 09/07/2016, and each has an approved payment in tb_payment_header.However, their legacy-migrated routing rows
            were left open: routingstatustypeid 43 with activeflag = 1 and remarks = 'Forwarded to Payment Approval' instead of 'Approved'.
Fix Provided (Data Fix Only): Update remarks to 'Approved' on the three active PCAUTH routing rows so
            they match the already-approved authorization/payment records and the other 32
            authorizations on the same service log. Three records updated. This clears
            ongoingtransflag, restores the edit icon, and lets the worker end date the service log.
Data/Code fix ticket#: CJAMS-69660
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Legacy data migration error - the authorizations are already approved.
*/


UPDATE cjams.routing
   SET remarks = 'Approved'
where routingstatustypeid  = 43
    and eventcode  in ( 'PCAUTHR', 'PCAUTH' )
    and lower(remarks) <> lower('Approved')
and activeflag = 1;
