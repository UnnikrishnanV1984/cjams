DROP FUNCTION  IF EXISTS cjams.updateCWUserDetails(v_email character varying,v_teamname character varying, v_teamcode character varying, v_supervisoremailid character varying, v_positioncode character varying, v_positiontitle character varying);
CREATE OR REPLACE FUNCTION cjams.updateCWUserDetails(v_email character varying,v_teamname character varying, v_teamcode character varying, v_supervisoremailid character varying, v_positioncode character varying, v_positiontitle character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$

declare  
v_teammemberid uuid ;
v_securityusersid character varying(100); 
v_teamid uuid ; 
v_message character varying(500);
v_supervisorsecurityusersid character varying(100);

BEGIN
	v_message:= 'User details updated Successfully';
 
		IF NOT EXISTS (SELECT * FROM userprofile WHERE  lower(email)=lower(v_email) and activeflag = 1 and teamtypekey = 'CW') THEN
			 v_message:= 'User does not exist';
		ELSE 

			Select securityusersid into v_securityusersid from userprofile where lower(email) = lower(v_email) and teamtypekey = 'CW' AND activeflag =1;

            SELECT teammemberid  INTO v_teammemberid FROM teammemberassignment WHERE securityusersid = v_securityusersid AND activeflag =1;

            IF (coalesce(v_supervisoremailid::character varying,''))!='' THEN 

                Select securityusersid into v_supervisorsecurityusersid from userprofile where lower(email) = lower(v_supervisoremailid) AND activeflag =1;

                IF (coalesce(v_supervisorsecurityusersid::character varying,''))!='' THEN            
					Update userprofile set supervisorid = v_supervisorsecurityusersid, updatedon = now(), updatedby = 'ADMIN'  where  securityusersid = v_securityusersid AND activeflag =1;
					v_message:= v_message || ';User supervisor email updated';
                ELSE
                    v_message:= v_message || ';Supervisor does not exist';
                END IF;

			END IF;

			IF (coalesce(v_positioncode::character varying,''))!='' THEN 
				UPDATE teammember SET positioncode=v_positioncode, updatedon = now(), updatedby = 'ADMIN'  WHERE teammemberid =v_teammemberid AND activeflag =1;
				v_message:= v_message || ';User position code updated';
			
			END IF; 
			IF (coalesce(v_positiontitle::character varying,''))!='' THEN 
				UPDATE teammember SET description=v_positiontitle,updatedon = now(), updatedby = 'ADMIN'  WHERE teammemberid =v_teammemberid AND activeflag =1;
                v_message:= v_message || ';User position title updated';
			END IF;			
			
			IF (coalesce(v_teamname::character varying,''))!='' THEN					
				Select teamid into v_teamid from team WHERE lower(teamname)=lower(v_teamname);
				IF (coalesce(v_teamid::character varying,''))!='' THEN	
					UPDATE teammember SET teamid=v_teamid,updatedon = now(), updatedby = 'ADMIN'  WHERE teammemberid =v_teammemberid AND activeflag =1;
					v_message:= v_message || ';User team name updated';
				ELSE
					v_message:= v_message || ';User team name does not exist';
				END IF;						
			END IF;

            IF (coalesce(v_teamcode::character varying,''))!='' THEN	
				Select teamid into v_teamid from team where lower(teamnumber) = lower(v_teamcode);
				IF (coalesce(v_teamid::character varying,''))!='' THEN	
					UPDATE teammember SET teamid=v_teamid,updatedon = now(), updatedby = 'ADMIN'  WHERE teammemberid =v_teammemberid AND activeflag =1;
					v_message:= v_message || ';User team code updated';	
				ELSE
					v_message:= v_message || ';User team code does not exist';
				END IF;						
			END IF;
					
		END IF;
	return v_message;
 END  ;
  
$function$
;