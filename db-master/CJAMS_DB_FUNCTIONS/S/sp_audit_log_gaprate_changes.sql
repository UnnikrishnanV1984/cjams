CREATE OR REPLACE FUNCTION cjams.sp_audit_log_gaprate_changes(v_screenid bigint, v_lipagenumber bigint, v_lipagesize bigint)
 RETURNS json
 LANGUAGE plpgsql
AS $function$

DECLARE  

	v_pagenumber int;
	v_pageoffset int;
    gaprateLog json;
BEGIN 
v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

select json_agg(x) into gaprateLog from 
(
select count(1) over() as total_count,a.* from
(
--SELECT GR.alternateid AS REVISION_ID,   
--	GR.transactiondate TRANSACTION_DT,   
--	coalesce('1011',null) AS CHANGE_TYPE_CD,
--	F_PDESC('1011',10041) AS CHANGE_TYPE,
--	GR.providerid PROVIDER_ID,   
--	GR.ratestartdate ENTRY_DT,   
--	GR.rateenddate EXIT_DT,   
--	GR.paymentamt PAYMENT_AMT,   
--	F_ENAME('2956', UPR.cjamspid) AS REQUESTED_BY ,
--	R.insertedon AS REQUESTED_DATE,
--	F_ENAME('2956', UPA.cjamspid) AS APPROVED_BY,
--	GR.approvaldate AS APPROVAL_DT,
--	GR.gaprateid GAP_RATE_ID,   
--	GR.guardiansubsidyid GUARDIAN_SUBSIDY_ID
--FROM gapratesrevision GR,
--	gapagreementrate GA,
--	guardianship GAP,
--	routing R,
--	userprofile UPR,
--    userprofile UPA 
--WHERE GR.gaprateid = GA.gapagreementrateid
--	and R.objectid = GA.gapagreementrateid::character varying 
--	and GAP.gapid = GR.guardiansubsidyid
--	and R.routingstatustypeid = 16 AND R.eventcode::text = 'GARR'::text AND R.activeflag = 1
--	AND GAP.alternateid = v_screenid
--	AND COALESCE(GR.approvalstatustypekey, '') = '3047' 	
--	--AND COALESCE(GR.isoriginal,false) <> true
--	AND GR.activeflag =  1
--	and UPR.securityusersid=R.tosecurityusersid
--  	and UPA.securityusersid=R.fromsecurityusersid
--	--AND SA.DELETE_SW = 'N'
--ORDER BY 2 desc


SELECT 0 AS REVISION_ID,   
	GA.insertedon TRANSACTION_DT,   
	coalesce('1011',null) AS CHANGE_TYPE_CD,
	F_PDESC('1011',10041) AS CHANGE_TYPE,
	GA.provider_id PROVIDER_ID,   
	GA.startdate ENTRY_DT,   
	GA.enddate EXIT_DT,   
	GA.paymentamout PAYMENT_AMT,   
--	F_ENAME('2956',0) AS REQUESTED_BY ,
--	null AS REQUESTED_DATE,
--	F_ENAME('2956',0) AS APPROVED_BY,
	--GA.rateapprovaldate AS APPROVAL_DT,
	GA.alternateid GAP_RATE_ID,   
	GAP.alternateid GUARDIAN_SUBSIDY_ID,
	GR.approvaldate AS APPROVAL_DT,
	F_ENAME('2956', UPR.cjamspid) AS REQUESTED_BY ,
	R.insertedon AS REQUESTED_DATE,
	F_ENAME('2956', UPA.cjamspid) AS APPROVED_BY
	
FROM --gapratesrevision GR,
	
	gapagreement GAA,
	guardianship GAP,
	gapagreementrate GA
	LEFT JOIN gapratesrevision GR ON GR.gaprateid = GA.gapagreementrateid AND COALESCE(GR.approvalstatustypekey, '') = '3047' AND GR.activeflag =  1
	left join routing R on R.objectid = GA.gapagreementrateid::character varying and R.routingstatustypeid = 16 AND R.eventcode::text = 'GARR'::text AND R.activeflag = 1
	left join userprofile UPR on  UPR.securityusersid=R.tosecurityusersid
	left join userprofile UPA on  UPA.securityusersid=R.fromsecurityusersid

--	routing R,
--	userprofile UPR,
--    userprofile UPA 
WHERE GA.gapagreementid = GAA.gapagreementid
--	and R.objectid = GA.gapagreementrateid::character varying 
	and GAP.gapid = GAA.gapid
	--and R.routingstatustypeid = 16 AND R.eventcode::text = 'GARR'::text AND R.activeflag = 1
	AND GA.alternateid = v_screenid
	--AND COALESCE(GR.approvalstatustypekey, '') = '3047' 	
	--AND COALESCE(GR.isoriginal,false) <> true
--	AND GR.activeflag =  1
--	and UPR.securityusersid=R.tosecurityusersid
--  	and UPA.securityusersid=R.fromsecurityusersid
	--AND SA.DELETE_SW = 'N'
ORDER BY 2 desc


) a
group by 
	a.REVISION_ID,   
	a.TRANSACTION_DT,   
	a.CHANGE_TYPE_CD,
	a.CHANGE_TYPE,
	a.PROVIDER_ID,   
	a.PAYMENT_AMT,
	a.ENTRY_DT,   
	a.EXIT_DT,   
	a.REQUESTED_BY ,
	a.REQUESTED_DATE,
	a.APPROVED_BY,
	a.APPROVAL_DT,
	a.GAP_RATE_ID,   
	a.GUARDIAN_SUBSIDY_ID
	--limit v_lipagesize offset v_pageoffset
) x;

return gaprateLog; 

END;
$function$
;
