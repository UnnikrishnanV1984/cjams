DROP FUNCTION IF EXISTS cjams.sp_fc_worksheet_court_info(al_client_id bigint, al_removal_id bigint, periodtype character varying, period_start_dt date, period_end_dt date);

CREATE OR REPLACE FUNCTION cjams.sp_fc_worksheet_court_info(al_client_id bigint, al_removal_id bigint, periodtype character varying, period_start_dt date, period_end_dt date)
 RETURNS TABLE(client_id bigint, removal_id integer, typeofcourthearing character varying, dateofcourthearing timestamp without time zone, ctwdecision character varying, dateoffindingctwdecision timestamp without time zone, courtorderdelayremoval character varying, courtorderdelaytimedays integer, reasonableeffortsmade character varying, reasonableeffortsnotnecessaryduetoemergentcircumstances character varying, dateofreasonableeffortscourthearing timestamp without time zone, fostercarepermanencyplan character varying, fostercarepermanencyplandesc character varying, isiveagencyresponsibleforplacementandcare character varying, magistrateorjudgename character varying, dateofnexthearing timestamp without time zone, dateofnexthearingresnbleff timestamp without time zone, issignedbyjudge character varying, dateagencylostlegalresponsibility timestamp without time zone, dateofjudicialfindingofrefpp timestamp without time zone, dateofsubsequentjudicialfindingofrefpp timestamp without time zone, dateofcurrentjudicialfindingofbestinterest timestamp without time zone, dateofsubsequentfindingofbestinterest timestamp without time zone)
 LANGUAGE plpgsql
AS $function$

DECLARE 
		vs_Procedure_nm 								VARCHAR(100) DEFAULT 'sp_fc_worksheet_court_info';
		vn_rmvl_id										INTEGER;
		vs_crt_hrng_typ									VARCHAR;
		vd_crt_hrng_dt									TIMESTAMP;
		vs_ctw_dcsn										VARCHAR(50);
		vd_ctw_dt										TIMESTAMP;
		vs_crt_ord_dly_rmvl								VARCHAR(50);
		vn_crt_ord_dly_tm_dys							INTEGER;
		vs_re_mde										VARCHAR(50);
		vs_re_emrgnt_crcmst								VARCHAR(50);
		vd_rsnbl_efrts_crt_hrng							TIMESTAMP;
		vs_fc_prmncy_pln								VARCHAR(50);
		vs_fc_prmncy_pln_desc							VARCHAR;
		vs_ive_agcy_rspbl_pl_cre						VARCHAR(50);
		vs_mgs_jdg_nm									VARCHAR(50);
		vd_nxt_hrng_dt									TIMESTAMP;
		vd_nxt_hrng_res_eff_dt							TIMESTAMP;
		vs_jdg_sgn										VARCHAR(50);
		vd_agnct_lst_lgl_cstdy_dt						TIMESTAMP;
		v_phyremovaldt  								TIMESTAMP;
		vd_removal_dt                                   TIMESTAMP;
		vd_removal_60									TIMESTAMP;
		courtorder										record;
		vd_jd_refpp										TIMESTAMP;
		vd_sub_jd_refpp									TIMESTAMP;
		vd_removal_type                                 VARCHAR(50);
		v_dt_ct_best_int								TIMESTAMP;
		v_dt_sub_best_int								TIMESTAMP;
		vs_ho_ct			 							INTEGER;
		vd_id_ctw_dt									UUID;
		v_id_ct_best_int								UUID;
		vd_id_jd_refpp									UUID;
				
	
 BEGIN	
