/*
   Issue Description: CDM-39192
   Category/ Module  : Payments
   Root cause:Subsidy provider was changed to Ed McAndrews on 5/31/2023. Current subsidy renewal is not permitted for unknown reason
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update
    adoptioncaseagreement
set
    updatedby = 'CDM-39192',
    updatedon = now(),
    enddate = '2025-02-06T05:00:00'
where
    adoptionagreementid = '4e343f13-0178-4e86-b577-105c7099e221'
    and adoptioncaseid = 'eb113e90-9e3e-4eed-8050-377acc4bcc88';

    update
    adoptioncase
set
    updatedby = 'CDM-39192',
    updatedon = now(),
    enddate = '2025-02-06T05:00:00'
where
    adoptioncaseid = 'eb113e90-9e3e-4eed-8050-377acc4bcc88'
and activeflag = 1;
