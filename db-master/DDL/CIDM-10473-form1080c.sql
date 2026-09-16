DROP TABLE IF EXISTS cjams.form1080c;

CREATE TABLE
    IF NOT EXISTS cjams.form1080c (
        form1080cid uuid NOT NULL DEFAULT gen_random_uuid (),
        objectid character varying,
        objecttype character varying,
        casenumber character varying,
        doesmaltreatmentappeartohavebeenacontributingfactor character varying,
        ifincidentoccurredinlicensedsettingindicateactiontaken character varying,
        specify character varying,
        legaloutcomeinthisincident character varying,
        wasthisincidentrelatedtosleeporanunsafesleepenvironment character varying,
        inthe72hoursbeforethefatalincidentwasthechildinjured character varying,
		personid uuid,
        fullname character varying,
        physicalabuse character varying,
        physicalabuseradio character varying,
        sexualabuse character varying,
        sexualabuseradio character varying,
        neglect character varying,
        neglectradio character varying,
        mentalinjuryabuse character varying,
        mentalinjuryabuseradio character varying,
        mentalinjuryneglect character varying,
        mentalinjuryneglectradio character varying,
        summaryoffactsandfindingincludingtheeventdateinthecase character varying,
        theallegedlymaltreatedchild character varying,
        siblingsoftheallegedlymaltreatedchild character varying,
        otherchildinhouseholdfamilyorincaseofallegedmaltreater character varying,
        substanceusechild character varying,
        substanceusefamily character varying,
        substanceusecaregiver character varying,
        mentalillnesschild character varying,
        mentalillnessfamily character varying,
        mentalillnesscaregiver character varying,
        domesticviolencechild character varying,
        domesticviolencefamily character varying,
        domesticviolencecaregiver character varying,
        prenatalexposurechild character varying,
        prenatalexposurefamily character varying,
        prenatalexposurecaregiver character varying,
        noprenatalcarechild character varying,
        noprenatalcarefamily character varying,
        noprenatalcarecaregiver character varying,
        childfatalitychild character varying,
        childfatalityfamily character varying,
        childfatalitycaregiver character varying,
        medicalconditionchild character varying,
        medicalconditionfamily character varying,
        medicalconditioncaregiver character varying,
        healthinsurancechild character varying,
        healthinsurancefamily character varying,
        healthinsurancecaregiver character varying,
        otherchild character varying,
        otherfamily character varying,
        othercaregiver character varying,
        describehowtheselectedriskfactorsfromchartaboveinfluencedtheinc character varying,
        signatureofpersoncompletingthisreport character varying,
        personcompletingthisreport character varying,
        supervisor character varying,
        phonenumber character varying,
        supervisorphonenumber character varying,
        email character varying,
        supervisoremail character varying,
        datecompleted timestamp with time zone,
        activeflag int4 NOT NULL DEFAULT 1,
        insertedby varchar(50) NOT NULL,
        insertedon timestamp NOT NULL DEFAULT now (),
        updatedby varchar(50) NOT NULL,
        updatedon timestamp NOT NULL DEFAULT now (),
        copyofform1080c jsonb NULL,
        submitforapproval character varying,
		supervisorcomments character varying,
		status character varying,
        otherriskfactors jsonb,
        CONSTRAINT pk_form1080c PRIMARY KEY (form1080cid),
		CONSTRAINT fk_form1080c_person FOREIGN KEY (personid) REFERENCES cjams.person (personid)
    );


