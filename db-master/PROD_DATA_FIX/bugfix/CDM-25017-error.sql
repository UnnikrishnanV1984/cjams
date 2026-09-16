-- CDM-25017-error
/*
   File Name: CDM-25017-error.sql
-- Issue Description: 
   User wants to delete the comments and also update name
    
  
-- Resolution: Updated the Flag to zero in the permanencyplan table for the servicerequestnumbers ('3265188')

-- Category/ Module: 
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

    update progressnote set 
	focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"dde5ec9f-ae2e-492f-9ae0-0df40a4a90d0","participantid":"dde5ec9f-ae2e-492f-9ae0-0df40a4a90d0","firstname":"LAKENYAH","lastname":"GRISWOLD","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
    updatedon = now(),
	updatedby = 'CDM-25017'
	where progressnoteid = '12bf8f77-de87-4fb3-a6fc-c2ef87c2b89e';
	
	update progressnote set 
	focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"dde5ec9f-ae2e-492f-9ae0-0df40a4a90d0","participantid":"dde5ec9f-ae2e-492f-9ae0-0df40a4a90d0","firstname":"LAKENYAH","lastname":"GRISWOLD","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
    updatedon = now(),
	updatedby = 'CDM-25017'
	where progressnoteid = '494407e9-5bc5-4b1c-b632-f822725e4b3d';
	
		
	update progressnote set 
	focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"dde5ec9f-ae2e-492f-9ae0-0df40a4a90d0","participantid":"dde5ec9f-ae2e-492f-9ae0-0df40a4a90d0","firstname":"LAKENYAH","lastname":"GRISWOLD","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
    updatedon = now(),
	updatedby = 'CDM-25017'
	where progressnoteid = 'f37cf074-42dc-42d7-9ba8-09f9cafc6c49';
			
	
	update progressnote set 
	focusperson = '{"focuspersonjson":[{"participanttypekey":"IP","intakeservicerequestactorid":"dde5ec9f-ae2e-492f-9ae0-0df40a4a90d0","participantid":"dde5ec9f-ae2e-492f-9ae0-0df40a4a90d0","firstname":"LAKENYAH","lastname":"GRISWOLD","address1":null,"address2":null,"city":null,"state":null,"zipcode":null,"email":null,"phonenumber":null}]}',
    updatedon = now(),
	updatedby = 'CDM-25017'
	where progressnoteid = 'e662c8ee-8841-4c0b-a6ff-afc8b80da447';

    update servicecasedisposition 
    set comments = null ,
    updatedon = now(),
	updatedby = 'CDM-25017'
    where servicecasedispositionid='7e040498-05ca-428a-b368-cf53a43ac768';

