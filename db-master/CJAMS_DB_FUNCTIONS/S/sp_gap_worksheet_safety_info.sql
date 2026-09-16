DROP FUNCTION IF EXISTS cjams.sp_gap_worksheet_safety_info(al_client_id bigint);

create
or replace
function cjams.sp_gap_worksheet_safety_info(al_client_id bigint) returns table
	(client_id bigint,
	fosterhomeapprover character varying,
	prinationalandstatecriminalhistorybackgroundcheck character varying,
	pridateofnationalandstatecriminalhistorybackgroundcheck date,
	prichildabuseandmaltreatmentdatabasecheck character varying,
	pridateofchildabuseandmaltreatmentdbcheck date,
	prioutofstatewithinpast5years character varying,
	prichildabuseandmaltreatmentinformationinthepreviousstates character varying,
	pridateofchildabuseandmaltreatmentdbcheckoos date,
	primaryguardianhhmembers integer,
	primaryhousehold json,
	secondguardianexists character varying,
	secguardlivingwithpriguard character varying,
	secnationalandstatecriminalhistorybackgroundcheck character varying,
	secdateofnationalandstatecriminalhistorybackgroundcheck date,
	secchildabuseandmaltreatmentdatabasecheck character varying,
	secdateofchildabuseandmaltreatmentdbcheck date,
	secoutofstatewithinpast5years character varying,
	secchildabuseandmaltreatmentinformationinthepreviousstates character varying,
	secdateofchildabuseandmaltreatmentdbcheckoos date,
	appropriatepermanencyforchildnotbeingreturned character varying,
	appropriatepermanencyforchildnotbeingadopted character varying,
	priguardiancommitment character varying,
	secguardiancommitment character varying,
	childprimaryguardianattachment character varying,
	childsecondguardianattachment character varying,
	ageappropriateconsultationtakenplacewiththechild character varying) language plpgsql as $function$ declare vs_Procedure_nm varchar(100) default 'sp_gap_worksheet_safety_info';
--              vs_ldss_home_aprvr                                                                                              VARCHAR(25);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
--              vs_cpa_home_aprvr                                                                                               VARCHAR(25);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
 vs_fstr_hm_aprvr varchar(50);

vs_bg_chk_national_state varchar(50);

vd_bg_chk_national_state_dt date;

vs_bg_chk_child_abuse_maltreatment varchar(20);

vd_bg_chk_child_abuse_maltreatment_dt date;

vs_bg_chk_child_abuse_maltreatment_oos varchar(20);

vs_bg_chk_oos varchar(20);

vd_bg_chk_child_abuse_maltreatment_oos_dt date;

vn_pri_grd_no_of_hh_mmbrs integer;

vs_pri_hh_bg_chk json;

vs_scnd_grd_exts varchar(25);

vs_sec_grd_lvng_with_pri_grd varchar(25);

vs_sec_bg_chk_national_state varchar(50);

vd_sec_bg_chk_national_state_dt date;

vs_sec_bg_chk_child_abuse_maltreatment varchar(20);

vd_sec_bg_chk_child_abuse_maltreatment_dt date;

vs_sec_bg_chk_child_abuse_maltreatment_oos varchar(20);

vs_sec_bg_chk_oos varchar(20);

vd_sec_bg_chk_child_abuse_maltreatment_oos_dt date;

vs_appr_prmncy_chld_rtrnd_hm varchar(20);

vs_appr_prmncy_chld_adptd varchar(20);

vs_pri_grd_cmmtmnt varchar(20);

vs_sec_grd_cmmtmnt varchar(20);

vs_chd_pri_grd_attch varchar(20);

vs_chd_sec_grd_attch varchar(20);

vs_age_appr_cnslt_pl varchar(20);

v_submission_data json;

v_criminal_history_check_data json;

