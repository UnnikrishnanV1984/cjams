/*
  Issue Description:  CDM-39894
   Category/ Module  :  Placement
   Root cause: user requested to remove the rejected placements
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update
    placement
set
    activeflag = 0,
    updatedby = 'CDM-39894',
    updatedon = now()
where
    placementid in ('48ef75ca-cc05-42e6-8113-3017fbd2b498', '06981a7c-f271-4860-996e-00edcea58b2f')
    and activeflag = 1;

update
    livingarrangement
set
    activeflag = 0,
    updatedby = 'CDM-39894',
    updatedon = now()
where
    placementid in ('48ef75ca-cc05-42e6-8113-3017fbd2b498', '06981a7c-f271-4860-996e-00edcea58b2f')
    and activeflag = 1;
   
update 
    routing
set
    activeflag=0,
    updatedby = 'CDM-39894',
    updatedon = now()    
where 
     objectid in ('48ef75ca-cc05-42e6-8113-3017fbd2b498', '06981a7c-f271-4860-996e-00edcea58b2f')    and eventcode = 'PLTR' and activeflag = 1;

update
    placementrevision
set
    activeflag = 0,
    updatedby = 'CDM-39894',
    updatedon = now()
where
    placementid in ('48ef75ca-cc05-42e6-8113-3017fbd2b498', '06981a7c-f271-4860-996e-00edcea58b2f')
    and activeflag = 1;