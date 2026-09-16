/*
   Issue Description: CDM-19637
   Category/ Module  : asked to change findings to indicated
   Root cause: User asked to change findings
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update investigationallegationmaltreators
set overridefindingtypekey = 'ID' ,
	updatedby = 'CDM-19637', 
	updatedon = now()
where investigationallegationmaltreatorsid = '7065f3a2-5ab6-4367-91bc-4664cfaeb3e7' 
	and activeflag = 1 ;