/*
   Issue Description:CDM-41936: Deleted Service plan in error
   Category/ Module  : Services/Service plan
   Root cause: For 3259325- Deleted Service plan in error
   Fix provided : Data fix has been promoted to retrieve the deleted service plans for the case from DB.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

/*
select * from servicecase s3 where servicecasenumber = '3259325';
select * from serviceplan s where objectid = '0c32a454-821f-4153-a6b5-fe50159874f9' and serviceplanid = '9f501863-6019-41fc-b9dd-09ab4268bea7'; --userid:ee7a8459-06e3-40b3-9037-3cc0e8130202
select goalname,* from cjams.splangoal where serviceplanid in ('9f501863-6019-41fc-b9dd-09ab4268bea7');
*/

update serviceplan 
set activeflag = 1,
	updatedby = 'CDM-41936',
	updatedon = now()
where objectid = '0c32a454-821f-4153-a6b5-fe50159874f9' 
	and serviceplanid = '9f501863-6019-41fc-b9dd-09ab4268bea7';