COMMENT ON COLUMN cjams.form1080c.form1080cid IS 'Unique identifier for the form1080c (primary key).';
COMMENT ON COLUMN cjams.form1080c.objectid IS 'Unique identifier for the object within the system.';
COMMENT ON COLUMN cjams.form1080c.objecttype IS 'Reference key used to link the object to related data.';
COMMENT ON COLUMN cjams.form1080c.casenumber IS 'Unique identifier assigned to the case for tracking and reference.';
COMMENT ON COLUMN cjams.form1080c.doesmaltreatmentappeartohavebeenacontributingfactor IS 'Indicates whether maltreatment appears to have contributed to the incident (true or false).';
COMMENT ON COLUMN cjams.form1080c.ifincidentoccurredinlicensedsettingindicateactiontaken IS 'Describes the actions taken if the incident occurred in a licensed setting.';
COMMENT ON COLUMN cjams.form1080c.specify IS 'Additional specification or details regarding the case.';
COMMENT ON COLUMN cjams.form1080c.legaloutcomeinthisincident IS 'Legal outcome related to the incident, including any charges or rulings.';
COMMENT ON COLUMN cjams.form1080c.wasthisincidentrelatedtosleeporanunsafesleepenvironment IS 'Indicates whether the incident was related to sleep or an unsafe sleep environment.';
COMMENT ON COLUMN cjams.form1080c.inthe72hoursbeforethefatalincidentwasthechildinjured IS 'Reports any injury sustained by the child in the 72 hours preceding the fatal incident.';
COMMENT ON COLUMN cjams.form1080c.personid IS 'Personid is the link thats established with the person table';
COMMENT ON COLUMN cjams.form1080c.physicalabuse IS 'Indicates whether physical abuse was involved in the incident.';
COMMENT ON COLUMN cjams.form1080c.physicalabuseradio IS 'Selection field confirming the presence of physical abuse.';
COMMENT ON COLUMN cjams.form1080c.sexualabuse IS 'Indicates whether sexual abuse was involved in the incident.';
COMMENT ON COLUMN cjams.form1080c.sexualabuseradio IS 'Selection field confirming the presence of sexual abuse.';
COMMENT ON COLUMN cjams.form1080c.neglect IS 'Indicates whether neglect was involved in the incident.';
COMMENT ON COLUMN cjams.form1080c.neglectradio IS 'Selection field confirming the presence of neglect.';
COMMENT ON COLUMN cjams.form1080c.mentalinjuryabuse IS 'Indicates whether mental injury due to abuse was present.';
COMMENT ON COLUMN cjams.form1080c.mentalinjuryabuseradio IS 'Selection field confirming mental injury caused by abuse.';
COMMENT ON COLUMN cjams.form1080c.mentalinjuryneglect IS 'Indicates whether mental injury due to neglect was present.';
COMMENT ON COLUMN cjams.form1080c.mentalinjuryneglectradio IS 'Selection field confirming mental injury caused by neglect.';
COMMENT ON COLUMN cjams.form1080c.summaryoffactsandfindingincludingtheeventdateinthecase IS 'Provides a summary of facts and findings related to the case, including event dates.';
COMMENT ON COLUMN cjams.form1080c.theallegedlymaltreatedchild IS 'Indicates whether the child was allegedly maltreated (true or false).';
COMMENT ON COLUMN cjams.form1080c.siblingsoftheallegedlymaltreatedchild IS 'Indicates whether siblings of the allegedly maltreated child were involved (true or false).';
COMMENT ON COLUMN cjams.form1080c.otherchildinhouseholdfamilyorincaseofallegedmaltreater IS 'Indicates whether other children in the household or related to the alleged maltreater were involved.';
COMMENT ON COLUMN cjams.form1080c.substanceusechild IS 'Reports substance use history related to the child.';
COMMENT ON COLUMN cjams.form1080c.substanceusefamily IS 'Reports substance use history related to the family.';
COMMENT ON COLUMN cjams.form1080c.substanceusecaregiver IS 'Reports substance use history related to the caregiver.';
COMMENT ON COLUMN cjams.form1080c.mentalillnesschild IS 'Reports mental illness history related to the child.';
COMMENT ON COLUMN cjams.form1080c.mentalillnessfamily IS 'Reports mental illness history related to the family.';
COMMENT ON COLUMN cjams.form1080c.mentalillnesscaregiver IS 'Reports mental illness history related to the caregiver.';
COMMENT ON COLUMN cjams.form1080c.domesticviolencechild IS 'Reports domestic violence history related to the child.';
COMMENT ON COLUMN cjams.form1080c.domesticviolencefamily IS 'Reports domestic violence history related to the family.';
COMMENT ON COLUMN cjams.form1080c.domesticviolencecaregiver IS 'Reports domestic violence history related to the caregiver.';
COMMENT ON COLUMN cjams.form1080c.prenatalexposurechild IS 'Reports prenatal exposure history related to the child.';
COMMENT ON COLUMN cjams.form1080c.prenatalexposurefamily IS 'Reports prenatal exposure history related to the family.';
COMMENT ON COLUMN cjams.form1080c.prenatalexposurecaregiver IS 'Reports prenatal exposure history related to the caregiver.';
COMMENT ON COLUMN cjams.form1080c.noprenatalcarechild IS 'Indicates whether the child lacked prenatal care.';
COMMENT ON COLUMN cjams.form1080c.noprenatalcarefamily IS 'Indicates whether the family lacked prenatal care.';
COMMENT ON COLUMN cjams.form1080c.noprenatalcarecaregiver IS 'Indicates whether the caregiver lacked prenatal care.';
COMMENT ON COLUMN cjams.form1080c.childfatalitychild IS 'Reports child fatality history related to the child.';
COMMENT ON COLUMN cjams.form1080c.childfatalityfamily IS 'Reports child fatality history related to the family.';
COMMENT ON COLUMN cjams.form1080c.childfatalitycaregiver IS 'Reports child fatality history related to the caregiver.';
COMMENT ON COLUMN cjams.form1080c.medicalconditionchild IS 'Reports medical condition history related to the child.';
COMMENT ON COLUMN cjams.form1080c.medicalconditionfamily IS 'Reports medical condition history related to the family.';
COMMENT ON COLUMN cjams.form1080c.medicalconditioncaregiver IS 'Reports medical condition history related to the caregiver.';
COMMENT ON COLUMN cjams.form1080c.healthinsurancechild IS 'Indicates health insurance status related to the child.';
COMMENT ON COLUMN cjams.form1080c.healthinsurancefamily IS 'Indicates health insurance status related to the family.';
COMMENT ON COLUMN cjams.form1080c.healthinsurancecaregiver IS 'Indicates health insurance status related to the caregiver.';
COMMENT ON COLUMN cjams.form1080c.otherchild IS 'Records additional children involved in the incident.';
COMMENT ON COLUMN cjams.form1080c.otherfamily IS 'Records additional family members involved in the incident.';
COMMENT ON COLUMN cjams.form1080c.othercaregiver IS 'Records additional caregivers involved in the incident.';
COMMENT ON COLUMN cjams.form1080c.describehowtheselectedriskfactorsfromchartaboveinfluencedtheinc IS 'Details how selected risk factors influenced the incident.';
COMMENT ON COLUMN cjams.form1080c.signatureofpersoncompletingthisreport IS 'Signature of the individual responsible for completing the report.';
COMMENT ON COLUMN cjams.form1080c.personcompletingthisreport IS 'Name of the person completing the report.';
COMMENT ON COLUMN cjams.form1080c.supervisor IS 'Name of the supervisor overseeing the report.';
COMMENT ON COLUMN cjams.form1080c.phonenumber IS 'Phone number of the person completing the report.';
COMMENT ON COLUMN cjams.form1080c.supervisorphonenumber IS 'Phone number of the supervisor.';
COMMENT ON COLUMN cjams.form1080c.email IS 'Email address of the person completing the report.';
COMMENT ON COLUMN cjams.form1080c.supervisoremail IS 'Email address of the supervisor.';
COMMENT ON COLUMN cjams.form1080c.datecompleted IS 'Date when the report was completed.';
COMMENT ON COLUMN cjams.form1080c.activeflag IS 'Indicates whether the form1080c is active (1 for active, 0 for inactive).';
COMMENT ON COLUMN cjams.form1080c.updatedby IS 'The user who last updated the form1080c information.';
COMMENT ON COLUMN cjams.form1080c.updatedon IS 'Timestamp of the last update to the form1080c record.';
COMMENT ON COLUMN cjams.form1080c.insertedby IS 'The user who initially inserted the form1080c record.';
COMMENT ON COLUMN cjams.form1080c.insertedon IS 'Timestamp of when the form1080c record was first inserted.';
COMMENT ON COLUMN cjams.form1080c.copyofform1080c IS 'Stores JSON copy values of the copied form 1080c information for record-keeping or archival purposes.';
COMMENT ON COLUMN cjams.form1080c.otherriskfactors IS 'Records adhoc other risk factors';
