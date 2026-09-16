/*
   Issue Description: CDM-32025
   Category/ Module  : Prod data fix to update inserted user details for contact notes
   Root cause: 
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/





-- CDM-32152
--ef3032b3-2f5a-4b48-8b27-c33cf654abf6
 update documentproperties set insertedby = 'd60833e2-0cd8-4d30-9222-9d144490cac3', updatedby = 'CDM-32152', updatedon = now()
where documentpropertiesid in ('1e31b499-41b5-4886-b066-8d3f482939c1');



-- CDM-32152
--ef3032b3-2f5a-4b48-8b27-c33cf654abf6
 update documentattachment set insertedby = 'd60833e2-0cd8-4d30-9222-9d144490cac3', updatedby = 'CDM-32152', updatedon = now()
where documentpropertiesid in ('1e31b499-41b5-4886-b066-8d3f482939c1');
