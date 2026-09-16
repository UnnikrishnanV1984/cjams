/* 
  Issue Description: CDM-40208
  Category/ Module  : Placement
  Root cause: User error to remove the living arrangement
  Pull request# for code fix: 
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update placement 
set activeflag = 0,
	updatedby = 'CDM-40208',
	updatedon = now()
where placementid ='616e03e2-3138-4ea7-b1dc-5cd293e90495'
	and activeflag = 1 ;
	
update placementrevision 
set activeflag = 0,
	updatedby = 'CDM-40208',
	updatedon = now()
where placementid ='616e03e2-3138-4ea7-b1dc-5cd293e90495'
	and activeflag  = 1 ;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-40208',
	updatedon = now()
where placementid ='616e03e2-3138-4ea7-b1dc-5cd293e90495'
	and activeflag = 1 ;

	update routing 
set activeflag = 0,
	updatedby = 'CDM-40208',
	updatedon = now()
where objectid ='616e03e2-3138-4ea7-b1dc-5cd293e90495'
	and eventcode = 'PLTR'
	and activeflag = 1 ;