/*
  Issue Description:  CDM-38205
   Category/ Module  :  Placement 
   Root cause: The living arrangement was entered and a duplicate was created.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

Update placement
set activeflag=0, updatedon = now(), updatedby = 'CDM-38205'
where placementid='02bce19b-50f2-48da-98cd-0ed7ef0789ab';

Update livingarrangement
set activeflag=0, updatedon = now(), updatedby = 'CDM-38205'
where placementid='02bce19b-50f2-48da-98cd-0ed7ef0789ab';

Update placementrevision
set activeflag=0, updatedon = now(), updatedby = 'CDM-38205'
where placementid='02bce19b-50f2-48da-98cd-0ed7ef0789ab';

Update routing
set activeflag=0, updatedon = now(), updatedby = 'CDM-38205'
where objectid='02bce19b-50f2-48da-98cd-0ed7ef0789ab';