CREATE TEMP TABLE IF NOT EXISTS
Temp_worksheet_court_info ( 
		client_id 													BIGINT,
		removal_id													INTEGER,
		typeOfcourthearing											VARCHAR,
		dateofcourthearing											TIMESTAMP,
		ctwdecision													VARCHAR(50),
		dateoffindingctwdecision									TIMESTAMP,
		courtorderdelayremoval										VARCHAR(50),
		courtorderdelaytimedays										INTEGER,
		reasonableeffortsmade										VARCHAR(50),
		reasonableEffortsnotnecessaryduetoemergentcircumstances		VARCHAR(50),
		dateofreasonableeffortscourthearing							TIMESTAMP,
		fostercarepermanencyplan									VARCHAR(50),
		fostercarepermanencyplandesc								VARCHAR,
		isiveagencyresponsibleforplacementandcare					VARCHAR(50),
		magistrateorjudgename										VARCHAR(50),
		dateofnexthearing											TIMESTAMP,
		dateofnexthearingresnbleff 									TIMESTAMP,
		issignedbyjudge												VARCHAR(50),
		dateagencylostlegalresponsibility							TIMESTAMP,
		dateofjudicialfindingofrefpp                                TIMESTAMP,
		dateofsubsequentjudicialfindingofrefpp                      TIMESTAMP,
		dateofcurrentjudicialfindingofbestinterest					TIMESTAMP,
		dateofsubsequentfindingofbestinterest						TIMESTAMP
	);
	
	vn_rmvl_id := al_removal_id::int;


SELECT isrcr.removaldate , isrcr.removaltypekey
INTO   vd_removal_dt , vd_removal_type
FROM   intakeservreqchildremoval isrcr, person per, intakeservicerequestactor isra 
WHERE  isrcr.removalid::bigint = al_removal_id AND isra.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1
	AND isra.activeflag = 1 AND isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD')
	AND per.personid = isra.personid AND per.cjamspid::BIGINT = al_client_id AND per.activeflag = 1 limit 1;

vd_removal_60 = vd_removal_dt + interval '60 days';
if (periodtype = 'I') 
then

select isrco.intakeservreqcourtorderid, isrco.courtorderdate , 'Y' , (CASE when (isrco.courtorderdelayremoval) then'Yes' else 'No' end), isrco.courtorderdelaytimeframe, isrch.judgename ,
	isrch.nexthearingdate, isrch.hearingdatetime 	
	into vd_id_ctw_dt, vd_ctw_dt , vs_ctw_dcsn, vs_crt_ord_dly_rmvl, vn_crt_ord_dly_tm_dys, vs_mgs_jdg_nm , vd_nxt_hrng_dt, vd_crt_hrng_dt
	FROM 	intakeservreqcourtorder isrco join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1 
	join intakeservicerequestactor isra on (isra.intakeserviceid = isrcr.intakeserviceid or isra.servicecaseid = isrcr.servicecaseid) and isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
	join person per on per.personid = isra.personid AND per.activeflag = 1	
	join intakeservreqcourtorderdetails iscod on iscod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid
	join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid
	WHERE 	isrco.activeflag = 1 AND isrco.courtorderdate between vd_removal_dt::date and vd_removal_60::date
		and isrcr.removalid::BIGINT = al_removal_id 
		AND isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD') AND isra.activeflag = 1
		AND per.cjamspid::BIGINT = al_client_id
		AND (iscod.checklisttypekey = 'COLANG' AND iscod.checklistid IN ('838f07f5-0c94-4f13-b5c0-658c4b9ad5bc') and iscod.isselected = 1 and iscod.activeflag = 1) -- Contrary to Welfare
		AND isrch.hearingstatustypekey = 'CONCULD' order by isrco.courtorderdate asc limit 1;	

select STRING_AGG(distinct ht.description, ',')	
	into vs_crt_hrng_typ
	FROM 	intakeservreqcourtorder isrco 
	join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid
	join hearingtype ht on isrch.hearingtype ? ht.hearingtypekey  AND ht.activeflag = 1
	WHERE 	isrco.activeflag = 1 AND isrco.intakeservreqcourtorderid = vd_id_ctw_dt	
		AND isrch.hearingstatustypekey = 'CONCULD' ;


