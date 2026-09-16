-- CDM-22754 - CJAMS approvals for over $3000 requested for supervisors in Charles Co.
/*
-- Issue Description: 
  User request to add Director Approval permissions for the below Charles County users
  
-- 95b57433-f7c8-4735-86af-87f726510a59	wanda.collins@maryland.gov (Wanda Collins) - 5009
-- dcc31ede-4dc7-446b-bc6d-fda4d8755cc2	markeeta.dixon@maryland.gov	(Markeeta Dixon) - 4897
-- 139c3716-d987-4ca9-9ce5-75929916dbab	deborah.guled@maryland.gov	(Deborah Guled) - 4971

-- Category/ Module: Service Log (Case Management) 
-- Root cause: N/A
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- To add Director Approval, CW permission group 
-- (Wanda Collins) - 5009 is already having Director Approval access

-- (Markeeta Dixon) - 4897

INSERT INTO cjams.userresource
	(	userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id
	)
VALUES
	(	gen_random_uuid(), 4897, '57a390b8-3387-428a-97a8-0b8559fd1f1e', 5984, NULL, 1, 
		'CDM-22754', now(), 'CDM-22754', now(), True, True, True, NULL
	);

-- (Deborah Guled) - 4971
INSERT INTO cjams.userresource
	(	userresourceid, userid, permissiongroupid, roleid, resourceid, activeflag, 
		insertedby, insertedon, updatedby, updatedon, isallowed, isvisible, isenabled, old_id
	)
VALUES
	(	gen_random_uuid(), 4971, '57a390b8-3387-428a-97a8-0b8559fd1f1e', 5984, NULL, 1, 
		'CDM-22754', now(), 'CDM-22754', now(), True, True, True, NULL
	);
	