v_fbi_Criminal_history_background_check varchar(5);
v_fbi_Criminal_history_background_check_date date;
v_fbi_Criminal_history_background_check_hh varchar(5);
v_fbi_Criminal_history_background_check_date_hh date;
v_fbi_Criminal_history_background_check_sg varchar(5);
v_fbi_Criminal_history_background_check_date_sg date;
begin
create
temp table
if not exists Temp_worksheet_safety_info ( client_id bigint,
--              homeapprovedbyldss                                                                                      VARCHAR(25),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
--              homeapprovedbycpa                                                                                       VARCHAR(25),                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
 fosterhomeapprover varchar(50),
prinationalandstatecriminalhistorybackgroundcheck varchar(20),
pridateofnationalandstatecriminalhistorybackgroundcheck date,
prichildabuseandmaltreatmentdatabasecheck varchar(20),
pridateofchildabuseandmaltreatmentdbcheck date,
prioutofstatewithinpast5years varchar(20),
prichildabuseandmaltreatmentinformationinthepreviousstates varchar(20),
pridateofchildabuseandmaltreatmentdbcheckoos date,
primaryguardianhhmembers integer,
primaryhousehold json,
secondguardianexists varchar(25),
secguardlivingwithpriguard varchar(25),
secnationalandstatecriminalhistorybackgroundcheck varchar(20),
secdateofnationalandstatecriminalhistorybackgroundcheck date,
secchildabuseandmaltreatmentdatabasecheck varchar(20),
secdateofchildabuseandmaltreatmentdbcheck date,
secoutofstatewithinpast5years varchar(20),
secchildabuseandmaltreatmentinformationinthepreviousstates varchar(20),
secdateofchildabuseandmaltreatmentdbcheckoos date,
appropriatepermanencyforchildnotbeingreturned varchar(20),
appropriatepermanencyforchildnotbeingadopted varchar(20),
priguardiancommitment varchar(20),
secguardiancommitment varchar(20),
childprimaryguardianattachment varchar(20),
childsecondguardianattachment varchar(20),
ageappropriateconsultationtakenplacewiththechild varchar(20) );

-- Foster Home Approver                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
 select (CASE when tp.picklist_value_cd = '1782' then 'CPS' else 'LDSS' end) into  --'1782','1783'
		vs_fstr_hm_aprvr from 
		tb_provider_picklist tp,
		tb_guardian_subsidy ts,
		tb_client_eligibility te
		where tp.provider_id = ts.provider_id 
		and tp.picklist_type_id = 155 
		and ts.guardian_subsidy_id = te.guardian_subsidy_id
		and te.client_id = al_client_id
		order by
		ts.update_ts desc
		limit 1;

-- National And State Criminal History Background Check                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
 select
bg.submission_data,
bg.criminal_history_check_data into
v_submission_data,
v_criminal_history_check_data
from
person per
inner join intakeservicerequestactor isra on
per.personid = isra.personid
inner join tb_placement tp on
isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
inner join servicecase sc on
tp.case_id = sc.servicecasenumber::bigint
inner join permanencyplan pp on
pp.servicecaseid = sc.servicecaseid
inner join guardianship grd on
grd.servicecaseid = pp.servicecaseid
inner join adoptionplanning ap on
ap.permanencyplanid = pp.permanencyplanid
inner join adoptionagreement aa on
aa.adoptionplanningid = ap.adoptionplanningid
inner join adoptionagreementrate aar on
aar.adoptionagreementid = aa.adoptionagreementid
inner join tb_provider_approval tpa on
tpa.provider_id = aar.provider_id
inner join tb_provider_applicant ppa on
ppa.provider_id = tpa.provider_id
inner join tb_public_provider_applicant_household hh on
hh.object_id = ppa.applicant_id
inner join pubprovapphouseholdbgchecks bg on
bg.household_member_id = hh.household_member_id
where
per.cjamspid = al_client_id
and tpa.approval_type_cd = '4990'
and hh.household_member_relation like 'Individual Applicant'
limit 1;

if v_criminal_history_check_data->'mdClearance'->>'mainQuestion' = '1' or
   v_criminal_history_check_data->'fbiClearance'->>'mainQuestion' = '1'
