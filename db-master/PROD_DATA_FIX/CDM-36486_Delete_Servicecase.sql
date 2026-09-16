/*
   Issue Description: CDM-36486
   Category/ Module  : ServiceCase 
   Root cause: user wants delete the service case which is not linked to any intake
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

select * from servicecase where servicecasenumber = '231030159316'; -- d156c1a4-67fe-4a10-b1ba-7312350c896b

update servicecase 
	set activeflag =0, 
		updatedby = 'CDM-36486', 
		updatedon = now() 
	where servicecasenumber = '231030159316' and activeflag =1;

update servicecasedisposition 
	set activeflag =0, 
		updatedby = 'CDM-36486', 
		updatedon = now() 
	where servicecaseid = 'd156c1a4-67fe-4a10-b1ba-7312350c896b'
		and activeflag = 1;
	
update routing 
	set activeflag =0, 
		updatedby = 'CDM-36486', 
		updatedon = now() 
	where objectid = 'd156c1a4-67fe-4a10-b1ba-7312350c896b' and activeflag =1;	

update caseassignment 
	set activeflag =0, 
		updatedby = 'CDM-36486', 
		updatedon = now() 
	where objectid = 'd156c1a4-67fe-4a10-b1ba-7312350c896b'
		and activeflag = 1;
		
-- No records found	
select * from intakeservicerequest where servicecaseid = 'd156c1a4-67fe-4a10-b1ba-7312350c896b'; 	
select * from personprogramarea  where objectid = 'd156c1a4-67fe-4a10-b1ba-7312350c896b' and activeflag = 1;