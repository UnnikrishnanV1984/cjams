DROP FUNCTION IF EXISTS cjams.approveintake20(savedtlsobj json, reviewobj json);
CREATE OR REPLACE FUNCTION cjams.approveintake20(savedtlsobj json, reviewobj json)
 RETURNS TABLE(responseservicereqnum character varying, responseintakeserviceid uuid, message character varying, intakeservicerequestactorid character varying, isfamilycase integer, progrmkey character varying, subprogrmkey character varying)
 LANGUAGE plpgsql
AS $function$     
------------------------------------------------------------------------------------------------------------
-- Revision(s) 
-- 02/15/2024 Vineet Tirodkar - To update updatedon audit column in personrole & other tables (CIDM-4704)
-- 04/09/2024 Prasanna kommineni- update sdm trafficking audit trail and maltreatment updated audit and update override flow(CIDM-8546)
-- 06/13/2024 Vinesh Puthan - Case should not be created when the ROA CPS type is selected as "ROA Under Court"(CIDM-8935)
-- 06/05/2024- sai kothapalli-CIDM-8742- Kinship Navigation Services
-- 06/05/2024 - Akhil Katukuri - Revert Sai Kothapalli code to unblock QA
-- 06/06/2024 - Akhil Katukuri - Added logic for kinship navigation
-- 10/22/2024 - Sandeep Kiran Anugolu - Override Screenin - programassignment remains on personcard(CIDM-9599)
--10/28/2024 -Smitha Somasekharan- CIDM-9290- Issue fix for case creation when puropse selected is ROA-CPS
--10/23/2024 - Manasa Kasula - CJAMS - Caseworker/Supervisor assignments (CIDM-9543)
--1/30/2025--Sai Teja Chintha -- Program Area and Program sub area fields are blank and disabled when approving the overridden intake(CIDM-10105)
--1/30/2025 - Sai Teja Chintha -Incident date is not updating in the case if edited during supervisor override(CIDM-10109)
--04/11/2025 - Manasa Kasula - Screenout overide scenario is not fetching the program area(CIDM-10389)
--05/16/2025 - Sandeep Kiran Anugolu - Screenout scenario for KINSHIP is adding program for the person (CDM-44384)
-- 05/27/2025 - Parshal Chitrakar - CIDM-10528-Decision, approved supervisor's name is overiding on the closed intake.
--07/08/2025 -Smitha Somasekharan -CIDM-10607-Update CPS Sterttime Override Userstory changes 
--08/01/2025- Triveni Bala- CIDM-10625 - Plan of selfcare user story changes
--11/24/2025 - Vinesh Puthan -  CDM-44592 -AR/IR start date/time pulling from wrong referral narrative (Screenedout intake should only have Addendum updated time as case creation time)
-- 1/14/2026 - Vinesh Puthan - CDM-44633 - Program assignment getting created for SEN child when supervisor screenouts intake
-- 01/23/2026 - Vamshikri.byreddy - CIDM-10829 - Addition of sdm tab in non-cps-intake-referrals
------------------------------------------------------------------------------------------------------------	
 
 DECLARE   
 v_concernfortrafficking character varying;
v_selecttrafficking character varying;
v_traffickingupdated character varying;
v_maltreatmentupdated character varying;
v_ismaltreatment character varying;
v_isfclivingarrangement character varying;
v_isschool character varying;
v_islicenseddaycare character varying;
v_isprivateplacement character varying; 
v_isfcplacementsetting character varying;
v_providerinfo json;
v_providerdetails json;
 v_isoverridereq bool; 
 v_actiontype character varying;
v_personid1 uuid;
l_record RECORD;
 v_intakesnapshotid uuid;
 v_IntakeServiceIdoverridereq uuid;
 v_servicecaseidoverridereq uuid;
 v_intakeserviceidoverride uuid;
 v_DAServiceRequestNumberoverridereq VARCHAR(50); 
 v_supDisposition character varying; 
  v_DADisposition character varying; 
v_intservreqtypkey character varying; 
v_temptemp    text[]; 
v_xmlText    text; 
v_DataTypeID    INT;   
v_ServiceRequestNumber    VARCHAR(50);  
v_DATypeKey        uuid;    
v_DASubTypeKey    uuid;    
v_AccessLevel    boolean;    
v_personId    VARCHAR(200);   
v_DueDateOffSet    INT;    
v_delimiter            VARCHAR(10); 
v_ReporterActorID    CHAR(36);   
v_ReporterPersonID    CHAR(36); 
v_IntakeGroupId    uuid;     
v_GroupNumber    VARCHAR(50);   
v_IntakeServiceId    uuid;    
v_message    VARCHAR(512);    
v_InatkeNumber    VARCHAR(50);   
v_DAStatus    VARCHAR(50);    
v_GroupServiceRequestNumber    VARCHAR(50); 
v_GroupComment    TEXT;   
v_GroupReasonType    VARCHAR(50); 
v_IllegalActivityKey    VARCHAR(256); 
v_DAServiceRequestNumber    VARCHAR(50); 
v_Generaljsondata    json; 
v_Personjsondata    json; 
v_DATypejsondata    json; 
v_DATypeDeailsjsondata    json; 
v_Recordingjsondata    json; 
v_recordingdetailsjsondata    json; 
v_Allegationsjsondata    json; 
v_AliasDtls    json; 
v_AgencyDtls    json; 
v_sdm    json; 
v_CrossRefDtls    json; 
i json;   
j json; 
recordingsloop    json; 
allegationloop    json; 
agencyloop    json; 
crossRefloop    json; 
v_GroupCount    INT;     
v_ErrorMessage    VARCHAR(4000);   
v_ErrorSeverity    INT;  
v_ErrorState    INT;      
v_FailureID    INT;      
v_DAType_rec    RECORD; 
v_GroupDA_rec    RECORD; 
my_delet_temp        varchar; 
my_Temp_Var    int; 
my_Temp_Varuuid    uuid; 
final_intakeServiceId    uuid; 
investigation_rec    record; 
v_securityuserid    character    varying; 
v_activity    record; 
v_createddanumberrec    record; 
personidnullCasting    uuid; 
v_finalServiceReqNumber    uuid; 
v_finalIntakeServiceID    uuid; 
l_newInvestigationId    uuid; 
l_newProgressnoteId    uuid; 
s_Actmsg        character    varying; 
l_Addressid    uuid; 
l_tempAddressid    uuid; 
l_generatedPersonId    uuid; 
v_targetId    uuid; 
v_intakeNumber    character    varying; 
v_phoneRecCount    int;  
v_roacpsstatetype character varying;

/*Variables    for    supervisor    approval*/
v_appeventcode    character    varying; 
v_statustext    character    varying; 
v_status    int; 
v_commenttext    text; 
l_status    character    varying; 
v_datype    uuid; 
v_dasubtype    uuid; 
v_dasubtype1    character    varying; 
v_configid    uuid; 
v_dispositionid    uuid;
v_subdispositionid    uuid;
v_dispositionstatusid    uuid;
v_subdispositionnotes character varying;
v_Agencyservicesdata    json; 
v_attachmentdata    json; 
v_documentpropertiesid    uuid; 
attah_data    json; 
v_addressdata    json; 
v_contacts    json; 
v_contactsmail    json; 
v_persondetails    json; 
v_intakeservtypekey    character    varying; 
v_Agencycode    character    varying; 
v_Servicereqno    Character    varying; 
dadetails    json; 
v_date    timestamp    without    time    zone; 
v_externalentity    Character    varying; 
v_perspmedu    Character    varying; 
v_persphealth    Character    varying; 
v_personguar character varying; 
v_sdmreturn    Character    varying;
v_Adultscreentoolreturn    Character    varying; 
v_recordingreturn    character    varying; 
v_dispositioncode        Character    varying;
v_subdispositioncode        Character    varying; 
l_isappeal    bool; 
l_intakeservicerequestactorid    uuid; 
v_ActorID    uuid; 
v_issubtypekey    bool; 
v_isDisposition    bool; 
notifysecurityuserid        Character    varying; 
v_notifystatus    Character    varying; 
v_msg    character    varying; 

i_evaluationcount    int; 
v_intakecrrefjson    json; 
v_intakecrref_status    character    varying; 
v_clwstatusintakenumber    character    varying; 
v_clwdate    timestamp    without    time    zone; 
v_notifyfromsecurityusersid    Character    varying; 
v_notifydescription    character    varying; 
v_notifystatusoffice    Character    varying; 
-- v_personrolerecord    RECORD; 
v_actpersonid    uuid; 
v_dispositionstatusdescription    text; 
arr_appointments    json; 
v_saveappointment_status    character    varying; 
v_notifyiwfromsecurityusersid    Character    varying; 
v_username    character    varying; 
v_notifystatusclw    Character    varying; 
j_clwusers    json; 
v_clwuserid    Character    varying;  
j_evaluation_fields    json; 
v_intakeservicerequestevaluationid    uuid; 
v_isrevalactorid    uuid; 
v_complaintid    character    varying;   
j_evaluation_victim    json; 
v_sstastatustypekey    character    varying; 
v_strengths    character    varying; 
v_needs    character    varying; 
v_relationship    Character    varying; 
	v_reqforservconfigcount    bigint; 
v_communicationFieldsdata    json; 
v_savenotesreturn    character    varying;  
v_intakeservreqserviceid  uuid; 
v_intakesubservice  json; 
v_livingsituationkey    character    varying; 
v_licensedfacilitykey    character    varying; 
v_otherlicensedfacility    character    varying; 
v_livingsituationdesc    character    varying;  
v_roletypekey character varying;
v_tempintakeserviceid    uuid;
v_created_isrdispositioncodeid text;
v_overideprogramkey character varying; 
v_overridesubprogrmkey character varying; 
	
---- allegation --- 
l_newmaltreatementid uuid; 
l_newinvestigationallegationid uuid; 
v_caseid character varying; 
v_investigationid uuid; 
v_indicators json;
v_createdcasejsondata json; 
indicators json; 
allegations json; 
v_allegations json; 
v_maltreators json; 
createcase json;
v_savefocuspersoncasestatus Character varying;
v_emergencycontact json;
v_taskstatus character varying;	
emergencycontact json;
v_savefocuspersoncasedetails character varying; 
j_focuspersoncasedetails json; 	
v_peaceorder character varying;
v_peaceorderdesc character varying;
v_suppeaceorder character varying;
v_suppeaceorderdesc character varying;
v_Pid uuid;
v_alertnotes text;
v_savepersonalert character varying;
v_focuspersonname character varying;
v_personalertid uuid; 
v_fetalalcoholspctrmdisordflag  int; 
v_drugexposednewbornflag  int; 
v_probationsearchconductedflag int; 
v_sexoffenderregisteredflag int;	 
v_restitutionstatus character varying(15); 
v_child character varying;
v_status_new bool;
v_bfromintake bool;
v_bclosecase bool;
j_placement    json;
v_saveplacement character varying; 
--added for save evalution field
v_evaluationstatus  character varying;
l_stagCount bigint;
l_draftCount bigint;
l_receiveddelay  character varying;
l_submissiondelay character varying;
v_dadispositioncode character varying;
v_screeningRecommend character varying;
v_dadispositiontext character varying;
v_dastatustext character varying;
v_isclw boolean;
l_Firstname character varying;
l_Lastname character varying;
l_focuspersonid uuid;
l_RAName character varying;
v_clwstatus character varying; 
v_personsupport  json; 
personsupport json; 
l_ispreintake    bool; 
v_asignsecurityuserid character varying;
v_intakeservsubtypekey character varying;
v_isroute int;
v_isinvestigation int;
v_isfamilycase int;
v_reporterdetails json;
v_reporterobj json;
v_collateralmsg CHARACTER VARYING;
v_roacps json;
l_routingCount bigint;
v_user_role character varying;
v_cpsresponsetimerupdate text;
l_accepteddate timestamp without time zone;
l_inserteddate timestamp without time zone;
v_servicerequestno character varying;
intake_service_req_id uuid;
v_personroleid uuid;
actorrec record;
personrolerec record;
v_purposename character varying;
v_iandrsubtype character varying;
v_casealreadycreated bool;
v_isaddendumnarrativeupdated bool;

BEGIN                                

v_date:=    now(); 
v_delimiter    :=','; 
v_screeningRecommend:= saveDtlsObj-> 'disposition'->0->>'dispositioncode';
v_user_role := saveDtlsObj ->>'userrole';
v_Generaljsondata    :=    saveDtlsObj->>'General'; 
v_persondetails:=    saveDtlsObj->>'persondetails'; 
v_Personjsondata    :=    v_persondetails->>'Person';
v_Pid               :=   v_Personjsondata->>'Pid'; 
v_DATypejsondata    :=    saveDtlsObj->>'DAType';
v_DATypeDeailsjsondata    :=    v_DATypejsondata->>'DATypeDetail'; 
v_securityuserid    :=    COALESCE(saveDtlsObj->>'securityuserid','S-1-5-21-152097760-152508613-1969071786-500'); 
v_AgencyDtls    :=    saveDtlsObj->>'agency'; 
v_CrossRefDtls    :=    saveDtlsObj->>'CrossReferences'; 
v_sdm    :=    saveDtlsObj->>'sdm'; 
v_Recordingjsondata    :=    saveDtlsObj->>'recordings'; 
v_RecordingDetailsjsondata    :=v_Recordingjsondata    ->>    'Recordings'; 
v_Allegationsjsondata    :=    saveDtlsObj->>'Allegations'; 
v_Agencyservicesdata    :=    saveDtlsObj->>'Agencyservices'; 
v_attachmentdata    :=    saveDtlsObj->>'attachment'; 
v_intakeNumber    :=    v_Generaljsondata->>    'IntakeNumber'; 
v_isDisposition:=    v_Generaljsondata->>    'isDisposition';
v_purposename:=    v_Generaljsondata->>    'PurposeName'; 
v_iandrsubtype:=    v_Generaljsondata->>    'iAndRsubtype';  
v_concernfortrafficking :=saveDtlsObj->'sdm'->>'confirmtrafficking';
v_selecttrafficking :=saveDtlsObj->'sdm'->>'selecttrafficking';
v_traffickingupdated :=saveDtlsObj->'sdm'->>'traffickingupdated';
v_ismaltreatment :=saveDtlsObj->'sdm'->> 'maltreatment';
v_maltreatmentupdated :=saveDtlsObj->'sdm'->> 'maltreatmentupdated';
v_isfclivingarrangement :=saveDtlsObj->'sdm'->> 'isfclivingarrangement';
v_isschool :=saveDtlsObj->'sdm'->> 'isschool';
v_islicenseddaycare:=saveDtlsObj->'sdm'->> 'islicenseddaycare';
v_isprivateplacement :=saveDtlsObj->'sdm'->> 'isprivateplacement';
v_isfcplacementsetting:=saveDtlsObj->'sdm'->> 'isfcplacementsetting';
v_providerinfo:=saveDtlsObj->'sdm'->> 'provider';
v_providerdetails:=saveDtlsObj->'sdm'->> 'selectedproviderdetails';
/*Variables    for    assignment    for    approval*/ 
v_appeventcode    :=    reviewobj->>    'appevent'; 
v_statustext    :=    reviewobj->>    'status'; 
v_commenttext    :=    reviewobj->>    'comments'; 

--    Variables    for    Intake    Cross    Reference 
v_intakecrrefjson    :=    saveDtlsObj->>'intakecrossrefs'; 
v_clwstatusintakenumber    :=    null; 
arr_appointments    :=    saveDtlsObj    ->>    'appointments'; 
v_saveappointment_status    :=    ''; 
j_evaluation_fields    :=    saveDtlsObj    ->>    'evaluationFields'; 
v_communicationFieldsdata    :=    saveDtlsObj->>'communicationFields'; 
j_focuspersoncasedetails    :=    saveDtlsObj    ->>    'focuspersoncasedetails';

