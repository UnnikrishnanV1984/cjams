ALTER TABLE cjams.adoptionapplicabilityinfo ADD childmeetsssimedicaldisabledeligliblerequirements varchar(10) NULL;
ALTER TABLE cjams.adoptionapplicabilityinfo ADD childreceivingssiatremoval varchar(10) NULL;
ALTER TABLE cjams.adoptionapplicabilityinfo ADD startdateofreceivingssi timestamp NULL;
ALTER TABLE cjams.adoptionapplicabilityinfo ADD adoptionbreakthelinkid uuid NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD nonapplsplneedscriteriainsecic12aorband3aorb varchar(10) NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD nonappltitleivestandardsofsecid1prioradptionaorbor2ivefcorssiaorb varchar(10) NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD appchildmeetchildstatuscriteriaofsectionia12or3 varchar(10) NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD appthespecialneedscriteriainsecic12aorband3aorb varchar(10) NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD nonappplacementormedicalcriteriaofsecib12or3 varchar(10) NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD appplacementormedicalcriteriaofsectionib12or3 varchar(10) NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD haschildbeenassessedtonotbeanappchild varchar(10) NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD applicableandnonapplicable varchar(10) NULL;
ALTER TABLE cjams.tb_ive_adoption_audit ADD neitheranappnornonappchildfortitleivepurposes varchar(10) NULL;
ALTER TABLE cjams.tb_ive_fostercare_audit ADD inputjson json NULL;
ALTER TABLE cjams.tb_ive_fostercare_audit ADD outputjson json NULL;
ALTER TABLE cjams.adoptionapplicabilityinfo ADD childssieligibilitystatus varchar(10) NULL;

