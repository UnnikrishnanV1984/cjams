
/* 
    Issue Description: CDM-39551
  Category/ Module  : Placement
  Root cause: User request to remove the two living arrangements
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: 
  Backup before update/ delete: 
*/


update placement 
set activeflag = 0,
	updatedby = 'CDM-39551',
	updatedon = now()
where placementid 
	in ( 	'653c92c1-f468-49e6-8822-ca375b1d5c31', 
	        '80373f45-a51c-4565-8235-63bce0429a21'
		)
	and activeflag = 1 ;
	
update placementrevision 
set activeflag = 0,
	updatedby = 'CDM-39551',
	updatedon = now()
where placementid 
	in ( '653c92c1-f468-49e6-8822-ca375b1d5c31', 
	     '80373f45-a51c-4565-8235-63bce0429a21'	
		)
	and activeflag  = 1 ;

update livingarrangement 
set activeflag = 0,
	updatedby = 'CDM-39551',
	updatedon = now()
where placementid 
	in ( 	
	'653c92c1-f468-49e6-8822-ca375b1d5c31', 
	 '80373f45-a51c-4565-8235-63bce0429a21'	
		)
	and activeflag = 1 ;

	update routing 
set activeflag = 0,
	updatedby = 'CDM-39551',
	updatedon = now()
where objectid 
		in ( '653c92c1-f468-49e6-8822-ca375b1d5c31',
              '80373f45-a51c-4565-8235-63bce0429a21'
			)
	and eventcode = 'PLTR'
	and activeflag = 1 ;
	
