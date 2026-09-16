
/*
   Issue Description: CDM-37948
   Category/ Module  : End-Dated Case
   Root cause: Worker noticed the case was end dated and closed on 3/7/24. The case is active and should not be end dated.
   Pull request# for code fix: na
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update servicecase set statustypekey='Open',dispositioncode='Open', updatedby = 'CDM-37948', updatedon = now() 
where servicecasenumber='221030016422';