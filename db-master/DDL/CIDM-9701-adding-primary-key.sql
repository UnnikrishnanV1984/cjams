 /*
   Issue Description: Tables without primary
   Category/ Module:  List of Reporting Tables with no Primary Keys
   Root cause: Missing primary key (Old Tables)
   Fix provided: Adding primary key
   Code fix ticket#: CIDM-9701
   Reason why no related code fix: NA
*/
ALTER TABLE IF EXISTS cjams.agencypgmareaservice DROP CONSTRAINT IF EXISTS agencypgmareaservice_pkey;
ALTER TABLE IF EXISTS cjams.agencypgmareaservice add primary key (agencypgmareaserviceid);
ALTER TABLE IF EXISTS cjams.announcement DROP CONSTRAINT IF EXISTS announcement_pkey;
ALTER TABLE IF EXISTS cjams.announcement add primary key (announcementid);
ALTER TABLE IF EXISTS cjams.assessmenttemplatemappingdetail DROP CONSTRAINT IF EXISTS assessmenttemplatemappingdetail_pkey;
ALTER TABLE IF EXISTS cjams.assessmenttemplatemappingdetail add primary key (assessmenttemplatemappingid);
ALTER TABLE IF EXISTS cjams.assignmentclients DROP CONSTRAINT IF EXISTS assignmentclients_pkey;
ALTER TABLE IF EXISTS cjams.assignmentclients add primary key (assignmentclientid);
ALTER TABLE IF EXISTS cjams.caseconnectfromintake DROP CONSTRAINT IF EXISTS caseconnectfromintake_pkey;
ALTER TABLE IF EXISTS cjams.caseconnectfromintake add primary key (caseconnectfromintakeid);
ALTER TABLE IF EXISTS cjams.client DROP CONSTRAINT IF EXISTS client_pkey;
ALTER TABLE IF EXISTS cjams.client add primary key (clientid);
ALTER TABLE IF EXISTS cjams.inputfromsailpoint DROP CONSTRAINT IF EXISTS inputfromsailpoint_pkey;
ALTER TABLE IF EXISTS cjams.inputfromsailpoint add primary key (inputid);
ALTER TABLE IF EXISTS cjams.intakeappeal DROP CONSTRAINT IF EXISTS intakeappeal_pkey;
ALTER TABLE IF EXISTS cjams.intakeappeal add primary key (appealid);
ALTER TABLE IF EXISTS cjams.intakeserreqinterstateresidingconfig DROP CONSTRAINT IF EXISTS intakeserreqinterstateresidingconfig_pkey;
ALTER TABLE IF EXISTS cjams.intakeserreqinterstateresidingconfig add primary key (intakeserreqinterstateresidingconfigid);
ALTER TABLE IF EXISTS cjams.intakeserreqinterstatewarranttypeconfig DROP CONSTRAINT IF EXISTS intakeserreqinterstatewarranttypeconfig_pkey;
ALTER TABLE IF EXISTS cjams.intakeserreqinterstatewarranttypeconfig add primary key (intakeserreqinterstatewarranttypeconfigid);
ALTER TABLE IF EXISTS cjams.intakeservicerequestcourtdispositions DROP CONSTRAINT IF EXISTS intakeservicerequestcourtdispositions_pkey;
ALTER TABLE IF EXISTS cjams.intakeservicerequestcourtdispositions add primary key (intakeservicerequestcourtdispositionsid);
ALTER TABLE IF EXISTS cjams.investigationtasktype DROP CONSTRAINT IF EXISTS investigationtasktype_pkey;
ALTER TABLE IF EXISTS cjams.investigationtasktype add primary key (investigationtasktypeid);
ALTER TABLE IF EXISTS cjams.iveclientasset DROP CONSTRAINT IF EXISTS iveclientasset_pkey;
ALTER TABLE IF EXISTS cjams.iveclientasset add primary key (iveassetid);
ALTER TABLE IF EXISTS cjams.iveclientdeprivation DROP CONSTRAINT IF EXISTS iveclientdeprivation_pkey;
ALTER TABLE IF EXISTS cjams.iveclientdeprivation add primary key (ivedeprivationid);
ALTER TABLE IF EXISTS cjams.ldsslocations DROP CONSTRAINT IF EXISTS ldsslocations_pkey;
ALTER TABLE IF EXISTS cjams.ldsslocations add primary key (ldsslocationid);
ALTER TABLE IF EXISTS cjams.legalactionperson DROP CONSTRAINT IF EXISTS legalactionperson_pkey;
ALTER TABLE IF EXISTS cjams.legalactionperson add primary key (legalactionpersonid);
ALTER TABLE IF EXISTS cjams.persondeprivation DROP CONSTRAINT IF EXISTS persondeprivation_pkey;
ALTER TABLE IF EXISTS cjams.persondeprivation add primary key (persondeprivationid);
ALTER TABLE IF EXISTS cjams.personfamilyinfo DROP CONSTRAINT IF EXISTS personfamilyinfo_pkey;
ALTER TABLE IF EXISTS cjams.personfamilyinfo add primary key (personfamilyinfoid);
ALTER TABLE IF EXISTS cjams.persongoldenrecords DROP CONSTRAINT IF EXISTS persongoldenrecords_pkey;
ALTER TABLE IF EXISTS cjams.persongoldenrecords add primary key (id);
ALTER TABLE IF EXISTS cjams.personmergelog DROP CONSTRAINT IF EXISTS personmergelog_pkey;
ALTER TABLE IF EXISTS cjams.personmergelog add primary key (id);
ALTER TABLE IF EXISTS cjams.placementadmissionclassification DROP CONSTRAINT IF EXISTS placementadmissionclassification_pkey;
ALTER TABLE IF EXISTS cjams.placementadmissionclassification add primary key (placementadmissionclassificationid);
ALTER TABLE IF EXISTS cjams.placementconversion DROP CONSTRAINT IF EXISTS placementconversion_pkey;
ALTER TABLE IF EXISTS cjams.placementconversion add primary key (placementconversionid);
ALTER TABLE IF EXISTS cjams.providerutility DROP CONSTRAINT IF EXISTS providerutility_pkey;
ALTER TABLE IF EXISTS cjams.providerutility add primary key (providerutilityid);
ALTER TABLE IF EXISTS cjams.prov_monitoring_case_record DROP CONSTRAINT IF EXISTS prov_monitoring_case_record_pkey;
ALTER TABLE IF EXISTS cjams.prov_monitoring_case_record add primary key (monitoring_case_record_id);
ALTER TABLE IF EXISTS cjams.referralplacement DROP CONSTRAINT IF EXISTS referralplacement_pkey;
ALTER TABLE IF EXISTS cjams.referralplacement add primary key (referralplacementid);
ALTER TABLE IF EXISTS cjams.referralrejectreason DROP CONSTRAINT IF EXISTS referralrejectreason_pkey;
ALTER TABLE IF EXISTS cjams.referralrejectreason add primary key (referralrejectreasonid);
ALTER TABLE IF EXISTS cjams.referredagencyir DROP CONSTRAINT IF EXISTS referredagencyir_pkey;
ALTER TABLE IF EXISTS cjams.referredagencyir add primary key (referrredagencyid);
ALTER TABLE IF EXISTS cjams.removeplacement DROP CONSTRAINT IF EXISTS removeplacement_pkey;
ALTER TABLE IF EXISTS cjams.removeplacement add primary key (removeplacementid);
ALTER TABLE IF EXISTS cjams.reviewappointment DROP CONSTRAINT IF EXISTS reviewappointment_pkey;
ALTER TABLE IF EXISTS cjams.reviewappointment add primary key (reviewappointmentid);
ALTER TABLE IF EXISTS cjams.savedreports DROP CONSTRAINT IF EXISTS savedreports_pkey;
ALTER TABLE IF EXISTS cjams.savedreports add primary key (savedreportid);
ALTER TABLE IF EXISTS cjams.securityprofiles DROP CONSTRAINT IF EXISTS securityprofiles_pkey;
ALTER TABLE IF EXISTS cjams.securityprofiles add primary key (profileid);
ALTER TABLE IF EXISTS cjams.securityprofiletasks DROP CONSTRAINT IF EXISTS securityprofiletasks_pkey;
ALTER TABLE IF EXISTS cjams.securityprofiletasks add primary key (profiletaskid);
ALTER TABLE IF EXISTS cjams.securitytaskaccess DROP CONSTRAINT IF EXISTS securitytaskaccess_pkey;
ALTER TABLE IF EXISTS cjams.securitytaskaccess add primary key (accessid);
ALTER TABLE IF EXISTS cjams.securitytasks DROP CONSTRAINT IF EXISTS securitytasks_pkey;
ALTER TABLE IF EXISTS cjams.securitytasks add primary key (taskid);
ALTER TABLE IF EXISTS cjams.serviceplanvisitationplanmapping DROP CONSTRAINT IF EXISTS serviceplanvisitationplanmapping_pkey;
ALTER TABLE IF EXISTS cjams.serviceplanvisitationplanmapping add primary key (serviceplanvisitationplanmappingid);
ALTER TABLE IF EXISTS cjams.servicepurchaseauthorization DROP CONSTRAINT IF EXISTS servicepurchaseauthorization_pkey;
ALTER TABLE IF EXISTS cjams.servicepurchaseauthorization add primary key (authorizationid);
ALTER TABLE IF EXISTS cjams.userannouncement DROP CONSTRAINT IF EXISTS userannouncement_pkey;
ALTER TABLE IF EXISTS cjams.userannouncement add primary key (userannouncementid);
ALTER TABLE IF EXISTS cjams.vocationinterest DROP CONSTRAINT IF EXISTS vocationinterest_pkey;
ALTER TABLE IF EXISTS cjams.vocationinterest add primary key (vocationinterestid);