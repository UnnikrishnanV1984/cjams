-- Drop table

-- DROP TABLE encr.intakeservicerequestsdm_encr;

CREATE TABLE encr.intakeservicerequestsdm_encr (
    intakeservicerequestsdmencrid uuid NOT NULL DEFAULT cjams.gen_random_uuid(),
	intakeservicerequestsdmid uuid NOT NULL,
	intakeserviceid uuid NULL,
	ismaltreatment bool NOT NULL DEFAULT false,
	referralname bytea NULL,
	referraldob timestamp NULL,
	referralid bytea NULL,
	countyid uuid NULL,
	ismalpa_suspeciousdeath bool NULL DEFAULT false,
	ismalpa_nonaccident bool NULL DEFAULT false,
	ismalpa_injuryinconsistent bool NULL DEFAULT false,
	ismalpa_insjury bool NULL DEFAULT false,
	ismalpa_childtoxic bool NULL DEFAULT false,
	ismalpa_caregiver bool NULL DEFAULT false,
	ismalsa_sexualmolestation bool NULL DEFAULT false,
	ismalsa_sexualact bool NULL DEFAULT false,
	ismalsa_sexualexploitation bool NULL DEFAULT false,
	ismalsa_physicalindicators bool NULL DEFAULT false,
	isneggn_suspiciousdeath bool NULL DEFAULT false,
	isneggn_signsordiagnosis bool NULL DEFAULT false,
	isneggn_inadequatefood bool NULL DEFAULT false,
	isneggn_exposuretounsafe bool NULL DEFAULT false,
	isneggn_inadequateclothing bool NULL DEFAULT false,
	isneggn_inadequatesupervision bool NULL DEFAULT false,
	isneggn_childdischarged bool NULL DEFAULT false,
	isnegfp_cargiverintervene bool NULL DEFAULT false,
	isnegab_abandoned bool NULL DEFAULT false,
	isneguc_leftunsupervised bool NULL DEFAULT false,
	isneguc_leftaloneinappropriatecare bool NULL DEFAULT false,
	isneguc_leftalonewithoutsupport bool NULL DEFAULT false,
	isnegrh_priordeath bool NULL DEFAULT false,
	isnegrh_sexualperpetrator bool NULL DEFAULT false,
	isnegrh_basicneedsunmet bool NULL DEFAULT false,
	isnegmn_unreasonabledelay bool NULL DEFAULT false,
	ismenab_psycologicalability bool NULL DEFAULT false,
	ismenng_psycologicalability bool NULL DEFAULT false,
	isrecsc_screenout bool NULL DEFAULT false,
	isrecsc_scrrenin bool NULL DEFAULT false,
	isrecovr_no bool NULL DEFAULT false,
	isrecovr_scrrenin bool NULL DEFAULT false,
	isreccps_screenout bool NULL DEFAULT false,
	isrec_imlist bool NULL DEFAULT false,
	isrec_noimmediate bool NULL DEFAULT false,
	isrec_reportallegtion bool NULL DEFAULT false,
	officerfirstname bytea NULL,
	officermiddlename bytea NULL,
	officerlastname bytea NULL,
	badgenumber bytea NULL,
	recordnumber bytea NULL,
	reportdate timestamp NULL,
	worker bytea NULL,
	workerdate timestamp NULL,
	supervisor bytea NULL,
	supervisordate timestamp NULL,
	activeflag int4 NOT NULL DEFAULT 1,
	updatedby varchar(50) NULL,
	updatedon timestamp NOT NULL DEFAULT now(),
	insertedby varchar(50) NULL,
	insertedon timestamp NOT NULL DEFAULT now(),
	effectivedate timestamp NOT NULL DEFAULT now(),
	issexualabuse bool NULL DEFAULT false,
	isoutofhome bool NULL DEFAULT false,
	isdeathorserious bool NULL DEFAULT false,
	isrisk bool NULL DEFAULT false,
	isreportmeets bool NULL DEFAULT false,
	issignordiagonises bool NULL DEFAULT false,
	ismaltreatment3yrs bool NULL DEFAULT false,
	ismaltreatment12yrs bool NULL DEFAULT false,
	ismaltreatment24yrs bool NULL DEFAULT false,
	isactiveinvestigation bool NULL DEFAULT false,
	isreportedhistory bool NULL DEFAULT false,
	ismultiple bool NULL DEFAULT false,
	isdomesticvoilence bool NULL DEFAULT false,
	isthread bool NULL DEFAULT false,
	islawenforcement bool NULL DEFAULT false,
	iscourtiinvestigation bool NULL DEFAULT false,
	isar bool NULL DEFAULT false,
	isir bool NULL DEFAULT false,
	isscrninrecovr_courtorder bool NULL DEFAULT false,
	isscrninrecovr_otherspecify bool NULL DEFAULT false,
	isscrnoutrecovr_insufficient bool NULL DEFAULT false,
	isscrnoutrecovr_information bool NULL DEFAULT false,
	isscrnoutrecovr_historicalinformation bool NULL DEFAULT false,
	isscrnoutrecovr_otherspecify bool NULL DEFAULT false,
	isimmed_childfaatility bool NULL DEFAULT false,
	isimmed_seriousinjury bool NULL DEFAULT false,
	isimmed_childleftalone bool NULL DEFAULT false,
	isimmed_allegation bool NULL DEFAULT false,
	isimmed_otherspecify bool NULL DEFAULT false,
	iscriminalhistory bool NULL DEFAULT false,
	yesdatadescription varchar(200) NULL,
	scrnin_description bytea NULL,
	scrnout_description bytea NULL,
	isnoimmed_physicalabuse bool NULL DEFAULT false,
	isnoimmed_sexualabuse bool NULL DEFAULT false,
	isnoimmed_neglectresponse bool NULL DEFAULT false,
	isnoimmed_mentalinjury bool NULL DEFAULT false,
	iscps bool NULL,
	isfinalscreenin bool NULL DEFAULT false,
	old_id varchar(50) NULL,
	intakenumber bytea NULL,
	"comments" bytea NULL,
	status int4 NULL,
	isfcplacementsetting bool NULL,
	isprivateplacement bool NULL,
	islicenseddaycare bool NULL,
	isschool bool NULL,
	ischildfatality bool NULL,
	lawenforcementid int4 NULL,
	lawenfmtreferralid int4 NULL,
	lawenfmtofficerprefixtypekey varchar(5) NULL,
	lawenfmtofficersuffixtypekey varchar(5) NULL,
	lawenfmtext varchar(20) NULL,
	lawdistrict varchar(20) NULL,
	lawenfmtofficerphone varchar(20) NULL,
	lawifieddate timestamp NULL,
	lawifiedtime timestamp NULL,
	lawenfmtdispatcherflag int4 NULL,
	lawenfmtinsertedon timestamp NULL,
	lawenfmtinsertedby varchar(10) NULL,
	lawenfmtupdatedon timestamp NULL,
	lawenfmtupdatedby varchar(10) NULL,
	lawenfmtactiveflag int4 NULL DEFAULT 1,
	lawenfmtcaseid int4 NULL,
	cpsscreeningname varchar(50) NULL,
	drugexposednewbornflag int4 NULL,
	maltreatmentcompleteflag int4 NULL,
	cpsscreenoutotherflag int4 NULL,
	cpsscreenoutother bytea NULL,
	newnoncpsrefflag int4 NULL,
	cpsscreeniherflag int4 NULL,
	cpsscreeniher bytea NULL,
	noscreeninoverridesflag int4 NULL,
	screenoutascpsflag int4 NULL,
	screeninonemalflag int4 NULL,
	childabandoned bytea NULL,
	immediateotherflag int4 NULL,
	immediateother bytea NULL,
	screeninoverrideflag int4 NULL,
	allegedmaltreatmentdate timestamp NULL,
	cpsagencyname bytea NULL,
	adrformattypekey varchar(5) NULL,
	adrstreetno int4 NULL,
	adrboxno int4 NULL,
	adrpredirtypekey varchar(5) NULL,
	adrstreetname bytea NULL,
	adrstreetsuffixtypekey varchar(5) NULL,
	adrpostdirtypekey varchar(5) NULL,
	adrunittypekey varchar(5) NULL,
	adrunitno bytea NULL,
	adrcityname bytea NULL,
	adrstatetypekey varchar(5) NULL,
	adrzip5no int4 NULL,
	adrzip4no int4 NULL,
	adrdirection bytea NULL,
	adrforeign varchar(500) NULL,
	adrforeignstate varchar(50) NULL,
	adrcountry varchar(50) NULL,
	adrpostalcode varchar(50) NULL,
	adrworkphone bytea NULL,
	adrworkxtn bytea NULL,
	adremail varchar(100) NULL,
	adrfax varchar(50) NULL,
	adrurl varchar(100) NULL,
	adrothercontact bytea NULL,
	outofhomeflag int4 NULL,
	communicationastncrqrdflag int4 NULL,
	cpslawifiedflag int4 NULL,
	cpscomplaintno bytea NULL,
	lawofficerassignedflag int4 NULL,
	cpsproviderid int4 NULL,
	adrstreettext bytea NULL,
	intinvfinalflag int4 NULL,
	intinvfinaldate timestamp NULL,
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
	screeningext bytea NULL,
	screeninglawdistrict bytea NULL,
	screeningofficerphone bytea NULL,
	screeninglawifieddate timestamp NULL,
	screeninglawifiedttime timestamp NULL,
	screeningdispatcherflag int4 NULL,
	screeninginsertedon timestamp NULL,
	screeninginsertedby varchar(10) NULL,
	screeningupdatedon timestamp NULL,
	screeningupdatedby varchar(10) NULL,
	screeningactiveflag int4 NULL DEFAULT 1,
	old_cps_id varchar(10) NULL,
	issubexpnewborn int4 NULL,
	isriskcso int4 NULL,
	isriskvoilence int4 NULL,
	iscgimpairment int4 NULL,
	islivinginhome int4 NULL,
	isdeathan int4 NULL,
	issextrafficking int4 NULL,
	isadultsurvivor int4 NULL,
	isbirthmatchtpr int4 NULL,
	isbirthmatchcriminal int4 NULL,
	isnegrh_sex_offender bool NULL DEFAULT false,
	isnegrh_risk_dv bool NULL DEFAULT false,
	isnegrh_sex_trafficking bool NULL DEFAULT false,
	isnegrh_fatality_can bool NULL DEFAULT false,
	isnegrh_indicated_unsub bool NULL DEFAULT false,
	isnegrh_survivor bool NULL DEFAULT false,
	isnegrh_birth_match bool NULL DEFAULT false,
	ismalsa_sex_trafficking bool NULL DEFAULT false,
	isnoimmed_substantial_risk bool NULL,
	isnoimmed_screeninoverride bool NULL,
	isnoimmed_risk_harm bool NULL,
	isnegrh_treatmenthealthrisk bool NULL DEFAULT false,
	etl_userid varchar(30) NULL,
	etl_load_date date NULL,
	isfclivingarrangement bool NULL DEFAULT false,
	linkschidresid bool NULL DEFAULT false,
	selectedplacement varchar NULL,
	confirmtrafficking varchar(10) NULL,
	selecttrafficking varchar(50) NULL,
	isexpunged int4 NULL DEFAULT 0,
	isseriousphysicalinjury bool NULL,
	CONSTRAINT pk_intakeservicerequestsdm_encr PRIMARY KEY (intakeservicerequestsdmencrid),
	CONSTRAINT fk_intakeservicerequestsdm_encr_county FOREIGN KEY (countyid) REFERENCES county(countyid),
	CONSTRAINT fk_intakeservicerequestsdm_encr_intakeservicerequest FOREIGN KEY (intakeserviceid) REFERENCES intakeservicerequest(intakeserviceid)
);
CREATE INDEX idx_intakeservicerequestsdm_encr_activeflag ON encr.intakeservicerequestsdm_encr USING btree (activeflag);
CREATE INDEX idx_intakeservicerequestsdm_encr_intakenumber ON encr.intakeservicerequestsdm_encr USING btree (intakenumber);
CREATE INDEX idx_intakeservicerequestsdm_encr_intakenumber_activeflag ON encr.intakeservicerequestsdm_encr USING btree (intakenumber, activeflag);
CREATE INDEX idx_intakeservicerequestsdm_encr_intakeserviceid_activeflag ON encr.intakeservicerequestsdm_encr USING btree (intakeserviceid, activeflag);