then
vd_bg_chk_national_state_dt = (v_criminal_history_check_data->'mdClearance'->>'clearance_date')::date;
      vs_bg_chk_national_state = 'yes';
   else vd_bg_chk_national_state_dt = null;
      vs_bg_chk_national_state = 'No';
end if;

if v_submission_data->'mdSexOffRegClearance'->>'mainQuestion' = '1' then
vs_bg_chk_child_abuse_maltreatment = 'yes';
else
vs_bg_chk_child_abuse_maltreatment = 'No';
end if;

if v_submission_data->'mdSexOffRegClearance'->>'mainQuestion' = '1' then
vd_bg_chk_child_abuse_maltreatment_dt = (submission_data->'mdSexOffRegClearance'->>'clearance_date')::date;
end if;

if v_submission_data->'outOfStateClearences'->>'mainQuestion' = '1' then
vs_bg_chk_child_abuse_maltreatment_oos = 'yes';
else
vs_bg_chk_child_abuse_maltreatment_oos = 'No';
end if;
-- OOS Check Past 5 Years    
if v_submission_data->'natSexOffRegClearance'->>'mainQuestion' = '1' then
vs_bg_chk_oos = 'yes';
else
vs_bg_chk_oos = 'No';
end if;
 
-- Child Abuse And Maltreatment Database Check OOS Date  
if v_submission_data->'natSexOffRegClearance'->>'mainQuestion' = '1' then
vd_bg_chk_child_abuse_maltreatment_oos_dt = (v_submission_data->'natSexOffRegClearance'->>'clearance_date')::date;
end if;
 
if v_criminal_history_check_data->'fbiClearance'->>'mainQuestion' = '1' then
v_fbi_Criminal_history_background_check_date  = v_criminal_history_check_data->'fbiClearance'->>'clearance_date';
v_fbi_Criminal_history_background_check = 'yes';
else
v_fbi_Criminal_history_background_check = 'no';
end if;
 
 
-- Primary Guardian HH Members      
select
count(*) into
vn_pri_grd_no_of_hh_mmbrs
from
person per
inner join intakeservicerequestactor isra on
per.personid = isra.personid
inner join tb_placement tp on
isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
inner join servicecase sc on
tp.case_id = sc.servicecasenumber::bigint
inner join permanencyplan pp on
pp.servicecaseid = sc.servicecaseid
inner join guardianship grd on
grd.servicecaseid = pp.servicecaseid
inner join adoptionplanning ap on
ap.permanencyplanid = pp.permanencyplanid
inner join adoptionagreement aa on
aa.adoptionplanningid = ap.adoptionplanningid
inner join adoptionagreementrate aar on
aar.adoptionagreementid = aa.adoptionagreementid
inner join tb_provider_approval tpa on
tpa.provider_id = aar.provider_id
inner join tb_provider_applicant ppa on
ppa.provider_id = tpa.provider_id
inner join tb_public_provider_applicant_household hh on
hh.object_id = ppa.applicant_id
inner join pubprovapphouseholdbgchecks bg on
bg.household_member_id = hh.household_member_id
where
per.cjamspid = al_client_id
and tpa.approval_type_cd = '4990';

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
 
-- Primary Guardian HH Members Background Check                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
 
-- Second Guardian Exists                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
 select
(
case
when (guardiantwoproviderid is not null) then 'YES'::varchar
else 'NO'::varchar
end ) into
vs_scnd_grd_exts
from
guardianship grd,
intakeservicerequestactor isra,
person per
where
grd.servicecaseid = isra.servicecaseid
and grd.activeflag = 1
and isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD')
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
limit 1;
-- Guardian Two living with Primary Guardian                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
 select
(
case
when (grd.guardiantwoid is null) then 'NO'::varchar
else 'YES'::varchar
end ) into
vs_sec_grd_lvng_with_pri_grd
from
guardianship grd,
intakeservicerequestactor isra,
person per
where
grd.servicecaseid = isra.servicecaseid
and grd.activeflag = 1
and isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD')
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
order by
grd.updatedon desc
limit 1;

