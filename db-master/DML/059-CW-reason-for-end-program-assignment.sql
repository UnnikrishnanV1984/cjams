INSERT INTO cjams.referencetype
(referencetypeid, typedescription, tablename, activeflag, insertedby, insertedon, updatedby, updatedon, flag)
VALUES(357, 'Reason for end - Program Assignment', 'Program Assignment', 1, 'Admin', now(), 'Admin', now(), NULL);


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES
('3401', 357, 'Case Converted To CINA', 'Case Converted To CINA', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3400', 357, 'Age Out, Individual Turned 21 Years Old', 'Age Out, Individual Turned 21 Years Old', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3399', 357, 'Court Closed Case', 'Court Closed Case', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3398', 357, 'Services By Other Agencies', 'Services By Other Agencies', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3397', 357, 'Department Denied Request', 'Department Denied Request', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3396', 357, 'Services Completed', 'Services Completed', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3395', 357, 'Other DSS Services Offered', 'Other DSS Services Offered', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3394', 357, 'Parent Withdrew Request', 'Parent Withdrew Request', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3393', 357, 'Services to be Given by Other', 'Services to be Given by Other', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3392', 357, 'Services to be Given by Another Provider', 'Services to be Given by Another Provider', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3391', 357, 'Services not Available', 'Services not Available', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3390', 357, 'Returned to Adult Caretaker', 'Returned to Adult Caretaker', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3389', 357, 'Parental Rights Terminated', 'Parental Rights Terminated', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3388', 357, 'Not Living in Home', 'Not Living in Home', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3387', 357, 'Moved Out of State', 'Moved Out of State', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3386', 357, 'Married', 'Married', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3385', 357, 'Legal Emanicipation', 'Legal Emanicipation', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3384', 357, 'Duplicate Client', 'Duplicate Client', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3383', 357, 'Divorce', 'Divorce', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3382', 357, 'Death', 'Death', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3381', 357, 'Court Action', 'Court Action', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3380', 357, 'Client''s Failure to Cooperate', 'Client''s Failure to Cooperate', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3379', 357, 'Child Welfare Services not Needed', 'Child Welfare Services not Needed', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3378', 357, 'Child Aged Out', 'Child Aged Out', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3377', 357, 'Cannot Locate', 'Cannot Locate', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3376', 357, 'Adoption Disruption', 'Adoption Disruption', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL),
('3375', 357, 'Adoption', 'Adoption', 'CW', 1, 1, 'Admin', now(), 'Admin', now(), NULL, NULL, NULL);