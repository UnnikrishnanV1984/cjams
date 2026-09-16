/*
Issue Description: CJAMS-57899: BEGIN DATE FOR SUBSIDY RATE
Category/Module: GAP Subsidy
Root cause: Data fix needed to correct the GAP agreement begin date as 8-29-2024. This is a know issue and agreement start date is fetched from latest court order for GAP agreement 
            but it is not getting updated in the subsidy rate. Data fix should fix it.
Fix provided: Data fix has been done to update the GAP agreement begin date as requested by the user.
Data/Code fix ticket#: CJAMS-57899
Regression Impacts: N/A
Is Code fix Required?: Yes
Code fix ticket#: To be Decided
Reason why no related code fix: This is a know issue and agreement start date is fetched from latest court order for GAP agreement 
                                but it is not getting updated in the subsidy rate. Data fix should fix it.
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

update gapagreement
set startdate = '2024-08-29 04:00:00.000',
    updatedby = 'CJAMS-57899',
    updatedon = now()
where gapagreementid='cc3721c1-3bda-4b26-baa0-373f15624cff'
and activeflag = 1;

update gapagreementrevision
set startdate = '2024-08-29 04:00:00.000',
    updatedby = 'CJAMS-57899',
    updatedon = now()
where gapagreementid='cc3721c1-3bda-4b26-baa0-373f15624cff'
and activeflag = 1;

