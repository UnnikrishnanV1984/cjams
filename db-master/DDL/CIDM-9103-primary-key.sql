 /*
   Issue Description: CIDM-9103
   Category/ Module  :  List of Reporting Tables with no Primary Keys
   Root cause: Missing primary key
   Fix provided :
   Code fix ticket#:
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date:  
   Backup before update/ delete:
*/
ALTER TABLE childcharacteristics  ADD PRIMARY KEY (childcharid);
ALTER TABLE cpsresponsereassignhistory  ADD PRIMARY KEY (historyid);
ALTER TABLE otherchildren  ADD PRIMARY KEY (otherchildrenid);
ALTER TABLE personmergesummary  ADD PRIMARY KEY (clientmergeid);
ALTER TABLE provlicensingactivities  ADD PRIMARY KEY (provlicensingactivitiesid);
ALTER TABLE supervisorapprovals  ADD PRIMARY KEY (approvalid);
ALTER TABLE tb_account_fast_entry  ADD PRIMARY KEY (fast_entry_id);
ALTER TABLE adoptionemotionalties  ADD PRIMARY KEY (emotionaltieid);
ALTER TABLE agencyprogramarea  ADD PRIMARY KEY (agencyprogramareaid);
ALTER TABLE caseplan3servagreement  ADD PRIMARY KEY (caseplan3servagreementid);
ALTER TABLE caseclient  ADD PRIMARY KEY (caseclientid);
ALTER TABLE biologicaladoptionlink  ADD PRIMARY KEY (biologicaladoptionlinkid);
ALTER TABLE tb_fiscal_category_master  ADD PRIMARY KEY (fiscal_category_id);
ALTER TABLE tb_provider_closure_history  ADD PRIMARY KEY (history_id);
ALTER TABLE tb_cpa_office_homes  ADD PRIMARY KEY (cpa_office_homes_id);
ALTER TABLE tb_county_unit  ADD PRIMARY KEY (county_unit_id);