if (vs_scnd_grd_exts = 'YES') then
-- SG National And State Criminal History Background Check  
select
bg.submission_data,
bg.criminal_history_check_data into
v_submission_data,
v_criminal_history_check_data
from
person per
inner join intakeservicerequestactor isra on
per.personid = isra.personid
inner join tb_placement tp on
isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
inner join servicecase sc on
tp.case_id = sc.servicecasenumber::bigint
inner join permanencyplan pp on
pp.servicecaseid = sc.servicecaseid
inner join guardianship grd on
grd.servicecaseid = pp.servicecaseid
inner join adoptionplanning ap on
ap.permanencyplanid = pp.permanencyplanid
inner join adoptionagreement aa on
aa.adoptionplanningid = ap.adoptionplanningid
inner join adoptionagreementrate aar on
aar.adoptionagreementid = aa.adoptionagreementid
inner join tb_provider_approval tpa on
tpa.provider_id = aar.provider_id
inner join tb_provider_applicant ppa on
ppa.provider_id = tpa.provider_id
inner join tb_public_provider_applicant_household hh on
hh.object_id = ppa.applicant_id
inner join pubprovapphouseholdbgchecks bg on
bg.household_member_id = hh.household_member_id
where
per.cjamspid = al_client_id
and tpa.approval_type_cd = '4990'
and hh.household_member_relation like 'Co Applicant'
limit 1;

if v_criminal_history_check_data->'mdClearance'->>'mainQuestion' = '1' or
   v_criminal_history_check_data->'fbiClearance'->>'mainQuestion' = '1'
then
vd_sec_bg_chk_national_state_dt = (v_criminal_history_check_data->'mdClearance'->>'clearance_date')::date;
      vs_sec_bg_chk_national_state = 'yes';
   else
vd_sec_bg_chk_national_state_dt = null;
      vs_sec_bg_chk_national_state = 'No';
end if;

if v_submission_data->'mdSexOffRegClearance'->>'mainQuestion' = '1' then
vs_sec_bg_chk_child_abuse_maltreatment = 'yes';
else
vs_sec_bg_chk_child_abuse_maltreatment = 'No';
end if;

if v_submission_data->'mdSexOffRegClearance'->>'mainQuestion' = '1' then
vd_sec_bg_chk_child_abuse_maltreatment_dt = (submission_data->'mdSexOffRegClearance'->>'clearance_date')::date;
end if;

if v_submission_data->'outOfStateClearences'->>'mainQuestion' = '1' then
vs_sec_bg_chk_child_abuse_maltreatment_oos = 'yes';
else
vs_sec_bg_chk_child_abuse_maltreatment_oos = 'No';
end if;
-- OOS Check Past 5 Years    
if v_submission_data->'natSexOffRegClearance'->>'mainQuestion' = '1' then
vs_sec_bg_chk_oos = 'yes';
else
vs_sec_bg_chk_oos = 'No';
end if;
 
-- Child Abuse And Maltreatment Database Check OOS Date  
if v_submission_data->'natSexOffRegClearance'->>'mainQuestion' = '1' then
vd_sec_bg_chk_child_abuse_maltreatment_oos_dt = (v_submission_data->'natSexOffRegClearance'->>'clearance_date')::date;
end if;

if v_criminal_history_check_data->'fbiClearance'->>'mainQuestion' = '1' then
v_fbi_Criminal_history_background_check_date_sg  = v_criminal_history_check_data->'fbiClearance'->>'clearance_date';
v_fbi_Criminal_history_background_check_sg  = 'yes';
else
v_fbi_Criminal_history_background_check_sg  = 'no';
end if;

end if;
-- Appropriate Permanency For Child For Not Being Returned Home                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
 select
