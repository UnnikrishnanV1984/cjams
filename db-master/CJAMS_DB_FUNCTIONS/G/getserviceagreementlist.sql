DROP FUNCTION IF EXISTS cjams.getserviceagreementlist(_page integer, _limit integer, v_caseid character varying, sortorder character varying, sortcolumn character varying);

CREATE OR REPLACE FUNCTION cjams.getserviceagreementlist(_page integer, _limit integer, v_caseid character varying, sortorder character varying, sortcolumn character varying)
 RETURNS TABLE(
	totalcount bigint, 
	agreementid uuid,
	caseid character varying, 
	agreementdate timestamp without time zone, 
	signatureobtflag integer, 
	approvalstatustypekey character varying, 
	approvaldate timestamp without time zone, 
	attentiontx text,
	insertedby character varying, 
	insertedon timestamp without time zone, 
	updatedby character varying,
	updatedon timestamp without time zone, 
	activeflag integer, 
	referralid character varying, 
	old_id character varying, 
	staffid character varying, 
	staffname character varying, 
	supervisorid character varying, 
	associateid character varying, 
	serviceagreementlist jsonb)
 LANGUAGE plpgsql
AS $function$

DECLARE 
                   
v_offset    integer;

BEGIN
v_offset  :=  (_page  -  1)  *  _limit;  

return Query select count(1) OVER() totalcount, sa.agreementid, sa.caseid, sa.agreementdate, sa.signatureobtflag, sa.approvalstatustypekey, 
		sa.approvaldate, sa.attentiontx, sa.insertedby, sa.insertedon, sa.updatedby, sa.updatedon,
		sa.activeflag, sa.referralid, sa.old_id, 
		sa.staffid::character varying, 
		(select fullname from userprofile where securityusersid = sa.staffid limit 1),
		sa.supervisorid::character varying, 
		(select sal.associateid from serviceagreementlist sal where sal.agreementid = sa.agreementid and sal.activeflag =1 limit 1),
	(SELECT Json_agg(list) FROM 
	(select sl.activeflag, sl.agreementid, sl.collateralid, sl.personid, sl.signagreementflag, sl.signeddate 
	from serviceagreementlist sl
	where sl.agreementid = sa.agreementid) list) :: jsonb AS serviceagreementlist
	from serviceagreement sa
	where sa.caseid =v_caseid

    order by (
				CASE sortorder
					WHEN 'asc'
					THEN
                         CASE sortcolumn
                         	WHEN 'approvalstatustypekey' THEN cast(sa.approvalstatustypekey  as character varying)
                         	WHEN 'approvaldate' THEN cast(sa.approvaldate  as character varying)
             		ELSE
                  		 cast(sa.agreementdate  as character varying)
             		END
             	END) ASC NULLS LAST,
                (CASE sortorder
                  	WHEN 'desc'
					THEN
                         CASE sortcolumn
                         	WHEN 'approvalstatustypekey' THEN cast(sa.approvalstatustypekey  as character varying)
                         	WHEN 'approvaldate' THEN cast(sa.approvaldate  as character varying)
             		ELSE
                  		 cast(sa.agreementdate  as character varying)
             		END
                   END) DESC NULLS LAST

limit _limit offset v_offset;
end;

$function$;
