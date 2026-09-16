/*
   Issue Description: CDM-36977
   Category/ Module  : PLacement
   Root cause: user wants Living Arrangement  to be Deleted
   Pull request #:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select placementid, placementtypekey, startdatetime, enddatetime  
	from placement 
	where placementid = '61681d3a-3210-4282-9f06-b050c33f279e' 
		and activeflag = 1;
--61681d3a-3210-4282-9f06-b050c33f279e	LA	2024-02-03 17:00:00.000	null		
		
update placement 
	set activeflag = 0, 
		updatedby = 'CDM-36977', 
		updatedon= now() 
	where placementid = '61681d3a-3210-4282-9f06-b050c33f279e' 
		and activeflag = 1;

select * from routing 
	where objectid = '61681d3a-3210-4282-9f06-b050c33f279e' 
		and activeflag = 1;

update routing
	set activeflag = 0,
		updatedby = 'CDM-36977',
		updatedon = now()
	where objectid = '61681d3a-3210-4282-9f06-b050c33f279e'
		and activeflag = 1;
   
   
--No living arrangement record created
select * from livingarrangement where placementid = '61681d3a-3210-4282-9f06-b050c33f279e' and activeflag = 1;


