/*
   Issue Description: CJAMS-60408
   Category/ Module  : Person profile -->Safe haven child
   Root cause:As per system design, Age of the child should be less than or equal to 10 days to enable the safe haven baby checkbox. 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update person 
set safehavenbabyflag = 1,
	updatedby = 'CJAMS-60408',
	updatedon = now()
where personid = '52e0c58b-e5b6-4b21-a6d7-632c29dcea28'
and activeflag =1;

update personrole  
set safehavenbabyflag = 1,
	updatedby = 'CJAMS-60408',
	updatedon = now()
where personid = '52e0c58b-e5b6-4b21-a6d7-632c29dcea28'
and activeflag =1
and servicecaseid = '0771a6fe-8723-4727-9a4f-afcf059d097e';