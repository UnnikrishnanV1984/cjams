/*
   Issue Description: CDM-33138
   Category/ Module  :  contact notes
   Root cause: user unable to add a new contact
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

UPDATE cjams.userresource
SET activeflag = 0, updatedby = 'CDM-33138', updatedon = now()
WHERE userresourceid='68175372-eac2-4433-87d4-52c3ed61a327' and userid=9659 and roleid=3150;
