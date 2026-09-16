/*
Issue Description:CJAMS-60647 Cant Save/Close I&R
Category/Module: Information and Referral 
Root cause: User is unable to close the intake CW9826918 as it is migrated and there is some data missing in these Intake of type Information and Referral.
            We have investigated on the old intake of type information and referral and that are stuck in the similar state.
            Below are the intake information
            1.'CW9637751','CW2490097','CW2552516','CW9826918','CW9233710','CW9034597'
            Except for CW9637751 and CW9826918 others dont show up in the dashboard as the Case workers who created them are inactive.
These intakes are no longer necessary to be shown in the pending dashboard and we will do a data fix to remove them from pending dashboard and shown them under closed at intake
dora.williams@maryland.gov - CW9637751
katie.horn@maryland.gov - CW9826918
Fix provided: Data fix has been done to move these migrated closed intake type information referral from pending to closed at intake section.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: There are old migrated cases with missing records in intake related tables and we will do a data fix to clear them.
*/


update intakedastaging
set status = 'Closed',
    activeflag = 0,
    updatedby = 'CJAMS-60647',
    updatedon = now()
where intakenumber in ('CW9637751','CW2490097','CW2552516','CW9826918','CW9233710','CW9034597')
and activeflag = 1;

update intakedastatus
set status = 8,
    updatedby = 'CJAMS-60647',
    updatedon = now()
where intakenumber in ('CW9637751','CW2490097','CW2552516','CW9826918','CW9233710','CW9034597')
and activeflag = 1;


update routing
set activeflag = 1,
    updatedby = 'CJAMS-60647',
    updatedon = now()
where objectid in ('CW9637751','CW2490097','CW2552516','CW9826918','CW9233710','CW9034597');    