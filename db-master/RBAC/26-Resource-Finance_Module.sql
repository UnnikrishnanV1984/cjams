INSERT INTO resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('23de2f59-f901-4b56-91f7-68889e36c846', NULL, 'Finance Approval', 2, 1, 'admin', '2019-09-19 07:06:14.000', 'admin', '2019-09-19 07:06:14.000', 'financeapproval', NULL, NULL, 'Finance Approval', NULL, 'financeapproval')ON CONFLICT DO NOTHING;
INSERT INTO resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('99537727-ecdb-497a-958d-b731cb18f411', NULL, 'Finance', 2, 1, 'admin', '2019-09-19 07:04:53.000', 'admin', '2019-09-19 07:04:53.000', 'finance', NULL, NULL, 'Finance Worker Module', NULL, 'finance')ON CONFLICT DO NOTHING;

