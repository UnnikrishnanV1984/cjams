/*
   Issue Description: CDM-35124
   Category/ Module  : Prod data fix to update 'to be assigned' list in adoptioncase
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update routing set routingstatustypeid =4 ,updatedby ='CDM-35124',updatedon =now() where routingid ='d61862a8-3963-48c2-8378-dc8fd8572375';

update adoptioncase set statustypekey ='Open',updatedby ='CDM-35124',updatedon =now() where adoptioncaseid ='7ef8b110-bec8-4b01-9b5c-2794e165c703';