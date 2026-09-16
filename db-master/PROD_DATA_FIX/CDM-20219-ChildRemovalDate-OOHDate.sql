
	/*
   Issue Description: CDM-20219
   Category/ Module  : Child Removal End date and OOH End date
   Root cause: user wants to end date removal and ooh date 
   Pull request# for code fix: 4761
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Case is closed without closing removal and placement. Need to do data fix
*/
update intakeservreqchildremoval set exitdate = null, updatedby = 'CDM-20219', updatedon = now()
where intakeservreqchildremovalid = 'b4811b7b-3aff-4bf8-9d1a-df3fdd9f417c';

update personprogramarea set enddate = null, updatedby = 'CDM-20219', updatedon = now() 
where personprogramid = '21bd994f-32be-4736-999f-d347bfd0b281';