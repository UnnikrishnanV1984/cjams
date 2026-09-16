
/*
   Issue Description: CDM-19814
   Category/ Module  : Updating Investion findings info
   Root cause: user requeseted to remove it
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

--null, 	a1d0c8a5-133c-4b35-b61c-b5e21523264a	2021-12-22 00:11:39
update investigationallegationmaltreators
set overridefindingtypekey = 'RO' ,
	updatedby = 'CDM-19814', 
	updatedon = now()
where investigationallegationmaltreatorsid = 'd9554f8e-8888-4680-b9c7-5b090e5289d2' 
	and activeflag = 1 ;