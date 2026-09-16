/* 
    Issue Description: CJAMS-59039
  Category/ Module: Persons
  Root cause: User request to do a data fix to update the education program to Regular for the Client ID: 4168656 
  Fix provided : A data fix to update the education program to Regular for the Client ID: 4168656
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

update personeducation
	set educationtypekey = 'RGL',
		updatedby = 'CJAMS-59039',
		updatedon = now()
where personeducationid = 'aa836b3d-9926-4958-b2d8-398e8cba0dff'
  and personid = '9bf9b292-0d26-41f7-ad81-ea514c4588dd' 
  and activeflag = 1 ;