--- Variables    for    Intake    createdCases 
v_createdcasejsondata  :=  saveDtlsObj->>'createdCases';
j_placement    :=    saveDtlsObj    ->>    'placement';
v_isoverridereq := saveDtlsObj -> 'General' ->> 'isoverriderequest';
v_bfromintake  = false; 
v_bclosecase  =false; 
v_casealreadycreated := saveDtlsObj -> 'General' ->> 'casealreadycreated';
v_isaddendumnarrativeupdated := saveDtlsObj -> 'General' ->> 'isaddendumnarrativeupdated';

l_receiveddelay := saveDtlsObj -> 'General' ->> 'receiveddelay';
l_submissiondelay := saveDtlsObj -> 'General' ->> 'submissiondelay';
v_dadispositioncode:= saveDtlsObj-> 'disposition'->>'dispositioncode';
v_dastatustext:= saveDtlsObj-> 'General'->>'statustext';

v_Agencycode := v_Generaljsondata->>    'AgencyCode';

v_reporterdetails := saveDtlsObj ->> 'narrative';
v_isroute:= 2;
v_isinvestigation := 1;
v_isfamilycase:=0;
v_roacps:= saveDtlsObj -> 'roacps';
v_roacpsstatetype := saveDtlsObj ->'roacps'->>'statetype';

SELECT description INTO v_dadispositiontext  FROM dispositioncode  WHERE dispositioncode = v_dadispositioncode; 

v_isclw:= false;
IF  v_clwstatus is not null THEN
	v_isclw:= true;
END IF;

For i in SELECT * FROM json_array_elements((saveDtlsObj->'General'->>'intakeservice')::json)
LOOP 
	v_intakeservtypekey:=        i->>'intakeservtypekey'; 
END  LOOP;

/*Dispostion assign to local variable*/
FOR i in SELECT * FROM json_array_elements((saveDtlsObj->>'disposition')::json)

LOOP 
 v_supDisposition :=lower(i->>'supDisposition') ;
 v_DADisposition:=lower(i->>'DADisposition');
	v_sstastatustypekey := i->>'DAStatus';
	IF (((i->>'DAStatus') = 'Approved' and ( lower(i->>'DADisposition') = 'screenout' or lower(i->>'supDisposition') = 'screenout'))  or ((i->>'DAStatus') = 'Approved' and (lower(i->>'supDisposition') = 'ovrscrnout' or (i->>'DADisposition') = 'OvrScrnout')) or ((i->>'DAStatus') = 'Closed')) THEN 
		v_status_new := true;
	END IF;	 
	IF ((i->>'DAStatus') = 'Closed') THEN
		v_user_role = 'CWSP';
	END IF;
END LOOP;

IF (v_sstastatustypekey != 'Closed') THEN 
	v_sstastatustypekey := null; 
END IF;

IF(v_Agencycode = 'AS~true' or v_Agencycode = 'AS') THEN 
	v_Agencycode := 'AS'; 
END IF;

v_asignsecurityuserid := saveDtlsObj->>'asignsecurityuserid';

/*Approved    status    code    hardcoded*/
IF (lower(v_statustext)='approved') THEN v_status = 2;   
ELSIF (lower(v_statustext)='closed') THEN v_status = 8;    
END IF;  

CREATE TEMP TABLE IF NOT EXISTS
Temp_insert_person_program_area (
personprogramid uuid
);
/*Create    temp    table    for    DA    process*/	 
CREATE temp TABLE sp_createintake_temp_dageneral 
  ( 
     createddate             TIMESTAMP(3), 
     source                  UUID, 
     inputsource             UUID, 
     author                  VARCHAR(50), 
     reciveddate             TIMESTAMP, 
     TIME                    TIMESTAMP, 
     narrative               TEXT, 
	  addendum               TEXT, 
     islocalreferal          INT, 
     referalcomments         CHARACTER varying(300), 
     nonreferalreason        CHARACTER varying(1000), 
     line                    VARCHAR(50), 
     groupreason             VARCHAR(50), 
     groupsummary            VARCHAR(256), 
     ananymousreporter       VARCHAR(10), 
     misssingpersons         BOOLEAN, 
     suspiciousdeath         BOOLEAN, 
     illegalactivity         BOOLEAN, 
     illegalactivitykey      VARCHAR(50), 
     significantevent        VARCHAR(50), 
     significanteventkey     VARCHAR(50), 
     intakenumber            VARCHAR(50), 
     monumber                VARCHAR(50), 
     isanonymousreporter     BOOLEAN, 
     purpose                 UUID, 
     agencycode              CHARACTER varying(25), 
     isotheragency           BOOL, 
     otheragency             CHARACTER varying(250), 
     isunknownreporter       BOOL, 
     reporterfirstname       CHARACTER varying(250), 
     reporterlastname        CHARACTER varying(250), 
     offenselocation         CHARACTER varying(100), 
     requesterphone          CHARACTER varying(100), 
     requesterzipcode        CHARACTER varying(20), 
     requesteraddress1       CHARACTER varying(100), 
     requesteraddress2       CHARACTER varying(100), 
     requestercity           CHARACTER varying(50), 
     requesterstate          CHARACTER varying(2), 
     requestercounty         CHARACTER varying(50), 
     narrativeUpdatedDate     TIMESTAMP,
     isacknowledgementletter INT, 
     iszipcoderefuse         BOOL, 
     countyid                UUID,
	 addendumNarrativeUpdateddate TIMESTAMP
	 
  );                                                                                                                                           

CREATE temp TABLE sp_createintake_temp_datype 
  (  
     datypekey            UUID, 
     dasubtypekey         UUID, 
     servicerequestnumber VARCHAR(50), 
     investigatable       BOOLEAN, 
     actionable           BOOLEAN, 
     accesslevel          BOOLEAN, --    ??    did    we    remove?                                                                                                                        
     intakeserviceid      UUID, 
     personid             VARCHAR(1000), 
     dastatus             VARCHAR(256), 
     dadisposition        VARCHAR(256), 
     dasubdisposition     UUID, 
     cancelreason         VARCHAR(256), 
     canceldescription    VARCHAR(512), 
     reasonfordelay       VARCHAR(512), 
     summary              VARCHAR(512), 
     groupnumber          VARCHAR(50), 
     groupreasontype      VARCHAR(50), 
     groupcomment         TEXT, 
     crossref             BOOLEAN, 
     dispositioncode      VARCHAR(50), 
     subdispositioncode   VARCHAR(50), 
     subdispositionnotes  VARCHAR(50), 
     isappeal             BOOL,
     isfamilycase	  	  int ,
	 progrmkey1 		  VARCHAR(50), 
	 subprogrmkey1		  VARCHAR(50)
  );                                                                                 
 
CREATE temp TABLE sp_createintake_temp_personalias 
  ( 
     id             INT, 
     personid       VARCHAR(50), 
     aliasfirstname VARCHAR(50), 
     aliaslastname  VARCHAR(50), 
     aliasid        UUID, 
     aliasexpired   VARCHAR(10) 
  ); 

CREATE temp TABLE sp_createintake_temp_daperson 
  ( 
     id                           INT, 
     personid                     UUID, 
     firstname                    VARCHAR(100), 
     lastname                     VARCHAR(100), 
     middlename                   VARCHAR(50), 
     dob                          TIMESTAMP(3), 
     dateofdeath                  TIMESTAMP(3), 
     isapproxdod                  INT, 
     isapproxdob                  INT, 
     stateid                      VARCHAR(512), 
     gender                       VARCHAR(50), 
     race                         VARCHAR(50), 
     ssn                          VARCHAR(50), 
     ethicity                     VARCHAR(128), 
     occupation                   VARCHAR(128), 
     maritalstatustypekey         VARCHAR(128), 
     religiontypekey              VARCHAR(50), 
     tribalassociation            VARCHAR(128), 
     physicalattributes           VARCHAR(128), 
     relationshiptora             VARCHAR(50), 
     dangerousself                VARCHAR(512), 
     dangerousselfreason          VARCHAR(512), 
     dangerousworker              VARCHAR(50), 
     dangerousworkerreason        VARCHAR(4000), 
     mentealillness               VARCHAR(50), 
     mentealillnessdetail         VARCHAR(512), 
     mentealimpair                VARCHAR(50), 
     mentealimpairdetail          VARCHAR(512), 
     actorroletype                VARCHAR(50), 
     newperson                    INT, 
     actorid                      UUID, 
     intakeservicerequestactorid  UUID, 
     suffix                       CHARACTER varying, 
     personalias                  CHARACTER varying, 
     userphoto                    CHARACTER varying, 
     ishouseholdmember            BOOL, 
     iscollateral                 BOOL, 
     strengths                    CHARACTER varying, 
     needs                        CHARACTER varying, 
     weight                       CHARACTER varying, 
     livingsituationkey           CHARACTER varying(100), 
     licensedfacilitykey          CHARACTER varying(100), 
     otherlicensedfacility        CHARACTER varying(100), 
     livingsituationdesc          CHARACTER varying(100), 
     primarylanguage              VARCHAR(25), 
     otherprimarylanguage         VARCHAR(50), 
     otherreligion                CHARACTER varying(50), 
     fetalalcoholspctrmdisordflag INT, 
     drugexposednewbornflag       INT, 
     probationsearchconductedflag INT, 
     sexoffenderregisteredflag    INT, 
     citizenalenageflag           INT, 
     isqualifiedalien             INT, 
     alienregistrationtext        CHARACTER varying(500), 
     verificationremarks          CHARACTER varying(255), 
     alienstatustypekey           CHARACTER varying(15), 
     safehavenbabyflag            INT, 
     everbeenadoptedflag          INT 
  ); 

CREATE temp TABLE sp_createintake_temp_address 
  ( 
     addressid                CHARACTER varying, 
     addresstype              VARCHAR(100), 
     address1                 VARCHAR(100), 
     address2                 VARCHAR(100), 
     zipcode                  VARCHAR(50), 
     city                     VARCHAR(50), 
     county                   VARCHAR(50), 
     country                  VARCHAR(50), 
     statekey                 VARCHAR(50), 
     startdate                DATE, 
     enddate                  DATE, 
     isnew                    INT DEFAULT 0, 
     knowndangeraddress       CHARACTER varying, 
     knowndangeraddressreason CHARACTER varying 
  ); 

CREATE temp TABLE sp_createintake_temp_personcontact 
  ( 
     contacttypeid CHARACTER varying, 
     contacttype   CHARACTER varying, 
     ismobile      BOOL, 
     contactnumber CHARACTER varying(100), 
     isactive      INT, 
     isnew         INT DEFAULT 0 
  ); 

CREATE temp TABLE sp_createintake_temp_personmail 
  ( 
     mailtypeid CHARACTER varying, 
     mailtype   CHARACTER varying, 
     emailid    CHARACTER varying, 
     isactive   INT, 
     isnew      INT DEFAULT 0 
  ); 

CREATE temp TABLE sp_createintake_temp_dapersontemp 
  ( 
     personid UUID 
  ); 

select intakeserviceid ,servicerequestnumber into v_IntakeServiceIdoverridereq ,v_DAServiceRequestNumberoverridereq from intakeservicerequest where intakenumber=v_intakenumber order by insertedon desc limit 1;


/*Inactivate    ServiceRequest    Data    for    migrated    one    */ 
IF EXISTS (SELECT * FROM   intakeservicerequest WHERE  intakenumber =v_intakenumber) THEN
	UPDATE intakeservicerequest SET    activeflag =0, updatedby = v_securityuserid, updatedon = now() 
	WHERE  intakenumber =v_intakenumber;
END IF; 

INSERT INTO sp_createintake_temp_dageneral 
	( 
	createddate, 
	source, 
	inputsource, 
	author, 
	reciveddate, 
	time, 
	narrative, 
	addendum,
	islocalreferal, 
	referalcomments, 
	nonreferalreason, 
	line, 
	groupreason, 
	groupsummary, 
	ananymousreporter, 
	misssingpersons, 
	suspiciousdeath, 
	illegalactivity, 
	illegalactivitykey, 
	significantevent, 
	significanteventkey, 
	intakenumber, 
	monumber, 
	isanonymousreporter, 
	purpose, 
	agencycode, 
	isotheragency, 
	otheragency , 
	isunknownreporter, 
	reporterfirstname, 
	reporterlastname, 
	offenselocation, 
	requesterphone, 
	requesterzipcode, 
	requesteraddress1, 
	requesteraddress2, 
	requestercity, 
	requesterstate, 
	requestercounty, 
	narrativeUpdatedDate,
	isacknowledgementletter, 
	iszipcoderefuse , 
	countyid,
	addendumNarrativeUpdateddate ) 
	VALUES(
	(v_Generaljsondata->>    'CreatedDate')::date,
	(v_Generaljsondata->>    'Source')::uuid,
	(v_Generaljsondata->>    'InputSource')::uuid,
	v_Generaljsondata->>    'Author',
	(v_Generaljsondata->>    'RecivedDate')::timestamp,
	(v_Generaljsondata->>    'Time')::timestamp,
	v_Generaljsondata->>    'Narrative',
	v_Generaljsondata->>    'addendumNarrative',
	(v_Generaljsondata->>    'islocalreferal')::int,
	v_Generaljsondata->>    'referalcomments',
	v_Generaljsondata->>    'nonreferalreason',
	v_Generaljsondata->>    'Line',
	v_Generaljsondata->>    'GroupReason',
	v_Generaljsondata->>    'GroupSummary',
	v_Generaljsondata->>    'AnanymousReporter',
	(v_Generaljsondata->>    'MisssingPersons')::boolean,
	(v_Generaljsondata->>    'SuspiciousDeath')::boolean,
	(v_Generaljsondata->>    'IllegalActivity')::boolean,
	v_Generaljsondata->>    'IllegalActivityKey',
	v_Generaljsondata->>    'SignificantEvent',
	v_Generaljsondata->>    'SignificantEventKey',
	v_Generaljsondata->>    'IntakeNumber',
	v_Generaljsondata->>    'MoNumber',
	(v_Generaljsondata->>    'IsAnonymousReporter')::boolean,
	(v_Generaljsondata->>    'Purpose')::uuid,
	v_Generaljsondata->>    'AgencyCode',
	(v_Generaljsondata->>    'isOtherAgency')::boolean,
	v_Generaljsondata->>    'OtherAgency'    ,
	(v_Generaljsondata->>    'IsUnknownReporter')    ::boolean,    
	v_Generaljsondata->>    'Firstname',
	v_Generaljsondata->>    'Lastname',
	v_Generaljsondata->>    'offenselocation',
	v_Generaljsondata->>    'requesterPhone',
	v_Generaljsondata->>    'requesterzipcode',
	v_Generaljsondata->>    'requesteraddress1',
	v_Generaljsondata->>    'requesteraddress2',
	v_Generaljsondata->>    'requestercity',
	v_Generaljsondata->>    'requesterstate',
	v_Generaljsondata->>    'requestercounty',
	(((v_Generaljsondata->>    'narrativeUpdatedDate')::timestamp) AT TIME ZONE 'UTC'),
	(v_Generaljsondata->>    'isacknowledgementletter') ::int ,
	(v_Generaljsondata->>    'iszipcoderefuse'    )    ::boolean,
	(v_Generaljsondata->>    'countyid')::uuid,
	(((v_Generaljsondata->> 'addendumNarrativeUpdatedAt')::timestamp))
	);
/*DA    Details    inseted    into    temp    table*/
SELECT Agencycode into v_Agencycode FROM sp_CreateIntake_Temp_DAGeneral; 

