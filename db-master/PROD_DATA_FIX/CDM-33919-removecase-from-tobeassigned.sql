/*
   Issue Description: CDM-33919
   Category/ Module  :Dashboard
   Root cause: Pending approval in assign inbox
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
update routing set routingstatustypeid  = 4 ,updatedby ='CDM-33919',updatedon =now() where routingid in('ad0219fc-2c6b-4a26-8ad6-58563e284c6d','3d9b807b-e441-4627-ac2e-f7c7c82de509','c2d9dc7e-7379-45bb-a296-f6fb3a126d43');