/*
Issue: CJAMS-64053 Rejected
Category/Module: Payments
Root cause: GAP Subsidy Payment has been paid for the service month from January 2025 to September 2025 and AR is created/identified on 11/20/2025 for the same month periods when the GAP agreement was extended and GAP subsidy rate got rejected.
            Data fix needed to correct  reject status and make the status approved. The reject status is going to create an overpayment.
            Case Number : 3123932
            CJAMS PID# : 2083740
            Please update the GAP subsidy status to 'Approved'
            Supervisor (Shaquan Brown) asked to change the status to Approved.      
Fix provided: Data fix has been provided to update the GAP subsidy status to 'Approved' and trigger payments
Data/Code fix ticket#: CJAMS-64053
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per system design and data fix needed to correct it.
*/

update gapagreementrate
set status = 'Approved',
    updatedon = now(),
    updatedby = 'CJAMS-64053'
where gapagreementrateid in ('d261ee44-25c9-4e1b-a1db-71b03f92b323');

update gapratesrevision
set activeflag = 0,
    updatedon = now(),
    updatedby = 'CJAMS-64053'
where gapratesrevisionid in ('a10ecd67-f3d7-4414-bef5-3ae03d0d71c3');


INSERT INTO cjams.gapratesrevision
(gapratesrevisionid, transactiondate, ratestartdate, rateenddate, paymentamt, "comments", approvalstatustypekey, approvaldate, isoriginal, insertedon, insertedby, updatedon, updatedby, activeflag, gaprateid, guardiansubsidyid, providerid, alternateid, etl_userid, etl_load_date)
VALUES(gen_random_uuid(), '2025-10-03 00:00:00.000', '2025-01-02 01:00:00.000', '2025-08-31 00:00:00.000', 1, NULL, '3047', now(), NULL, now(), 'CJAMS-64053', now(), 'CJAMS-64053', 1, 'd261ee44-25c9-4e1b-a1db-71b03f92b323'::uuid, '4d2382cd-e39f-4da3-aed8-1e9cf1c79a39'::uuid, 5027246, 1398796, NULL, NULL);


update routing
set routingstatustypeid = 16,
    remarks = 'Updated as the part of data fix for CJAMS-64053',
    updatedon = now(),
    updatedby = 'CJAMS-64053'
where routingid in ('4f0eaf15-e24b-4fc5-958d-cc3024896d14','ba2ea87e-2a49-4fd3-a885-55c24015e7ec');

update gapratesrevision
set updatedby='CJAMS-64045',
    updatedon = now(),
    approvaldate =now() -- To trigger payments batch for last two payments
where gaprateid in ('d261ee44-25c9-4e1b-a1db-71b03f92b323','1e742c6a-5bea-4e1a-bdbf-2a14fd8a3fc2') and activeflag=1;