select 'YES'
	into vs_ive_agcy_rspbl_pl_cre
	FROM 	intakeservreqcourtorder isrco join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1 
	join intakeservicerequestactor isra on (isra.intakeserviceid = isrcr.intakeserviceid or isra.servicecaseid = isrcr.servicecaseid) and isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
	join person per on per.personid = isra.personid AND per.activeflag = 1	
	join intakeservreqcohearingoutcome isrho on isrho.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid
	where isrco.activeflag = 1 AND isrco.courtorderdate between vd_removal_dt::date and vd_removal_60::date
		and isrcr.removalid::BIGINT = al_removal_id 
		AND isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD') AND isra.activeflag = 1
		AND per.cjamspid::BIGINT = al_client_id	
		and isrho.hearingoutcometypekey in ('COSSDDA', 'CDSSDHMH', 'CDSSDDADHMH', 'COMAGE', 'CONCOCOM', 'CONCOM', 'CONGUA', 'SHEGRA')
		order by isrco.courtorderdate asc limit 1; 
	
SELECT 
	'Y' AS reasonableeffortsmade,
	isrco.courtorderdate AS dateofreasonableeffortscourthearing,
	(case when (iscod.checklistid = 'e4c3f3a6-6756-4123-82a4-f676399e80ce') then 'Y' end) AS reasonableeffortsnotnecessaryduetoemergentcircumstances 
	into vs_re_mde , vd_rsnbl_efrts_crt_hrng, vs_re_emrgnt_crcmst
	FROM 	intakeservreqcourtorder isrco join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1 
	join intakeservicerequestactor isra on (isra.intakeserviceid = isrcr.intakeserviceid or isra.servicecaseid = isrcr.servicecaseid) and isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
	join person per on per.personid = isra.personid AND per.activeflag = 1	
	join intakeservreqcourtorderdetails iscod on iscod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid
	WHERE 	isrco.activeflag = 1 AND isrco.courtorderdate between vd_removal_dt::date and vd_removal_60::date
		and isrcr.removalid::BIGINT = al_removal_id 
		AND isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD') AND isra.activeflag = 1
		AND per.cjamspid::BIGINT = al_client_id
		AND (iscod.checklisttypekey = 'COLANG' AND iscod.checklistid IN ('f4365b4c-e0ad-422c-b76e-e6a05ec3320f', 'e4c3f3a6-6756-4123-82a4-f676399e80ce') AND iscod.isselected = 1 and iscod.activeflag = 1) -- Reasonable efforts were made
		order by isrco.courtorderdate asc;
	
select (case when (iscod.checklisttypekey = 'COPP' AND iscod.checklistid = '041def29-b981-4fd2-9c9c-5baafb37e253' and iscod.isselected = 1) then 'No' else 'Yes' end) AS judgesignflag
	into vs_jdg_sgn
	from intakeservreqcourtorderdetails iscod
	where iscod.intakeservreqcourtorderid = vd_id_ctw_dt
	AND (iscod.checklisttypekey = 'COPP' AND iscod.checklistid = '041def29-b981-4fd2-9c9c-5baafb37e253' and iscod.activeflag = 1); -- judge signed flag

select tj.date_agency_lost_legal_responsibility 
into vd_agnct_lst_lgl_cstdy_dt
from tb_foster_care_judicial tj
where tj.client_id = al_client_id
	  AND tj.removal_id = al_removal_id
	  AND tj.period_type = periodtype limit 1;