(
case
when (gdis.isreunificationremoved = 'true') then 'YES'::varchar
else 'NO'::varchar
end ) into
vs_appr_prmncy_chld_rtrnd_hm
from
gapdisclosure gdis,
guardianship grd,
permanencyplan pp,
servicecase sc,
tb_placement tp,
intakeservicerequestactor isra,
person per
where
gdis.gapid = grd.gapid
and gdis.activeflag = 1
and grd.servicecaseid = pp.servicecaseid
and grd.permanencyplanid = pp.permanencyplanid
and pp.activeflag = 1
and pp.servicecaseid = sc.servicecaseid
and sc.activeflag = 1
and tp.case_id = sc.servicecasenumber::bigint
and tp.delete_sw = 'N'
and tp.approval_status_cd = '3047'
and isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
order by
gdis.updatedon desc
limit 1;
-- Appropriate Permanency For Child For Being Adopted                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
 select
(
case
when (gdis.isadoptionremoved = 'true') then 'YES'::varchar
else 'NO'::varchar
end ) into
vs_appr_prmncy_chld_adptd
from
gapdisclosure gdis,
guardianship grd,
permanencyplan pp,
servicecase sc,
tb_placement tp,
intakeservicerequestactor isra,
person per
where
gdis.gapid = grd.gapid
and gdis.activeflag = 1
and grd.servicecaseid = pp.servicecaseid
and grd.permanencyplanid = pp.permanencyplanid
and pp.activeflag = 1
and pp.servicecaseid = sc.servicecaseid
and sc.activeflag = 1
and tp.case_id = sc.servicecasenumber::bigint
and tp.delete_sw = 'N'
and tp.approval_status_cd = '3047'
and isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
order by
gdis.updatedon desc
limit 1;
-- Primary Guardian Commitment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
 select
(
case
when (grd.priguardiancommitmentflag = 1) then 'YES'::varchar
when (grd.priguardiancommitmentflag = 0) then 'NO'::varchar
else null
end ) into
vs_pri_grd_cmmtmnt
from
guardianship grd,
permanencyplan pp,
servicecase sc,
tb_placement tp,
intakeservicerequestactor isra,
person per
where
grd.servicecaseid = pp.servicecaseid
and grd.permanencyplanid = pp.permanencyplanid
and pp.activeflag = 1
and pp.servicecaseid = sc.servicecaseid
and sc.activeflag = 1
and tp.case_id = sc.servicecasenumber::bigint
and tp.delete_sw = 'N'
and tp.approval_status_cd = '3047'
and isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
order by
grd.updatedon desc
limit 1;

if (vs_scnd_grd_exts = 'YES') then
-- Secondary Guardian Commitment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
 select
(
case
when (grd.secguardiancommitmentflag = 1) then 'YES'::varchar
when (grd.secguardiancommitmentflag = 0) then 'NO'::varchar
else null
end ) into
vs_sec_grd_cmmtmnt
from
guardianship grd,
permanencyplan pp,
servicecase sc,
tb_placement tp,
intakeservicerequestactor isra,
person per
where
grd.servicecaseid = pp.servicecaseid
and grd.permanencyplanid = pp.permanencyplanid
and pp.activeflag = 1
and pp.servicecaseid = sc.servicecaseid
and sc.activeflag = 1
and tp.case_id = sc.servicecasenumber::bigint
and tp.delete_sw = 'N'
and tp.approval_status_cd = '3047'
and isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
order by
grd.updatedon desc
limit 1;
end if;
-- Child Primary Guardian Attachment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
 select
(
case
when (gdis.isguardianattach = 'true') then 'YES'::varchar
else 'NO'::varchar
end ) into
vs_chd_pri_grd_attch
from
gapdisclosure gdis,
guardianship grd,
permanencyplan pp,
servicecase sc,
tb_placement tp,
intakeservicerequestactor isra,
person per
where
gdis.gapid = grd.gapid
and gdis.activeflag = 1
and grd.servicecaseid = pp.servicecaseid
and grd.permanencyplanid = pp.permanencyplanid
and pp.activeflag = 1
and pp.servicecaseid = sc.servicecaseid
and sc.activeflag = 1
and tp.case_id = sc.servicecasenumber::bigint
and tp.delete_sw = 'N'
and tp.approval_status_cd = '3047'
and isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
order by
gdis.updatedon desc
limit 1;

