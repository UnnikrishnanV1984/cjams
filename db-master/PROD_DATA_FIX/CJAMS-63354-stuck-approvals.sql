/*
Issue:CJAMS-63354:Stuck Approvals
Root Cause: These are old cases created in the in 2021 and they are not part of the adoptionapplicabilityinfo table.
            Hence these are stuck in the dashboard. We will do a data fix to remove these old records from IV-E dashboard.
            This is the reason current status is blank. User will need to create a new ACA to view them.
Fix Provided: Data fix has been done to remove the old cases that are created by Melinda from crystal.stewart@montgomerycountymd.gov dashboard
Data/Code fix ticket#:
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: These are old cases and the person who created them is inactive.
                                We just need data fix to clear these records.
Status of the code fix: Data fix completed, PR raised for documentation.
Backup before update/ delete:Query:
*/

-- select approvalid ,insertedon ,updatedon ,*from tb_ive_adoption_audit where cjamspid  in ('3423328','3113641','3192889','3262083','3392199','3541964','3541483') 

-- approvalid is objectid in routing table.  

update routing
set activeflag = 0,
    updatedby = 'CJAMS-63354',
    updatedon = now()
where objectid in ('5823ae67-6acc-4fad-80f8-2db8928699d9','21ef853b-2f6b-493c-8925-0441823d5ffe','54be63f5-ea2c-441f-8bd5-f750ad3a7448','a8261c95-4a77-4ff8-96a4-5dbc929327aa','c2b1259f-b57c-4a20-ab64-877dca56842b','69b1cb47-c3b0-42b0-947e-c673551eee1c','996fe276-e02d-44be-a434-44417cd9bd30','b4cdf75b-10bc-4b38-a521-ea8f650cbecf','db51546f-0377-489f-aaec-bd74c12a4597','5823ae67-6acc-4fad-80f8-2db8928699d7') and activeflag =1;    