IF (lower(v_Agencycode)='all')    THEN 
	SELECT teamtypekey INTO   v_agencycode FROM   intakeagencypurpose WHERE  intakeservreqtypeid IN (SELECT purpose FROM   sp_createintake_temp_dageneral) LIMIT  1; 
	UPDATE sp_createintake_temp_dageneral SET    agencycode = v_agencycode; 
END IF; 

/*Assign DA values into local variables */
FOR  j IN SELECT * FROM json_array_elements(v_DATypeDeailsjsondata) 
LOOP

	SELECT j->>'DaTypeKey', j->>'DasubtypeKey', j->>'DasubtypeKey', j->>'DAsubnotes', j->>'dispositioncode', j->>'dispositioncodedesc', j->>'supDispositiondesc' 
	INTO v_datype,v_dasubtype1,v_dasubtype,v_subdispositionnotes,v_peaceorder,v_peaceorderdesc,v_suppeaceorderdesc;
            
	 /*Config    taken    based    on    DA    Subtype    and    DAtype    */
	IF (CAST(v_datype AS character varying) <> CAST( coalesce(v_dasubtype1 :: character varying, '')AS character varying) AND CAST( coalesce(v_dasubtype1 ::character varying, '')AS character varying)<>'') THEN 
        v_Servicereqno:=        j->>'ServiceRequestNumber';
        v_issubtypekey:=    j->>'issubtypekey'; 
        IF (v_issubtypekey = true) THEN
        /*SELECT servicerequestsubtypeid into v_dasubtype FROM servicerequestsubtype where lower(classkey) = lower(v_dasubtype1); */
        SELECT getnextdanumber into v_Servicereqno FROM getnextdanumber('servicerequestauthorizationnumber');  
        END IF; 

        /*Assign dattype and configid to local variable based on subtype*/
        SELECT servicerequestsubtypeid,servicerequesttypeconfigid INTO  v_dasubtype,   v_configid    
        FROM  servicerequesttypeconfig    
        WHERE intakeservreqtypeid    =(j->>    'DaTypeKey')::uuid 
        AND    servicerequestsubtypeid    =(CASE WHEN v_Agencycode='CW' THEN v_dasubtype::uuid else (j->> 'DasubtypeKey')::uuid  end)
        AND activeflag    =1    limit    1;    
	ELSE
        SELECT    servicerequestsubtypeid,servicerequesttypeconfigid    into    v_dasubtype,    v_configid    
        FROM  servicerequesttypeconfig 
        WHERE intakeservreqtypeid    =(j->>    'DaTypeKey')::uuid
        AND servicerequestsubtypeid    ='00000000-0000-0000-0000-000000000000'
        AND activeflag = 1 LIMIT 1;

        SELECT getnextdanumber into v_Servicereqno FROM getnextdanumber('servicerequestauthorizationnumber');     
	END IF; 
	-- v_intakeserviceid='a02bc0ac-6a15-4a40-8f7f-c6862c090f06';
	-- v_Servicereqno='241021927362';
	/*if    (cast(v_dasubtype    as    character    varying)    ='')    THEN    v_dasubtype    ='00000000-0000-0000-0000-000000000000'; end    if;*/

	SELECT Intakeserreqstatustypeid,description into v_dispositionstatusid,v_dispositionstatusdescription FROM Intakeserreqstatustype WHERE Intakeserreqstatustypekey =(j->> 'DAStatus') and activeflag =1 limit 1;
	
	/*Close case flag when the disposition is Screenout*/
	IF (v_Agencycode = 'CW') THEN 
        IF (((j->>'DAStatus') = 'Approved' and ( lower(j->>'supDisposition') = 'screenout' or lower(j->>'DADisposition') = 'screenout')) or ((j->>'DAStatus') = 'Approved' and ( (j->>'supDisposition') = 'oScrnout' or (j->>'DADisposition') = 'OvrScrnout')) or ((j->>'DAStatus') = 'Closed')) THEN
            SELECT Intakeserreqstatustypeid ,description  INTO v_dispositionstatusid,v_dispositionstatusdescription 
            FROM Intakeserreqstatustype WHERE Intakeserreqstatustypekey = 'Closed' and activeflag = 1 limit 1; 

            v_bFROMintake  = true;
            v_bclosecase  =true;
        END IF; 
	END IF; 
	 
	SELECT servicerequesttypeconfigiddispostionid, dispositioncode, Coalesce(isallowappeal, false) 
	INTO   v_dispositionid, v_dispositioncode, l_isappeal 
	FROM   servicerequesttypeconfigdispositioncode 
	WHERE  servicerequesttypeconfigid = v_configid 
	AND intakeserreqstatustypeid = v_dispositionstatusid 
	AND Lower(dispositioncode) in (LOWER(j ->> 'DADisposition'), LOWER(j ->> 'supDisposition'))
	AND activeflag = 1 
	LIMIT  1 ;

    IF (coalesce(V_DISPOSITIONID::text, '')='') THEN 
        SELECT servicerequesttypeconfigid 
        INTO   v_configid 
        FROM   servicerequesttypeconfig 
        WHERE  intakeservreqtypeid = ( j ->> 'DaTypeKey' ) :: uuid 
		AND servicerequestsubtypeid = '00000000-0000-0000-0000-000000000000' 
		AND activeflag = 1 
		LIMIT  1;  
        SELECT servicerequesttypeconfigiddispostionid, dispositioncode, Coalesce(isallowappeal, false) 
        INTO   v_dispositionid, v_dispositioncode, l_isappeal 
        FROM   servicerequesttypeconfigdispositioncode 
        WHERE  servicerequesttypeconfigid = v_configid 
		AND intakeserreqstatustypeid = v_dispositionstatusid 
		AND Lower(dispositioncode) in (Lower(j ->> 'DADisposition'), Lower(j ->> 'supDisposition'))
		AND activeflag = 1 
        LIMIT  1; 
        SELECT servicerequestdispositionsubtypeconfigid, dispositioncode 
        INTO   v_subdispositionid, v_subdispositioncode 
        FROM   servicerequestdispositionsubtypeconfig 
        WHERE  Lower(dispositioncode) = Lower(j ->> 'dasubdisposition') AND activeflag = 1 
        LIMIT  1; 	
	END IF;                    
    INSERT INTO sp_createintake_temp_datype 
            ( 
                        datypekey,dasubtypekey,personid, 
                        servicerequestnumber ,dastatus ,dadisposition, 
                        dasubdisposition, summary, canceldescription , 
                        cancelreason, reasonfordelay, groupnumber , 
                        groupreasontype , groupcomment , dispositioncode, 
                        subdispositioncode, subdispositionnotes, isappeal 
            )    
	VALUES 
	( 
	(j->> 'DaTypeKey')::uuid, (CASE WHEN v_Agencycode='CW' THEN v_dasubtype::uuid else (j->> 'DasubtypeKey')::uuid  end), j->> 'personid',
 	 v_servicereqno, v_dispositionstatusid, v_dispositionid, 
	 v_subdispositionid, j->> 'Summary', j->> 'CancelDescription', 
	 j->> 'CancelReason', j->> 'ReasonforDelay', j->> 'GroupNumber', 
	 j->> 'GroupReasonType', j->> 'GroupComment', v_dispositioncode, 
	 v_subdispositioncode, v_subdispositionnotes, l_isappeal 
	);    
END LOOP;	

/*DA Loop Ends here */   
UPDATE sp_createintake_temp_datype SET    groupnumber = '' 
WHERE  groupnumber IN (SELECT groupnumber sp_CreateIntake_Temp_DAType WHERE  COALESCE(isappeal, false) = true); 
/*Person DML Starts here*/
FOR i IN SELECT * FROM json_array_elements(v_Personjsondata) 
LOOP 
	DELETE FROM sp_CreateIntake_Temp_address; 
	DELETE FROM sp_CreateIntake_Temp_personmail; 
	DELETE FROM sp_CreateIntake_Temp_personcontact;
	INSERT INTO sp_createintake_temp_daperson 
            ( 
                        id, 
                        personid , 
                        firstname , 
                        lastname , 
                        middlename, 
                        dob , 
                        dateofdeath, 
                        isapproxdod, 
                        isapproxdob, 
                        stateid , 
                        gender , 
                        race , 
                        ssn , 
                        ethicity, 
                        occupation, 
                        maritalstatustypekey, 
                        religiontypekey, 
                        tribalassociation, 
                        physicalattributes, 
                        relationshiptora, 
                        dangerousself , 
                        dangerousselfreason , 
                        dangerousworker, 
                        dangerousworkerreason, 
                        mentealillness , 
                        mentealillnessdetail, 
                        mentealimpair, 
                        mentealimpairdetail, 
                        actorroletype , 
                        suffix, 
                        personalias, 
                        userphoto, 
                        ishouseholdmember, 
                        iscollateral, 
                        strengths , 
                        needs, 
                        weight , 
                        livingsituationkey , 
                        licensedfacilitykey , 
                        otherlicensedfacility , 
                        livingsituationdesc , 
                        primarylanguage, 
                        otherprimarylanguage, 
                        otherreligion, 
                        fetalalcoholspctrmdisordflag, 
                        drugexposednewbornflag, 
                        probationsearchconductedflag, 
                        sexoffenderregisteredflag, 
                        citizenalenageflag, 
                        isqualifiedalien, 
                        alienregistrationtext, 
                        verificationremarks, 
                        alienstatustypekey, 
                        safehavenbabyflag, 
                        everbeenadoptedflag 
            ) 
	VALUES	(
	CAST(i    ->>    'id'    as    int),
	(case    length(i->>'Pid')   WHEN 0  THEN    '00000000-0000-0000-0000-000000000000' 
	 ELSE (CASE left((i->>'Pid'),6)    when    'tempid'    THEN    '00000000-0000-0000-0000-000000000000' ELSE (i->>'Pid') END )
	END)::uuid,
	i    ->>'Firstname',
	i    ->>'Lastname',
	i    ->>'Middlename',
	(i    ->>'Dob')::date,
	(i    ->>'dateofdeath')::date,
	(i    ->>    'isapproxdod')::int,
	(i    ->>    'isapproxdob')::int,
	i    ->>'stateid',
	i    ->>'Gender',
	i    ->>    'Race',
	LOWER(i    ->>    'SSN'),
	i    ->>'Ethicity',
	i    ->>    'occupation',   
	i->>    'maritalstatustypekey',
	i    ->>    'religionkey',
	i    ->>    'tribalassociation',    
	i    ->>    'physicalattributes',
	i    ->>    'RelationshiptoRA',
	i    ->>    'Dangerousself',        
	i    ->>    'DangerousselfReason',            
	i    ->>    'Dangerousworker',        
	i    ->>    'DangerousWorkerReason',
	i    ->>    'Mentealillness',
	i    ->>    'MentealillnessDetail',
	i    ->>    'Mentealimpair',
	i    ->>    'MentealimpairDetail',
	i    ->>    'Role'    ,
	i    ->>'suffix',
	i    ->>'aliasname',
	i    ->>'userPhoto',
	true,
	(i    ->>'iscollateralcontact')::bool,
	(i    ->>    'strengths')::    VARCHAR(50),
	(i    ->>    'needs')::    VARCHAR(50),
	i    ->>    'weight',
	i    ->>    'livingsituationkey',
	i    ->>    'licensedfacilitykey',
	i    ->>    'otherlicensedfacility',
	i    ->>    'livingsituationdesc',
	i ->> 'primarylanguage',	
	i ->> 'otherprimarylanguage',
	i ->>'otherreligion',
	(i ->> 'fetalalcoholspctrmdisordflag')::int,
	(i ->> 'drugexposednewbornflag')::int,
	(i ->> 'probationsearchconductedflag')::int,
	(i ->> 'sexoffenderregisteredflag')::int,
	(i ->> 'citizenalenageflag')::int,
	(i ->> 'isqualifiedalien')::int,
	i ->> 'alienregistrationtext',
	i ->> 'verificationremarks',
	i ->> 'alienstatustypekey',
	(i ->> 'safehavenbabyflag')::int,
	(i ->> 'everbeenadoptedflag')::int
	); 
	
        v_strengths    :=i    ->>'strengths';        
	/*Person Contacts*/
	v_contacts:=    i->>'contacts';
	INSERT INTO sp_createintake_temp_personcontact 
	SELECT * 
	FROM   json_to_recordset(v_contacts ) AS x("contacttypeid" character VARYING, "contacttype" character VARYING,
	"ismobile" bool,"contactnumber" character VARYING , "isactive" int);
	
	/*Person Email*/
    v_contactsmail:=    i->>'contactsmail';
	INSERT INTO sp_createintake_temp_personmail 
	SELECT * 
	FROM   json_to_recordset(v_contactsmail ) AS x("mailtypeid" character VARYING, "mailtype" character VARYING,
	"mailid" character VARYING, "isactive" int);
	
	/*Person Address*/
	v_addressdata:=    i->>'address';
	INSERT INTO sp_createintake_temp_address 
	SELECT * 
	FROM   json_to_recordset(v_addressdata ) AS x("addressid" character VARYING, "addresstype" character VARYING, 
	  "address1" character VARYING, "Address2" character VARYING, 
	  "zipcode" character VARYING, "city" character VARYING, 
	  "county" character VARYING, "country" character VARYING,
	  "state" character VARYING, "startdate" date, "enddate" date,
	  "isactive" int, "knownDangerAddress" character VARYING,
	  "knownDangerAddressReason" character VARYING );
                                                           
	UPDATE sp_createintake_temp_personcontact SET    isnew = 1 WHERE  COALESCE(contacttypeid, '') = ''; 
	UPDATE sp_createintake_temp_personmail SET    isnew = 1 WHERE  COALESCE(mailtypeid, '') = ''; 
	UPDATE sp_createintake_temp_address SET    isnew = 1 WHERE  COALESCE(addressid, '') = ''; 
	UPDATE sp_createintake_temp_daperson SET    newperson = 1 WHERE  personid = '00000000-0000-0000-0000-000000000000';  
        
	l_generatedPersonId    :=    gen_random_uuid();

    IF    length(i    ->>    'Pid')    >    1    and        left((i->>'Pid'),6)        <>    'tempid'    THEN
        l_generatedPersonId    :=    (i    ->>    'Pid')::uuid;

        SELECT Json_agg(e) FROM (
        SELECT i ->> 'Firstname'     firstname, 
           i ->> 'Lastname'      lastname, 
           i ->> 'Dob'           dob, 
           i ->> 'maritalstatus' maritalstatus, 
           i ->> 'SSN'           ssn, 
           i ->> 'weight'        weight, 
           i ->> 'occupation'    occupation
           )e 
        INTO   dadetails ;
        /*Audit Log*/
        INSERT INTO auditlog(
        logtypekey, description, referenceid, 
        servicerequestnumber, isnew, isedit, 
        isdelete, insertedon, metadata, insertedby
        ) 
        VALUES (
        'IP', 'Person    Edited', ( i ->> 'Pid' ) :: uuid, 
        v_intakenumber, 'false', 'true', 
        'false', v_date AT TIME zone 'utc', dadetails :: json, v_securityuserid
        ); 

	ELSE    
 
            SELECT Json_agg(e) FROM
              (SELECT firstname , 
             lastname, 
             dob, 
             maritalstatustypekey, 
             ssn, 
             weight, 
             occupation 
              FROM   sp_createintake_temp_daperson)e 
            INTO    dadetails;

            /*Audit Log*/
            INSERT INTO auditlog 
            ( 
                                logtypekey, description, referenceid, 
                                servicerequestnumber, isnew, isedit, 
                                isdelete, insertedon, metadata, insertedby 
            ) 
                    VALUES 
            ( 
                                'IP', 'Person    Added', l_generatedpersonid, 
                                v_intakenumber, 'true', 'false', 
                                'false', v_date , dadetails::json, v_securityuserid 
            );
                                                                     
      END if;  
	
	/* Person Informal Support */ 
	v_personsupport  :=  i->>  'personsupport'; 
	FOR  personsupport  IN  SELECT  *  FROM      Json_array_elements(v_personsupport)  
	LOOP
        INSERT INTO personsupport 
        (personsupportid, 
         intakenumber, 
         intakeserviceid, 
         personid, 
         personsupporttypekey, 
         supportername, 
         description, 
         activeflag, 
         insertedby, 
         insertedon, 
         updatedby, 
         updatedon, 
         effectivedate) 
        VALUES      ( Gen_random_uuid(), 
          ( personsupport ->> 'intakenumber' ), 
          v_intakeserviceid, 
          l_generatedpersonid, 
          ( personsupport ->> 'personsupporttypekey' ), 
          ( personsupport ->> 'supportername' ), 
          ( personsupport ->> 'description' ), 
          1, 
          v_securityuserid, 
          v_date, 
          v_securityuserid, 
          v_date, 
          v_date ); 
	END LOOP;

  END LOOP;	
  
