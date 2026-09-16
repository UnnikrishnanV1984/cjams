/*
   Issue Description: CDM-20817
   Category/ Module  : Candidacy-service plan
   Pull request# for code fix:
   Reason why no related code fix: User wants to display Candidacy information  in pdf
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


UPDATE
    snapshothist
set
    snapshotdata = jsonb_set(
        snapshotdata :: jsonb,
        '{legalGuardian}',
        '"MILDRE YANERI DUARTE CRUZ "'
    ),
    updatedby = 'CDM-20817',
    updatedon = now()
where
    id = '3b05d0e2-e27a-4c18-9e6e-82af1877fcd6'
    and objectid = 'fd665c7b-b8bd-4863-bd6a-dd26df2f3faa';


UPDATE
    snapshothist
set
    snapshotdata = jsonb_set(
        snapshotdata :: jsonb,
        '{legalGuardian}',
        '"MILDRE YANERI DUARTE CRUZ "'
    ),
    updatedby = 'CDM-20817',
    updatedon = now()
where
    id = '156375b6-77ee-41eb-9d0a-7fc53d14b146'
    and objectid = 'de3ee3ac-2cdf-4d92-8db9-81b3ca3b68fd';    