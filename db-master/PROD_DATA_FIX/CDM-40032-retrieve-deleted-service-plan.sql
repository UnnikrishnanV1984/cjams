/*
   Issue Description: CDM-40032:Service Plans Deleted by worker GAP subsidy.
   Category/ Module  : Services/Service plan
   Root cause: Foster care manager D. Page deleted Service Plans that were in restricted case record #221030017162 and wants them to be retrieved
   Fix provided : Data fix has been promoted to retrieve all the deleted service plans for the case from DB.
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/

update serviceplan 
set activeflag = 1,
    updatedby = 'CDM-40032',
    updatedon = now()
where objectid ='66a450c0-30af-4a52-9450-c5aef5a2f6f1'
and activeflag =0;