/*
   Issue Description: CDM-30650
   Category/ Module  : Assessments(MIFRA)
   Root cause: User requested to remove the draft record
   Pull request# for code fix: 8763
   Reason why no related code fix: 
    requested a data fix to resolve
*/
update assessment set activeflag = 0, updatedon = now(), 
	updatedby = 'CDM-30650' 
where assessmentid = 'a79094e0-2f88-45a8-be42-250afd45e802';