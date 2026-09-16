/*
   Issue Description: CDM-29368
   Category/ Module  : Prod data fix to Remove Incorrect GAP Agreement Rate
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update
    gapagreementrate
set
    activeflag = 0,
    updatedby = 'CDM-29368',
    updatedon = now()
where
    gapagreementrateid = '1b2503e0-3d28-4890-8ccc-93862d24e021'
    and activeflag = 1;

update
    gapratesrevision
set
    activeflag = 0,
    updatedby = 'CDM-29368',
    updatedon = now()
where
    gaprateid = '1b2503e0-3d28-4890-8ccc-93862d24e021'
    and activeflag = 1;

update
    routing
set
    activeflag = 0,
    updatedby = 'CDM-29368',
    updatedon = now()
where
    routingid in(
        '48d33238-e071-41e1-869f-338b829c6acb',
        'fe2db004-782e-41b8-ad24-e045ef1f44be'
    )
    and activeflag = 1;