else

	if(rtrim(vd_removal_type) = 'JD')
	then	

	select isrco.intakeservreqcourtorderid ,isrco.courtorderdate ,
	isrch.nexthearingdate, 
	isrco.childpermanencyplankey, rtd.description as fosterpermanancyplan 		
	into vd_id_jd_refpp, vd_jd_refpp , vd_nxt_hrng_dt, vs_fc_prmncy_pln, vs_fc_prmncy_pln_desc
	FROM 	intakeservreqcourtorder isrco join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1 
	join intakeservicerequestactor isra on (isra.intakeserviceid = isrcr.intakeserviceid or isra.servicecaseid = isrcr.servicecaseid) and isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
	join person per on per.personid = isra.personid AND per.activeflag = 1	
	join intakeservreqcourtorderdetails iscod on iscod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid 
	join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid 	
	left join referencevalues rtd on rtd.ref_key=isrco.childpermanencyplankey and rtd.referencetypeid=137 and rtd.activeflag=1 
	WHERE 	isrco.activeflag = 1 AND isrco.courtorderdate between period_start_dt::date and period_end_dt::date
			and isrcr.removalid::BIGINT = al_removal_id 
			AND isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD') AND isra.activeflag = 1
			AND per.cjamspid::BIGINT = al_client_id	
		AND (iscod.checklisttypekey = 'COLANG' AND iscod.checklistid IN ('34993888-d849-4774-a5c0-6aa25a2b9a42') and iscod.isselected = 1 and iscod.activeflag = 1) -- REFPP
		AND isrch.hearingstatustypekey = 'CONCULD'order by isrco.courtorderdate desc limit 1;
	
	vd_sub_jd_refpp = ((date_trunc('month',vd_jd_refpp) + interval '1 month') - interval '1 day') + interval '1 year';		
	
	end if;

	if (rtrim(vd_removal_type) = 'TLV' OR rtrim(vd_removal_type) = 'CDVP' OR rtrim(vd_removal_type) = 'EHA')
	then	
	select isrco.intakeservreqcourtorderid, isrco.courtorderdate ,
	isrch.nexthearingdate,	isrco.childpermanencyplankey, rtd.description as fosterpermanancyplan 		
	into v_id_ct_best_int, v_dt_ct_best_int  , vd_nxt_hrng_dt, vs_fc_prmncy_pln, vs_fc_prmncy_pln_desc
	FROM 	intakeservreqcourtorder isrco join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1 
	join intakeservicerequestactor isra on (isra.intakeserviceid = isrcr.intakeserviceid or isra.servicecaseid = isrcr.servicecaseid) and isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid
	join person per on per.personid = isra.personid AND per.activeflag = 1	
	join intakeservreqcourtorderdetails iscod on iscod.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid 
	join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid
	left join referencevalues rtd on rtd.ref_key=isrco.childpermanencyplankey and rtd.referencetypeid=137 and rtd.activeflag=1 
	WHERE 	isrco.activeflag = 1 AND isrco.courtorderdate between period_start_dt::date and period_end_dt::date
			and isrcr.removalid::BIGINT = al_removal_id 
			AND isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD') AND isra.activeflag = 1
			AND per.cjamspid::BIGINT = al_client_id	
			AND (iscod.checklisttypekey = 'COLANG' AND iscod.checklistid IN ('54a42db9-aa34-4b79-bd59-33866e519bf1') and iscod.isselected = 1 and iscod.activeflag = 1) -- Best interest
			AND isrch.hearingstatustypekey = 'CONCULD' order by isrco.courtorderdate desc limit 1;
	
	
	v_dt_sub_best_int = ((date_trunc('month',v_dt_ct_best_int) + interval '1 month') - interval '1 day') + interval '1 year';
		
	end if;

	select isrco.intakeservreqcourtorderid , 'YES', isrch.judgename ,isrch.hearingdatetime 
		into vd_id_ctw_dt, vs_ive_agcy_rspbl_pl_cre, vs_mgs_jdg_nm, vd_crt_hrng_dt
		FROM intakeservreqcourtorder isrco join intakeservreqchildremoval isrcr on isrco.servicecaseid = isrcr.servicecaseid AND isrcr.activeflag = 1 
		join intakeservreqcohearingoutcome isrho on isrho.intakeservreqcourtorderid = isrco.intakeservreqcourtorderid
		join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid 
		join intakeservicerequestactor isra on (isra.intakeserviceid = isrcr.intakeserviceid or isra.servicecaseid = isrcr.servicecaseid) and isra.intakeservicerequestactorid = isrco.intakeservicerequestactorid 
		join person per on per.personid = isra.personid and per.personid = isra.personid  and per.activeflag = 1
		where isrco.activeflag = 1 AND isrco.courtorderdate between period_start_dt::date and period_end_dt::date
			and isrcr.removalid::BIGINT = al_removal_id 
			AND isra.intakeservicerequestpersontypekey in ('CHILD', 'OTHERCHILD') AND isra.activeflag = 1
			AND per.cjamspid::BIGINT = al_client_id	
			and isrho.hearingoutcometypekey in ('COSSDDA', 'CDSSDHMH', 'CDSSDDADHMH', 'COMAGE', 'CONCOCOM', 'CONCOM', 'CONGUA', 'SHEGRA')
			AND isrch.hearingstatustypekey = 'CONCULD'
			order by isrco.courtorderdate desc limit 1; 


	select STRING_AGG(distinct ht.description, ',')
		into vs_crt_hrng_typ
		FROM intakeservreqcourtorder isrco 
		join intakeservicerequestcourthearing isrch on isrch.intakeservicerequestcourthearingid = isrco.intakeservicerequesthearingid 
		join hearingtype ht on isrch.hearingtype ? ht.hearingtypekey  AND ht.activeflag = 1
		where isrco.activeflag = 1 AND isrco.intakeservreqcourtorderid = vd_id_ctw_dt			
			AND isrch.hearingstatustypekey = 'CONCULD';
		 		
	
	select (case when (iscod.checklisttypekey = 'COPP' AND iscod.checklistid = '041def29-b981-4fd2-9c9c-5baafb37e253' and iscod.isselected = 1) then 'No' else 'Yes' end) AS judgesignflag
		into vs_jdg_sgn
		from intakeservreqcourtorderdetails iscod
		where iscod.intakeservreqcourtorderid = vd_id_ctw_dt
		AND (iscod.checklisttypekey = 'COPP' AND iscod.checklistid = '041def29-b981-4fd2-9c9c-5baafb37e253' and iscod.activeflag = 1); -- judge signed flag
			

