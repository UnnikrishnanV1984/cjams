DROP TABLE IF EXISTS cjams.form1080a;

CREATE TABLE
	IF NOT EXISTS cjams.form1080a (
		form1080aid uuid NOT NULL DEFAULT gen_random_uuid (),
		objectid character varying,
		objecttype character varying,
		casenumber character varying,
		ischildfatality boolean,
		isseriousphysicalinjury boolean,
		ismaltreatment boolean,
		justificationforchange text,
		dateofthiscfspicriticalincidentreport timestamp with time zone,
		countyjurisdictionwheretheincidentoccurred character varying,
		datewhentheincidentoccurred timestamp with time zone,
		dateldssbecameawareofincident timestamp with time zone,
		jurisdictionwithchildresponsibility character varying,
		intakereferral character varying,
		screen character varying,
		providereason character varying,
		personid uuid,
		cjamspid character varying,
		dob timestamp with time zone,
		dod timestamp with time zone,
		sex character varying,
		race character varying,
		enthnicity character varying,
		submitforapproval character varying,
		supervisorcomments character varying,
		status character varying,
		wasthereanyotheropencaseinvolvingthischildatthetimeofincident boolean,
		wasthereacaseinvolvingthischildclosedwithin12monthsofincident boolean,
		wasthechildeverplacedoutsideofhomebeforetheincident boolean,
		didmostrecentoohplacementend12monthsofincident boolean,
		wasthechilddiagnosedwithamentalorphysicaldisability boolean,
		wasthechildbornsubstanceexposed boolean,
		wasthechildrecordupdatedwiththedateofdeathincjams boolean,
		locationtypewhereincidentoccurred character varying,
		specifylocation character varying,
		wasthechildinanoutofhomeplacementatthetimeoftheincident boolean,
		placementprovideratthetimeoftheincident character varying,
		--Details about Alleged Maltreator
		allegedmaltreatername character varying,
		isthisalsothecasehead boolean,
		aliases character varying,
		dob1 timestamp with time zone, --dob for alleged maltreator
		cjamspid1 character varying, --cjamspid for alleged maltreator
		relationshiptovictim character varying, --relationship for alleged maltreator
		anychildwelfarehistoryinvolvingthisperson boolean, --history for alleged maltreator
		narrativesummaryofhistory character varying, --summary for alleged maltreator
		isthislocationthechildprimaryresidence boolean,
		releventinformation character varying,
		--Details about Parent Guardian
		parentname character varying,
		parentrole character varying,
		aliases1 character varying,
		dob2 timestamp with time zone, --dob for parent guardian
		cjamspid2 character varying,  --cjamspid for parent guardian
		relationshiptovictim1 character varying, --relationship for parent guardian
		anychildwelfarehistoryinvolvingthisperson1 boolean, --history for parent guardian
		narrativesummaryofhistory1 character varying, --summary for parent guardian
		didthechildresideprimarilyatthislocation boolean,
		dateldssheldtherapidresponsereview timestamp with time zone,
		additionalrelevantinformation character varying,
		whatistheextentofanycurrentorpotentialmediainvolvementrelease character varying,
		signatureofpersoncompletingthisreport character varying,
		datecompleted timestamp with time zone,
		activeflag int4 NOT NULL DEFAULT 1,
		insertedby varchar(50) NOT NULL,
		insertedon timestamp NOT NULL DEFAULT now (),
		updatedby varchar(50) NOT NULL,
		updatedon timestamp NOT NULL DEFAULT now (),
		copyofform1080a jsonb NULL,
		CONSTRAINT pk_form1080a PRIMARY KEY (form1080aid),
		CONSTRAINT fk_form1080a_person FOREIGN KEY (personid) REFERENCES cjams.person (personid)
	);


