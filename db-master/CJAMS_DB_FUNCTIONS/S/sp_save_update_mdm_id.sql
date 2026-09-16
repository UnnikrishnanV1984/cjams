DROP FUNCTION IF EXISTS cjams.sp_save_update_mdm_id(uuid, character varying, character varying, boolean, character varying);
CREATE OR REPLACE FUNCTION cjams.sp_save_update_mdm_id(person_id uuid, mdm_id character varying, insertedby character varying, newflag boolean DEFAULT false, returnstatus character varying DEFAULT NULL::character varying)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$     

-------------------------------------------------------------------------------------------------------
-- 11/04/2022 - Vigneshwar Kumar - CIDM-6014 - Persons with missing MDM ID
-- 9/19/2023 - Manasa Kasula - CIDM-7949 - MDM update changes
-------------------------------------------------------------------------------------------------------

 DECLARE                                                                                                                                                                                         
        vs_person_id                                                            uuid;                                                                                                           
        vs_mdm_id                                                               VARCHAR(100);                                   
        vs_insertedby                                                           VARCHAR(100);                                                                                                   
        mdm_id_count                                                            INT;                                                                                                           
        response                                                                VARCHAR(50); 
        mdm_id_exists_count                                                     INT;
        vs_existing_personid                                                    uuid; 
        v_actorid                                                               uuid;
        vs_newflag                                                              boolean; 
        v_existingcisid                                                         VARCHAR;    
        v_existingmdmid                                                         VARCHAR;                                                                          
  BEGIN                                                                                                                                                                                          
        vs_person_id            := person_id;                                                                                                                                                       
        vs_mdm_id               := mdm_id;                                                                                                                                                          
        vs_insertedby           := insertedby;                                                                                                                                                      
        response                := 'sucess';                                                                                                                                                        
        mdm_id_count            := 0; 
        mdm_id_exists_count     := 0;
        vs_newflag              := newflag;

-- Cisclient id changes

select cisclientid into v_existingcisid from person where personid = vs_person_id;

select pi.personidentifiervalue into v_existingmdmid from personidentifier pi 
where pi.personid = vs_person_id and pi.activeflag = 1 and pi.personidentifiertypekey = 'MDM_ID'; 

 -- checking to see if mdm id exists -- 
 IF(vs_mdm_id IS NOT NULL) THEN 

       -- select COUNT(pi.personidentifiervalue), pi.personid into mdm_id_exists_count, vs_existing_personid from personidentifier pi 
       --        inner join person p on p.personid = pi.personid and p.activeflag = 1
       --        where pi.personidentifiervalue = vs_mdm_id and pi.personid != vs_person_id and pi.activeflag = 1 and pi.personidentifiertypekey = 'MDM_ID' group by pi.personid; 

       -- IF((mdm_id_exists_count > 0) and vs_newflag) THEN 

       --        update person set activeflag = 0, updatedby = 'MDM Person Reset', updatedon = now() where personid = vs_person_id;

       --        update actor set personid = vs_existing_personid, updatedon = now(), updatedby = vs_insertedby  where personid = vs_person_id returning actorid into v_actorid;

       --        update intakeservicerequestactor set updatedon = now(), updatedby = vs_insertedby, personid = vs_existing_personid where actorid = v_actorid;

       --        UPDATE cjams.person p
       --        SET     p.activeflag=1, p.userphoto = p2.userphoto, p.prefx = p2.prefx, p.firstname = p2.firstname, p.lastname = p2.lastname, p.middlename = p2.middlename, p.suffix = p2.suffix, p.dob = p2.dob,
       --               p.isapproxdob = p2.isapproxdob, p.everbeenadoptedflag = p2.everbeenadoptedflag, p.preadoptiondate = p2.preadoptiondate, p.dateofdeath =  p2.dateofdeath, p.isapproxdod = p2.isapproxdod,
       --               p.gendertypekey = p2.gendertypekey, p.livingsituationkey = p2.livingsituationkey, p.livingsituationdesc = p2.livingsituationdesc, p.stateid = p2.stateid, p.ssnno = p2.ssnno, p.ssnverified = p2.ssnverified,
       --               p.racetypekey = p2.racetypekey,	p.ethnicgrouptypekey = p2.ethnicgrouptypekey, p.occupation = p2.occupation,  p.tribalassociation = p2.tribalassociation, p.religiontypekey = p2.religiontypekey,		
       --               p.primarylanguageid = p2.primarylanguageid, p.secondarylanguageid = p2.secondarylanguageid, p.citizenalenageflag = p2.citizenalenageflag, p.primarycitizenshiptypekey = p2.primarycitizenshiptypekey,	 
       --               p.seccitizenshiptypekey = p2.seccitizenshiptypekey, p.nationalitytypekey = p2.nationalitytypekey, p.alienstatustypekey = p2.alienstatustypekey,	p.alienregistrationtext = p2.alienregistrationtext,		
       --               p.aname = p2.aname, p.maritalstatustypekey = p2.maritalstatustypekey, p.haircolortypekey = p2.haircolortypekey,	p.hairtexturetypekey = p2.hairtexturetypekey, p.eyecolortypekey = p2.eyecolortypekey,
       --               p.physicalbuildtypekey = p2.physicalbuildtypekey, p.skintonetypekey = p2.skintonetypekey, p.hairtextureotherdesc = p2.hairtextureotherdesc, p.haircolorotherdesc = p2.haircolorotherdesc,
       --               p.isglasses = p2.isglasses, p.employername = p2.employername, p.clienttitle = p2.clienttitle, p.biologicalmothermarriedsw = p2.biologicalmothermarriedsw, p.clientflag = p2.clientflag,
       --               p.updatedby = vs_insertedby, p.updatedon = now()
       --        FROM person p2 
       --        WHERE p.personid=vs_existing_personid and p2.personid = vs_person_id;


       -- ELSE    
              -- checking to see if mdm id exists --                                                                                                                                                          
              -- select COUNT(pi.personidentifiervalue) into mdm_id_count from personidentifier pi where pi.personid = vs_person_id and activeflag = 1 and pi.personidentifiertypekey = 'MDM_ID';
                                                                                                                                                                                                           
              IF (v_existingmdmid is null or vs_mdm_id != v_existingmdmid) THEN                                                                                                                                                                      
                 UPDATE personidentifier SET activeflag = 0, updatedby = vs_insertedby, updatedon = now() WHERE personid = vs_person_id AND personidentifiertypekey='MDM_ID' and activeflag = 1;                                                                                                                                                                                                                                               
                 INSERT INTO personidentifier(personid,personidentifiertypekey,personidentifiervalue,insertedby,updatedby) values (vs_person_id,'MDM_ID',vs_mdm_id,vs_insertedby,vs_insertedby);                                    
              END IF; 

              update person 
              set updatedby = vs_insertedby
                     , updatedon = now() 
                     , ispostmdmflag = true
                     , postmdmreturnstatus = returnstatus
              where personid = vs_person_id;          

       -- END IF;   

ELSE 

       update person 
       set updatedby = vs_insertedby
          , updatedon = now() 
          , ispostmdmflag = false
          , postmdmreturnstatus = returnstatus
       where personid = vs_person_id;

END IF;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

RETURN response;                                                                                                                                                                                
                                                                                                                                                                                                 
END;                                                                                                                                                                                             
$function$
;
