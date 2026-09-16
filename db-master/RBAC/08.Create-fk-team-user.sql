delete from "assessmentcomments" where assessmentid in (select assessmentid from assessment where securityusersid not in (select securityusersid from securityusers));

delete from assessment where securityusersid not in (select securityusersid from securityusers);
delete from assignedassessment where securityusersid not in (select securityusersid from securityusers);
delete from intakeservicerequestuseraccess where securityusersid not in (select securityusersid from securityusers);
delete from intakesnapshot where approverusersid not in (select securityusersid from securityusers);
delete from routing where fromsecurityusersid not in (select securityusersid from securityusers);
delete from routing where tosecurityusersid not in (select securityusersid from securityusers);

ALTER TABLE actortypeagency ADD CONSTRAINT fk_actortypeagency_teamtypekey FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE agencyconfig ADD CONSTRAINT fk_agencyconfig_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE ammapping ADD CONSTRAINT fk_ammapping_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE assessmenttemplatecategoryfiltermap ADD CONSTRAINT fk_assessmenttemplate_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE assessmenttemplateroleconfig ADD CONSTRAINT fk_assessmenttemplateroleconfig_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE intakeserreqstatustyperoleconfig ADD CONSTRAINT fk_intakeserreqstatustyperoleconfig_teamtype FOREIGN KEY (teamtypekey) 
REFERENCES teamtype(teamtypekey);
ALTER TABLE intakeservreqinputtypeagency ADD CONSTRAINT fk_intakeservreqinputtypeagency_teamtypekey FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE notificationconfig ADD CONSTRAINT fk_notificationconfig_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE provideragencytypeconfig ADD CONSTRAINT fk_provideragencytypeconfig_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE referencevalues ADD CONSTRAINT fk_referencevalues_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE relationshiptypeagency ADD CONSTRAINT fk_relationshiptypeagency_teamtypekey FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE religionagencytypeconfig ADD CONSTRAINT fk_religionagencytypeconfig_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
-- ALTER TABLE servicerequesttypeconfigalert ADD CONSTRAINT fk_servicerequesttypeconfigalert_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE servicetype ADD CONSTRAINT fk_servicetype_teamtype FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE typesagencymapping ADD CONSTRAINT fk_typesagencymapping_teamtypekey FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
ALTER TABLE userprofile ADD CONSTRAINT fk_userprofile_teamptye FOREIGN KEY (teamtypekey) REFERENCES teamtype(teamtypekey);
 
ALTER TABLE activitylog ADD CONSTRAINT fk_activitylog_securityusers FOREIGN KEY (securityusersid)
REFERENCES securityusers(securityusersid);
ALTER TABLE alertlog ADD CONSTRAINT fk_alertlog_securityusers FOREIGN KEY (assignedsid)
REFERENCES securityusers(securityusersid);
ALTER TABLE alertstate ADD CONSTRAINT fk_alertstate_securityusers FOREIGN KEY (securityuserid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE alerttemplateuser ADD CONSTRAINT fk_alerttemplateuser_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE assessment ADD CONSTRAINT fk_assessment_securityuserid FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE assignedassessment ADD CONSTRAINT fk_assignedassessment_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE caregiver ADD CONSTRAINT fk_caregiver_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE careplanmanager ADD CONSTRAINT fk_careplanmanager_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE clientcasemanager ADD CONSTRAINT fk_clientcasemanager_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE customform ADD CONSTRAINT fk_customform_securityuserid FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE intakeservicerequestuseraccess ADD CONSTRAINT fk_intakeservicerequestuseraccess_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE intakesnapshot ADD CONSTRAINT fk_snapshot_securityusers FOREIGN KEY (approverusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE investigationfindingassessors ADD CONSTRAINT fk_investigationfindingassessors_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE paspecialtermsnsanction ADD CONSTRAINT fk_paspecialtermsnsanction_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE personrepresentativepayee ADD CONSTRAINT fk_personrepresentativepayee_personrepresentativeworkerid FOREIGN KEY (personrepresentativeworkerid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE provideragreementqas ADD CONSTRAINT fk__provideragreement_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE provideragreementsecurityuser ADD CONSTRAINT fk__provideragreementsecurityuser_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE routing ADD CONSTRAINT fk_fromid_routing_secrityuserforeign FOREIGN KEY (fromsecurityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE routing ADD CONSTRAINT fk_toid_routing_secrityuser FOREIGN KEY (tosecurityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE teammemberassignment ADD CONSTRAINT fk_teammemberassignment_securityusersid FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE usercredentials ADD CONSTRAINT fk_assignedassessment_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE userleaveplan ADD CONSTRAINT fk_userleaveplan_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE usernotification ADD CONSTRAINT fk_securityuser_usernotification FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE usernotificationmap ADD CONSTRAINT fk_usernotificationmap_securityusers FOREIGN KEY (tosecurityusersid) 
REFERENCES securityusers(securityusersid);
ALTER TABLE workitem ADD CONSTRAINT fk_workitem_securityusers FOREIGN KEY (securityusersid) 
REFERENCES securityusers(securityusersid); 
ALTER TABLE intakeserreqstatustyperoleconfig ADD CONSTRAINT fk_intakeserreqstatustyperoleconfig_teammemberroletype FOREIGN KEY (roletypekey)
REFERENCES teammemberroletype (roletypekey);
ALTER TABLE teammemberrolecategoryteammemberroletypemap ADD CONSTRAINT fk_servicerequesttypeconfigalertmapping_teammemberroletype FOREIGN KEY (roletypekey)
REFERENCES teammemberroletype (roletypekey);
ALTER TABLE intakeserreqstatustyperoleconfig ADD CONSTRAINT fk_teammemberrolecategoryteammemberroletypemap_teammemberroletype FOREIGN KEY (roletypekey)
REFERENCES teammemberroletype (roletypekey);

ALTER TABLE team ADD CONSTRAINT fk_team_parentteam FOREIGN KEY (parentteamid) REFERENCES team (teamid); 
ALTER TABLE teammemberrolecategoryteammemberroletypemap ADD CONSTRAINT fk_teammemberrolecategoryteammemberroletypemap_teammemberrolety FOREIGN KEY (roletypekey) 
REFERENCES teammemberroletype(roletypekey);