select tj.date_agency_lost_legal_responsibility 
into vd_agnct_lst_lgl_cstdy_dt
from tb_foster_care_judicial tj
where tj.client_id = al_client_id
	  AND tj.removal_id = al_removal_id
	  AND tj.period_type = periodtype limit 1;


end if;


INSERT INTO Temp_worksheet_court_info
SELECT 
		al_client_id,
		vn_rmvl_id,
		vs_crt_hrng_typ,
		vd_crt_hrng_dt,
		(select case when vs_ctw_dcsn is null then 'N' else vs_ctw_dcsn end),
		vd_ctw_dt,
		vs_crt_ord_dly_rmvl,
		vn_crt_ord_dly_tm_dys,
		(select case when vs_re_mde is null then 'N' else vs_re_mde end),
		(select case when vs_re_emrgnt_crcmst is null then 'N' else vs_re_emrgnt_crcmst end),
		vd_rsnbl_efrts_crt_hrng,
		vs_fc_prmncy_pln,
		vs_fc_prmncy_pln_desc,
		(select case when vs_ive_agcy_rspbl_pl_cre is null then 'NO' else vs_ive_agcy_rspbl_pl_cre end),
		vs_mgs_jdg_nm,
		vd_nxt_hrng_dt,
		vd_nxt_hrng_res_eff_dt,
		(select case when (vs_jdg_sgn is null and vd_id_ctw_dt is not null) then 'Yes' else vs_jdg_sgn end),
		vd_agnct_lst_lgl_cstdy_dt,
		vd_jd_refpp,
		vd_sub_jd_refpp,
		v_dt_ct_best_int,
		v_dt_sub_best_int;
   	
RETURN QUERY SELECT *
               FROM Temp_worksheet_court_info;
              
DROP TABLE Temp_worksheet_court_info;

   END
    $function$
