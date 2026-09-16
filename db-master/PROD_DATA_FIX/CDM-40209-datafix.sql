/* 
  Issue Description: CDM-40209
  Category/ Module  : Placement
  Root cause: User error to remove the living arrangement
  Pull request# for code fix: 
  Reason why no related code fix: N/A
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/

update placement 
set activeflag = 0,
	updatedby = 'CDM-40209',
	updatedon = now()
where placementid ='237cb3d7-5552-4d7d-9881-81644cdbbc1d'
	and activeflag = 1 ;
	
update placementrevision 
set activeflag = 0,
	updatedby = 'CDM-40209',
	updatedon = now()
where placementid ='237cb3d7-5552-4d7d-9881-81644cdbbc1d'
	and activeflag  = 1 ;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-40209',
	updatedon = now()
where placementid ='237cb3d7-5552-4d7d-9881-81644cdbbc1d'
	and activeflag = 1 ;

	update routing 
set activeflag = 0,
	updatedby = 'CDM-40209',
	updatedon = now()
where objectid ='237cb3d7-5552-4d7d-9881-81644cdbbc1d'
	and eventcode = 'PLTR'
	and activeflag = 1 ;
		