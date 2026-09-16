-- expunge.intakeservicerequestsdm_expunge definition

-- Drop table

-- DROP TABLE expunge.intakeservicerequestsdm_expunge;

CREATE TABLE expunge.intakeservicerequestsdm_expunge (
	intakeservicerequestsdmexpungeid uuid DEFAULT cjams.gen_random_uuid() NOT NULL, -- Intakeservicerequest sdm information (PRIMARY KEY)
	intakeservicerequestsdmid uuid NOT NULL, -- Intakeservicerequest sdm information (PRIMARY KEY)
	intakeserviceid uuid NULL, -- Intakeserviceid(FOREIGN KEY)
	ismaltreatment bool DEFAULT false NOT NULL, -- Maltreatment flag
	referralname varchar(100) NULL, -- Referral name
	referraldob timestamp NULL, -- Referral dob
	referralid varchar(100) NULL, -- Referral id
	countyid uuid NULL, -- County id(FOREIGN KEY)
	ismalpa_suspeciousdeath bool DEFAULT false NULL, -- Malpa suspecious death flag
	ismalpa_nonaccident bool DEFAULT false NULL, -- Malpa nonaccident flag
	ismalpa_injuryinconsistent bool DEFAULT false NULL, -- Malpa injury inconsistent flag
	ismalpa_insjury bool DEFAULT false NULL, -- Malpa insjury flag
	ismalpa_childtoxic bool DEFAULT false NULL, -- Malpa childtoxic flag
	ismalpa_caregiver bool DEFAULT false NULL, -- Malpa caregiver flag
	ismalsa_sexualmolestation bool DEFAULT false NULL, -- Malsa sexual mole station flag
	ismalsa_sexualact bool DEFAULT false NULL, -- Malsa sexual act flag
	ismalsa_sexualexploitation bool DEFAULT false NULL, -- Malsa sexual exploitation flag
	ismalsa_physicalindicators bool DEFAULT false NULL, -- Malsa physical indicators flag
	isneggn_suspiciousdeath bool DEFAULT false NULL, -- Neggn suspicious death flag
	isneggn_signsordiagnosis bool DEFAULT false NULL, -- Neggn signsor diagnosis flag
	isneggn_inadequatefood bool DEFAULT false NULL, -- Neggn inadequate food flag
	isneggn_exposuretounsafe bool DEFAULT false NULL, -- Neggn exposure to unsafe flag
	isneggn_inadequateclothing bool DEFAULT false NULL, -- Neggn inadequate clothing flag
	isneggn_inadequatesupervision bool DEFAULT false NULL, -- Neggn inadequate supervision flag
	isneggn_childdischarged bool DEFAULT false NULL, -- Neggn child discharged flag
	isnegfp_cargiverintervene bool DEFAULT false NULL, -- Negfp cargiver intervene flag
	isnegab_abandoned bool DEFAULT false NULL, -- Negab abandoned flag
	isneguc_leftunsupervised bool DEFAULT false NULL, -- Neguc left unsupervised flag
	isneguc_leftaloneinappropriatecare bool DEFAULT false NULL, -- Neguc leftalonein appropriate care flag
	isneguc_leftalonewithoutsupport bool DEFAULT false NULL, -- Neguc leftalone without support flag
	isnegrh_priordeath bool DEFAULT false NULL, -- Negrh prior death flag
	isnegrh_sexualperpetrator bool DEFAULT false NULL, -- Negrh sexual per petrator flag
	isnegrh_basicneedsunmet bool DEFAULT false NULL, -- Negrh basicneeds unmet flag
	isnegmn_unreasonabledelay bool DEFAULT false NULL, -- Negmn unreasonable delay flag
	ismenab_psycologicalability bool DEFAULT false NULL, -- Menab psycologicalability flag
	ismenng_psycologicalability bool DEFAULT false NULL, -- Menng psycologicalability flag
	isrecsc_screenout bool DEFAULT false NULL, -- Recsc screenout flag
	isrecsc_scrrenin bool DEFAULT false NULL, -- Recsc scrrenin flag
	isrecovr_no bool DEFAULT false NULL, -- Recovr no flag
	isrecovr_scrrenin bool DEFAULT false NULL, -- Recovr scrrenin flag
	isreccps_screenout bool DEFAULT false NULL, -- Reccps screenout flag
	isrec_imlist bool DEFAULT false NULL, -- Rec imlist flag
	isrec_noimmediate bool DEFAULT false NULL, -- Rec noimmediate flag
	isrec_reportallegtion bool DEFAULT false NULL, -- Rec reportallegtion flag
	officerfirstname varchar(150) NULL, -- Officer firstname
	officermiddlename varchar(150) NULL, -- Officer middlename
	officerlastname varchar(150) NULL, -- Officer lastname
	badgenumber varchar(150) NULL, -- Badge number
	recordnumber varchar(150) NULL, -- Record number
	reportdate timestamp NULL, -- Report date
	worker varchar(150) NULL, -- Worker
	workerdate timestamp NULL, -- Worker date
	supervisor varchar(150) NULL, -- supervisor
	supervisordate timestamp NULL, -- Supervisor date
	activeflag int4 DEFAULT 1 NOT NULL, -- Status of the record
	updatedby varchar(50) NULL, -- user who last updated the record
	updatedon timestamp DEFAULT now() NOT NULL, -- Record updated date and time
	insertedby varchar(50) NULL, -- User who created this record
	insertedon timestamp DEFAULT now() NOT NULL, -- Record created date and time
	effectivedate timestamp DEFAULT now() NOT NULL, -- Record valid from
	issexualabuse bool DEFAULT false NULL, -- Sexual abuse flag
	isoutofhome bool DEFAULT false NULL, -- Out of home flag
	isdeathorserious bool DEFAULT false NULL, -- Death serious flag
	isrisk bool DEFAULT false NULL, -- Risk flag
	isreportmeets bool DEFAULT false NULL, -- Report meets flag
	issignordiagonises bool DEFAULT false NULL, -- Sign or diagonises flag
	ismaltreatment3yrs bool DEFAULT false NULL, -- Maltreatment 3 years flag
	ismaltreatment12yrs bool DEFAULT false NULL, -- Maltreatment 12 years flag
	ismaltreatment24yrs bool DEFAULT false NULL, -- Maltreatment 24 years flag
	isactiveinvestigation bool DEFAULT false NULL, -- Active investigation flag
	isreportedhistory bool DEFAULT false NULL, -- Report history
	ismultiple bool DEFAULT false NULL, -- Multiple flag
	isdomesticvoilence bool DEFAULT false NULL, -- Domestic voilence flag
	isthread bool DEFAULT false NULL, -- Thread flag
	islawenforcement bool DEFAULT false NULL, -- Law enforcement flag
	iscourtiinvestigation bool DEFAULT false NULL, -- Court investigation flag
	isar bool DEFAULT false NULL, -- AR flag
	isir bool DEFAULT false NULL, -- IR flag
	isscrninrecovr_courtorder bool DEFAULT false NULL, -- SCRN inrecover court order flag
	isscrninrecovr_otherspecify bool DEFAULT false NULL, -- SCRN inrecover other specify flag
	isscrnoutrecovr_insufficient bool DEFAULT false NULL, -- SCRN outrecover insufficient flag
	isscrnoutrecovr_information bool DEFAULT false NULL, -- SCRN outrecover information flag
	isscrnoutrecovr_historicalinformation bool DEFAULT false NULL, -- SCRN outrecover historical information flag
	isscrnoutrecovr_otherspecify bool DEFAULT false NULL, -- SCRN outrecover other specify flag
	isimmed_childfaatility bool DEFAULT false NULL, -- Immediate child fatility flag
	isimmed_seriousinjury bool DEFAULT false NULL, -- Immediate serious injury flag
	isimmed_childleftalone bool DEFAULT false NULL, -- Immediate child left alone flag
	isimmed_allegation bool DEFAULT false NULL, -- Immediate allegation flag
	isimmed_otherspecify bool DEFAULT false NULL, -- Immediate Other specify flag
	iscriminalhistory bool DEFAULT false NULL, -- Criminal history flag
	yesdatadescription varchar(200) NULL, -- Data Description
	scrnin_description varchar NULL, -- Screen in description
	scrnout_description varchar NULL, -- Screen out description
	isnoimmed_physicalabuse bool DEFAULT false NULL, -- No immediate physical abuse flag
	isnoimmed_sexualabuse bool DEFAULT false NULL, -- No immediate sexual abuse flag
	isnoimmed_neglectresponse bool DEFAULT false NULL, -- No immediate neglect response flag
	isnoimmed_mentalinjury bool DEFAULT false NULL, -- No immediate mental injury flag
	iscps bool NULL, -- CPS flag
	isfinalscreenin bool DEFAULT false NULL, -- Final screen in flag
	old_id varchar(50) NULL, -- Used for migration purpose
	intakenumber varchar(20) NULL, -- Intakenumber
	"comments" varchar(2000) NULL, -- Comments
	status int4 NULL, -- Status
	isfcplacementsetting bool NULL, -- Foster care placement setting flag
	isprivateplacement bool NULL, -- Private placement flag
	islicenseddaycare bool NULL, -- Licensed day care flag
	isschool bool NULL, -- School flag
	ischildfatality bool NULL, -- Child fatality flag
	lawenforcementid int4 NULL,
	lawenfmtreferralid int4 NULL,
	lawenfmtofficerprefixtypekey varchar(5) NULL,
	lawenfmtofficersuffixtypekey varchar(5) NULL,
	lawenfmtext varchar(20) NULL,
	lawdistrict varchar(20) NULL,
	lawenfmtofficerphone varchar(20) NULL,
	lawifieddate timestamp(6) NULL,
	lawifiedtime timestamp(6) NULL,
	lawenfmtdispatcherflag int4 NULL,
	lawenfmtinsertedon timestamp(6) NULL,
	lawenfmtinsertedby varchar(10) NULL,
	lawenfmtupdatedon timestamp(6) NULL,
	lawenfmtupdatedby varchar(10) NULL,
	lawenfmtactiveflag int4 DEFAULT 1 NULL,
	lawenfmtcaseid int4 NULL,
	cpsscreeningname varchar(50) NULL,
	drugexposednewbornflag int4 NULL,
	maltreatmentcompleteflag int4 NULL,
	cpsscreenoutotherflag int4 NULL,
	cpsscreenoutother varchar(500) NULL,
	newnoncpsrefflag int4 NULL,
	cpsscreeniherflag int4 NULL,
	cpsscreeniher varchar(500) NULL,
	noscreeninoverridesflag int4 NULL,
	screenoutascpsflag int4 NULL,
	screeninonemalflag int4 NULL,
	childabandoned varchar(500) NULL,
	immediateotherflag int4 NULL,
	immediateother varchar(500) NULL,
	screeninoverrideflag int4 NULL,
	allegedmaltreatmentdate timestamp(6) NULL,
	cpsagencyname varchar(50) NULL,
	adrformattypekey varchar(5) NULL,
	adrstreetno int4 NULL,
	adrboxno int4 NULL,
	adrpredirtypekey varchar(5) NULL,
	adrstreetname varchar(50) NULL,
	adrstreetsuffixtypekey varchar(5) NULL,
	adrpostdirtypekey varchar(5) NULL,
	adrunittypekey varchar(5) NULL,
	adrunitno varchar(5) NULL,
	adrcityname varchar(50) NULL,
	adrstatetypekey varchar(5) NULL,
	adrzip5no int4 NULL,
	adrzip4no int4 NULL,
	adrdirection varchar(500) NULL,
	adrforeign varchar(500) NULL,
	adrforeignstate varchar(50) NULL,
	adrcountry varchar(50) NULL,
	adrpostalcode varchar(50) NULL,
	adrworkphone varchar(50) NULL,
	adrworkxtn varchar(50) NULL,
	adremail varchar(100) NULL,
	adrfax varchar(50) NULL,
	adrurl varchar(100) NULL,
	adrothercontact varchar(100) NULL,
	outofhomeflag int4 NULL,
	communicationastncrqrdflag int4 NULL,
	cpslawifiedflag int4 NULL,
	cpscomplaintno varchar NULL,
	lawofficerassignedflag int4 NULL,
	cpsproviderid int4 NULL,
	adrstreettext varchar(500) NULL,
	intinvfinalflag int4 NULL,
	intinvfinaldate timestamp(6) NULL,
	orderofshelterflag int4 NULL,
	oohmaltsettingtypekey varchar(5) NULL,
	maltscreencompleteflag int4 NULL,
	decisioncompleteflag int4 NULL,
	physicalabusesdflag int4 NULL,
	malnegchildabandonedflag int4 NULL,
	noimdrspscninovrdeflag int4 NULL,
	finalscreenoutonemalflag int4 NULL,
	doassociateflag int4 NULL,
	associatedentitykeyid int4 NULL,
	associatedentitytypekey varchar(5) NULL,
	duplicatereportflag int4 NULL,
	initrecommrohonlyncpsflag int4 NULL,
	finalrecommrohonlyncpsflag int4 NULL,
	resptimerohonlysenflag int4 NULL,
	resptimerohonlynonsenflag int4 NULL,
	substantialriskofharmflag int4 NULL,
	physicaltreatmentriskflag int4 NULL,
	screeninglawenforcementid int4 NULL,
	screeninglawenfmtid int4 NULL,
	screeninglawofficerprefixtypekey varchar(5) NULL,
	screeninglawofficersuffixtypekey varchar(5) NULL,
	screeningext varchar(20) NULL,
	screeninglawdistrict varchar(20) NULL,
	screeningofficerphone varchar(10) NULL,
	screeninglawifieddate timestamp(6) NULL,
	screeninglawifiedttime timestamp(6) NULL,
	screeningdispatcherflag int4 NULL,
	screeninginsertedon timestamp(6) NULL,
	screeninginsertedby varchar(10) NULL,
	screeningupdatedon timestamp(6) NULL,
	screeningupdatedby varchar(10) NULL,
	screeningactiveflag int4 DEFAULT 1 NULL,
	old_cps_id varchar(10) NULL,
	issubexpnewborn int4 NULL, -- Substance Exposed Newborns
	isriskcso int4 NULL, -- Risk of Sexual Abuse By Registered Child Sex Offender
	isriskvoilence int4 NULL, -- Risk due to Domestic Voilence
	iscgimpairment int4 NULL, -- Risk due to Caregiver Impairment
	islivinginhome int4 NULL, -- Child age 5 OR Under Living In Home
	isdeathan int4 NULL, -- Serious Injury of abuse and neglect
	issextrafficking int4 NULL, -- Suspicion of Sex Trafficking
	isadultsurvivor int4 NULL, -- Adult survivor Of maltreatment
	isbirthmatchtpr int4 NULL, -- TPR rated
	isbirthmatchcriminal int4 NULL, -- Criminal History rated
	isnegrh_sex_offender bool DEFAULT false NULL,
	isnegrh_risk_dv bool DEFAULT false NULL,
	isnegrh_sex_trafficking bool DEFAULT false NULL,
	isnegrh_fatality_can bool DEFAULT false NULL,
	isnegrh_indicated_unsub bool DEFAULT false NULL,
	isnegrh_survivor bool DEFAULT false NULL,
	isnegrh_birth_match bool DEFAULT false NULL,
	ismalsa_sex_trafficking bool DEFAULT false NULL, -- Maltreatment Sexual Abuse - Sex trafficking flag
	isnoimmed_substantial_risk bool NULL,
	isnoimmed_screeninoverride bool NULL,
	isnoimmed_risk_harm bool NULL,
	isnegrh_treatmenthealthrisk bool DEFAULT false NULL,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isfclivingarrangement bool DEFAULT false NULL, -- to store Alleged maltreatment linked to a childs residence while they were removed in Foster Care
	linkschidresid bool DEFAULT false NULL,
	selectedplacement varchar NULL, -- to store selected placement or living arrangement
	confirmtrafficking varchar(10) NULL, -- to store confirm trafficking value
	selecttrafficking varchar(50) NULL, -- to store selected trafficking value
	isseriousphysicalinjury bool NULL, -- to store Near-Death/Serious Physical Injury
	isexpunged int4 DEFAULT 0 NULL, -- Flag to indicate the expunged record
	CONSTRAINT pk_intakeservicerequestsdm_expunge PRIMARY KEY (intakeservicerequestsdmexpungeid),
	CONSTRAINT fk_intakeservicerequestsdm_expunge_county FOREIGN KEY (countyid) REFERENCES cjams.county(countyid),
	CONSTRAINT fk_intakeservicerequestsdm_expunge_intakeservicerequest FOREIGN KEY (intakeserviceid) REFERENCES cjams.intakeservicerequest(intakeserviceid)
);
CREATE INDEX idx_intakeservicerequestsdm_expunge_activeflag ON expunge.intakeservicerequestsdm_expunge USING btree (activeflag);
CREATE INDEX idx_intakeservicerequestsdm_expunge_intakenumber ON expunge.intakeservicerequestsdm_expunge USING btree (intakenumber);
CREATE INDEX idx_intakeservicerequestsdm_expunge_intakenumber_activeflag ON expunge.intakeservicerequestsdm_expunge USING btree (intakenumber, activeflag);
CREATE INDEX idx_intakeservicerequestsdm_expunge_intakeserviceid ON expunge.intakeservicerequestsdm_expunge USING btree (intakeserviceid, activeflag);
CREATE INDEX idx_intakeservicerequestsdm_expunge_intakeserviceid_activeflag ON expunge.intakeservicerequestsdm_expunge USING btree (intakeserviceid, activeflag);

