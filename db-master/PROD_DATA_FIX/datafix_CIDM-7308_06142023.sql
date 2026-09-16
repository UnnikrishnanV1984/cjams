-- CIDM-7308 - Upload user story in the release notes
/*
Update the release notes # Release/6.13.0 to add User Story B-165757

-- Category/ Module: Release notes
-- Root cause: Missed earlier. 
-- Fix Provided: Datafix to add User Story B-165757 under release notes # Release/6.13.0
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

delete from defecttracking.releasenotes where insertedby = 'CIDM-7308' ;

INSERT INTO defecttracking.releasenotes
	(	releasenotesid, releaseversionno, releasedate, application, 
		itemtype, itemid, 
		title, 
		description, 
		supportid, documentlink, activeflag, insertedby, insertedon, updatedby, updatedon, publish, raisedby)
VALUES
	(	gen_random_uuid(), 'Release/6.13.0', '2023-06-13', 'CW', 
		'Story', 'B-165757', 
		'CJAMS-CW--Contact Support Refinement', 
		'Description

1. The ''View Tickets'' from ''Contact Support'' will navigate to ''Contact Support Tickets'' detail page.

2. In ''Contact Support ticket'' details page, supervisors can view the number of tickets based on statuses and team assignments. It is displayed on the top right corner of the screen.

3. The support number search and advanced search is provided to filter the tickets.

4. Multi select option is provided for the supervisor to approve/reject pending tickets.

5. The complete details of the ticket will be visible from view action.

6. The ''JIRA Status'' field in the View Details will reflect the status of the corresponding ticket.

7. The ''view chart'' button will display various graphs based on Approval Status, Focus Area, team and month wise.

8. Supervisors will be notified with pending approval tickets count in their dashboar. On click of this icon, the Supervisor can see the tickets waiting for his/her approval.
', 
		NULL, NULL, 1, 
		'CIDM-7308', now(), 'CIDM-7308', now(), true, 'Hallie Persell'
	);


