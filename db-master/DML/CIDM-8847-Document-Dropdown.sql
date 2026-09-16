



--Customer/Case Notification and History

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cuory', 1000, 'Customer/Case Notification and History', 'Customer/Case Notification and History', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, NULL, NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('acnce', 1000, 'Active Case Participant Clearance', 'Active Case Participant Clearance', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cpsest', 1000, 'CPS Background/Adam Walsh Background Clearance Request (DHR/SSA 1279A)', 'CPS Background/Adam Walsh Background Clearance Request (DHR/SSA 1279A)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('repecta', 1000, 'Report of Suspected Child Abuse/Neglect (DHR/SSA 180) ', 'Report of Suspected Child Abuse/Neglect (DHR/SSA 180) ', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('notorms', 1000, 'Notification of Substance Exposed Newborn Form (DHR/SSA 3010)', 'Notification of Substance Exposed Newborn Form (DHR/SSA 3010)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('nottch', 1000, 'Notification of Birth Match', 'Notification of Birth Match', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('fyiker', 1000, 'FYI Information to Active Worker', 'FYI Information to Active Worker', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('lawion', 1000, 'Law Enforcement Notification', 'Law Enforcement Notification', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ackter', 1000, 'Acknowledgement Letter', 'Acknowledgement Letter', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othory', 1000, 'Other Customer/ Case Notification and History', 'Other Customer/ Case Notification and History', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'cuory', NULL)on conflict do nothing;



--Finance / Home Information

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('finion', 1000, 'Finance / Home Information', 'Finance / Home Information', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, NULL, NULL)on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('purpts', 1000, 'Purchase Authorization/ Invoice/ Receipts', 'Purchase Authorization/ Invoice/ Receipts', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('incent', 1000, 'Income or Employment Document', 'Income or Employment Document', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('awaity', 1000, 'Award Letter from Social Security', 'Award Letter from Social Security', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('leaopy', 1000, 'Lease Copy', 'Lease Copy', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('biletc', 1000, 'Bill Copy (Water, BGE, Mortgage Statement, Rent Statement Etc.)', 'Bill Copy (Water, BGE, Mortgage Statement, Rent Statement Etc.)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('chiare', 1000, 'Child Care (Application, Attendance, Invoices Etc.)', 'Child Care (Application, Attendance, Invoices Etc.)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('famet', 1000, 'Family Unification Program Referral Packet', 'Family Unification Program Referral Packet', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('oneent', 1000, 'One on One Support Services Detailed Billing Statement ', 'One on One Support Services Detailed Billing Statement ', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('verorm', 1000, 'Verification of Non-Reimbursable Expenditures Form', 'Verification of Non-Reimbursable Expenditures Form', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othtion', 1000, 'Other Finance/ Home Information', 'Other Finance/ Home Information', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'finion', NULL)on conflict do nothing;





--Behavioral Health

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('behlth', 1000, 'Behavioral Health', 'Behavioral Health', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, NULL, NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('behent', 1000, 'Behavioral Health Assessment', 'Behavioral Health Assessment', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'behlth', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('psyion', 1000, 'Psychiatric Evaluation', 'Psychiatric Evaluation', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'behlth', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('psytion', 1000, 'Psychological Evaluation', 'Psychological Evaluation', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'behlth', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('psyua', 1000, 'Psychosocial Evaluation', 'Psychosocial Evaluation', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'behlth', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('psyary', 1000, 'Psychiatric Discharge Summary', 'Psychiatric Discharge Summary', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'behlth', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('tessis', 1000, 'Test Results/ Urinalysis', 'Test Results/ Urinalysis', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'behlth', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('susent', 1000, 'Substance Use/Abuse Document/ Assessment', 'Substance Use/Abuse Document/ Assessment', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'behlth', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othheal', 1000, 'Other Behavioral Health Document / Assessment', 'Other Behavioral Health Document / Assessment', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'behlth', NULL)on conflict do nothing;







--Disability Services

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('disces', 1000, 'Disability Services', 'Disability Services', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, NULL, NULL)on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('devity', 1000, 'Developmental Disabilities Administration Application for Eligibility ', 'Developmental Disabilities Administration Application for Eligibility ', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ssiion', 1000, 'SSI/SSDI Outreach, Access, and Recovery (SOARS) Application', 'SSI/SSDI Outreach, Access, and Recovery (SOARS) Application', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('notits', 1000, 'Notification to Child’s Counsel for Title II and Title XVI Benefits (DHR/SSA 224)', 'Notification to Child’s Counsel for Title II and Title XVI Benefits (DHR/SSA 224)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('reqyeek', 1000, 'Request to be Selected as Representative Payee (SSA 11-BK)', 'Request to be Selected as Representative Payee (SSA 11-BK)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('aution', 1000, 'Authorization to Disclose Information to the Social Security Administration (SSA 827)', 'Authorization to Disclose Information to the Social Security Administration (SSA 827)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('apporm', 1000, 'Appointment of Representative Form (SSA 1696)', 'Appointment of Representative Form (SSA 1696)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('report4', 1000, 'Representative Payee Report (SSA 6234)', 'Representative Payee Report (SSA 6234)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('repunt', 1000, 'Representative Payee Report of Benefits & Dedicated Account (SSA 6233)', 'Representative Payee Report of Benefits & Dedicated Account (SSA 6233)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('reframy', 1000, 'Referral for Disability Benefits Advocacy Program', 'Referral for Disability Benefits Advocacy Program', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othcesy', 1000, 'Other Disability Services', 'Other Disability Services', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'disces', NULL)on conflict do nothing;




--ICPC

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('icpcn', 1000, 'ICPC', 'ICPC', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, NULL, NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('icpest', 1000, 'ICPC Request (Form 100A)', 'ICPC Request (Form 100A)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'icpcn', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('icptus', 1000, 'ICPC Report on Childs Placement Status (Form 100B)', 'ICPC Report on Childs Placement Status (Form 100B)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'icpcn', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('sencpc', 1000, 'Sending State Priority Home Study Request ICPC (Form 101)', 'Sending State Priority Home Study Request ICPC (Form 101)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'icpcn', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('reccpc', 1000, 'Receiving State Priority Home Study ICPC (Form 102)', 'Receiving States Priority Home Study ICPC (Form 102)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'icpcn', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('marlan', 1000, 'Maryland ICPC Financial/Medical Plan (Form 890)', 'Maryland ICPC Financial/Medical Plan (Form 890)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'icpcn', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('notion', 1000, 'Notice of Medicaid Eligibility/Case Activation ICAMA (Form 6.01)', 'Notice of Medicaid Eligibility/Case Activation ICAMA (Form 6.01)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'icpcn', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othcpc', 1000, 'Other ICPC', 'Other ICPC', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'icpcn', NULL)on conflict do nothing;




--Adoption/Guardianship

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('adohip', 1000, 'Adoption/Guardianship ', 'Adoption/Guardianship ', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, NULL, NULL)on conflict do nothing;




INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('addeer', 1000, 'Adoption Decree or Order', 'Adoption Decree or Order', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cuship', 1000, 'Custody and Guardianship Decree', 'Custody and Guardianship Decree', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('conhip', 1000, 'Consent to Guardianship (MD Form 9-102.1)', 'Consent to Guardianship (MD Form 9-102.1)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('guaram', 1000, 'Guardianship Assistance Program Application (DHS/SSA 3036)', 'Guardianship Assistance Program Application (DHS/SSA 3036)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('guncnt', 1000, 'Guardianship Assistance Agreement (DHS/SSA 2039)', 'Guardianship Assistance Agreement (DHS/SSA 2039)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('sucipce', 1000, 'Successor Guardian Guardianship Assistance Agreement (DHS/SSA 2039B)', 'Successor Guardian Guardianship Assistance Agreement (DHS/SSA 2039B)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('guntor', 1000, 'Guardianship Assistance Agreement Successor Guardian Addendum (DHS/SSA 2039A)', 'Guardianship Assistance Agreement Successor Guardian Addendum (DHS/SSA 2039A)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('hodyip', 1000, 'Home Study for Custody and Guardianship (DHS/SSA 2005)', 'Home Study for Custody and Guardianship (DHS/SSA 2005)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('anorce', 1000, 'Annual Reapplication for Guardianship Assistance (DHS/SSA 3038)', 'Annual Reapplication for Guardianship Assistance (DHS/SSA 3038)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('authon', 1000, 'Authorization for Release of Health Information (DHS/SSA 2000-A)', 'Authorization for Release of Health Information (DHS/SSA 2000-A)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('docondy', 1000, 'Documentation and Justification of Eligibility Requirements for GAP Subsidy', 'Documentation and Justification of Eligibility Requirements for GAP Subsidy', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ticent', 1000, 'Title IVE- Adoption Assistance Agreement (DHS/SSA 3034)', 'Title IVE- Adoption Assistance Agreement (DHS/SSA 3034)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('redlece', 1000, 'Redetermination for Title IVE Adoption Assistance (DHS/SSA 6.113 (IV-E))', 'Redetermination for Title IVE Adoption Assistance (DHS/SSA 6.113 (IV-E))', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('rednta', 1000, 'Redetermination for State Adoption Agreement (DHS/SSA 2041)', 'Redetermination for State Adoption Agreement (DHS/SSA 2041)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('aglyta', 1000, 'Agreement for One-Time-Only Assistance (DHS/SSA 3035)', 'Agreement for One-Time-Only Assistance (DHS/SSA 3035)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('adntds', 1000, 'Adoption State Agreement for Special Needs (DHS/SSA 2043)', 'Adoption State Agreement for Special Needs (DHS/SSA 2043)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('reorce', 1000, 'Request for Initial and/or Increase in Adoption Assistance (DHS/SSA 3030)', 'Request for Initial and/or Increase in Adoption Assistance (DHS/SSA 3030)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('adfirm', 1000, 'Adoption Assistance Justification Form ', 'Adoption Assistance Justification Form ', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('adceer', 1000, 'Adoption/ Guardianship Assistance Suspension Intended Action Letter', 'Adoption/ Guardianship Assistance Suspension Intended Action Letter', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('adewsi', 1000, 'Adoption Assistance Committee Review - SSA Written Decision', 'Adoption Assistance Committee Review - SSA Written Decision', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ovueey', 1000, 'Over 18 Years Old Verification to Continue Adoption Assistancey', 'Over 18 Years Old Verification to Continue Adoption Assistance', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othonip', 1000, 'Other Adoption/ Guardianship', 'Other Adoption/ Guardianship', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adohip', NULL)on conflict do nothing;


update cjams.referencevalues set value_text  ='Over 18 Years Old Verification to Continue Adoption Assistance', 
description ='Over 18 Years Old Verification to Continue Adoption Assistance',  updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='ovueey' and  parentkey  ='adohip';


--Adoption Search Services

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('adoices', 1000, 'Adoption Search Services', 'Adoption Search Services', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, NULL, NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('appoment', 1000, 'Application Form for Minor In Out-Of-Home Placement (DHR/SSA 2088)', 'Application Form for Minor In Out-Of-Home Placement (DHR/SSA 2088)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adoices', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('conagent', 1000, 'Confidential Intermediary Service Agreement for Minor in Out-Of -Home Placement (DHR/SSA 2091)', 'Confidential Intermediary Service Agreement for Minor in Out-Of -Home Placement (DHR/SSA 2091)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adoices', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('conspla', 1000, 'Consent to Release Information Form for Minor in Out-Of-Home Placement (DHR/SSA 2090)', 'Consent to Release Information Form for Minor in Out-Of-Home Placement (DHR/SSA 2090)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adoices', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('staomet', 1000, 'Status Report - Minor in Out-Of-Home Placement (DHR/SSA 2092)', 'Status Report - Minor in Out-Of-Home Placement (DHR/SSA 2092)', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adoices', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othonce', 1000, 'Other Adoption Search Services', 'Other Adoption Search Services', 'CW', 1, 1, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'adoices', NULL)on conflict do nothing;



--Protection


update cjams.referencevalues set activeflag= 0 , updatedby='CIDM-8847', updatedon =now()
where ref_key in('apprk','cpsba','lawon', 'inter', 'recide','repect', 'planre', 'cpsces', 'notorm','arner','irner' ) and referencetypeid =1000 and parentkey ='prot';



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('recides', 1000,  'Receipt of Parent’s Guide', 'Receipt of Parent’s Guide', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'prot', NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('mulings', 1000,  'Multi-D Meeting Notes', 'Multi-D Meeting Notes', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('supevie', 1000,  'Supporting Case Evidence', 'Supporting Case Evidence', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('offatio', 1000,  'Office of Child Care Administration Coordination', 'Office of Child Care Administration Coordination', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('irarer', 1000,  'IR/AR Notification of Closing Letter', 'IR/AR Notification of Closing Letter', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('notealy', 1000,  'Notice of Action/Opportunity to Appeal', 'Notice of Action/Opportunity to Appeal', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'prot', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othproon', 1000,  'Other Protection', 'Other Protection', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'prot', NULL)on conflict do nothing;



--Assessments

update cjams.referencevalues set activeflag= 0 , updatedby='CIDM-8847', updatedon =now()
where ref_key in('subent','homeent' ) and referencetypeid =1000 and parentkey ='assnts';


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('biraryh', 1000,  'Birth Match Summary', 'Birth Match Summary', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'assnts', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('horert', 1000,  'Home Health Report (DHR/SSA 1083)', 'Home Health Report (DHR/SSA 1083)', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'assnts', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('domlesc', 1000,  'Domestic Violence Lethality Screen', 'Domestic Violence Lethality Screen', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'assnts', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('fadhry', 1000,  'Family Find Summary (DHR/SSA 2085)', 'Family Find Summary (DHR/SSA 2085)', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'assnts', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othasen', 1000,  'Other Assessments ', 'Other Assessments ', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'assnts', NULL)on conflict do nothing;



--1080 Notification Series
update cjams.referencevalues set activeflag= 0 , updatedby='CIDM-8847', updatedon =now()
where ref_key in('pubecy' ) and referencetypeid =1000 and parentkey ='1080es';



--Child Personal Information


update cjams.referencevalues set value_text= 'Personal Information' ,description='Personal Information', updatedby='CIDM-8847', updatedon =now()
where ref_key in('childon') and referencetypeid =1000;

update cjams.referencevalues set value_text ='Social Security (Federal Form SS-5)', description ='Social Security (Federal Form SS-5)', updatedby='CIDM-8847', updatedon =now()
where ref_key in('rep234') and referencetypeid =1000;


update cjams.referencevalues set activeflag= 0 , updatedby='CIDM-8847', updatedon =now()
where ref_key in('curoto','socest','appo96', 'cons827', 'not224','Other2', 'refram','rep623', 'rep624','reqyee') and referencetypeid =1000 and parentkey ='childon';


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('bircelace', 1000,  'Birth Certificate Replacement Request', 'Birth Certificate Replacement Request', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('clieoto', 1000,  'Client Photo', 'Client Photo', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('dristad', 1000, 'Driver''s License or State ID', 'Driver''s License or State ID', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)
ON CONFLICT DO NOTHING;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('protusp', 1000,  'Proof of Citizenship Status', 'Proof of Citizenship Status', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('polrepo', 1000,  'Police Report', 'Police Report', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('legumets', 1000,  'Legal Documents', 'Legal Documents', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ncmeing', 1000,  'NCMEC Website Filing ', 'NCMEC Website Filing ', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('runlice', 1000,  'Runaway Police Report ', 'Runaway Police Report ', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('tranaref', 1000,  'Trafficking Navigator Referral', 'Trafficking Navigator Referral', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('deacerca', 1000,  'Death Certificate ', 'Death Certificate', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othperfor', 1000,  'Other Personal Information ', 'Other Personal Information', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'childon', NULL)on conflict do nothing;






--Ready by 21

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('youform', 1000, 'Youth Acknowledgement Form (DHR/SSA 2089)', 'Youth Acknowledgement Form (DHR/SSA 2089)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('resume21', 1000, 'Resume', 'Resume', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('liftions', 1000, 'Life Skill Training Documentation', 'Life Skill Training Documentation', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('silaapp', 1000, 'SILA Application', 'SILA Application', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('fostter', 1000, 'Foster Care Verification Letter', 'Foster Care Verification Letter', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('fosdocm', 1000, 'Foster Youth Savings Program Verification Documents', 'Foster Youth Savings Program Verification Documents', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('annrepo', 1000, 'Annual Credit Report ', 'Annual Credit Report ', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('credisle', 1000, 'Credit Reporting Agency Dispute Letter', 'Credit Reporting Agency Dispute Letter', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('encavol', 1000, 'Enhanced After Care Voluntary Placement Agreement (DHR/SSA 2032B)', 'Enhanced After Care Voluntary Placement Agreement (DHR/SSA 2032B)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('casskas', 1000, 'Casey Life Skills Assessment', 'Casey Life Skills Assessment', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othread2', 1000, 'Other Ready By 21', 'Other Ready By 21', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ytp', NULL)on conflict do nothing;



--placement


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('affpover', 1000, 'Affidavit of Potential Kinship Caregiver (DHS/SSA 3011)', 'Affidavit of Potential Kinship Caregiver (DHS/SSA 3011)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('plarefor', 1000, 'Placement Referral Form (DHS/SSA 3026)', 'Placement Referral Form (DHS/SSA 3026)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('writcval', 1000, 'Written Notice to TCA and Recipients Re: Removal', 'Written Notice to TCA and Recipients Re: Removal', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('relnochi', 1000, 'Relative Notification of Child Entering Out of Home Placement', 'Relative Notification of Child Entering Out of Home Placement', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('wrinotri', 1000, 'Written Notice to Tribe', 'Written Notice to Tribe', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('foscarre', 1000, 'Foster Care and Kinship Care Respite Services Request Form (DHR/SSA 2002)', 'Foster Care and Kinship Care Respite Services Request Form (DHR/SSA 2002)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('loctesur', 1000, 'Local Care Team Summary', 'Local Care Team Summary', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('chiagtrla', 1000, 'Child Placement Agency Treatment Plan', 'Child Placement Agency Treatment Plan', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('difdoccar', 1000, 'Difficulty of Care Documentation', 'Difficulty of Care Documentation', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('exrepat', 1000, 'Exception Request Packet (DHR/SSA 1310 A B C D)', 'Exception Request Packet (DHR/SSA 1310 A B C D)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('trtemi', 1000, 'Treatment Team Minutes', 'Treatment Team Minutes', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('trteinno', 1000, 'Treatment Team Invitation Notice', 'Treatment Team Invitation Notice', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('reexshpl', 1000, 'Request for Extension, Short-Term Placement Form', 'Request for Extension, Short-Term Placement Form', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('noplenex', 1000, 'Notification of Placement Entry and Exit Form (DHR/SSA 2030 for Child Specific Agreement)', 'Notification of Placement Entry and Exit Form (DHR/SSA 2030 for Child Specific Agreement)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('plfoqrnt', 1000, 'Placement Referral Form QRTP Assessment (DHS/SSA 3027)', 'Placement Referral Form QRTP Assessment (DHS/SSA 3027)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('concastan', 1000, 'Congregate Care Step Down Plan', 'Congregate Care Step Down Plan', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('uncaapsa', 1000, 'Under 13 Congregate Care Approval (SSA Approval Memo)', 'Under 13 Congregate Care Approval (SSA Approval Memo)	', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cerneofl', 1000, 'Certificate of Need for Level of Care', 'Certificate of Need for Level of Care', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('efseplorm', 1000, 'Efforts to Secure Placement Form', 'Efforts to Secure Placement Form', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('placdeer', 1000, 'Placement Acceptance or Denial Letter', 'Placement Acceptance or Denial Letter', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('chidivol', 1000, 'Children with Disabilities Voluntary Placement Checklist/ Approval (DHR/SSA 296)', 'Children with Disabilities Voluntary Placement Checklist/ Approval (DHR/SSA 296)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ivinmest', 1000, 'IV-A/ IV-D Information Memo/Action Request (957 Form)', 'IV-A/ IV-D Information Memo/Action Request (957 Form)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('refahein', 1000, 'Request for Fair Hearing (DHS/FIA 334)', 'Request for Fair Hearing (DHS/FIA 334)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('chidisvol', 1000, 'Children with Disabilities Voluntary Placement Agreement (DHR/SSA 582)', 'Children with Disabilities Voluntary Placement Agreement (DHR/SSA 582)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('volplaaser', 1000, 'Voluntary Placement Assessment Letter (DHR/SSA 782)', 'Voluntary Placement Assessment Letter (DHR/SSA 782)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('timevol', 1000, 'Time-Limited Voluntary Placement Agreement (DHR/SSA 830-E)', 'Time-Limited Voluntary Placement Agreement (DHR/SSA 830-E)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('perreorm', 1000, 'Periodic Treatment Review Form ', 'Periodic Treatment Review Form ', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('trrepaag', 1000, 'Treatment Resource Parent Agreement (DHR/SSA 1300)', 'Treatment Resource Parent Agreement (DHR/SSA 1300)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('trpaagad', 1000, 'Treatment Resource Parent Agreement Addendum (DHR/SSA 1301)', 'Treatment Resource Parent Agreement Addendum (DHR/SSA 1301)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('otcementr', 1000, 'Other Placement', 'Other Placement', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'placementprf', NULL)on conflict do nothing;


--Education 


update cjams.referencevalues set value_text= 'Other Education' ,description='Other Education', updatedby='CIDM-8847', updatedon =now()
where ref_key in('Other1') and referencetypeid =1000 and  parentkey ='edution';


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('traplan', 1000, 'Transportation Plan', 'Transportation Plan', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'edution', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('indieduc', 1000, 'Individualized Education Plan', 'Individualized Education Plan', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'edution', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('attcord', 1000, 'Attendance Records', 'Attendance Records	', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'edution', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('finawar', 1000, 'Financial Aid Award Letter', 'Financial Aid Award Letter', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'edution', NULL) on conflict do nothing;

update cjams.referencevalues set activeflag  =0, updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='iep' and  parentkey  ='edution';

--court 


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('proorder', 1000, 'Protective Order / Peace Order', 'Protective Order / Peace Order', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ordeconduc', 1000, 'Order of Controlling Conduct', 'Order of Controlling Conduct', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ordevisio', 1000, 'Order of Protective Supervision', 'Order of Protective Supervision', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('annnobe', 1000, 'Annual Notification of Benefits', 'Annual Notification of Benefits', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('respanot', 1000, 'Resource Parent Notification of Court Hearing', 'Resource Parent Notification of Court Hearing', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('parecouhe', 1000, 'Parent Notification of Court Hearing', 'Parent Notification of Court Hearing', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('qrtpheor', 1000, 'QRTP Hearing Order', 'QRTP Hearing Order', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('decofgua', 1000, 'Decree of Guardianship to DSS', 'Decree of Guardianship to DSS', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('guarevord', 1000, 'Guardianship Review Order', 'Guardianship Review Order', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('adopetion', 1000, 'Adoption Petition', 'Adoption Petition', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('resorder', 1000, 'Rescission Order', 'Rescission Order', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('casaporrt', 1000, 'CASA Report', 'CASA Report', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('waivetion', 1000, 'Waiver of Reunification ', 'Waiver of Reunification ', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('couport', 1000, 'Court Report', 'Court Report', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;



INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('volutader', 1000, 'Voluntary Placement Hearing Order', 'Voluntary Placement Hearing Order', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('supdocum', 1000, 'Supporting Court Documents (I.e. Discovery)', 'Supporting Court Documents (I.e. Discovery)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Court', NULL) on conflict do nothing;


update cjams.referencevalues set activeflag  =0, updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='noting' and  parentkey  ='Court';

update cjams.referencevalues set value_text  ='Permanency Planning Review Hearing Court Order (Periodic Review/ CINA Review)', description ='Permanency Planning Review Hearing Court Order (Periodic Review/ CINA Review)',  updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='perder' and  parentkey  ='Court';

update cjams.referencevalues set value_text ='Other Court', description ='Other Court', updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='ottry' and  parentkey  ='Court';




---Consents

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('consreal', 1000, 'Consent for Release of Confidential Alcohol and Other Drug Information Form (DHR/SSA 1185)', 'Consent for Release of Confidential Alcohol and Other Drug Information Form (DHR/SSA 1185)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'consent', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('disvetod', 1000, 'Disclosure Veto (DHR/SSA 2072)', 'Disclosure Veto (DHR/SSA 2072)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'consent', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('parenauoc', 1000, 'Parental Authorization of Care of a Child by a Caregiver (DHS/SSA 3014)', 'Parental Authorization of Care of a Child by a Caregiver (DHS/SSA 3014)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'consent', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('consrelco', 1000, 'Consent for the Release of Confidential Information by Substance Use Assessment and Treatment Providers to LDSS (DHR/SSA 3007 )', 'Consent for the Release of Confidential Information by Substance Use Assessment and Treatment Providers to LDSS (DHR/SSA 3007 )', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'consent', NULL) on conflict do nothing;




--Medical/Dental Health

update cjams.referencevalues set value_text= 'Medical/Dental Health' ,description='Medical/Dental Health', updatedby='CIDM-8847', updatedon =now()
where ref_key in('medts') and referencetypeid =1000;

update cjams.referencevalues set value_text= 'Annual Exam/EPSDT Exam (Form 631-E)' ,description='Annual Exam/EPSDT Exam (Form 631-E)', updatedby='CIDM-8847', updatedon =now()
where ref_key in('annam') and referencetypeid =1000 and  parentkey ='medts';

update cjams.referencevalues set value_text= 'Health Care Services Authorization Form (DHS/SSA 3032)' ,description='Health Care Services Authorization Form (DHS/SSA 3032)', updatedby='CIDM-8847', updatedon =now()
where ref_key in('heaorm') and referencetypeid =1000 and  parentkey ='medts';

update cjams.referencevalues set value_text= 'Comprehensive Exam (Form 631-E )' ,description='Comprehensive Exam (Form 631-E )', updatedby='CIDM-8847', updatedon =now()
where ref_key in('comxam') and referencetypeid =1000 and  parentkey ='medts';

update cjams.referencevalues set value_text= 'Dental Exam (Form 631-E' ,description='Dental Exam (Form 631-E', updatedby='CIDM-8847', updatedon =now()
where ref_key in('denam') and referencetypeid =1000 and  parentkey ='medts';

update cjams.referencevalues set value_text= 'Vision Exam (Form 631-E)' ,description='Vision Exam (Form 631-E)', updatedby='CIDM-8847', updatedon =now()
where ref_key in('visam') and referencetypeid =1000 and  parentkey ='medts';

update cjams.referencevalues set value_text= 'Other Medical/ Dental ' ,description='Other Medical/ Dental ', updatedby='CIDM-8847', updatedon =now()
where ref_key in('otherds') and referencetypeid =1000 and  parentkey ='medts';



update cjams.referencevalues set activeflag  =0, updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='behrds' and  parentkey  ='medts';

update cjams.referencevalues set activeflag  =0, updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='heaort' and  parentkey  ='medts';

update cjams.referencevalues set activeflag  =0, updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='infocon' and  parentkey  ='medts';

update cjams.referencevalues set value_text  ='Initial Medical Exam (Form 631-E)', 
description ='Initial Medical Exam (Form 631-E)',  updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='iniam' and  parentkey  ='medts';


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('inftodal', 1000, 'Infants and Toddlers Referral ', 'Infants and Toddlers Referral ', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('conhecaaf', 1000, 'Consent for Health Care-Affidavit (DHS/SSA 554)', 'Consent for Health Care-Affidavit (DHS/SSA 554)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('heapasmed', 1000, 'Health Passport Medi-Alert (Form 631-A )', 'Health Passport Medi-Alert (Form 631-A )', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('heapaschi', 1000, 'Health Passport Child''s Health History (Form 631-B)', 'Health Passport Child''s Health History (Form 631-B)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('healdevst', 1000, 'Health Passport Developmental Status (Form 631-C )', 'Health Passport Developmental Status (Form 631-C )', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('heapacore', 1000, 'Health Passport Consent to Health Care and Release of Records (Form 631-F)', 'Health Passport Consent to Health Care and Release of Records (Form 631-F)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('healheacapa', 1000, 'Health Passport Receipt for Health Care Passport (Form 631-G)', 'Health Passport Receipt for Health Care Passport (Form 631-G)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('othafvis', 1000, 'Other After Visit Summary', 'Other After Visit Summary', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('imztioh', 1000, 'Immunization', 'Immunization', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('medcainsu', 1000, 'Medical Card/ Insurance', 'Medical Card/ Insurance', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('tesults', 1000, 'Test Results', 'Test Results', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'medts', NULL) on conflict do nothing;





--Other Case Management 

update cjams.referencevalues set value_text= 'Other Case Management' ,description='Other Case Management', updatedby='CIDM-8847', updatedon =now()
where ref_key in('Other') and referencetypeid =1000;

update cjams.referencevalues set value_text= 'Other Case Management' ,description='Other Case Management', updatedby='CIDM-8847', updatedon =now()
where ref_key in('other4') and referencetypeid =1000 and  parentkey ='Other';


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('plansare', 1000, 'Plan of Safe Care (DHS/SSA 3008)', 'Plan of Safe Care (DHS/SSA 3008)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('seragnt', 1000, 'Service Agreement (signed)', 'Service Agreement (signed)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('serplam', 1000, 'Service Plan (signed)', 'Service Plan (signed)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('visplan', 1000, 'Visitation Plan', 'Visitation Plan', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('intacle', 1000, 'Intended Action Letter (DHS/SSA 1068A/B)', 'Intended Action Letter (DHS/SSA 1068A/B)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('direapra', 1000, 'Director Approval', 'Director Approval', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ssamemo', 1000, 'SSA Approval Memo', 'SSA Approval Memo', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('refserv', 1000, 'Referral for Services ', 'Referral for Services ', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('resprovi', 1000, 'Resources Provided', 'Resources Provided', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('famserrev', 1000, 'Family Service Review (DHR/SSA 3003)', 'Family Service Review (DHR/SSA 3003)', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('malrere', 1000, 'Mail Return Receipt ', 'Mail Return Receipt ', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('cizrebo', 1000, 'Citizens Review Board For Children Case Review', 'Citizens Review Board For Children Case Review', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('outlence', 1000, 'Outreach Letters/ Other Correspondence ', 'Outreach Letters/ Other Correspondence ', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('handnot', 1000, 'Handwritten Notes', 'Handwritten Notes', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('reqreco', 1000, 'Request for Records ', 'Request for Records ', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'Other', NULL) on conflict do nothing;


update cjams.referencevalues set activeflag  =0, updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='birary' and  parentkey  ='Other';

update cjams.referencevalues set activeflag  =0, updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='purice' and  parentkey  ='Other';

update cjams.referencevalues set activeflag  =0, updatedby  ='CIDM-8847', updatedon  = now()
where referencetypeid  =1000 and ref_key ='tralan' and  parentkey  ='Other';

---Title IV-E

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('otherive', 1000, 'Other Title IV-E', 'Other Title IV-E', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'titiv', NULL) on conflict do nothing;


--These values are inserted as part of CIDM-8847 but that story is on hold, but in CIDM-8847 (Current story) they requested these changes so i am inculding changes as part of this story

--Family Team Decision Meeting

delete from cjams.referencevalues where referencetypeid = 1000 and ref_key='ftdmeet';


INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('ftdmeet', 1000, 'Family Team Decision Meeting', 'Family Team Decision Meeting', 'CW', 1, null, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, NULL, NULL) on conflict do nothing;

delete from cjams.referencevalues where referencetypeid = 1000 and ref_key='fmcf';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('fmcf', 1000, 'Facilitated Meeting Consent Form', 'Facilitated Meeting Consent Form', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ftdmeet', NULL) on conflict do nothing;

delete from cjams.referencevalues where referencetypeid = 1000 and ref_key='fmca';

INSERT INTO cjams.referencevalues 
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('fmca', 1000, 'Facilitated Meeting Confidentiality Agreement', 'Facilitated Meeting Confidentiality Agreement', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ftdmeet', NULL) on conflict do nothing;

delete from cjams.referencevalues where referencetypeid = 1000 and ref_key='fmsummar';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('fmsummar', 1000, 'FTDM Summary', 'FTDM Summary', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ftdmeet', NULL) on conflict do nothing;

delete from cjams.referencevalues where referencetypeid = 1000 and ref_key='otherftdm';

INSERT INTO cjams.referencevalues
(ref_key, referencetypeid, value_text, description, teamtypekey, activeflag, displayorder, insertedby, insertedon, updatedby, updatedon, parenttypeid, parentkey, mdmcode)
VALUES('otherftdm', 1000, 'Other FTDM', 'Other FTDM', 'CW', 1, NULL, 'CIDM-8847', now(), 'CIDM-8847', now(), NULL, 'ftdmeet', NULL) on conflict do nothing;