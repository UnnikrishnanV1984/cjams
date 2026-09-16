/*
  Issue Description:  CDM-38367
   Category/ Module  :  Title IV-E
   Root cause: Jurisdiction not populating 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
   Backup before update/ delete: 
*/
update guardianship 
set primaryrelationshipkey = 'Relative', updatedby = 'CDM-38367', updatedon =  now()
where gapid = 'c8f69d95-190b-48f4-bc1a-e430e6fdc30b';

Update gapeligibilityinfo 
set childjurisdiction='Baltimore City',primaryguardianisrelative='YES',primaryguardianrelationshipid = 1001,
    updatedon= now(), updatedby='CDM-38367'
where client_id = 4446574;