/*Person DML Ends here*/
	
SELECT DAG.intakenumber INTO   v_inatkenumber FROM   sp_createintake_temp_dageneral DAG;                      
INSERT INTO personracetypemap 
            ( 
                        personracetypemapid, 
                        personid, 
                        racetypekey, 
                        updatedby, 
                        updatedon, 
                        insertedby, 
                        insertedon, 
                        effectivedate 
            )
SELECT Gen_random_uuid(), 
       DAP.personid, 
       RP.racetypekey, 
       v_securityuserid, 
       v_date, 
       (SELECT DAG.author 
        FROM   sp_createintake_temp_dageneral DAG), 
       v_date, 
       v_date 
FROM   sp_createintake_temp_daperson DAP 
       JOIN racetype RP 
         ON RP.racetypekey = DAP.race 
WHERE  DAP.newperson = 1;            
                                                                                                                                 
UPDATE sp_createintake_temp_daperson SET    intakeservicerequestactorid = Gen_random_uuid(); 

v_ActorID = gen_random_uuid();                                                                                                                                                                

UPDATE sp_createintake_temp_daperson SET actorid = Gen_random_uuid() WHERE  actorid IS NULL;                                                                                                                                                                                                              
  
SELECT assessmenttemplatetargetid INTO   v_targetid FROM   assessmenttemplatetarget WHERE  Lower(target) = 'intake' AND activeflag = 1;                                                                                                                                                                                                                                                                    
FOR v_DAType_rec IN SELECT --datatypeid,
datypekey, dasubtypekey, personid, servicerequestnumber, dastatus FROM sp_CreateIntake_Temp_DAType 
LOOP  
--	v_DataTypeID    :=    v_DAType_rec.DataTypeID; 
	v_DATypeKey    :=    v_DAType_rec.DATypeKey; 
	v_DASubTypeKey    :=    v_DAType_rec.DASubTypeKey; 
	v_personId    :=    v_DAType_rec.PersonId; 
	v_DAServiceRequestNumber    :=    v_DAType_rec.ServiceRequestNumber;--201800106994 
	v_DAStatus    :=    v_DAType_rec.DAStatus;
	SELECT SRTC.internalfile, 
	   SRTC.duedateoffset 
	INTO   v_accesslevel, v_duedateoffset 
	FROM   servicerequesttypeconfig SRTC 
	WHERE  SRTC.intakeservreqtypeid = v_datypekey 
	   AND SRTC.servicerequestsubtypeid = v_dasubtypekey 
	   AND SRTC.activeflag = 1 
	   AND Lower(SRTC.category) = 'intake' 
	   AND SRTC.expirationdate :: date > v_date :: date; 
	v_IntakeServiceId    :=            gen_random_uuid();                                  
	/*For    Assesment    Update*/                                                     
   
	IF v_targetId  IS  NOT NULL THEN
	UPDATE assessment SET objectid = v_intakeserviceid , updatedby = v_securityuserid,                                                                                                                                                                                                                                        
     updatedon = v_date WHERE  intakenumber = v_intakenumber AND    COALESCE(objectid:: character VARYING,'') ='00000000-0000-0000-0000-000000000000';                                                    
	END IF;
	
	                                  	    
	UPDATE sp_createintake_temp_datype SET    accesslevel = v_accesslevel, intakeserviceid = v_intakeserviceid WHERE  servicerequestnumber = v_daservicerequestnumber; 
	if(v_isoverridereq=true and ((LOWER(v_supDisposition)='scrnin') and (v_purposename ='Request for services' or v_purposename = 'Kinship Navigation') )
	or ((Lower(v_supDisposition) ='progress roa' and LOWER(v_roacpsstatetype)='outofstate' ) and v_isoverridereq=true )) then
	UPDATE sp_createintake_temp_datype SET    accesslevel = v_accesslevel, intakeserviceid = v_IntakeServiceIdoverridereq WHERE  servicerequestnumber = v_daservicerequestnumber;
	
	END IF;


    IF LENGTH(v_personId) > 0 THEN                                               	
        INSERT    INTO    sp_CreateIntake_Temp_DAPersonTemp 
        SELECT    regexp_split_to_table(v_personId,',')::uuid    as    value;
    END IF;                                       
    SELECT count(*)INTO my_Temp_Var FROM sp_CreateIntake_Temp_DAPersonTemp;
	
	RAISE  NOTICE  '  v_isoverridereq  %',v_isoverridereq; 
	RAISE  NOTICE  '  v_intakenumber  %',v_intakenumber; 


IF (v_traffickingupdated = 'true' ) then
  INSERT INTO cjams.sdmtraffickingaudittrail
								(intakeservicerequestsdmid,
								updatedby,
								updatedon,
								insertedby,
								insertedon,
								objectid,
								objecttype,
								selecttrafficking,
								concernfortrafficking,
								objectkey)
								
							 values(
							 null,
							 v_securityuserid, 
				             now(),
							 v_securityuserid, 
				             now(),
							 v_InatkeNumber,
							 'Intake',
							 v_selecttrafficking,
							 v_concernfortrafficking,
						     'trafficking'
							 ); 
END IF;							 
IF ( v_maltreatmentupdated = 'true') then
  INSERT INTO cjams.sdmtraffickingaudittrail
								(intakeservicerequestsdmid,
								updatedby,
								updatedon,
								insertedby,
								insertedon,
								objectid,
								objecttype,
								ismaltreatment,
								isfclivingarrangement,
								isschool,
								islicenseddaycare,
								isprivateplacement,
								isfcplacementsetting,
								provider,
								providerdetails,
								objectkey)
								
							 values(
							 null,
							 v_securityuserid, 
				             now(),
							 v_securityuserid, 
				             now(),
							 v_InatkeNumber,
							 'Intake',
							 v_ismaltreatment,
							 v_isfclivingarrangement ,
							v_isschool ,
							v_islicenseddaycare ,
							v_isprivateplacement ,
							v_isfcplacementsetting ,
							v_providerinfo ,
							v_providerdetails ,
							 'maltreatment'
							 ); 
END IF;	

if(v_isoverridereq=true) then
 v_IntakeServiceId:=v_IntakeServiceIdoverridereq;
 v_DAServiceRequestNumber:=v_DAServiceRequestNumberoverridereq;
  --update personprogramarea set activeflag=0,updatedon=now(),updatedby=v_securityuserid where objectid=cast(v_IntakeServiceId  as  character varying) and activeflag=1;
	
update Investigationmaltreatmentactor  set activeflag =0 ,updatedon=now(),updatedby=v_securityuserid
			where Investigationmaltreatmentactor.intakeservicerequestactorid in (select distinct  intakeservicerequestactor.intakeservicerequestactorid as intakeservicerequestactorid1  from 
			intakeservicerequestactor  where intakeserviceid=v_IntakeServiceId and activeflag =1);

UPDATE actor SET intakeserviceid=null , updatedby = v_securityuserid, updatedon = now() where  intakenumber is null and activeflag=1 and  intakeserviceid=v_IntakeServiceId;
	
update intakeservicerequestactor set intakeserviceid=null , updatedby = v_securityuserid, updatedon = now() where 
intakenumber is null and activeflag=1 and intakeserviceid=v_IntakeServiceId;
-- select intakeserviceid ,servicerequestnumber into v_IntakeServiceId ,v_DAServiceRequestNumber from intakeservicerequest where intakenumber=v_intakenumber  and activeflag = 1 limit 1;
RAISE  NOTICE  '  v_IntakeServiceId update  %',v_IntakeServiceId; 
	-- update investigationfinding  set activeflag=0,updatedon=now(),updatedby=v_securityuserid where activeflag =1 and  investigationallegationid in
	-- 	( select investigationallegationid from  investigationallegation where investigationid 
	-- 	in (select investigationid from investigation  where intakeserviceid
	-- 	in (select intakeserviceid  from intakeservicerequest where
	-- 	 intakenumber=v_intakenumber order by updatedon limit 1 )));
	update
	investigationfinding 
set
	activeflag = 0,
	updatedon = now(),
	updatedby = v_securityuserid
	from 
	intakeservicerequest isr join  
	investigation inv on inv.intakeserviceid= isr.intakeserviceid
	join investigationallegation isa on isa.investigationid=inv.investigationid
	where investigationfinding.activeflag=1 and isr.intakenumber = v_intakenumber and 
	investigationfinding.investigationallegationid=isa.investigationallegationid;

	update   investigationallegation set activeflag=0,updatedon=now(),updatedby=v_securityuserid  where investigationid in (select investigationid from investigation  where intakeserviceid= (select intakeserviceid  from intakeservicerequest where intakenumber=v_intakenumber order by updatedon limit 1 ));
	RAISE  NOTICE  '  investigation-1141  %',v_IntakeServiceId; 

update investigation set activeflag=0,updatedon=now(),updatedby=v_securityuserid  where intakeserviceid= (select intakeserviceid  from intakeservicerequest where intakenumber=v_intakenumber order by updatedon limit 1 );

