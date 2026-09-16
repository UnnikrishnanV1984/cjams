DROP FUNCTION IF EXISTS getintakeroutingdetails(character varying) ;

CREATE OR REPLACE FUNCTION cjams.getintakeroutingdetails(v_intakenumber character varying)
 RETURNS TABLE(routinginfo json)
 LANGUAGE plpgsql
AS $function$

declare

Begin
      
 return query

				SELECT 
        	  ( 
                 SELECT Json_agg(e) AS routinginfo 
                 FROM   ( 
                                   SELECT     up.fullname      AS fromusername, 
                                              upto.fullname    AS tousername, 
                                              rt.roletypename  AS fromrole, 
                                              rt1.roletypename AS torole, 
                                              CASE r.routingstatustypeid 
                                                         WHEN 4 THEN 'Assigned' 
                                                         ELSE rst.routingstatustypekey 
                                              END             routingstatustypekey, 
                                              r.insertedon AS routedon , 
                                              up.title, 
                                              ( 
                                                         SELECT     upa.address 
                                                         FROM       userprofileaddress upa 
                                                         INNER JOIN userprofileaddresstype upat  ON  upa.userprofileaddresstypekey=upat.userprofileaddresstypekey
                                                         WHERE      upa.userprofileaddresstypekey='P'
                                                         AND        upa.activeflag=1 
                                                         AND        upa.securityusersid=up.securityusersid limit 1 ),
                                              ( 
                                                         SELECT     uppn.phonenumber 
                                                         FROM       userprofilephonenumber uppn 
                                                         INNER JOIN userprofilephonetype uppt  ON  uppn.userprofiletypekey=uppt.userprofiletypekey
                                                         WHERE      uppn.userprofiletypekey='office'
                                                         AND        uppn.activeflag=1 
                                                         AND        uppn.securityusersid=up.securityusersid limit 1 ),
                                              CASE r.objectid 
                                                         WHEN ids.intakenumber::character VARYING THEN true
                                                         WHEN isr.intakeserviceid::character VARYING THEN
                                                            CASE r.routingstatustypeid 
                                                                WHEN 4 THEN true
                                                                ELSE false
                                                                END
                                                         ELSE false
                                              END             isintake
                                   FROM       routing r 
                                   INNER JOIN routingstatustype rst ON rst.sequencenumber = r.routingstatustypeid 
                                   INNER JOIN userprofile up ON up.securityusersid = r.fromsecurityusersid 
                                   INNER JOIN userprofile upto ON upto.securityusersid = r.tosecurityusersid 
                                   INNER JOIN 
                                              ( 
                                                         SELECT     rt.*, 
                                                                    rtt.roletypename 
                                                         FROM       role rt 
                                                         INNER JOIN roletype rtt ON rtt.shortname = rt.NAME 
                                               ) rt  ON  r.fromroleid = rt.roletypekey 
                                   INNER JOIN 
                                              ( 
                                                         SELECT     rt.*, 
                                                                    rtt.roletypename 
                                                         FROM       role rt 
                                                         INNER JOIN roletype rtt 
                                                         ON         rtt.shortname = rt.NAME 
                                               ) rt1 ON  r.toroleid = rt1.roletypekey 
                                   WHERE      r.objectid IN (ids.intakenumber::character VARYING)     
                                            AND r.insertedon::date >= ids.insertedon::date
                                   ORDER BY   r.insertedon ASC )e)::json 
	FROM      intakedastatus ids 
	LEFT JOIN intakeservicerequest isr ON  isr.intakenumber = ids.intakenumber 
	LEFT JOIN servicecase sc ON  sc.servicecaseid = isr.servicecaseid 
	WHERE     ids.intakenumber = v_intakenumber
	ORDER BY  ids.insertedon DESC limit 1;
	 	 	   
end;

$function$
;