-- Column comments
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.intakeservicerequestsdmencrid IS 'Intakeservicerequest sdm information encrypted table (PRIMARY KEY)';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.intakeservicerequestsdmid IS 'intakeservicerequestsdm Table information (PRIMARY KEY)';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.intakeserviceid IS 'Intakeserviceid(FOREIGN KEY)';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismaltreatment IS 'Maltreatment flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.referralname IS 'Referral name';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.referraldob IS 'Referral dob';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.referralid IS 'Referral id';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.countyid IS 'County id(FOREIGN KEY)';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalpa_suspeciousdeath IS 'Malpa suspecious death flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalpa_nonaccident IS 'Malpa nonaccident flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalpa_injuryinconsistent IS 'Malpa injury inconsistent flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalpa_insjury IS 'Malpa insjury flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalpa_childtoxic IS 'Malpa childtoxic flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalpa_caregiver IS 'Malpa caregiver flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalsa_sexualmolestation IS 'Malsa sexual mole station flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalsa_sexualact IS 'Malsa sexual act flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalsa_sexualexploitation IS 'Malsa sexual exploitation flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalsa_physicalindicators IS 'Malsa physical indicators flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneggn_suspiciousdeath IS 'Neggn suspicious death flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneggn_signsordiagnosis IS 'Neggn signsor diagnosis flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneggn_inadequatefood IS 'Neggn inadequate food flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneggn_exposuretounsafe IS 'Neggn exposure to unsafe flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneggn_inadequateclothing IS 'Neggn inadequate clothing flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneggn_inadequatesupervision IS 'Neggn inadequate supervision flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneggn_childdischarged IS 'Neggn child discharged flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnegfp_cargiverintervene IS 'Negfp cargiver intervene flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnegab_abandoned IS 'Negab abandoned flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneguc_leftunsupervised IS 'Neguc left unsupervised flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneguc_leftaloneinappropriatecare IS 'Neguc leftalonein appropriate care flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isneguc_leftalonewithoutsupport IS 'Neguc leftalone without support flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnegrh_priordeath IS 'Negrh prior death flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnegrh_sexualperpetrator IS 'Negrh sexual per petrator flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnegrh_basicneedsunmet IS 'Negrh basicneeds unmet flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnegmn_unreasonabledelay IS 'Negmn unreasonable delay flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismenab_psycologicalability IS 'Menab psycologicalability flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismenng_psycologicalability IS 'Menng psycologicalability flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isrecsc_screenout IS 'Recsc screenout flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isrecsc_scrrenin IS 'Recsc scrrenin flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isrecovr_no IS 'Recovr no flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isrecovr_scrrenin IS 'Recovr scrrenin flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isreccps_screenout IS 'Reccps screenout flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isrec_imlist IS 'Rec imlist flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isrec_noimmediate IS 'Rec noimmediate flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isrec_reportallegtion IS 'Rec reportallegtion flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.officerfirstname IS 'Officer firstname';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.officermiddlename IS 'Officer middlename';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.officerlastname IS 'Officer lastname';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.badgenumber IS 'Badge number';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.recordnumber IS 'Record number';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.reportdate IS 'Report date';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.worker IS 'Worker';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.workerdate IS 'Worker date';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.supervisor IS 'supervisor';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.supervisordate IS 'Supervisor date';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.activeflag IS 'Status of the record';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.updatedby IS 'user who last updated the record';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.updatedon IS 'Record updated date and time';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.insertedby IS 'User who created this record';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.insertedon IS 'Record created date and time';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.effectivedate IS 'Record valid from';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.issexualabuse IS 'Sexual abuse flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isoutofhome IS 'Out of home flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isdeathorserious IS 'Death serious flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isrisk IS 'Risk flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isreportmeets IS 'Report meets flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.issignordiagonises IS 'Sign or diagonises flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismaltreatment3yrs IS 'Maltreatment 3 years flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismaltreatment12yrs IS 'Maltreatment 12 years flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismaltreatment24yrs IS 'Maltreatment 24 years flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isactiveinvestigation IS 'Active investigation flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isreportedhistory IS 'Report history';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismultiple IS 'Multiple flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isdomesticvoilence IS 'Domestic voilence flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isthread IS 'Thread flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.islawenforcement IS 'Law enforcement flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.iscourtiinvestigation IS 'Court investigation flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isar IS 'AR flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isir IS 'IR flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isscrninrecovr_courtorder IS 'SCRN inrecover court order flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isscrninrecovr_otherspecify IS 'SCRN inrecover other specify flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isscrnoutrecovr_insufficient IS 'SCRN outrecover insufficient flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isscrnoutrecovr_information IS 'SCRN outrecover information flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isscrnoutrecovr_historicalinformation IS 'SCRN outrecover historical information flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isscrnoutrecovr_otherspecify IS 'SCRN outrecover other specify flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isimmed_childfaatility IS 'Immediate child fatility flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isimmed_seriousinjury IS 'Immediate serious injury flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isimmed_childleftalone IS 'Immediate child left alone flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isimmed_allegation IS 'Immediate allegation flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isimmed_otherspecify IS 'Immediate Other specify flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.iscriminalhistory IS 'Criminal history flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.yesdatadescription IS 'Data Description';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.scrnin_description IS 'Screen in description';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.scrnout_description IS 'Screen out description';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnoimmed_physicalabuse IS 'No immediate physical abuse flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnoimmed_sexualabuse IS 'No immediate sexual abuse flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnoimmed_neglectresponse IS 'No immediate neglect response flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isnoimmed_mentalinjury IS 'No immediate mental injury flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.iscps IS 'CPS flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isfinalscreenin IS 'Final screen in flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.old_id IS 'Used for migration purpose';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.intakenumber IS 'Intakenumber';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr."comments" IS 'Comments';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.status IS 'Status';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isfcplacementsetting IS 'Foster care placement setting flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isprivateplacement IS 'Private placement flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.islicenseddaycare IS 'Licensed day care flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isschool IS 'School flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ischildfatality IS 'Child fatality flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.issubexpnewborn IS 'Substance Exposed Newborns';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isriskcso IS 'Risk of Sexual Abuse By Registered Child Sex Offender';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isriskvoilence IS 'Risk due to Domestic Voilence';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.iscgimpairment IS 'Risk due to Caregiver Impairment';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.islivinginhome IS 'Child age 5 OR Under Living In Home';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isdeathan IS 'Serious Injury of abuse and neglect';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.issextrafficking IS 'Suspicion of Sex Trafficking';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isadultsurvivor IS 'Adult survivor Of maltreatment';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isbirthmatchtpr IS 'TPR rated';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isbirthmatchcriminal IS 'Criminal History rated';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.ismalsa_sex_trafficking IS 'Maltreatment Sexual Abuse - Sex trafficking flag';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.isfclivingarrangement IS 'to store Alleged maltreatment linked to a childs residence while they were removed in Foster Care';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.selectedplacement IS 'to store selected placement or living arrangement';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.confirmtrafficking IS 'to store confirm trafficking value';
COMMENT ON COLUMN encr.intakeservicerequestsdm_encr.selecttrafficking IS 'to store selected trafficking value';