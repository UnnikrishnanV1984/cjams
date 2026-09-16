		/*
   Issue Description: CDM-31530
   Category/ Module  : Serivelog Documents 
   Root cause: updating correct role 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/
        
        ----Adding document to the correct servicelog authid
        
        
        update cjams.documentproperties set additionalobjectid =2184766, updatedby='CDM-31530', updatedon = now()
		
		where documentpropertiesid ='8f2615a9-1e3a-4b6c-8347-4e62611680a9';