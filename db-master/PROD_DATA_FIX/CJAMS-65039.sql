
/*
Issue: CJAMS-65039 Pathway Change Review
Category/Module: Placement (Case Management)
Root cause:  There is a Pathway Change Review pending in the approval inbox. However, there is nothing actually pending approval in the associated investigation.
Fix provided: Datafix has been promoted to remove the pathway change review
Data/Code fix ticket#: CJAMS-65039
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data entry error.
*/
update routing set activeflag =0,updatedby ='CJAMS-65039',updatedon =now()
where objectid='a668a2b9-9918-4228-ba30-c0aa83f045d3' and activeflag=1 and routingid='985fbf61-c605-4b98-b386-3c585c356edb';