/*
   Issue Description: CDM-20405
   221020178631:Please correct CPS/CASE ID column for alleged victim, Davonte Hampton, listed in this AR Neglect case. The space where the case number belongs is blank.
   Category/ Module  :  CPS/Case ID Blank/Missing in PA
   Root cause: In programassignment case number is blank
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/


update
    personprogramarea
set
    entityid = '221020178631',
    updatedby = 'CDM-20405',
    updatedon = now()
where
    objectid = '3f11bb8b-9b2c-45f8-8a52-a697455eb01c'
    and personprogramid = '71e1fac8-4397-44d7-a22f-f46b302b96d6';