if (vs_scnd_grd_exts = 'YES') then
-- Child Second Guardian Attachment                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
 select
(
case
when (gdis.isguardiantwoattach = 'true') then 'YES'::varchar
else 'NO'::varchar
end ) into
vs_chd_sec_grd_attch
from
gapdisclosure gdis,
guardianship grd,
permanencyplan pp,
servicecase sc,
tb_placement tp,
intakeservicerequestactor isra,
person per
where
gdis.gapid = grd.gapid
and gdis.activeflag = 1
and grd.servicecaseid = pp.servicecaseid
and grd.permanencyplanid = pp.permanencyplanid
and pp.activeflag = 1
and pp.servicecaseid = sc.servicecaseid
and sc.activeflag = 1
and tp.case_id = sc.servicecasenumber::bigint
and tp.delete_sw = 'N'
and tp.approval_status_cd = '3047'
and isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
order by
gdis.updatedon desc
limit 1;
end if;
-- Age Appropriate Consult Place                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
 select
(
case
when (gdis.isconsultationchildage = 'true') then 'YES'::varchar
else 'NO'::varchar
end ) into
vs_age_appr_cnslt_pl
from
gapdisclosure gdis,
guardianship grd,
permanencyplan pp,
servicecase sc,
tb_placement tp,
intakeservicerequestactor isra,
person per
where
gdis.gapid = grd.gapid
and gdis.activeflag = 1
and grd.servicecaseid = pp.servicecaseid
and grd.permanencyplanid = pp.permanencyplanid
and pp.activeflag = 1
and pp.servicecaseid = sc.servicecaseid
and sc.activeflag = 1
and tp.case_id = sc.servicecasenumber::bigint
and tp.delete_sw = 'N'
and tp.approval_status_cd = '3047'
and isra.intakeservicerequestactorid = tp.intakeservicerequestactorid
and isra.activeflag = 1
and per.personid = isra.personid
and per.cjamspid::bigint = al_client_id
and per.activeflag = 1
order by
gdis.updatedon desc
limit 1;

insert
	into
		Temp_worksheet_safety_info select
			al_client_id,
			--              vs_ldss_home_aprvr,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
			--              vs_cpa_home_aprvr,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
 vs_fstr_hm_aprvr,
			vs_bg_chk_national_state,
			vd_bg_chk_national_state_dt,
			vs_bg_chk_child_abuse_maltreatment,
			vd_bg_chk_child_abuse_maltreatment_dt,
			vs_bg_chk_child_abuse_maltreatment_oos,
			vs_bg_chk_oos,
			vd_bg_chk_child_abuse_maltreatment_oos_dt,
			vn_pri_grd_no_of_hh_mmbrs,
			vs_pri_hh_bg_chk,
			vs_scnd_grd_exts,
			vs_sec_grd_lvng_with_pri_grd,
			vs_sec_bg_chk_national_state,
			vd_sec_bg_chk_national_state_dt,
			vs_sec_bg_chk_child_abuse_maltreatment,
			vd_sec_bg_chk_child_abuse_maltreatment_dt,
			vs_sec_bg_chk_child_abuse_maltreatment_oos,
			vs_sec_bg_chk_oos,
			vd_sec_bg_chk_child_abuse_maltreatment_oos_dt,
			vs_appr_prmncy_chld_rtrnd_hm,
			vs_appr_prmncy_chld_adptd,
			vs_pri_grd_cmmtmnt,
			vs_sec_grd_cmmtmnt,
			vs_chd_pri_grd_attch,
			vs_chd_sec_grd_attch,
			vs_age_appr_cnslt_pl;

return QUERY select
	*
from
	Temp_worksheet_safety_info;

drop
	table
		Temp_worksheet_safety_info;
end $function$
