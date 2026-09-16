/*
	Issue Description:CDM-36932
	Category/ Module  : intake 
	Root cause: Closed intake after transferring 
	Fix Provided: Data fix and removed the record from assign transfer dashboard
*/

update cjams.intaketransfers 
	set activeflag = 0, 
		updatedby = 'CDM-36932', 
		updatedon = now()
	where intaketransferid ='8bacf9d5-c784-483d-a418-4193889e10fe';