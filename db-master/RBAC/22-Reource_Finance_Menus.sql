INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('751c3a66-fd9a-42c4-a897-486394e82b3c', 'fe3c0612-2fd1-40e2-92a0-695e2db4eb5a', 'Accounts -> Child Accounts', 5, 1, 'admin', '2019-08-21 19:57:18.004', 'admin', '2019-08-21 19:57:18.004', 'childaccounts', NULL, NULL, 'Child Accounts', 'accounts', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('a85886ca-3ba2-4c93-bbaa-4d8b1bd74c15', 'fe3c0612-2fd1-40e2-92a0-695e2db4eb5a', 'Accounts -> Commingled Accounts', 5, 1, 'admin', '2019-08-21 19:57:18.004', 'admin', '2019-08-21 19:57:18.004', 'commingledaccounts', NULL, NULL, 'Commingled Accounts', 'accounts', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('1e429566-6618-40a7-a3a0-8da2731e8022', 'fe3c0612-2fd1-40e2-92a0-695e2db4eb5a', 'Accounts -> Recipts Fast entry', 5, 1, 'admin', '2019-08-21 19:57:18.004', 'admin', '2019-08-21 19:57:18.004', 'reciptsfastentry', NULL, NULL, 'Recipts Fast entry', 'accounts', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('5968eec7-e0ce-4f3f-b502-e06187fed8c9', 'e35c30a3-0cc3-4695-b309-bae67176bdb4', 'Accountspayable -> Maintenance/Subsidy Payment', 5, 1, 'admin', '2019-08-21 20:02:00.076', 'admin', '2019-08-21 20:02:00.076', 'maintenancesubsidypayment', NULL, NULL, 'Maintenance/Subsidy Payment', 'accountspayable', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('a912f8c2-8736-4978-bff9-0ca64d23416f', 'e35c30a3-0cc3-4695-b309-bae67176bdb4', 'Accountspayable - >Ancillary Payments', 5, 1, 'admin', '2019-08-21 20:02:00.076', 'admin', '2019-08-21 20:02:00.076', 'ancillarypayments', NULL, NULL, 'Ancillary Payments', 'accountspayable', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('4bbb294c-c519-46f7-be3a-4ee045030559', 'e35c30a3-0cc3-4695-b309-bae67176bdb4', 'Accountspayable  -> Ancillary payments Adjustment', 5, 1, 'admin', '2019-08-21 20:02:00.076', 'admin', '2019-08-21 20:02:00.076', 'ancillarypaymentsadjustment', NULL, NULL, 'Ancillary payments Adjustment', 'accountspayable', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('990b7256-0c76-455f-a509-b107dc555cc7', 'e35c30a3-0cc3-4695-b309-bae67176bdb4', 'Accountspayable  -> History', 5, 1, 'admin', '2019-08-21 20:02:00.076', 'admin', '2019-08-21 20:02:00.076', 'history', NULL, NULL, 'History', 'accountspayable', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('68f62424-b6cc-48ed-8820-b34107022162', 'e35c30a3-0cc3-4695-b309-bae67176bdb4', 'Accountspayable  -> Approval', 5, 1, 'admin', '2019-08-21 20:02:00.076', 'admin', '2019-08-21 20:02:00.076', 'approval', NULL, NULL, 'Approval', 'accountspayable', 'finance') ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('3813c729-f82d-4378-b460-df8b30ca8abb', 'f924dede-7242-4011-9364-feb7a1181540', 'Finance -> Vendor Pay File Calendar', 5, 1, 'admin', '2019-08-21 20:20:08.616', 'admin', '2019-08-21 20:20:08.616', 'vendorpayfilecalendar', NULL, NULL, 'Vendor Pay File Calendar', 'finance', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('4c5bbb28-7f8a-41f8-8b8c-b8a69634ea73', 'b8196927-dcb1-401c-93b6-547999d6f4c1', 'Financereferences -> Foster Care Rate', 5, 1, 'admin', '2019-08-21 20:09:47.029', 'admin', '2019-08-21 20:09:47.029', 'fostercarerate', NULL, NULL, 'Foster Care Rate', 'financereferences', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('3e0529fb-1697-4c11-bb2b-1e10584fde99', 'b8196927-dcb1-401c-93b6-547999d6f4c1', 'Financereferences -> Provider Checklist', 5, 1, 'admin', '2019-08-21 20:09:47.029', 'admin', '2019-08-21 20:09:47.029', 'providerchecklist', NULL, NULL, 'Provider Checklist', 'financereferences', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('8a0972ba-cf7b-4032-9eec-676558e3e9ee', '990b7256-0c76-455f-a509-b107dc555cc7', 'History -> Funding Source Allocation', 5, 1, 'admin', '2019-08-21 20:09:47.029', 'admin', '2019-08-21 20:09:47.029', 'fundingsourceallocation', NULL, NULL, 'Funding Source Allocation', 'history', 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('05d0162c-10f7-4058-8ff3-7382cdf7c9d4', '990b7256-0c76-455f-a509-b107dc555cc7', 'History -> Client Payment History', 5, 1, 'admin', '2019-08-21 20:09:47.029', 'admin', '2019-08-21 20:09:47.029', 'clientpaymenthistory', NULL, NULL, 'Client Payment History', 'history', 'finance')ON CONFLICT DO NOTHING;