COMMENT ON COLUMN cjams.form1080a.form1080aid IS 'Unique identifier for the form1080a (primary key).';
COMMENT ON COLUMN cjams.form1080a.objectid IS 'Unique identifier for the object within the system.';
COMMENT ON COLUMN cjams.form1080a.objecttype IS 'Reference type used to link the object to related data.';
COMMENT ON COLUMN cjams.form1080a.casenumber IS 'Unique identifier assigned to the case for tracking and reference.';
COMMENT ON COLUMN cjams.form1080a.ischildfatality IS 'Indicates whether the incident resulted in a child fatality (true or false).';
COMMENT ON COLUMN cjams.form1080a.isseriousphysicalinjury IS 'Indicates whether the incident involved near-death or serious physical injury (true or false).';
COMMENT ON COLUMN cjams.form1080a.ismaltreatment IS 'Indicates whether a provider was involved in maltreatment related to the incident (true or false).';
COMMENT ON COLUMN cjams.form1080a.justificationforchange IS 'Details explaining any changes made to the report or case.';
COMMENT ON COLUMN cjams.form1080a.dateofthiscfspicriticalincidentreport IS 'Timestamp for when this Child Fatality/Serious Physical Injury/Critical Incident Report was created.';
COMMENT ON COLUMN cjams.form1080a.countyjurisdictionwheretheincidentoccurred IS 'County where the incident took place.';
COMMENT ON COLUMN cjams.form1080a.datewhentheincidentoccurred IS 'Date when the incident happened.';
COMMENT ON COLUMN cjams.form1080a.dateldssbecameawareofincident IS 'Date when LDSS became aware of the incident.';
COMMENT ON COLUMN cjams.form1080a.jurisdictionwithchildresponsibility IS 'Jurisdiction responsible for the child at the time of the incident.';
COMMENT ON COLUMN cjams.form1080a.intakereferral IS 'Reference to the intake referral associated with the incident.';
COMMENT ON COLUMN cjams.form1080a.screen IS 'Screening result related to the intake referral.';
COMMENT ON COLUMN cjams.form1080a.providereason IS 'Reason provided regarding the case decision.';
COMMENT ON COLUMN cjams.form1080a.personid IS 'Name of the child involved in the incident.';
COMMENT ON COLUMN cjams.form1080a.cjamspid IS 'Unique identifier for the child in CJAMS.';
COMMENT ON COLUMN cjams.form1080a.dob IS 'Date of birth of the child.';
COMMENT ON COLUMN cjams.form1080a.dod IS 'Date of death of the child, if applicable.';
COMMENT ON COLUMN cjams.form1080a.sex IS 'Sex of the child (male, female, other).';
COMMENT ON COLUMN cjams.form1080a.race IS 'Race of the child as recorded.';
COMMENT ON COLUMN cjams.form1080a.enthnicity IS 'Ethnicity of the child as recorded.';
COMMENT ON COLUMN cjams.form1080a.wasthereanyotheropencaseinvolvingthischildatthetimeofincident IS 'Indicates if another case was open at the time of the incident (true or false).';
COMMENT ON COLUMN cjams.form1080a.wasthereacaseinvolvingthischildclosedwithin12monthsofincident IS 'Indicates if a case involving the child was closed within 12 months prior to the incident (true or false).';
COMMENT ON COLUMN cjams.form1080a.wasthechildeverplacedoutsideofhomebeforetheincident IS 'Indicates if the child was ever placed outside of the home before the incident (true or false).';
COMMENT ON COLUMN cjams.form1080a.didmostrecentoohplacementend12monthsofincident IS 'Indicates if the child’s most recent out-of-home placement ended within 12 months of the incident date (true or false).';
COMMENT ON COLUMN cjams.form1080a.wasthechilddiagnosedwithamentalorphysicaldisability IS 'Indicates whether the child had a mental or physical disability diagnosis (true or false).';
COMMENT ON COLUMN cjams.form1080a.wasthechildbornsubstanceexposed IS 'Indicates whether the child was born substance-exposed (true or false).';
COMMENT ON COLUMN cjams.form1080a.wasthechildrecordupdatedwiththedateofdeathincjams IS 'Indicates whether the child''s record was updated with the date of death in CJAMS (true or false).';
COMMENT ON COLUMN cjams.form1080a.locationtypewhereincidentoccurred IS 'Type of location where the incident occurred.';
COMMENT ON COLUMN cjams.form1080a.specifylocation IS 'Specific location where the incident occurred.';
COMMENT ON COLUMN cjams.form1080a.wasthechildinanoutofhomeplacementatthetimeoftheincident IS 'Indicates if the child was in an out-of-home placement at the time of the incident (true or false).';
COMMENT ON COLUMN cjams.form1080a.placementprovideratthetimeoftheincident IS 'Placement provider responsible for the child at the time of the incident.';
COMMENT ON COLUMN cjams.form1080a.allegedmaltreatername IS 'Name of the alleged maltreater.';
COMMENT ON COLUMN cjams.form1080a.isthisalsothecasehead IS 'Indicates if the alleged maltreater is also the case head (true or false).';
COMMENT ON COLUMN cjams.form1080a.aliases IS 'Known aliases of the alleged maltreater.';
COMMENT ON COLUMN cjams.form1080a.dob1 IS 'Date of birth of the Alleged Maltreator.';
COMMENT ON COLUMN cjams.form1080a.cjamspid1 IS 'Unique identifier for the Alleged Maltreator in CJAMS.';
COMMENT ON COLUMN cjams.form1080a.relationshiptovictim IS 'The relationship of this Alleged Maltreator to the child victim.';
COMMENT ON COLUMN cjams.form1080a.anychildwelfarehistoryinvolvingthisperson IS 'Indicates whether this Alleged Maltreator has any prior child welfare history (true or false).';
COMMENT ON COLUMN cjams.form1080a.narrativesummaryofhistory IS 'Summary of any child welfare history involving this Alleged Maltreator.';
COMMENT ON COLUMN cjams.form1080a.isthislocationthechildprimaryresidence IS 'Indicates whether the location is the child’s primary residence (true or false).';
COMMENT ON COLUMN cjams.form1080a.releventinformation IS 'Additional relevant details pertaining to the case.';
COMMENT ON COLUMN cjams.form1080a.parentname IS 'Name of the parent or guardian of the child.';
COMMENT ON COLUMN cjams.form1080a.parentrole IS 'The role of the parent in relation to the child (e.g., biological, foster, guardian).';
COMMENT ON COLUMN cjams.form1080a.aliases1 IS 'Any known aliases associated with the parent or guardian.';
COMMENT ON COLUMN cjams.form1080a.dob2 IS 'Date of birth of parent or guardian related to the case.';
COMMENT ON COLUMN cjams.form1080a.cjamspid2 IS 'Unique identifier for this parent or guardian in CJAMS.';
COMMENT ON COLUMN cjams.form1080a.relationshiptovictim1 IS 'The relationship of the parent or guardian to the child victim.';
COMMENT ON COLUMN cjams.form1080a.anychildwelfarehistoryinvolvingthisperson1 IS 'Indicates whether this parent or guardian has any prior child welfare history (true or false).';
COMMENT ON COLUMN cjams.form1080a.narrativesummaryofhistory1 IS 'Summary of any child welfare history involving this parent or guardian.';
COMMENT ON COLUMN cjams.form1080a.didthechildresideprimarilyatthislocation IS 'Indicates whether the child primarily resided at this location (true or false).';
COMMENT ON COLUMN cjams.form1080a.dateldssheldtherapidresponsereview IS 'Date when LDSS held the rapid response review for the incident.';
COMMENT ON COLUMN cjams.form1080a.additionalrelevantinformation IS 'Further information that may be relevant to the case.';
COMMENT ON COLUMN cjams.form1080a.whatistheextentofanycurrentorpotentialmediainvolvementrelease IS 'Details regarding any current or potential media involvement in the case.';
COMMENT ON COLUMN cjams.form1080a.signatureofpersoncompletingthisreport IS 'Signature of the individual responsible for completing the report.';
COMMENT ON COLUMN cjams.form1080a.datecompleted IS 'Date when the report was completed.';
COMMENT ON COLUMN cjams.form1080a.activeflag IS 'Indicates whether the form1080a is active (1 for active, 0 for inactive).';
COMMENT ON COLUMN cjams.form1080a.updatedby IS 'The user who last updated the form1080a information.';
COMMENT ON COLUMN cjams.form1080a.updatedon IS 'Timestamp of the last update to the form1080a record.';
COMMENT ON COLUMN cjams.form1080a.insertedby IS 'The user who initially inserted the form1080a record.';
COMMENT ON COLUMN cjams.form1080a.insertedon IS 'Timestamp of when the form1080a record was first inserted.';
COMMENT ON COLUMN cjams.form1080a.copyofform1080a IS 'Stores JSON copy values of the copied form 1080a information for record-keeping or archival purposes.';