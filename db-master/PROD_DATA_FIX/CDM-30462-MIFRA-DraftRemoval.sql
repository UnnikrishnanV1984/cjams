/*
   Issue Description: CDM-30462
   Category/ Module  : Assessments MIFRA
   Root cause: user requested to remove drfat MIFRA record
   Pull request# for code fix: 8823
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: data fix
*/
update assessment set activeflag = 0, updatedon = now(), 
	updatedby = 'CDM-30462' 
where assessmentid = '1e2203d1-e5d2-4bea-b971-22c5fd790a9d';