update intakeservicerequest 
set
	activeflag =1, 
	addendum =(SELECT    addendum        FROM    sp_CreateIntake_Temp_DAGeneral), 
	narrative =(SELECT    Narrative        FROM    sp_CreateIntake_Temp_DAGeneral), 
	islocalreferal =(SELECT    islocalreferal        FROM    sp_CreateIntake_Temp_DAGeneral ),                                                                                                                                                        
	referalcomments=(SELECT    referalcomments        FROM    sp_CreateIntake_Temp_DAGeneral ),                                                                                                                                                        
	nonreferalreason=(SELECT    nonreferalreason        FROM    sp_CreateIntake_Temp_DAGeneral), 
	                                                                                                                                                                                                                              
	intakeservreqinputtypeid=(SELECT    DAG.Source  FROM    sp_CreateIntake_Temp_DAGeneral    DAG), 
	 intakeservreqtypeid =(select DA.DATypeKey from sp_CreateIntake_Temp_DAType DA), 
	intakeserreqstatustypeid =	CASE  WHEN (v_DAStatus    is    null    OR        v_DAStatus    ='') THEN '6F45B314-10DD-4388-B89B-3590D2850577' ELSE    v_DAStatus::uuid    END,     
	 intakeservicerequestclassid =(select DA.DASubTypeKey from sp_CreateIntake_Temp_DAType DA), 
	updatedby=v_securityuserid,
	updatedon=now(), 
	effectivedate=v_date, 
	targetcompletedate= v_date::date    +    v_DueDateOffSet   , 
	suspiciousdeath =(SELECT    DAG.SuspiciousDeath 	FROM    	sp_CreateIntake_Temp_DAGeneral    DAG), 
	missingpersons=(SELECT    DAG.MisssingPersons 	FROM    sp_CreateIntake_Temp_DAGeneral    DAG)        ,   
	illegalactivity=(SELECT    DAG.IllegalActivity  FROM    sp_CreateIntake_Temp_DAGeneral    DAG)        ,   
	intakeservicerequestillegalactivitytypekey=(SELECT    DAG.IllegalActivityKey FROM  sp_CreateIntake_Temp_DAGeneral    DAG),   
	servicerequestincidenttypekey=(SELECT    DAG.SignificantEventKey FROM sp_CreateIntake_Temp_DAGeneral    DAG)    ,                                                        
	monumber=(SELECT    DAG.MONumber FROM    sp_CreateIntake_Temp_DAGeneral    DAG), 
	isanonymousreporter=(SELECT    DAG.IsAnonymousReporter FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	intakeservreqpurposeid=(SELECT    DAG.Purpose FROM    sp_CreateIntake_Temp_DAGeneral    DAG)    ,
	intakenumber=v_InatkeNumber	,
	teamtypekey=(SELECT    DAG.Agencycode            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	isotheragency=(SELECT    DAG.isOtherAgency            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	agencyname=(SELECT    DAG.OtherAgency            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	isunknownreporter=(SELECT    DAG.isUnknownreporter            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	reporterfirstname=(SELECT    DAG.reporterfirstname            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	reporterlastname=(SELECT    DAG.reporterlastname            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	offenselocation=(SELECT    DAG.offenselocation            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	requesterphone=(SELECT    DAG.requesterPhone            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	requesterzipcode=(SELECT    DAG.requesterzipcode            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	requesteraddress1=(SELECT    DAG.requesteraddress1            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	requesteraddress2=(SELECT    DAG.requesteraddress2            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	requestercity=(SELECT    DAG.requestercity            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	requesterstate=(SELECT    DAG.requesterstate            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	requestercounty=(SELECT    DAG.requestercounty            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	narrativeUpdatedDate=(SELECT    DAG.narrativeUpdatedDate            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	intakedaterecieved=(SELECT    DAG.RecivedDate                 FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	isacknowledgementletter=(SELECT    DAG.isacknowledgementletter            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	iszipcoderefuse=(SELECT    DAG.iszipcoderefuse            FROM    sp_CreateIntake_Temp_DAGeneral    DAG) ,
	countyid=(SELECT    DAG.countyid            FROM    sp_CreateIntake_Temp_DAGeneral    DAG) ,
	addendumNarrativeUpdateddate = (SELECT    DAG.addendumNarrativeUpdateddate            FROM    sp_CreateIntake_Temp_DAGeneral    DAG)

	WHERE  ServiceRequestNumber   =   v_DAServiceRequestNumber and  intakeserviceid in (v_IntakeServiceId ) ; 
	raise notice 'v_inakeserviceid 11271 %' ,v_supDisposition;
   if COALESCE(v_casealreadycreated, false) = false then 
   update intakeservicerequest set 
   reporteddate=(SELECT    COALESCE(DAG.narrativeUpdatedDate, DAG.RecivedDate)      FROM    sp_CreateIntake_Temp_DAGeneral    DAG), 
   reportedtime =(SELECT    DAG.Time    FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
   updatedby=v_securityuserid,
   updatedon=now()
	WHERE  ServiceRequestNumber   =   v_DAServiceRequestNumber and  intakeserviceid in (v_IntakeServiceId ) ;

	end if;
	IF  (v_Agencycode=  'CW')  then
			IF (v_reporterdetails)::json IS NOT NULL THEN
				For    v_reporterobj    in    SELECT    *    FROM    json_array_elements(v_reporterdetails) 
				LOOP 
					update intakeservicerequest set 
					reportermiddlename = (v_reporterobj ->> 'Middlename'):: character varying,
					reporterphonenumber = (v_reporterobj ->> 'PhoneNumber'):: character varying,
					reporterphonenumberext = (v_reporterobj ->> 'PhoneNumberExt'):: character varying,
					reporterroletypekey = (v_reporterobj ->> 'Role'):: character varying,
					reporterzipcode = (v_reporterobj ->> 'ZipCode'):: character varying,
					reporteremail = (v_reporterobj ->> 'email'):: character varying,
					reporterincidentlocation = (v_reporterobj ->> 'incidentlocation'):: character varying,
					reporterisapproximate = (v_reporterobj ->> 'isapproximate'):: boolean,
					reporterorganization = (v_reporterobj ->> 'organization'):: character varying,
					reportertitle = (v_reporterobj ->> 'title'):: character varying,
					reporterincidentdate = (case when (v_reporterobj ->> 'incidentdate') = '' then null else (v_reporterobj ->> 'incidentdate')  end):: timestamp,
					reporterisAnonymousReporter = (v_reporterobj ->> 'IsAnonymousReporter'):: boolean,
					reporterisUnknownReporter = (v_reporterobj ->> 'IsUnknownReporter'):: boolean,
					reporternarrative = (v_reporterobj ->> 'Narrative'):: text,
					reporterrefuseToShareZip = (v_reporterobj ->> 'RefuseToShareZip'):: boolean,
					reporterisacknowledgementletter = (v_reporterobj ->> 'isacknowledgementletter'):: integer,
					reporteraddress1 = (v_reporterobj ->> 'requesteraddress1'):: character varying,
					reporteraddress2 = (v_reporterobj ->> 'requesteraddress2'):: character varying,
					reportercity = (v_reporterobj ->> 'requestercity'):: character varying,
					reporterstate = (v_reporterobj ->> 'requesterstate'):: character varying,
					updatedon = now(),
					updatedby = v_securityuserid
					WHERE    ServiceRequestNumber   =   v_DAServiceRequestNumber  ;
				END LOOP;
			END IF;
	End IF;

	if(LOWER(v_supDisposition)='scrnin') then


	raise notice 'v_inakeserviceid 1127 %' ,v_IntakeServiceId;
							update intakeservicerequestdispositioncode  set intakeserreqstatustypeid='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690',
						servicerequesttypeconfigiddispostionid ='e1005c79-c6d1-40c2-9a78-5b6845763bef', updatedon = now(),
				updatedby = v_securityuserid where intakeserviceid=v_IntakeServiceId;
	UPDATE sp_CreateIntake_Temp_DAType SET 
    DAStatus='52ad4cc7-e8f8-4cbb-9e27-d86f2b817690' , 
    DADisposition='e1005c79-c6d1-40c2-9a78-5b6845763bef' WHERE  intakeserviceid=v_IntakeServiceId;
	end if;
	if(LOWER(v_supDisposition)=LOWER('screenout')) then
	v_isinvestigation:= 0; 

		update investigationfinding  set activeflag=0 ,updatedon=now(),updatedby=v_securityuserid where activeflag =1 and  investigationallegationid in
		( select investigationallegationid from  investigationallegation where investigationid 
		in (select investigationid from investigation  where intakeserviceid
		in (select intakeserviceid  from intakeservicerequest where
		 intakenumber=v_intakenumber order by updatedon limit 1 )));

	update   investigationallegation set activeflag=0,updatedon=now(),updatedby=v_securityuserid where investigationid in (select investigationid from investigation  where intakeserviceid= (select intakeserviceid  from intakeservicerequest where intakenumber=v_intakenumber order by updatedon limit 1 ));
	RAISE  NOTICE  '  investigation-1141  %',v_IntakeServiceId; 

update investigation set activeflag=0,updatedon=now(),updatedby=v_securityuserid where intakeserviceid= (select intakeserviceid  from intakeservicerequest where intakenumber=v_intakenumber order by updatedon limit 1 );
v_isinvestigation := 0;
			select servicecaseid into v_servicecaseidoverridereq from intakeservicerequest where intakeserviceid=v_IntakeServiceId and activeflag=1;
update personprogramarea set activeflag=0,updatedon=now(),updatedby=v_securityuserid where objectid=cast(v_IntakeServiceId  as  character varying) and activeflag=1;
update intakeservicerequest
				set activeflag = 0,
				servicecaseid = null,
				updatedon = now(),
				updatedby = v_securityuserid				
				where intakenumber = v_intakenumber;
RAISE  NOTICE  ' 1  %',v_DADisposition; 
			update routing set activeflag=0 where objectid=v_intakenumber and routingstatustypeid=860 and activeflag=1;
			
if (not exists (select intakeserviceid   from intakeservicerequest where servicecaseid in (v_servicecaseidoverridereq)
and intakeserviceid != v_IntakeServiceId)) then 
			
			update servicecase set activeflag=0,updatedon = now(),
				updatedby = v_securityuserid where servicecaseid=v_servicecaseidoverridereq and activeflag=1;
end if;				--update servicecase set updatedby=v_securityuserid,updatedon=now(),activeflag=0 where servicecaseid in (select servicecaseid from intakeservicerequest  where intakenumber=v_intakenumber) and activeflag=1;
end if;
else
RAISE  NOTICE  '  v_isoverridereq--in  %',v_isoverridereq; 
	INSERT INTO intakeservicerequest 
	( 
	intakeserviceid, 
	activeflag, 
	servicerequestnumber, 
	narrative, 
	addendum,
	islocalreferal, 
	referalcomments, 
	nonreferalreason, 
	reporteddate, 
	reportedtime, 
	intakeservreqinputtypeid, 
	intakeservreqtypeid, 
	intakeserreqstatustypeid, 
	intakeservicerequestclassid, 
	updatedby, 
	updatedon, 
	insertedby, 
	insertedon, 
	effectivedate , 
	targetcompletedate , 
	suspiciousdeath, 
	missingpersons , 
	illegalactivity, 
	intakeservicerequestillegalactivitytypekey , 
	servicerequestincidenttypekey, 
	monumber, 
	--IntakeServReqInputSourceId, 
	isanonymousreporter, 
	intakeservreqpurposeid, 
	intakenumber, 
	teamtypekey, 
	isotheragency, 
	agencyname, 
	isunknownreporter, 
	reporterfirstname, 
	reporterlastname, 
	offenselocation, 
	requesterphone, 
	requesterzipcode, 
	requesteraddress1, 
	requesteraddress2, 
	requestercity, 
	requesterstate, 
	requestercounty, 
	narrativeUpdatedDate,
    intakedaterecieved,
	isacknowledgementletter, 
	iszipcoderefuse , 
	countyid,
	addendumNarrativeUpdateddate 
	
	)                    

	SELECT  DA.IntakeServiceId    ,
	1,  -- reverting previously implemented logic of using active flag 2 to record the entry as Screened Out entry                                                                                                                                                                                                                              
	DA.ServiceRequestNumber,                                                                                                                                                                                                                                
	(SELECT    Narrative        FROM    sp_CreateIntake_Temp_DAGeneral    DAG),  
	(SELECT    DAG.addendum        FROM    sp_CreateIntake_Temp_DAGeneral DAG),          
	(SELECT    islocalreferal        FROM    sp_CreateIntake_Temp_DAGeneral    DAG),                                                                                                                                                        
	(SELECT    referalcomments        FROM    sp_CreateIntake_Temp_DAGeneral    DAG),                                                                                                                                                        
	(SELECT    nonreferalreason        FROM    sp_CreateIntake_Temp_DAGeneral    DAG),                                                                                                                                                        
	--@Simar: This change has been requeted by State.
    --The investigation start date will be the most recent 'narrative updated date'
    --In intakeservicerequest the 'reporteddate' is used as the investigation start date
    (SELECT    COALESCE(DAG.narrativeUpdatedDate, DAG.RecivedDate)      FROM    sp_CreateIntake_Temp_DAGeneral    DAG),                                                                                                                                                                                                                                
	(SELECT    DAG.Time    FROM    sp_CreateIntake_Temp_DAGeneral    DAG),                                                                                                                                                                                                                                
	(SELECT    DAG.Source  FROM    sp_CreateIntake_Temp_DAGeneral    DAG),                                                                                                                                                                                                                            
	DA.DATypeKey,                                                                                                                                                                                                                                
	CASE  WHEN (v_DAStatus    is    null    OR        v_DAStatus    ='') THEN '6F45B314-10DD-4388-B89B-3590D2850577' ELSE    v_DAStatus::uuid    END,    
	DA.DASubTypeKey,    
	v_securityuserid,
	v_date,
	v_securityuserid,
	v_date,
	v_date,
	v_date::date    +    v_DueDateOffSet    ,
	(SELECT    DAG.SuspiciousDeath 	FROM    	sp_CreateIntake_Temp_DAGeneral    DAG)  , 
	(SELECT    DAG.MisssingPersons 	FROM    sp_CreateIntake_Temp_DAGeneral    DAG)        ,   
	(SELECT    DAG.IllegalActivity  FROM    sp_CreateIntake_Temp_DAGeneral    DAG)        ,   
	(SELECT    DAG.IllegalActivityKey FROM  sp_CreateIntake_Temp_DAGeneral    DAG),   
	(SELECT    DAG.SignificantEventKey FROM sp_CreateIntake_Temp_DAGeneral    DAG)    ,                                                        
	(SELECT    DAG.MONumber FROM    sp_CreateIntake_Temp_DAGeneral    DAG), 
	(SELECT    DAG.IsAnonymousReporter FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.Purpose FROM    sp_CreateIntake_Temp_DAGeneral    DAG)    ,
	v_InatkeNumber	,
	(SELECT    DAG.Agencycode            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.isOtherAgency            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.OtherAgency            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.isUnknownreporter            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.reporterfirstname            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.reporterlastname            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.offenselocation            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.requesterPhone            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.requesterzipcode            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.requesteraddress1            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.requesteraddress2            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.requestercity            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.requesterstate            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.requestercounty            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.narrativeUpdatedDate            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.RecivedDate                 FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.isacknowledgementletter            FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	(SELECT    DAG.iszipcoderefuse            FROM    sp_CreateIntake_Temp_DAGeneral    DAG) ,
	(SELECT    DAG.countyid            FROM    sp_CreateIntake_Temp_DAGeneral    DAG)  ,
	(SELECT    DAG.addendumNarrativeUpdateddate           FROM    sp_CreateIntake_Temp_DAGeneral    DAG) 
	FROM    sp_CreateIntake_Temp_DAType    DA  
	WHERE    DA.ServiceRequestNumber   =   v_DAServiceRequestNumber ;                    
END IF; 
/*    Agency    Services    */

    IF  (v_Agencycode=  'CW')  then
		IF (v_reporterdetails)::json IS NOT NULL THEN
			For    v_reporterobj    in    SELECT    *    FROM    json_array_elements(v_reporterdetails) 
			LOOP 
				update intakeservicerequest set 
				reportermiddlename = (v_reporterobj ->> 'Middlename'):: character varying,
				reporterphonenumber = (v_reporterobj ->> 'PhoneNumber'):: character varying,
				reporterphonenumberext = (v_reporterobj ->> 'PhoneNumberExt'):: character varying,
				reporterroletypekey = (v_reporterobj ->> 'Role'):: character varying,
				reporterzipcode = (v_reporterobj ->> 'ZipCode'):: character varying,
				reporteremail = (v_reporterobj ->> 'email'):: character varying,
				reporterincidentlocation = (v_reporterobj ->> 'incidentlocation'):: character varying,
				reporterisapproximate = (v_reporterobj ->> 'isapproximate'):: boolean,
				reporterorganization = (v_reporterobj ->> 'organization'):: character varying,
				reportertitle = (v_reporterobj ->> 'title'):: character varying,
				reporterincidentdate = (case when (v_reporterobj ->> 'incidentdate') = '' then null else (v_reporterobj ->> 'incidentdate')  end):: timestamp,
				reporterisAnonymousReporter = (v_reporterobj ->> 'IsAnonymousReporter'):: boolean,
				reporterisUnknownReporter = (v_reporterobj ->> 'IsUnknownReporter'):: boolean,
				reporternarrative = (v_reporterobj ->> 'Narrative'):: text,
				reporterrefuseToShareZip = (v_reporterobj ->> 'RefuseToShareZip'):: boolean,
				reporterisacknowledgementletter = (v_reporterobj ->> 'isacknowledgementletter'):: integer,
				reporteraddress1 = (v_reporterobj ->> 'requesteraddress1'):: character varying,
				reporteraddress2 = (v_reporterobj ->> 'requesteraddress2'):: character varying,
				reportercity = (v_reporterobj ->> 'requestercity'):: character varying,
				reporterstate = (v_reporterobj ->> 'requesterstate'):: character varying
				where intakeserviceid = (select DA.IntakeServiceId  FROM    sp_CreateIntake_Temp_DAType    DA  
				WHERE    DA.ServiceRequestNumber   =   v_DAServiceRequestNumber)  ;
			END LOOP;
		END IF;

        FOR  i  in  SELECT  *  FROM  json_array_elements((saveDtlsObj->'General'->>'intakeservice')::json)
        LOOP
            v_intakeservtypekey:=    i->>'intakeservtypekey';
            v_intakesubservice:=  i->>'intakesubservice'; 
       
           	SELECT (CASE  WHEN plantypekey = 'FC'  THEN  1  ELSE 0 END) INTO v_isfamilycase FROM  intakeagencyserv  
          	WHERE  intakeservid = (i->>'intakeservid')::uuid LIMIT 1;
	
            IF (v_intakeservtypekey  is  not  null)  THEN
                INSERT  INTO  intakeservicerequestservice(
                        intakeservreqserviceid,Intakeserviceid,teamtypekey,intakeservreqservicekey )
                VALUES(gen_random_uuid(),v_IntakeServiceId,v_Agencycode,v_intakeservtypekey)  RETURNING  "intakeservreqserviceid"  INTO  v_intakeservreqserviceid;

                INSERT  INTO  intakeservicerequestsubservice  (intakeservreqserviceid,intakeservsubtypekey,insertedby,insertedon,updatedby,updatedon)
                SELECT      v_intakeservreqserviceid,*  ,v_securityuserid,v_date,v_securityuserid,v_date  
                FROM    json_to_recordset(v_intakesubservice    )    as    x("intakeservsubtypekey"    character    varying);

				IF(v_intakeservtypekey = 'CPSHC') THEN
					update cjams.usernotification un set activeflag = 0, updatedby = v_securityuserid, updatedon = v_date where un.objectid::varchar = v_intakeNumber::varchar and un.activeflag = 1 and un.subject like '%Submitted for Review by%';
				END IF;

                For  j in Select * from json_array_elements((i->>'intakesubservice')::json)	
                LOOP 
                    v_intakeservsubtypekey := j->>'intakeservsubtypekey'; 
                    IF ( v_intakeservtypekey = 'IHS' and (v_intakeservsubtypekey IN ('VP', 'FPS') )) THEN
                        v_isroute := 21;
                        v_isinvestigation := 0; 
                    END IF; 
                END LOOP; 
			END IF;
        END LOOP;
    ELSE
        IF(v_intakeservtypekey is not null) THEN
			INSERT INTO intakeservicerequestservice(Intakeserviceid,teamtypekey, intakeservreqservicekey)
			VALUES(v_IntakeServiceId,v_Agencycode,v_intakeservtypekey);
		END IF;
    END IF;
         
	   UPDATE sp_CreateIntake_Temp_DAType SET isfamilycase = v_isfamilycase WHERE  intakeserviceid=v_IntakeServiceId;
	      /*Attachment    Updated    */	
    Update documentproperties SET servicerequestid = v_IntakeServiceId, updatedby = v_securityuserid, updatedon = now()
    WHERE intakenumber = v_intakeNumber; 

    --    Investigation 
    IF (v_isinvestigation = 1) THEN
        INSERT    INTO    investigation(activeflag,intakeserviceid,insertedby,updatedby,effectivedate, insertedon, updatedon)
        VALUES    (1,v_IntakeServiceId,v_securityuserid,v_securityuserid,v_date,v_date,v_date)    RETURNING    "investigationid"    INTO    l_newInvestigationId;
    END IF; 

	/*    DSDS    ACTION    TASK    GOAL    DETAILS    */  
--For    Inserting    Agency    Details 
IF(LOWER(v_supDisposition) !=LOWER('screenout') and v_isoverridereq =false) then
    INSERT INTO    intakeservicerequestagency(agencyid,  description, agencyroletypekey,    agencytypekey,intakeserviceid, activeflag,insertedby, insertedon)                                
    SELECT agencyid,  description, agencyroletypekey,    agencytypekey, v_IntakeServiceId,1,v_securityuserid,v_date 
    FROM    json_to_recordset(v_AgencyDtls) as    x ("agencyid"    uuid,"description"    character    varying, "agencyroletypekey"    character    varying, "agencytypekey"    character    varying );                        

    IF    (v_Agencycode='CW')    THEN 
      INSERT INTO    intakeservicerequestagency
      				(referralid, agencytypekey, screeningid,
      				 intakeserviceid, otherresource, resourcetypes, statecountycode,
      				 roacpsstatetypekey, servicerequesttypekey, activeflag, 
      				 insertedby, insertedon, updatedby, updatedon)                                
  	 	 VALUES 	((v_roacps->>'cpsid'), v_roacps->>'statetype', v_roacps->>'intakenumber',
  	 				 v_IntakeServiceId, v_roacps->>'otherresource', (v_roacps->>'resourcetypes')::json,v_roacps->>'jurisdiction',
  	 				 v_roacps->>'roacpsstatetypekey', v_roacps->>'servicerequested', 1,
  	 				 v_securityuserid, v_date, v_securityuserid, v_date );
    END IF;	
	END IF;	

	SELECT  externalentity  INTO    v_externalentity    FROM    externalentity(v_IntakeServiceId,v_securityuserid);     

    /*CW   -  SDM    info*/ 
    SELECT intakeservreqtypekey INTO v_child FROM intakeservicerequesttype WHERE intakeservreqtypeid = v_DATypeKey ;     

    IF (v_Agencycode='CW' and v_child IN ('CHILD','ROH', 'ROACPS', 'Information and Referral', 'Request for services') and v_sdm is not null)    THEN 
        SELECT intakesdm INTO v_sdmreturn FROM intakesdm(v_sdm, v_dispositioncode, v_IntakeServiceId::uuid, v_securityuserid);
    END IF;	 
	if((LOWER(v_supDisposition)='scrnin' and v_isoverridereq=true) ) then	 
	 IF ((COALESCE(v_casealreadycreated, false) = false)) THEN
    	UPDATE intakeservicerequest
    	SET
			reporteddate = (
				SELECT COALESCE(DAG.addendumNarrativeUpdateddate, DAG.RecivedDate)
				FROM sp_CreateIntake_Temp_DAGeneral DAG
			),
			updatedby = v_securityuserid,
			updatedon = NOW()
    	WHERE ServiceRequestNumber = v_DAServiceRequestNumber
      		AND intakeserviceid IN (v_IntakeServiceId);
	END IF;

SELECT actiontype INTO v_actiontype FROM  intakeservicerequest WHERE intakeserviceid=v_IntakeServiceId;
-- WITH temp_ids AS ( INSERT INTO personprogramarea 
--    (personid, programkey,subprogramkey,objecttypekey,objectid,startdate,insertedby,updatedby,entityid, datatransferflag, sourcetype) 	
-- SELECT 
-- 	a.personid,'CPS',v_actiontype,'servicerequest',v_IntakeServiceId,COALESCE(l_accepteddate,l_inserteddate)::date,fromuserid,fromuserid,v_servicerequestno,'A', 'CW'
-- FROM  actor a 
-- WHERE a.intakeserviceid=v_IntakeServiceId AND a.activeflag=1 and a.personid not in (select 
-- personid from personprogramarea where programkey='CPS' and objecttypekey =  'servicerequest' and
-- objectid::uuid = v_IntakeServiceId )
-- RETURNING personprogramid )
-- INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids
-- ;
WITH temp_ids1 AS (
update personprogramarea set subprogramkey =v_actiontype ,updatedon = now(),updatedby=v_securityuserid where personid in (select 
personid from personprogramarea where programkey='CPS' and objecttypekey =  'servicerequest' and
objectid::uuid = v_IntakeServiceId)
and programkey='CPS' and objecttypekey =  'servicerequest' and
objectid::uuid = v_IntakeServiceId and subprogramkey!= v_actiontype RETURNING personprogramid)
INSERT INTO Temp_insert_person_program_area SELECT personprogramid from temp_ids1;
--  end if;
FOR l_record IN (select * from Temp_insert_person_program_area)
LOOP
  INSERT INTO auditlog(referenceid, logtypekey, description, metadata, insertedon, insertedby)
  VALUES(l_record.personprogramid,'PRGMAREA','systemupdate10',
            (SELECT row_to_json(personprogramarea) FROM personprogramarea WHERE personprogramid = l_record.personprogramid), now(), v_securityuserid);
END LOOP;

DROP TABLE Temp_insert_person_program_area;
	end if;

	
IF  (LOWER(v_supDisposition)='progress roa' and LOWER(v_roacpsstatetype)='roaundercourt') THEN
UPDATE intakeservicerequest SET    activeflag =0, updatedby = v_securityuserid, updatedon = now() 
WHERE  intakenumber =v_intakenumber;
END IF; 

if ((Lower(v_supDisposition) ='progress roa' and v_isoverridereq=true and LOWER(v_roacpsstatetype)='outofstate' )) then

  update intakeservicerequest set
	   reporteddate=(SELECT    COALESCE(DAG.addendumNarrativeUpdateddate, DAG.RecivedDate)      FROM    sp_CreateIntake_Temp_DAGeneral    DAG),
	   updatedby=v_securityuserid,
       updatedon=now()
	   WHERE  ServiceRequestNumber   =   v_DAServiceRequestNumber and  intakeserviceid in (v_IntakeServiceId ) ; 
	   end if;

	INSERT INTO intakeservicerequestcrossreference 
	( 
	fromintakeservicerequestid, 
	withintakeservicerequestid, 
	insertedby, 
	insertedon, 
	intakeservicerequestcrossreferencereasontypekey, 
	activeflag 
	)
    SELECT crossrefdaid::uuid, 
	   v_intakeserviceid, 
	   v_securityuserid, 
	   v_date, 
	   reasonsofcrossref, 
	   1 
	FROM json_to_recordset(v_CrossRefDtls    ) 
	as    x("crossrefdaid"    character    varying,
	"reasonsofcrossref"    character    varying,
	"crossrefwith"        character    varying)    
	WHERE    crossrefwith    =    v_DAServiceRequestNumber    ;                

--For    Inserting    Recording    Details  
SELECT    intakerecording    INTO    v_recordingreturn    FROM    intakerecording(v_Recordingjsondata,v_IntakeServiceId::uuid,v_DAServiceRequestNumber,v_securityuserid);

SELECT    DAG.IllegalActivityKey    INTO    v_IllegalActivityKey  FROM    sp_CreateIntake_Temp_DAGeneral    DAG;                                                                                                                    
IF    (v_IllegalActivityKey    IS    NOT    NULL) THEN   
	INSERT INTO intakeservicerequestillegalactivity 
	( 
	activeflag, 
	intakeservicerequestillegalactivityid, 
	intakeservicerequestillegalactivitytypekey, 
	intakeservicerequestid, 
	effectivedate, 
	insertedby, 
	insertedon, 
	updatedby, 
	updatedon 
	)
                                                                 
	SELECT    1, 
	gen_random_uuid(),  
	(SELECT    DAG.IllegalActivityKey  FROM    sp_CreateIntake_Temp_DAGeneral    DAG),     
	DA.IntakeServiceId,    
	v_date,    
	v_securityuserid,   
	v_date,  
	v_securityuserid,    
	v_date   
	FROM    sp_CreateIntake_Temp_DAType    DA    
	WHERE    DA.ServiceRequestNumber        =    v_DAServiceRequestNumber;    
END    IF;   
                                                                                                                                         
INSERT INTO intakeservicerequestdispositioncode 
	( 
	activeflag, 
	intakeservicerequestdispositioncodeid, 
	intakeserviceid, 
	insertedby, 
	insertedon, 
	updatedby, 
	updatedon, 
	statusdate, 
	description, 
	reasonfordelay, 
	effectivedate, 
	intakeserreqstatustypeid, 
	servicerequesttypeconfigiddispostionid, 
	servicerequestdispositionsubtypeconfigid, 
	servicerequestdispositionsubtypenotes 
	) 
SELECT    1, 
	gen_random_uuid(),  
	DA.IntakeServiceId    ,   
	v_securityuserid,   
	v_date,    
	v_securityuserid,   
	v_date,   
	v_date,   
	DA.Summary,   
	DA.ReasonforDelay, 
	v_date,    
	case when (LOWER(v_supDisposition)='scrnin' and v_isoverridereq=true)  then '52ad4cc7-e8f8-4cbb-9e27-d86f2b817690' else DAStatus    ::uuid  end,
	case when (LOWER(v_supDisposition)='scrnin' and v_isoverridereq=true)  then 'e1005c79-c6d1-40c2-9a78-5b6845763bef' else DADisposition    ::uuid  end,
	
	DAsubdisposition::uuid,
	subdispositionnotes 
FROM sp_CreateIntake_Temp_DAType    DA     
WHERE DA.ServiceRequestNumber  =    v_DAServiceRequestNumber;  

FOR i IN SELECT * FROM json_array_elements(v_Personjsondata)
LOOP
	IF i->>'Role' in ('RA', 'RC','Youth') THEN
	l_Firstname :=i ->> 'Firstname';
	l_Lastname :=i ->> 'Lastname';
	l_focuspersonid := (case length(i->>'Pid') when 0 THEN null else 
	(case left((i->>'Pid'),6) when 'tempid' THEN null else (i->>'Pid') end ) end )::uuid ;
	l_RAName := l_Firstname || ' ' || l_Lastname;
	END IF;
END LOOP;

-- UPDATE actor SET intakeserviceid=v_IntakeServiceId, updatedby = v_securityuserid, updatedon = now()
-- WHERE intakenumber=v_intakeNumber;

-- UPDATE intakeservicerequestactor SET intakeserviceid=v_IntakeServiceId, updatedby = v_securityuserid, updatedon = now()
-- WHERE intakenumber=v_intakeNumber;
For actorrec in select actorid from actor where intakenumber = v_intakeNumber and activeflag = 1 loop 
v_actorid := null;
	INSERT INTO actor
	(actorid, activeflag, personid, actortype,insertedby, insertedon, updatedby, updatedon, "timestamp", medicaideligibility, blockgranteligibility, recipientstatus, manualupdateflag, intakeserviceid, iscollateralcontact, ismentalillness,mentalillnessdetail, ismentalimpair,mentalimpairdetail, ishouseholdmember, isdangertoworker,dangertoworkerreason, sexoffenderregisteredflag, probationsearchconductedflag, drugexposednewbornflag, otherdrugs, personroletypeid, drugexposedkey)
	select gen_random_uuid(), 1, personid, actortype, v_securityuserid, now(), v_securityuserid, now(),null, medicaideligibility, blockgranteligibility, recipientstatus, manualupdateflag, v_IntakeServiceId, iscollateralcontact, ismentalillness, mentalillnessdetail, ismentalimpair,mentalimpairdetail, ishouseholdmember, isdangertoworker,dangertoworkerreason, sexoffenderregisteredflag, probationsearchconductedflag, drugexposednewbornflag, otherdrugs, personroletypeid, drugexposedkey
	from actor where intakenumber=v_intakeNumber and activeflag = 1 and actorid = actorrec.actorid returning actorid into v_actorid;

	INSERT INTO intakeservicerequestactor
	(intakeservicerequestactorid, actorid, intakeservicerequestpersontypekey, insertedon, insertedby, updatedon, updatedby, intakeserviceid,
	reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
	sexoffenderregisteredflag, probationsearchconductedflag,intakenumber,servicecaseid, fetalalcoholspctrmdisordflag,isheadofhousehold)
	select gen_random_uuid(), v_actorid, intakeservicerequestpersontypekey, now(),v_securityuserid, now(), v_securityuserid, v_IntakeServiceId,
	reported, isprimary, personid, rcactiveflag, aractiveflag, practiveflag, drugexposednewbornflag,
	sexoffenderregisteredflag, probationsearchconductedflag,null, null , fetalalcoholspctrmdisordflag, isheadofhousehold
	from intakeservicerequestactor where intakenumber=v_intakeNumber and activeflag = 1 and actorid = actorrec.actorid;

END Loop;

For actorrec in select actorid from actor where intakenumber = v_intakeNumber and activeflag = 1 loop 
	INSERT INTO cjams.actorrelationship
	(actorrelationshipid, relationshiptypekey, insertedby, insertedon, updatedby, updatedon, effectivedate, activeflag, intakeservicerequestactorid, client1id, client2id, person1id, person2id, intakeserviceid)
	select gen_random_uuid(), relationshiptypekey, v_securityuserid, now(), v_securityuserid, now(), now(),1, (select isra1.intakeservicerequestactorid from intakeservicerequestactor isra1 where isra1.activeflag = 1 and isra1.intakeserviceid = v_IntakeServiceId and isra1.personid = ar.person1id limit 1), 
	client1id, client2id, person1id, person2id, v_IntakeServiceId
	from actorrelationship ar where ar.intakeservicerequestactorid in (select isra.intakeservicerequestactorid from intakeservicerequestactor isra where isra.intakenumber = v_intakeNumber and actorid = actorrec.actorid and isra.activeflag = 1) and ar.activeflag = 1;
END Loop;

For personrolerec in select personroleid from personrole where intakenumber = v_intakeNumber and activeflag = 1 loop 
v_personroleid := null;
	INSERT INTO personrole ( personroleid, activeflag, personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
	otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, 
	dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, updatedby, updatedon,intakeserviceid,initialresponse,initialresponseupdatedby,initialresponseupdatedon)
	select gen_random_uuid(),1,personid, ishouseholdmember, iscollateralcontact, drugexposednewbornflag, drugexposedtypekey,
	otherdrugs, safehavenbabyflag, probationsearchconductedflag, sexoffenderregisteredflag, dangertoself, dangertoselfreason, isdangertoworker, 
	dangertoworkerreason, ismentalillness, mentalillnessdetail, ismentalimpair, mentalimpairdetail, v_securityuserid, now(), v_IntakeServiceId, initialresponse,initialresponseupdatedby,initialresponseupdatedon
	from personrole where intakenumber = v_intakeNumber and activeflag = 1  and personroleid = personrolerec.personroleid  returning personroleid into v_personroleid;

	INSERT INTO personroletype (personroletypeid, activeflag, personroleid, roletype, updatedby, updatedon, isprimary, insertedon, insertedby)
	select gen_random_uuid(), 1, v_personroleid, roletype, v_securityuserid, now(), isprimary, now(), v_securityuserid
	from personroletype where activeflag =1 and personroleid in (select personroleid from personrole where intakenumber = v_intakeNumber and personroleid = personrolerec.personroleid and activeflag = 1 order by insertedon desc limit 1);
End Loop;
-- UPDATE personrole set intakeserviceid=v_IntakeServiceId, updatedby = v_securityuserid, updatedon = now()
-- WHERE intakenumber=v_intakeNumber;

	INSERT INTO IntakeServiceRequestClearingData                                                                                                                
	( IntakeServiceRequestClearingId,                                                                                        
	IntakeServiceId,
	ActiveFlag,                                                                                                                
	EntityType,                                                                                                                
	EntityTypeId,                                                                                                                
	ClearingType,                                                                                                                
	Result,                                                                                                                
	updatedby,                                                                                                                
	updatedon,                                                                                                                
	insertedby,                                                                                                                
	insertedon,                                                                                                                            
	EffectiveDate,                                                                                                                
	FROMEntityTypeId,                                                                                                                
	ClearingData                                                                                                                    
	) SELECT    gen_random_uuid(),
	v_IntakeServiceId,
	1,
	'person',
	DAP.PersonId,
	'MID',
	'match',
	(SELECT DAG.Author FROM sp_CreateIntake_Temp_DAGeneral DAG),
	v_date,
	(SELECT DAG.Author FROM sp_CreateIntake_Temp_DAGeneral DAG),
	v_date,
	v_date,
	DAP.IntakeServiceRequestActorID, 
	DAP.MentealillnessDetail
	FROM sp_CreateIntake_Temp_DAPerson DAP
	WHERE DAP.MentealillnessDetail IS NOT NULL                                                                                                                                
	UNION                                                                                                                                            
	SELECT    gen_random_uuid(),
	v_IntakeServiceId,
	1,
	'person',
	DAP.PersonId,
	'MRD',
	'match',
	(SELECT DAG.Author FROM sp_CreateIntake_Temp_DAGeneral DAG),
	v_date,
	(SELECT DAG.Author FROM sp_CreateIntake_Temp_DAGeneral DAG),
	v_date,
	v_date,
	DAP.IntakeServiceRequestActorID,
	DAP.MentealimpairDetail
	FROM sp_CreateIntake_Temp_DAPerson DAP
	WHERE DAP.MentealimpairDetail IS NOT NULL ;                                                        

-- WHERE DAP.DmhConsumerId IS NOT NULL AND DAP.DmhConsumerId <> '00000000-0000-0000-0000-000000000000'                                                                                                                                    

	IF (SELECT COUNT(1) FROM sp_CreateIntake_Temp_DAGeneral DAG WHERE DAG.AnanymousReporter LIKE '%true%') = 1 THEN                                                                                                                                                                            
		INSERT INTO    IntakeServiceRequestActor 
		(                                                                                                                                                                                                                                
		IntakeServiceRequestActorId,
		ActorId,
		IntakeServiceRequestPersonTypeKey,
		insertedby, 
		insertedon,
		updatedby, 
		updatedon,
		IntakeServiceId,
		reported
		)
		SELECT 
		gen_random_uuid(),
		v_ReporterActorID,
		'Rep', 
		v_securityuserid,
		v_date,
		v_securityuserid,
		v_date, 
		v_IntakeServiceId,
		1::boolean;      
		
	END IF;    

	INSERT    INTO    IntakeServiceRequestUserAccess                                                                                                                                                                                                                                    
	(
	ActiveFlag,
	IntakeServiceRequestUserAccessId,
	SecurityUsersId,
	IntakeServiceId,
	insertedby,
	insertedon, 
	updatedby,
	updatedon, 
	EffectiveDate,
	LoadNumber
	)
	SELECT 1,
	gen_random_uuid(),
	coalesce(TMA.SecurityUsersId,''),
	v_IntakeServiceId,
	v_securityuserid, 
	v_date,
	v_securityuserid,
	v_date,
	v_date,
	TM.LoadNumber                                                                                                                                                                                                                                    
	FROM AccessList AC
	JOIN ServiceRequestTypeConfig CNFG ON CNFG.ServiceRequestTypeConfigId = AC.ServiceRequestTypeConfigId
	JOIN TeamMember TM ON TM.LoadNumber = AC.LoadNumber
	LEFT JOIN TeamMemberAssignment TMA ON TMA.TeamMemberId = TM.TeamMemberId AND TMA.ActiveFlag    =    1
	WHERE CNFG.IntakeServReqTypeId = v_DATypeKey
	AND CNFG.ServiceRequestSubTypeId = v_DASubTypeKey
	AND CNFG.ActiveFlag = 1;    

	if (v_message is null) THEN
		v_message := v_DAServiceRequestNumber;
	else
		v_message := v_message || '    ' || v_DAServiceRequestNumber;
	end if;                                                                                                                                                                                                    

	UPDATE    sp_CreateIntake_Temp_DAPerson    SET    IntakeServiceRequestActorID    =    gen_random_uuid();
	DELETE    FROM    sp_CreateIntake_Temp_DAPersonTemp;            

	--Save    Appointments
	SELECT    saveappointment    INTO    v_saveappointment_status    FROM    saveappointment(arr_appointments,    v_IntakeServiceId,    v_intakeNumber,    v_securityuserid);

END LOOP; 
			
/* Allegation */

-- start
FOR createcase IN SELECT * FROM json_array_elements(v_createdcasejsondata)
LOOP
	v_caseid:=createcase->>'caseID';
	
	RAISE  NOTICE  '  caseID  %',v_caseid; 

	IF  v_caseid is not null THEN
RAISE  NOTICE  '  investigation-1623  %',v_isoverridereq; 
	SELECT iv.investigationid INTO v_investigationid FROM intakeservicerequest isr
	join investigation iv on iv.intakeserviceid=isr.intakeserviceid and iv.activeflag=1 and isr.activeflag=1
	WHERE isr.servicerequestnumber=v_caseid;

	end if;

	RAISE  NOTICE  '  investigationid  %',v_investigationid; 

	v_maltreators:=createcase->>'maltreatmentactors';
	
	FOR  j  IN  SELECT  *  FROM  json_array_elements(v_maltreators)
	LOOP
		update intakeservicerequestactor isst 
		set ismaltreator= true, updatedby = v_securityuserid, updatedon = now()
		WHERE isst.intakeservicerequestactorid in 
		(SELECT isra.intakeservicerequestactorid FROM intakeservicerequestactor isra 
		join actor a on a.actorid  =  isra.actorid
		join person p on p.personid = a.personid WHERE isra.activeflag = 1 and a.activeflag = 1 and p.activeflag = 1 and  
		case when  j->>'personid'  is  not  null  THEN  p.personid  =  (j->>'personid')::uuid
		else (p.firstname  =  j->>'firstname'  and  p.lastname  =  j->>'lastname')  end);
	END LOOP;
	
	v_allegations:=createcase->>'choosenAllegation';
	
	FOR  allegations  IN  SELECT  *  FROM  json_array_elements(v_allegations)
	LOOP
		INSERT  INTO  investigationmaltreatment(investigationid,isjurisdiction, isreported,activeflag,insertedby,effectivedate) 
		VALUES  (v_investigationid,0,true,1,  v_securityuserid,  v_date) RETURNING  "maltreatmentid"  INTO  l_newmaltreatementid;
		RAISE  NOTICE  '  maltreatmentid  %',l_newmaltreatementid;
		 
		INSERT INTO investigationallegation( investigationid,  allegationid, maltreatmentid, name, reported,  indicators,  activeflag,insertedby, effectivedate)
		VALUES  (l_newInvestigationId,  (allegations->>'allegationID')::uuid, l_newmaltreatementid, (allegations->>'allegationValue'):: character varying,  1::boolean,
		allegations->>'Indicators',  1,  v_securityuserid,  v_date) RETURNING  "investigationallegationid"  INTO  l_newinvestigationallegationid;
		
		RAISE  NOTICE  '  investigationallegationid  %',l_newinvestigationallegationid;
		RAISE  NOTICE  '  v_indicators  %',v_indicators;
		
		v_indicators :=allegations->>'indicators';
		
		FOR indicators IN SELECT * FROM json_array_elements(v_indicators)
		LOOP
			INSERT INTO investigationallegationindicator(investigationallegationid,  indicatorid,activeflag,insertedby)
			VALUES (l_newinvestigationallegationid, (indicators->>'indicatorid')::uuid, 1,  v_securityuserid);
		END LOOP;
		  
	END LOOP;
END LOOP;
-- end
                    

/*Validate    the    Group    Details    */

SELECT COUNT(GroupNumber) INTO v_GroupCount FROM    sp_CreateIntake_Temp_DAType;        

IF v_GroupCount > 0 THEN                    
	FOR v_GroupDA_rec IN SELECT DISTINCT GroupNumber, GroupComment, GroupReasonType FROM sp_CreateIntake_Temp_DAType WHERE GroupNumber IS NOT NULL
	LOOP                        	    
		v_GroupNumber := v_GroupDA_rec.GroupNumber;
		v_GroupComment := v_GroupDA_rec.GroupComment;
		v_GroupReasonType := v_GroupDA_rec.GroupReasonType;
		v_IntakeGroupId := gen_random_uuid();    

		if( coalesce(v_GroupNumber,'') <>'') THEN
			INSERT    INTO    IntakeServiceRequestGroup                                                                                                                                                
			(                                                                                                                                                                                                                                
			GroupId,GroupNumber,GroupSummary,                                                                                                                                                                                                                                
			insertedby,insertedon,updatedby,                                                
			updatedon,EffectiveDate,GroupReasonTypeKey                                                                                                                                                                                                                                
			)                                                                                                                                                                                                                                
			SELECT                                                                                                                                                                                                                                    
			v_IntakeGroupId,    v_GroupNumber,    v_GroupComment,                                                                                                                                                                                                                                                            
			v_securityuserid,v_date,    v_securityuserid,                                                                                                                                                                                                                                
			v_date,v_date,v_GroupReasonType;                

			INSERT INTO IntakeServiceRequestGroupDetails(GroupDetlId, GroupId,IntakeServiceId, insertedby, insertedon, updatedby, updatedon, EffectiveDate                                                                                                                                                                                                                                
			) SELECT gen_random_uuid(), v_IntakeGroupId, DAT.IntakeServiceId, v_securityuserid, v_date, v_securityuserid, v_date, v_date                                                                                                                                                                                                                                
			FROM sp_CreateIntake_Temp_DAType    DAT            
			WHERE DAT.GroupNumber = v_GroupNumber;                        
		end if;
	END LOOP;                                                                                                                                                    
END IF;                

                    

/*Update    Intake    status*/                    
UPDATE IntakeDAStaging SET Status = 'Complete', updatedby = v_securityuserid, updatedon = now() WHERE IntakeNumber = v_InatkeNumber;                

IF (v_status_new = true) THEN
	UPDATE IntakeDAStaging SET Status = 'Closed', updatedby = v_securityuserid, updatedon = now() WHERE IntakeNumber = v_InatkeNumber and activeflag = 1; 
END IF;

SELECT    COUNT(*)    INTO    v_reqforservconfigcount    FROM    intakereqforservconfig            WHERE        intakenumber    =    v_InatkeNumber    and    activeflag=1;

IF (v_reqforservconfigcount > 0) THEN	
	UPDATE intakereqforservconfig SET reqforservstatus = 'Closed' , closingdate=now(), updatedon=now()
	WHERE intakenumber = v_InatkeNumber and activeflag=1;
END IF;

       
/*Intake    approval    update*/

IF ( v_appeventcode IN ('INTR','KINR')) THEN
	INSERT INTO intakesnapshot ( Intakenumber, intakeserviceid, approvedate, jsondata, approverusersid, insertedby, updatedby) 
	VALUES(v_intakeNumber, v_IntakeServiceId, cast(v_date as date), savedtlsobj::jsonb, v_securityuserid, v_securityuserid, v_securityuserid) returning intakesnapshotid  into v_intakesnapshotid;
	update intakesnapshot set activeflag=0, updatedby = v_securityuserid, updatedon = now() where intakesnapshotid not in (v_intakesnapshotid) and intakenumber=v_intakeNumber and activeflag=1;
	IF(v_Agencycode ='AS' and v_asignsecurityuserid is not null) THEN 
		SELECT routingintake INTO l_status FROM routingintake(v_intakeNumber, v_securityuserid, v_appeventcode, 2, v_commenttext, v_asignsecurityuserid, false, true, true);
	ELSE -- Child Welfare
		if (v_status_new = true) THEN
			SELECT    routingintake    INTO    l_status    FROM    routingintake
			(v_intakeNumber,v_securityuserid,v_appeventcode,8,v_commenttext,null,false,v_bFROMintake,v_bclosecase,'','','','',0, v_user_role);
			UPDATE intakedastatus  SET status = 8, submitteddate = v_date, updatedby = v_securityuserid, updatedon = now() 
			WHERE intakenumber = v_intakeNumber;
			
			-- select intakerecommendation into  v_DADisposition from routing where objectid=v_intakeNumber and activeflag=1 and routingstatustypeid=860;
		update routing set intakerecommendation= v_screeningRecommend,supervisordecision=v_supDisposition, updatedby = v_securityuserid, updatedon = now(),approveddate=now() where objectid=v_intakeNumber and routingid=(select routingid from routing where  activeflag =1 and objectid=v_intakeNumber order by updatedon desc limit 1);
			UPDATE routing SET activeflag =0, updatedby = v_securityuserid, updatedon = now()  WHERE    objectid=    v_intakeNumber and  routingstatustypeid  =  8 and activeflag=1;
		else 
		    SELECT COUNT(*) into l_routingCount FROM routing r  where r.objectid = v_intakeNumber and r.routingstatustypeid = 1 and r.activeflag=1 and r.tosecurityusersid =  v_securityuserid;
			IF l_routingCount>0 THEN
			   SELECT routingintake INTO l_status  FROM routingintake (v_intakeNumber,v_securityuserid,v_appeventcode,v_isroute,v_commenttext);
					update routing set intakerecommendation= v_screeningRecommend,supervisordecision=v_supDisposition where objectid=v_intakeNumber and routingid=(select routingid from routing where  activeflag =1 and objectid=v_intakeNumber order by updatedon desc limit 1);

			ELSE 
			   INSERT INTO routing
				(routingid, eventcode, fromsecurityusersid, tosecurityusersid, teamid, fromroleid, toroleid, objectid, routingstatustypeid, activeflag, insertedby, insertedon, updatedby, updatedon, isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid,intakerecommendation,supervisordecision,approveddate)
				select 
				gen_random_uuid(), eventcode, fromsecurityusersid, v_securityuserid, teamid, fromroleid, toroleid, objectid, 2, activeflag, v_securityuserid, now(), v_securityuserid, now(), isreviewrequest, remarks, old_id, routeddescription, servicerequestnumber, objecttypekey, old_from_id, old_to_id, principaltype, actiondatetime, etl_userid, etl_load_date, entityid,v_DADisposition,v_supDisposition,now()
				from routing 
				where objectid = v_intakeNumber and activeflag = 1 and routingstatustypeid in(1,860)  limit 1;
							UPDATE routing SET activeflag =0, updatedby = v_securityuserid, updatedon = now()  WHERE    objectid=    v_intakeNumber and  routingstatustypeid  =  860 and activeflag = 1 ;
 
			END IF;
			UPDATE  intakedastatus SET status = 2, submitteddate =  v_date, updatedby = v_securityuserid, updatedon = now()
			WHERE intakenumber = v_intakeNumber;
		end if;
	END IF;                    
END IF; 
 
IF v_isDisposition = true THEN 
	SELECT insertedby FROM intakedastatus WHERE intakenumber = v_intakeNumber INTO notifysecurityuserid;
	v_msg:=            'Approver    changed    Intake(    '||v_intakeNumber    ||')    disposition'    ;    	
	SELECT send_notification INTO v_notifystatus FROM 
	send_notification(notifysecurityuserid, v_securityuserid, notifysecurityuserid, 'System', 'Normal', v_msg,v_msg, v_intakeNumber);
END    IF;

SELECT coalesce(lastname,'')||', '|| coalesce(firstname,'') INTO v_username FROM userprofile WHERE securityusersid = v_securityuserid;

SELECT R.FROMsecurityusersid,RST.typedescription    INTO    v_notifyFROMsecurityusersid,v_notifydescription    FROM    routing    as    R
Join intakedastaging as IDAS On IDAS.intakenumber = R.objectid and IDAS.activeflag=1
Join routingstatustype as RST on RST.sequencenumber = R.routingstatustypeid and RST.activeflag=1                
WHERE R.FROMroleid like '%SW' and IDAS.intakenumber = v_intakeNumber limit    1;

IF (COALESCE(v_notifyFROMsecurityusersid,'')!='' and COALESCE(v_notifydescription)!='' ) THEN
	v_msg:= 'Approver changed Intake( '||v_intakeNumber ||') to status - '||v_dispositionstatusdescription || ' by ' ;
	SELECT send_notification INTO v_notifystatusoffice 
	FROM send_notification(v_notifyFROMsecurityusersid, v_securityuserid, v_notifyFROMsecurityusersid, 'System', 'Low', v_msg || v_username, v_msg || v_username , v_intakeNumber, false);
END    IF;    





/*Update    intakedastaging    isclw    ,    clwstatus    DJS    SAO    CLW    Dashboard    */            
 
SELECT IDS.intakenumber INTO v_clwstatusintakenumber FROM intakedastatus IDS
JOIN intakeservicerequest as ISR ON ISR.intakenumber=IDS.intakenumber and ISR.activeflag = 1        
JOIN intakeservicerequestactor as ISRA ON ISRA.intakeserviceid=ISR.intakeserviceid and ISRA.activeflag = 1        
JOIN intakeservicerequestdispositioncode as ISRDC ON ISRDC.intakeserviceid = ISR.intakeserviceid and ISRDC.activeflag = 1        
JOIN ServiceRequestTypeConfigDispositionCode as SRTCDC ON SRTCDC.servicerequesttypeconfigiddispostionid = ISRDC.servicerequesttypeconfigiddispostionid 
and SRTCDC.activeflag = 1    
JOIN DispositionCode as DC ON DC.dispositioncode = SRTCDC.dispositioncode and DC.activeflag = 1    
WHERE SRTCDC.dispositioncode='FPTSAO' and ISRA.intakeservicerequestpersontypekey='Youth' AND ISR.intakenumber = v_InatkeNumber AND ISR.intakeserreqstatustypeid    
IN (SELECT intakeserreqstatustypeid FROM intakeserreqstatustype WHERE LOWER(intakeserreqstatustypekey) in ('approved')) and ISR.activeflag =1 ;

IF (v_clwstatusintakenumber is not null) THEN
	v_clwdate:= now();
	
	UPDATE    intakedastaging set activeflag=0 , updatedby = v_securityuserid, updatedon = now() 
	WHERE intakenumber = v_InatkeNumber and activeflag=1;
	
	INSERT INTO intakedastaging(
	intakenumber,    dateRecieved,    narrative,    raname,    entityname,        intakeuser,
	cruworkername,    data,activeflag,    insertedon,    insertedby,    timerecieved,    updatedon,
	updatedby,    status,jsondata,versionnumber,dispositiondescription,statusdescription,ispreintake,isclw,sstastatustypekey, teamtypekey
	)
	
	SELECT    intakenumber,    dateRecieved,    narrative,    raname,    entityname,        intakeuser,
	cruworkername,    data,1,    v_clwdate,    v_securityuserid,    timerecieved,    v_clwdate,    
	v_securityuserid,    'Complete' ,jsondata,versionnumber,dispositiondescription,statusdescription,ispreintake,true,v_sstastatustypekey , 'CW'   --,1    
	FROM    intakedastaging    as    IDAS    WHERE    IDAS.intakenumber    =    v_InatkeNumber        order    by    IDAS.insertedon    desc    limit    1;

	UPDATE intakedastatus set isclw=true,sstastatustypekey=v_sstastatustypekey, updatedby = v_securityuserid, updatedon = now()   
	WHERE    intakenumber    =    v_InatkeNumber    ; 
	IF(v_intservreqtypkey = 'Waiver FROM Adult Court') THEN
		UPDATE intakeservicerequestevaluation    
		set complaintstatustypekey = 'PS', updatedby = v_securityuserid, updatedon = now()   
		WHERE intakenumber = v_InatkeNumber    ;
	ELSE
		UPDATE intakeservicerequestevaluation 
		set complaintstatustypekey = 'RCL', updatedby = v_securityuserid, updatedon = now()   
		WHERE intakenumber = v_InatkeNumber    ;
	END IF; 
    SELECT    JSON_AGG(TMA2.securityusersid)    INTO    j_clwusers   
	FROM    teammemberassignment    TMA     
	JOIN    teammember    TM    on    TM.teammemberid    =    TMA.teammemberid 
	JOIN    teammember    TM2    on    TM.teamid    =    TM2.teamid    and    TM2.roletypekey    like    '%CLW'    
	JOIN    teammemberassignment    TMA2    on    TM2.teammemberid    =    TMA2.teammemberid
	WHERE    TMA.securityusersid    =    v_securityuserid;

    --update    and    insert    folder    assignment 
	UPDATE folderassignment 
	SET status='Closed',closedate=now(),activeflag=0, updatedby = v_securityuserid, updatedon = now()   
    WHERE    objectid=v_intakeNumber    AND    foldertypekey='Intake'    AND    status='Active';

	INSERT    INTO    folderassignment(folderassignmentid,    objectid,    foldertypekey,    status,    opendate,        activeflag,    effectivedate, insertedon, updatedon, insertedby, updatedby)
 	SELECT    gen_random_uuid(),    v_intakeNumber,    'LegalAction',    'Active',    now(),    1,    now(), now(), now(), v_securityuserid, v_securityuserid WHERE    not    exists (SELECT    1    FROM    folderassignment    WHERE    objectid=v_intakeNumber    and    foldertypekey='LegalAction');

	FOR v_clwuserid IN SELECT * FROM    json_array_elements(j_clwusers) 
	LOOP 
		v_clwuserid := replace(v_clwuserid,'"','');
		v_msg:= 'Approver changed Intake( '||v_intakeNumber    ||') to status - '||v_dispositionstatusdescription || ' by ' ;

		SELECT send_notification INTO v_notifystatusclw 
		FROM send_notification(v_clwuserid,v_securityuserid,v_clwuserid,'System', 'High', v_msg || v_username, v_msg || v_username, v_intakeNumber,false);
	END LOOP;
	
ELSE
	/*Update    Intake    status*/   
    UPDATE IntakeDAStaging 
	SET Status = 'Complete' , ispreintake=true, updatedby = v_securityuserid, updatedon = now()   
	WHERE IntakeNumber = v_InatkeNumber;                

	IF (v_status_new = true) THEN 
	 UPDATE IntakeDAStaging 
	 SET Status = 'Closed' ,ispreintake=true, updatedby = v_securityuserid, updatedon = now()   
	 WHERE IntakeNumber = v_InatkeNumber and activeflag =1;  
	END IF; 
END IF;

-- Add Restitution 
IF (saveDtlsObj->>'paymentSchedule')::json IS NOT NULL THEN
	SELECT saverestitution INTO v_restitutionstatus FROM saverestitution (v_intakeNumber, (saveDtlsObj->>'paymentSchedule')::json, v_securityuserid);
END IF;
--added by venky for save repoter summary details

-- Add collaterals to case on approval
select * from addcollateralsfromintaketocase(v_intakeNumber, v_intakeserviceid::CHARACTER VARYING, v_securityuserid) INTO v_collateralmsg;
select  send_notification_for_cpsros   INTO    v_notifystatusclw from send_notification_for_cpsros(v_securityuserid::character varying,(v_roacps->>'cpsid')::character varying);

--Consider Contacts added in intake for responsetimer.
select cpsresponsetimerupdate into v_cpsresponsetimerupdate from cjams.cpsresponsetimerupdate(v_intakeserviceid);

--CIDM-8701: @personprogramarea insert
SELECT intakeserviceid, actiontype, insertedon, servicerequestnumber INTO intake_service_req_id, v_actiontype, l_inserteddate, v_servicerequestno FROM intakeservicerequest WHERE intakenumber = v_intakenumber order by insertedon desc limit 1; 
IF (v_actiontype='IR' OR v_actiontype='AR') THEN 
	SELECT updatedon INTO l_accepteddate FROM routing   WHERE  routingstatustypeid = 2 AND activeflag =1 AND eventcode ='INTR' AND objectid = v_intakenumber; 
	INSERT INTO personprogramarea 
	(personid, programkey,subprogramkey,objecttypekey,objectid,startdate,insertedby,updatedby,entityid, datatransferflag, sourcetype) 	
	SELECT 
		a.personid,'CPS',v_actiontype,'servicerequest',intake_service_req_id,COALESCE(l_accepteddate,l_inserteddate)::date,v_securityuserid,v_securityuserid,v_servicerequestno,'A', 'CW'
	FROM  actor a 
	WHERE a.intakeserviceid=intake_service_req_id AND a.activeflag=1 and a.personid not in (select 
	personid from personprogramarea where programkey='CPS' and objecttypekey =  'servicerequest' and objectid::uuid = intake_service_req_id); 
	v_overideprogramkey = 'CPS'; 
	v_overridesubprogrmkey = v_actiontype;
   
	update sp_CreateIntake_Temp_DAType set progrmkey1 = 'CPS', subprogrmkey1 = v_actiontype
	WHERE intakeserviceid=v_IntakeServiceId; 
END IF;
IF (v_actiontype is NULL and LOWER(v_supDisposition)='scrnin') THEN 
	SELECT updatedon INTO l_accepteddate FROM routing   WHERE  routingstatustypeid = 2 AND activeflag =1 AND eventcode ='INTR' AND objectid = v_intakenumber; 

	INSERT INTO personprogramarea 
	(personid, programkey,subprogramkey,objecttypekey,objectid,startdate,insertedby,updatedby,entityid, datatransferflag, sourcetype, isdefault) 	
	SELECT 
		a.personid,'IHSFP','SFCI','servicecase',intake_service_req_id,COALESCE(l_accepteddate,l_inserteddate)::date,v_securityuserid,v_securityuserid,null,'A', 'CW', true
	FROM  actor a 
	INNER JOIN person p ON p.personid = a.personid
	WHERE a.intakeserviceid=intake_service_req_id
	AND a.activeflag=1
    AND senstatusflag = 1
		AND NOT EXISTS (SELECT 1 FROM personprogramarea WHERE  personid = p.personid
		AND programkey = 'IHSFP' AND subprogramkey = 'SFCI'
		);

END IF;
IF (v_purposename = 'Kinship Navigation' and LOWER(v_supDisposition) = LOWER('scrnin')) THEN 
	IF (v_iandrsubtype='formal') THEN 
		SELECT updatedon INTO l_accepteddate FROM routing   WHERE  routingstatustypeid = 2 AND activeflag =1 AND eventcode ='INTR' AND objectid = v_intakenumber; 
		INSERT INTO personprogramarea 
		(personid, programkey,subprogramkey,objecttypekey,objectid,startdate,insertedby,updatedby,entityid, datatransferflag, sourcetype) 	
		SELECT 
			a.personid,'KIN','FOR','servicerequest',intake_service_req_id,COALESCE(l_accepteddate,l_inserteddate)::date,v_securityuserid,v_securityuserid,v_servicerequestno,'A', 'CW'
		FROM  actor a 
		WHERE a.intakeserviceid=intake_service_req_id AND a.activeflag=1 and a.personid not in (select 
		personid from personprogramarea where programkey='CPS' and objecttypekey =  'servicerequest' and objectid::uuid = intake_service_req_id); 
		ELSE IF (v_iandrsubtype='informal') THEN 
		SELECT updatedon INTO l_accepteddate FROM routing   WHERE  routingstatustypeid = 2 AND activeflag =1 AND eventcode ='INTR' AND objectid = v_intakenumber; 
		INSERT INTO personprogramarea 
		(personid, programkey,subprogramkey,objecttypekey,objectid,startdate,insertedby,updatedby,entityid, datatransferflag, sourcetype) 	
		SELECT 
			a.personid,'KIN','INF','servicerequest',intake_service_req_id,COALESCE(l_accepteddate,l_inserteddate)::date,v_securityuserid,v_securityuserid,v_servicerequestno,'A', 'CW'
		FROM  actor a 
		WHERE a.intakeserviceid=intake_service_req_id AND a.activeflag=1 and a.personid not in (select 
		personid from personprogramarea where programkey='CPS' and objecttypekey =  'servicerequest' and objectid::uuid = intake_service_req_id); 
		
  ELSE  
		SELECT updatedon INTO l_accepteddate FROM routing   WHERE  routingstatustypeid = 2 AND activeflag =1 AND eventcode ='INTR' AND objectid = v_intakenumber; 
		INSERT INTO personprogramarea 
		(personid, programkey,subprogramkey,objecttypekey,objectid,startdate,insertedby,updatedby,entityid, datatransferflag, sourcetype) 	
		SELECT 
			a.personid,'KIN','NON','servicerequest',intake_service_req_id,COALESCE(l_accepteddate,l_inserteddate)::date,v_securityuserid,v_securityuserid,v_servicerequestno,'A', 'CW'
		FROM  actor a 
		WHERE a.intakeserviceid=intake_service_req_id AND a.activeflag=1 and a.personid not in (select 
		personid from personprogramarea where programkey='CPS' and objecttypekey =  'servicerequest' and objectid::uuid = intake_service_req_id); 
		v_overideprogramkey = 'KIN'; 
       v_overridesubprogrmkey = 'NON';
	END IF; 
	END IF;	
END IF;	
RETURN    QUERY    
	SELECT   case when  v_isoverridereq=true  THEN  
	v_DAServiceRequestNumberoverridereq  else
	 DAT.ServiceRequestNumber end as  ResponseServiceReqNum,
	case when  v_isoverridereq=true  THEN  
	v_IntakeServiceIdoverridereq  
	else DAT.IntakeServiceId end as  ResponseIntakeServiceId, 
	CAST('SUCCESS'    as    character    varying)    AS    Message   
         /*COALESCE((SELECT    CAST(INSRA.IntakeServiceRequestActorId    AS    VARCHAR(50))    
                    	FROM    IntakeServiceRequestActor    INSRA   
                    	JOIN    Actor    AC        ON    INSRA.ActorId    =    AC.ActorId   
                    	WHERE        INSRA.IntakeServiceId    =    DAT.IntakeServiceId   
                    	AND    AC.ActorType    in    ('RA','RC')    limit    1   ),NULL)    
                        AS    IntakeServiceRequestActorId */
	,'' :: character varying AS    IntakeServiceRequestActorId
    , COALESCE(DAT.isfamilycase ,0)  isfamilycase ,
	v_overideprogramkey,
	v_overridesubprogrmkey
    FROM    sp_CreateIntake_Temp_DAType    DAT;    

	--## PUBLISH DATA ACROSS TO CHESSIE FOR CHECKING CLIENT ACTIVITY WITH IN CJAMS
	SELECT publishpersonparticipation(v_intakeserviceid::UUID, 'servicerequest'::character varying, NULL) INTO l_status;

 
/*DROP    Created    Temp    tables*/ 
DROP TABLE sp_createintake_temp_dageneral;  
DROP TABLE sp_createintake_temp_datype;  
DROP TABLE sp_createintake_temp_personalias;  
DROP TABLE sp_createintake_temp_daperson;  
DROP TABLE sp_createintake_temp_dapersontemp;  
DROP TABLE sp_createintake_temp_personmail;  
DROP TABLE sp_createintake_temp_personcontact;  
DROP TABLE sp_createintake_temp_address;  
--DROP TABLE sp_createintake_temp_personrole; 
END;

$function$
;