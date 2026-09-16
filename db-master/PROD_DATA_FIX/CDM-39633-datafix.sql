/*
  Issue Description:  CDM-39633
   Category/ Module  :placement
   Root cause: Delete record of living arrangement.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/

update placement 
set activeflag = 0,
	updatedby = 'CDM-39633',
	updatedon = now()
where placementid ='ccc0c6b7-4f3e-4e74-bda8-a85ae068bb0f'
	and activeflag = 1 ;
	
update placementrevision 
set activeflag = 0,
	updatedby = 'CDM-39633',
	updatedon = now()
where placementid ='ccc0c6b7-4f3e-4e74-bda8-a85ae068bb0f'
	and activeflag  = 1 ;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-39633',
	updatedon = now()
where placementid ='ccc0c6b7-4f3e-4e74-bda8-a85ae068bb0f'
	and activeflag = 1 ;

	update routing 
set activeflag = 0,
	updatedby = 'CDM-39633',
	updatedon = now()
where objectid ='ccc0c6b7-4f3e-4e74-bda8-a85ae068bb0f'
	and eventcode = 'PLTR'
	and activeflag = 1 ;