-- Column comments
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.intakeservicerequestsdmexpungeid IS 'Intakeservicerequest sdm information (PRIMARY KEY)';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.intakeservicerequestsdmid IS 'Intakeservicerequest sdm information (PRIMARY KEY) for intakeservicerequestsdm table';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.intakeserviceid IS 'Intakeserviceid(FOREIGN KEY)';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismaltreatment IS 'Maltreatment flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.referralname IS 'Referral name';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.referraldob IS 'Referral dob';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.referralid IS 'Referral id';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.countyid IS 'County id(FOREIGN KEY)';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalpa_suspeciousdeath IS 'Malpa suspecious death flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalpa_nonaccident IS 'Malpa nonaccident flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalpa_injuryinconsistent IS 'Malpa injury inconsistent flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalpa_insjury IS 'Malpa insjury flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalpa_childtoxic IS 'Malpa childtoxic flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalpa_caregiver IS 'Malpa caregiver flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalsa_sexualmolestation IS 'Malsa sexual mole station flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalsa_sexualact IS 'Malsa sexual act flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalsa_sexualexploitation IS 'Malsa sexual exploitation flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalsa_physicalindicators IS 'Malsa physical indicators flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneggn_suspiciousdeath IS 'Neggn suspicious death flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneggn_signsordiagnosis IS 'Neggn signsor diagnosis flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneggn_inadequatefood IS 'Neggn inadequate food flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneggn_exposuretounsafe IS 'Neggn exposure to unsafe flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneggn_inadequateclothing IS 'Neggn inadequate clothing flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneggn_inadequatesupervision IS 'Neggn inadequate supervision flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneggn_childdischarged IS 'Neggn child discharged flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnegfp_cargiverintervene IS 'Negfp cargiver intervene flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnegab_abandoned IS 'Negab abandoned flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneguc_leftunsupervised IS 'Neguc left unsupervised flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneguc_leftaloneinappropriatecare IS 'Neguc leftalonein appropriate care flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isneguc_leftalonewithoutsupport IS 'Neguc leftalone without support flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnegrh_priordeath IS 'Negrh prior death flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnegrh_sexualperpetrator IS 'Negrh sexual per petrator flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnegrh_basicneedsunmet IS 'Negrh basicneeds unmet flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnegmn_unreasonabledelay IS 'Negmn unreasonable delay flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismenab_psycologicalability IS 'Menab psycologicalability flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismenng_psycologicalability IS 'Menng psycologicalability flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isrecsc_screenout IS 'Recsc screenout flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isrecsc_scrrenin IS 'Recsc scrrenin flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isrecovr_no IS 'Recovr no flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isrecovr_scrrenin IS 'Recovr scrrenin flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isreccps_screenout IS 'Reccps screenout flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isrec_imlist IS 'Rec imlist flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isrec_noimmediate IS 'Rec noimmediate flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isrec_reportallegtion IS 'Rec reportallegtion flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.officerfirstname IS 'Officer firstname';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.officermiddlename IS 'Officer middlename';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.officerlastname IS 'Officer lastname';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.badgenumber IS 'Badge number';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.recordnumber IS 'Record number';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.reportdate IS 'Report date';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.worker IS 'Worker';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.workerdate IS 'Worker date';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.supervisor IS 'supervisor';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.supervisordate IS 'Supervisor date';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.activeflag IS 'Status of the record';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.insertedby IS 'User who created this record';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.insertedon IS 'Record created date and time';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.effectivedate IS 'Record valid from';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.issexualabuse IS 'Sexual abuse flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isoutofhome IS 'Out of home flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isdeathorserious IS 'Death serious flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isrisk IS 'Risk flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isreportmeets IS 'Report meets flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.issignordiagonises IS 'Sign or diagonises flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismaltreatment3yrs IS 'Maltreatment 3 years flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismaltreatment12yrs IS 'Maltreatment 12 years flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismaltreatment24yrs IS 'Maltreatment 24 years flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isactiveinvestigation IS 'Active investigation flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isreportedhistory IS 'Report history';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismultiple IS 'Multiple flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isdomesticvoilence IS 'Domestic voilence flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isthread IS 'Thread flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.islawenforcement IS 'Law enforcement flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.iscourtiinvestigation IS 'Court investigation flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isar IS 'AR flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isir IS 'IR flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isscrninrecovr_courtorder IS 'SCRN inrecover court order flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isscrninrecovr_otherspecify IS 'SCRN inrecover other specify flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isscrnoutrecovr_insufficient IS 'SCRN outrecover insufficient flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isscrnoutrecovr_information IS 'SCRN outrecover information flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isscrnoutrecovr_historicalinformation IS 'SCRN outrecover historical information flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isscrnoutrecovr_otherspecify IS 'SCRN outrecover other specify flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isimmed_childfaatility IS 'Immediate child fatility flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isimmed_seriousinjury IS 'Immediate serious injury flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isimmed_childleftalone IS 'Immediate child left alone flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isimmed_allegation IS 'Immediate allegation flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isimmed_otherspecify IS 'Immediate Other specify flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.iscriminalhistory IS 'Criminal history flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.yesdatadescription IS 'Data Description';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.scrnin_description IS 'Screen in description';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.scrnout_description IS 'Screen out description';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnoimmed_physicalabuse IS 'No immediate physical abuse flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnoimmed_sexualabuse IS 'No immediate sexual abuse flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnoimmed_neglectresponse IS 'No immediate neglect response flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isnoimmed_mentalinjury IS 'No immediate mental injury flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.iscps IS 'CPS flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isfinalscreenin IS 'Final screen in flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.intakenumber IS 'Intakenumber';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge."comments" IS 'Comments';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.status IS 'Status';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isfcplacementsetting IS 'Foster care placement setting flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isprivateplacement IS 'Private placement flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.islicenseddaycare IS 'Licensed day care flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isschool IS 'School flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ischildfatality IS 'Child fatality flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.issubexpnewborn IS 'Substance Exposed Newborns';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isriskcso IS 'Risk of Sexual Abuse By Registered Child Sex Offender';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isriskvoilence IS 'Risk due to Domestic Voilence';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.iscgimpairment IS 'Risk due to Caregiver Impairment';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.islivinginhome IS 'Child age 5 OR Under Living In Home';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isdeathan IS 'Serious Injury of abuse and neglect';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.issextrafficking IS 'Suspicion of Sex Trafficking';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isadultsurvivor IS 'Adult survivor Of maltreatment';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isbirthmatchtpr IS 'TPR rated';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isbirthmatchcriminal IS 'Criminal History rated';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.ismalsa_sex_trafficking IS 'Maltreatment Sexual Abuse - Sex trafficking flag';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isfclivingarrangement IS 'to store Alleged maltreatment linked to a childs residence while they were removed in Foster Care';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.selectedplacement IS 'to store selected placement or living arrangement';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.confirmtrafficking IS 'to store confirm trafficking value';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.selecttrafficking IS 'to store selected trafficking value';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isseriousphysicalinjury IS 'to store Near-Death/Serious Physical Injury';
COMMENT ON COLUMN expunge.intakeservicerequestsdm_expunge.isexpunged IS 'Flag to indicate the expunged record';