DROP FUNCTION IF EXISTS cjams.listproviderinfo(p_providerid character varying);
CREATE OR REPLACE FUNCTION cjams.listproviderinfo(
	p_providerid character varying)
    RETURNS json
    LANGUAGE 'plpgsql'

    COST 100
    VOLATILE 
AS $BODY$

DECLARE

v_providerdata json;

BEGIN   

select json_agg(a) from ( 

SELECT *, pp.ssnno FROM cjams.tb_provider p
 join cjams.providerinfoconfig pc on p.provider_id ::character varying=pc.providerid AND pc.activeflag =1
 INNER JOIN intakeservicerequestactor isra ON isra.intakenumber = p.provider_id ::character varying AND isra.activeflag =1
 INNER JOIN person pp ON PP.personid = isra.personid AND pp.activeflag =1
where pc.providerid=p_providerid AND p.delete_sw = 'N'
) a INTO v_providerdata;



RETURN v_providerdata;	

END;

$BODY$;

ALTER FUNCTION cjams.listproviderinfo(character varying)
    OWNER TO welfareadmin;
