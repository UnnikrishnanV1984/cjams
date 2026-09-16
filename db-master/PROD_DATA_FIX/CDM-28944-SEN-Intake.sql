/*
   Issue Description: CDM-28944
   Category/ Module  : 
   the wrong SEN intake is associated to the service case and the Assessments are done in a different Service case. (SEN baby is in both the Service Case ID's we need to get the data associated to this Service Case  221030014444  ).
   This is the New Intake that need's to be marked and as SEN Intake: I221010245640 
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update cjams.person set substanceexposednewbornsourceid='I221010245640',updatedby = 'CDM-28944',
updatedon = now() where cjamspid = 200872492;