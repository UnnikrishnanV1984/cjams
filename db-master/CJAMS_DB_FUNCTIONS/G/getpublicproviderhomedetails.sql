

drop FUNCTION IF EXISTS getpublicproviderhomedetails (character varying);

CREATE OR REPLACE FUNCTION getpublicproviderhomedetails(v_providerid character varying)
 RETURNS TABLE(providerapprovetypeconfigid uuid, providerid character varying, referralid character varying, applicantid character varying, comments text, communication character varying, requested_date timestamp without time zone, description character varying, insertedon timestamp without time zone, createdby character varying, application_status character varying, updatedon timestamp without time zone)
 LANGUAGE plpgsql
AS $function$

BEGIN

RETURN Query
	
SELECT  
    patc.providerapprovetypeconfigid,patc.providerid,patc.referralid,patc.applicantid,
    patc."comments",patc.communication,patc.requested_date,rv.description,
    patc.insertedon,
    (SELECT displayname  FROM userprofile up WHERE up.securityusersid = patc.insertedby limit 1) as createdby,
    tbpa.application_status,
    (select r.insertedon from routing r where r.objectid=patc.applicantid and r.activeflag=1 limit 1) as updatedon
	FROM providerapprovetypeconfig patc
	INNER JOIN referencevalues rv ON rv.ref_key = patc.approval_type 
	inner join tb_public_provider_applicant tbpa on tbpa.applicant_id=patc.applicantid	
	WHERE patc.providerid = v_providerid AND patc.activeflag =1;
    
END;

$function$;

