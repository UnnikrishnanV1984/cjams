/*
Issue: CJAMS-64474 GAP subsidy Agreement
Category/Module: GAP/ Subsidy
Root cause: This is not a defect. As per system design, the new subsidy rate slab can not be added beyond the GAP agreement end date.
             the GAP agreement can not be extended as the GAP Agreement is overlapping with the initial GAP subsidy rate end date.
             Verified in the Court Order and the C & G court date is 08/04/2022.
             data fix to update the GAP Agreement start date to 08/04/2022.

             GAP Agreement Start Date: 08/05/2022
             Initial Subsidy Rate Start Date: 08/04/2022
             Permanency Plan Start & End Date: 05/08/2014 - 05/02/2022

Fix provided:  Data fix has been done to update the GAP agreement start date to 08/05/2022 and run payment related batch for payment generation.
Data/Code fix ticket#: CJAMS-64474
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: This is as per the system Design and data fix needed to resolve it.
*/


update gapagreement
set startdate = '2022-08-04 08:00:00.000',
    updatedby = 'CJAMS-64474',
    updatedon = now()
where gapagreementid='4a3dd338-06e3-4e2c-b3a0-7c86da4cc7dc'
and activeflag = 1;

--  Trigger payment batch
update gapratesrevision
set approvaldate = now(),
updatedby = 'CJAMS-64474',
updatedon = now()
where gaprateid in ('f8dfe45b-a2b1-41fb-a72b-306bd5325c54','af152fb5-6a25-467e-aaff-30c4dfa2b5ad','232ba3f5-1913-412f-bca4-bee6f6c22f84','721b97eb-8519-4031-baea-5151fa6319b6')
and activeflag = 1;