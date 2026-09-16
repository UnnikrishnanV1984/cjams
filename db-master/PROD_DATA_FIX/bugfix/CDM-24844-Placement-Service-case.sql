/*
   Issue Description: CDM-24844
   Category/ Module  :   
   Root cause: Child removal is linked to CPS # 221020242250 and the child removal is not reflected in the placement tab. 
   So the user is not able to create the placement.Please do a data fix to change the Service case number to 3307700 in the child removal tab.
   Child removal should be reflected in the placement tab after the data fix.(We should fix the placement tab if the removal is not reflected after the data fix)
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update Intakeservreqchildremoval set servicecaseid = 'd380c0b2-e639-4100-8ce7-01b427667d0a',
updatedby = 'CDM-24844', updatedon = now() 
where intakeservreqchildremovalid = 'd483aee2-c464-4a7e-84a9-598b78b21eee' and activeflag = 1;