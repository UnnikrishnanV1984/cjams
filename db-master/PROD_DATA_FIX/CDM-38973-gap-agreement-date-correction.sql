 /*
   Issue Description: CDM-38973 Subsidy Start Date
   Category/ Module  :  Permanency Plan
    Root cause: User Error while creating the subsidy rate and needs to be corrected.
                Please do a data fix to update the subsidy rate start & end date as highlighted below
                Client ID: 3515606 (KAYLEE NORFOLK)
                Provider ID: 5063890 (Kelly Stinchcomb)
   Fix provided : Data fix has been promoted to subsidy start date for the user with client id # 3515606
                  and provider id #5063890 with rate start date as 4/30/2024 and rate end date as 4/29/2025 
   Code fix ticket#: N/A
   Reason why no related code fix: N/A 
   Status of the code fix if already submitted and expected prod fix date: N/A
   Backup before update/ delete: N/A

*/

update gapagreementrate
set startdate = '2024-04-30 00:00:00',
    enddate = '2025-04-29 00:00:00',
    updatedon = now(),
    updatedby = 'CDM-38973'
where gapagreementrateid='2fde8267-dcb8-4667-a17d-5c84c1cbbecd'
and activeflag = 1;


update gapratesrevision
set ratestartdate='2024-04-30 00:00:00',
    rateenddate='2025-04-29 00:00:00',
    updatedby='CDM-38973',
    updatedon=now(), 
    approvaldate = now()
where gaprateid in ('2fde8267-dcb8-4667-a17d-5c84c1cbbecd');

