DROP FUNCTION if exists getiveassignment(character varying,character varying,character varying) ;
CREATE OR REPLACE FUNCTION cjams.getiveassignment(v_clientid character varying, v_removalid character varying, v_module character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

DECLARE

v_secuserid text;
 
BEGIN
 
    if(v_module = 'fostercare') then
                select r.tosecurityusersid into v_secuserid
                FROM tb_client_eligibility tce
                INNER JOIN person p on p.cjamspid = tce.client_id AND p.activeflag=1 
                INNER JOIN intakeservreqchildremoval isrcr ON isrcr.removalid = tce.removal_id AND isrcr.activeflag=1
                INNER JOIN placement pl on (( pl.intakeservreqchildremovalid = isrcr.intakeservreqchildremovalid and pl.placementtypekey = 'PRPL') or (pl.placementtypekey = 'LA' and pl.personid = p.personid ))
                inner join routing r on r.activeflag=1 AND r.eventcode='PLTR' and r.toroleid in ('IVESP','IVEEA') AND r.routingstatustypeid::text = '70' and r.objectid::varchar =  pl.placementid::varchar
                WHERE tce.eligibility_type_cd = '2931' AND tce.delete_sw = 'N' AND pl.activeflag=1                
                AND p.cjamspid::character varying = v_clientid and isrcr.removalid::varchar = v_removalid order by r.insertedon desc; 
       
    elsif (v_module = 'adoption') then
                select r.tosecurityusersid  into v_secuserid                
                FROM tb_client_eligibility tce 
                INNER JOIN person p ON p.cjamspid=tce.client_id AND p.activeflag=1 
                INNER JOIN adoptionplanning apl on apl.alternateid = tce.adoption_id and apl.activeflag = 1
                INNER JOIN adoptionbreakthelink adbl on apl.adoptionplanningid = adbl.adoptionplanningid and adbl.activeflag = 1
                LEFT JOIN intakeservreqchildremoval isrcr on isrcr.intakeservicerequestactorid = apl.intakeservicerequestactorid and (isrcr.removalexitreason is null or (trim(isrcr.removalexitreason)::varchar in ('','ADPFIN','OTHER'))) and isrcr.activeflag = 1
                inner join routing r on r.activeflag=1 AND r.eventcode='ABLR' and r.toroleid in ('IVESP','IVEEA') AND r.routingstatustypeid::text = '67' and r.objectid::varchar = adbl.adoptionbreakthelinkid::varchar
                WHERE tce.eligibility_type_cd = '2934' AND tce.delete_sw = 'N' AND p.cjamspid::character varying = v_clientid
                AND case when v_removalid is not null then isrcr.removalid::varchar = v_removalid else true end order by r.insertedon desc; 
    elsif (v_module = 'gap') then
            select r.tosecurityusersid  into v_secuserid  
            from  tb_client_eligibility tce   
            INNER JOIN person p ON p.cjamspid=tce.client_id AND p.activeflag=1 
            INNER JOIN guardianship g on g.alternateid = tce.guardian_subsidy_id
            INNER JOIN gapagreement ga on ga.gapid = g.gapid AND ga.activeflag = 1
            INNER JOIN routing r on r.activeflag=1 AND r.eventcode='GAAR' and r.toroleid in ('IVESP','IVEEA') AND r.routingstatustypeid::text = '73' and r.objectid::varchar = ga.gapagreementid::varchar     
            WHERE tce.eligibility_type_cd = '2935' AND tce.delete_sw = 'N' AND p.cjamspid::character varying = v_clientid order by r.insertedon desc; 
    end if;

    return v_secuserid;
END;

$function$
;
