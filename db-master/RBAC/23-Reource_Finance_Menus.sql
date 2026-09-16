
--resource 

--FINANCE SUBMENUS

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('4f8eaba8-ff66-41b8-9a4c-9e88c944e319', 'b8196927-dcb1-401c-93b6-547999d6f4c1', 'Financereferences -> Provider Contract Rate', 5, 1, 'admin', '2019-08-29 15:47:22.053', 'admin', '2019-08-29 15:47:22.053', 'providercontractrate', NULL, NULL, 'Provider Contract Rate', 'financereferences', 'finance')ON CONFLICT DO NOTHING;


-- action
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('16fb6de8-e2ba-440f-a803-256135eece72', NULL, 'manage_interfacestatus_update', 4, 1, 'admin', '2019-08-26 13:23:39.428', 'admin', '2019-08-26 13:23:39.428', 'manage_interfacestatus_update', NULL, NULL, 'Manage Interfacetatus Update', NULL, 'Finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('37b64154-d7b8-4219-ac47-7497aa3c06d1', NULL, 'manage_receipt_add', 4, 1, 'admin', '2019-08-26 13:23:39.428', 'admin', '2019-08-26 13:23:39.428', 'manage_receipt_add', NULL, NULL, 'Manage Receipt Add (Public Provider)', NULL, 'Finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('9746dbbe-eac3-4c14-ab9b-87aab37c1cb9', NULL, 'manage_privatereceipt_add', 4, 1, 'admin', '2019-08-27 11:06:51.438', 'admin', '2019-08-27 11:06:51.438', 'manage_privatereceipt_add', NULL, NULL, 'Manage Receipt Add (Private Provider)', NULL, 'Finance')ON CONFLICT DO NOTHING;

-- finance dashboard screen

INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('d6cc707f-3cbe-4e3e-a287-bbffa38cd18d', NULL, 'Finance Dashboard - Commingled Transaction Approval', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'commingled-transaction-aproval', NULL, NULL, 'Commingled Transaction Approval', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('214990a3-c173-4cb3-a6ab-188b53d0b4f7', NULL, 'Finance Dashboard - Disbursement Approval', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'disbursement-approval', NULL, NULL, 'Disbursement Approval', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('c09dfb90-ea02-439e-9e32-baf4591c75d9', NULL, 'Finance Dashboard - Reversal Receipt Details', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'reversal-receipt-details', NULL, NULL, 'Reversal Receipt Details', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('82161616-5827-41f9-9bf3-ef1bc235443d', NULL, 'Finance Dashboard - Write Off Details', 3, 1, 'admin', '2019-08-29 12:42:10.442', 'admin', '2019-08-29 12:42:10.442', 'write-off-details', NULL, NULL, 'Write Off Details', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('4d84fbcd-d48a-4096-9bc6-20e8f161cf7e', NULL, 'Finance Dashboard - Ancillary Payment Adjustment', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'ancillary-payment-adjustment', NULL, NULL, 'Ancillary Payment Adjustment', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('dfc869c5-41d1-499c-98bc-b36d5e50a6b9', NULL, 'Finance Dashboard - Disbursement View', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'disbursement-view', NULL, NULL, 'Disbursement View', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('bbdd2b08-e961-4c63-9080-0cebf7c7bef2', NULL, 'Finance Dashboard - Purchase Authorization', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'purchase-authorization', NULL, NULL, 'Purchase Authorization', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('3c5b1136-690e-430a-8a47-71597b082237', NULL, 'Finance Dashboard - Conserved Balance Alert', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'conserved-balance-alert', NULL, NULL, 'Conserved Balance Alert', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('8747271e-172f-439c-b899-7b63c3ae99b9', NULL, 'Finance Dashboard - Child Account Transaction Error Correction', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'child-account-transaction-error-correction', NULL, NULL, 'Child Account Transaction Error Correction', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('77e0d145-e81f-4dac-a746-fa0633ae5f17', NULL, 'Finance Dashboard - Manual Receivable Details', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'manual-receivable-details', NULL, NULL, 'Manual Receivable Details', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('a180e74e-6a33-4522-a86d-dfacf46daa48', NULL, 'Finance Dashboard - Commingled Transaction Details', 3, 1, 'admin', '2019-08-29 12:42:10.442', 'admin', '2019-08-29 12:42:10.442', 'commingled-transaction-details', NULL, NULL, 'Commingled Transaction Details', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;


INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('d6cc707f-3cbe-4e3e-a287-bbffa38cd18d', NULL, 'Finance Dashboard - Commingled Transaction Approval', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'commingled-transaction-aproval', NULL, NULL, 'Commingled Transaction Approval', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('214990a3-c173-4cb3-a6ab-188b53d0b4f7', NULL, 'Finance Dashboard - Disbursement Approval', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'disbursement-approval', NULL, NULL, 'Disbursement Approval', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('c09dfb90-ea02-439e-9e32-baf4591c75d9', NULL, 'Finance Dashboard - Reversal Receipt Details', 3, 1, 'admin', '2019-08-29 12:49:59.370', 'admin', '2019-08-29 12:49:59.370', 'reversal-receipt-details', NULL, NULL, 'Reversal Receipt Details', 'finance-dashboard', 'finance-module')ON CONFLICT DO NOTHING;

----
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('b987dfa0-fec6-4fd9-82e8-a9a68351528a', NULL, 'Private-Provider', 1, 1, NULL, '2019-07-16 14:42:14.070', NULL, '2019-07-16 14:42:14.070', NULL, NULL, NULL, NULL, NULL, NULL)ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('7dfd3031-2603-4dec-b916-ae7ab7d9bd13', NULL, 'Finance References', 1, 1, 'admin', '2019-08-21 19:52:01.439', 'admin', '2019-08-21 19:52:01.439', 'financereferences', NULL, NULL, 'Finance References', NULL, 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('2e83f277-9e09-4dd6-be2a-7191a7ed3305', NULL, 'Accounts Payable', 1, 1, 'admin', '2019-08-21 19:52:01.439', 'admin', '2019-08-21 19:52:01.439', 'accountspayable', NULL, NULL, 'Accounts Payable', NULL, 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('a158f2c7-c1dc-40cd-b603-a4c82d3b5d9c', NULL, 'Accounts', 1, 1, 'admin', '2019-08-21 19:52:01.439', 'admin', '2019-08-21 19:52:01.439', 'accounts', NULL, NULL, 'Accounts', NULL, 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('c68d8222-3dfc-4f51-9713-a6784fd44889', NULL, 'Accounts Receivable', 1, 1, 'admin', '2019-08-21 19:52:01.439', 'admin', '2019-08-21 19:52:01.439', 'accountsreceivable', NULL, NULL, 'Accounts Receivable', NULL, 'finance')ON CONFLICT DO NOTHING;
INSERT INTO cjams.resource
(id, parentid, resourcename, resourcetype, activeflag, insertedby, insertedon, updatedby, updatedon, resourceid, tooltip, old_id, description, parentkey, modulekey)
VALUES('aa89d85e-763b-4b3b-9aa0-5b38b08ac086', NULL, 'Finance Vendor', 1, 1, 'admin', '2019-08-21 19:52:01.439', 'admin', '2019-08-21 19:52:01.439', 'financevendor', NULL, NULL, 'Finance Vendor', NULL, 'finance')ON CONFLICT DO NOTHING;
