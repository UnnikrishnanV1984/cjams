-- FUNCTION: cjams.sp_audit_log_adoptionrate_changes(bigint, bigint, bigint)

DROP FUNCTION IF EXISTS cjams.sp_audit_log_adoptionrate_changes(bigint, bigint, bigint);

CREATE OR REPLACE FUNCTION cjams.sp_audit_log_adoptionrate_changes(
	v_screenid bigint,
	v_lipagenumber bigint,
	v_lipagesize bigint)
    RETURNS json
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

DECLARE  

	v_pagenumber int;
	v_pageoffset int;
    adoptionrateLog json;
BEGIN 
v_pagenumber := v_liPageNumber - 1;
v_pageoffset := v_pagenumber * v_liPageSize;

select json_agg(x) into adoptionrateLog from 
(
select count(1) over() as total_count,a.* from
(
--SELECT AR.alternateid AS REVISION_ID,   
--	AR.transactiondate TRANSACTION_DT,   
--	coalesce('1013',null) AS CHANGE_TYPE_CD,
--	F_PDESC('1013',10041) AS CHANGE_TYPE,
--	AR.providerid PROVIDER_ID,   
--	AR.agreementstartdate ENTRY_DT,   
--	AR.agreementenddate EXIT_DT,   
--	AR.paymentamt PAYMENT_AMT,   
--	F_ENAME('2956', UPR.cjamspid) AS REQUESTED_BY ,
--	R.insertedon AS REQUESTED_DATE,
--	F_ENAME('2956', UPA.cjamspid) AS APPROVED_BY,
--	AR.approvaldate AS APPROVAL_DT,
--	AR.adoptionagreementid SUBSIDY_AGREEMENT_ID,   
--	ACD.adoptioncaseid ADOPTION_ID
--FROM adoptioncaserevision AR,
--	adoptioncaseagreementrate ACA,
--	adoptioncaseagreement ACAA,
--	adoptioncase ACD,
--	routing R,
--	userprofile UPR,
--    userprofile UPA 
--WHERE  AR.agreementrateid = ACA.adoptionagreementrateid
--	 and R.objectid = ACA.adoptionagreementrateid::character varying 
--	and R.routingstatustypeid = 16 AND R.eventcode::text = 'AARR'::text AND R.activeflag = 1
--	and UPR.securityusersid=R.tosecurityusersid
--  	and UPA.securityusersid=R.fromsecurityusersid
--	and ACA.adoptionagreementid = ACAA.adoptionagreementid
--	and ACAA.adoptioncaseid =  ACD.adoptioncaseid
--	AND ACD.alternateid = v_screenid
--	AND COALESCE(AR.approvalstatustypekey, '') = '3047' 	
--	--AND COALESCE(AR.ORIGINAL_SW,'') <> 'Y'
----	AND SA.APPROVAL_NATURE_CD = '7064'	
--	--AND AR.DELETE_SW = 'N'
----	AND SA.DELETE_SW = 'N'
--ORDER BY 2 desc

SELECT  null AS REVISION_ID,   
	ACA.transactiondate TRANSACTION_DT,   
	coalesce('1013',null) AS CHANGE_TYPE_CD,
	F_PDESC('1013',10041) AS CHANGE_TYPE,
	ACA.provider_id PROVIDER_ID,   
	ACA.startdate ENTRY_DT,   
	ACA.enddate EXIT_DT,   
	ACA.paymentamout PAYMENT_AMT,   
	F_ENAME('2956', UPR.cjamspid) AS REQUESTED_BY ,
	R.insertedon AS REQUESTED_DATE,
	F_ENAME('2956', UPA.cjamspid) AS APPROVED_BY,
	AR.approvaldate AS APPROVAL_DT,
	ACA.adoptionagreementid SUBSIDY_AGREEMENT_ID,   
	ACD.alternateid ADOPTION_ID
FROM --adoptioncaserevision AR,
	adoptioncaseagreement ACAA,
	adoptioncase ACD,
	adoptioncaseagreementrate ACA
	LEFT JOIN adoptioncaserevision AR ON AR.agreementrateid = ACA.adoptionagreementrateid AND COALESCE(AR.approvalstatustypekey, '') = '3047' and AR.activeflag =  1
	left join routing R on  R.objectid = ACA.adoptionagreementrateid::character varying and R.routingstatustypeid = 16 AND R.eventcode::text = 'AARR'::text AND R.activeflag = 1
	left join userprofile UPR on  UPR.securityusersid=R.tosecurityusersid
	left join userprofile UPA on  UPA.securityusersid=R.fromsecurityusersid
--	routing R,
--	userprofile UPR,
--    userprofile UPA 
WHERE -- AR.agreementrateid = ACA.adoptionagreementrateid
	-- and R.objectid = ACA.adoptionagreementrateid::character varying 
	--and R.routingstatustypeid = 16 AND R.eventcode::text = 'AARR'::text AND R.activeflag = 1
	--and UPR.securityusersid=R.tosecurityusersid
  	--and UPA.securityusersid=R.fromsecurityusersid
	 ACA.adoptionagreementid = ACAA.adoptionagreementid
	and ACAA.adoptioncaseid =  ACD.adoptioncaseid
	--AND ACA.alternateid = v_screenid
	AND AR.alternateid = v_screenid
	--AND COALESCE(AR.approvalstatustypekey, '') = '3047' 	
--	--AND COALESCE(AR.ORIGINAL_SW,'') <> 'Y'
----	AND SA.APPROVAL_NATURE_CD = '7064'	
--	--AND AR.DELETE_SW = 'N'
----	AND SA.DELETE_SW = 'N'
ORDER BY 2 desc


) a
group by 
	 REVISION_ID,   
	TRANSACTION_DT,   
	CHANGE_TYPE_CD,
	CHANGE_TYPE,
	PROVIDER_ID,   
	a.ENTRY_DT,   
	a.EXIT_DT,
	PAYMENT_AMT,   
	REQUESTED_BY ,
	REQUESTED_DATE,
	APPROVED_BY,
	APPROVAL_DT,
	SUBSIDY_AGREEMENT_ID,   
	ADOPTION_ID
	--limit v_lipagesize offset v_pageoffset
) x;

return adoptionrateLog; 

END;
$BODY$;


