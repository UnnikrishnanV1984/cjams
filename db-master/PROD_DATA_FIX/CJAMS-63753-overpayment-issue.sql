/*
Issue Description:CJAMS-63753 :OVERPAYMENT 
Category/Module: Payments/ GAP
Root cause: User error and The subsidy rate slab amount was changed from $950 to $307.so CJAMS created an overpayment (AR) for the guardianship payment from December 2020 till June 2021 as the Provider has been paid with the initial rate amount ($950) for the same month periods.
            Data fix needed to update the subsidy rate slab (12/02/2020 - 12/01/2021) amount from $307 to $950.
            Case ID: 3159648
            Client ID: 2161787 (ADRIAN T RICE)
            Provider ID: 5038748 (Victoria Manning)
            Subsidy Rate Slab: 12/02/2020 - 12/01/2021
Fix provided: Data fix has been done to update the subsidy rate slab (12/02/2020 - 12/01/2021) amount from $307 to $950 and trigger payments batch.
Data/Code fix ticket#: CJAMS-63753
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User error and data fix should resolve it.
*/


update gapagreementrate
set paymentamout = 950,
    updatedby = 'CJAMS-63753',
    updatedon = now()
where  gapagreementrateid = '5f75070f-67d8-416f-968b-9ac1ec1043a2'
and activeflag=1;


update gapratesrevision
set paymentamt = 950,
    updatedby = 'CJAMS-63753',
    updatedon = now()
where  gaprateid = '5f75070f-67d8-416f-968b-9ac1ec1043a2'
and activeflag=1;

--To Trigger overpayment batch for all the gap rate records
update gapratesrevision
set approvaldate = now(),
    updatedby = 'CJAMS-62877',
    updatedon = now()
where  gaprateid  in ('5f75070f-67d8-416f-968b-9ac1ec1043a2','8809c32b-2cb6-4c67-9f62-1abb316d35d5','e07ef12f-ed72-420c-89a7-c0ec285840ad','01d60776-4c75-4dd8-8e58-5775b792cea0','f75184eb-26b0-44d6-b333-75dab1b9260e','c9240014-7c12-4f11-91dc-9ceeab497f7d')
and activeflag =1;

-- This is to avoid creating wrong ARs by sp_susbsidy_receivables.
update gapagreementrate
set updatedby = 'CJAMS-62877',
updatedon = now()
where gapagreementrateid in ('5f75070f-67d8-416f-968b-9ac1ec1043a2','8809c32b-2cb6-4c67-9f62-1abb316d35d5','e07ef12f-ed72-420c-89a7-c0ec285840ad','01d60776-4c75-4dd8-8e58-5775b792cea0','f75184eb-26b0-44d6-b333-75dab1b9260e','c9240014-7c12-4f11-91dc-9ceeab497f7d')
and activeflag =1;

