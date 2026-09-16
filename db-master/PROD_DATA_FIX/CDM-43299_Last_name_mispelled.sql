/*
  Issue Description:  CDM-43198
   Category/ Module  : Person tab
   Root cause: User requested to correct the mispelled last name
   Pull request# for code fix: 
   Reason why no related code fix: user requested 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
/*
select * from person where cjamspid = '204041993'; 
*/
update person 
set lastname ='Ehrenreich',--Ehreneich
	updatedby = 'CDM-43299',
	updatedon  =now() 
where cjamspid = '204041993' 
	and personid = '6463e7a1-db90-4525-b6c0-12440f364a14'
	and activeflag = 1;