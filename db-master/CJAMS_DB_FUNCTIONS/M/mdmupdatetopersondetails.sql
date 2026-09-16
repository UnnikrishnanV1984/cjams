drop function if exists mdmupdatetopersondetails(json,character varying);
CREATE OR REPLACE FUNCTION cjams.mdmupdatetopersondetails(persondetails json, v_securityusersid character varying)
 RETURNS text
 LANGUAGE plpgsql
AS $function$

	declare
	
	v_persondetails json;
	v_mdmId varchar(50);
	v_personid uuid; 	 
	v_message varchar(50);
	v_clientinfo json;
	v_firstname json;
	v_middlename json;
	v_lastname json;
    v_ssnno json;
	v_dob json;
	v_gendertypekey json;
    v_maritalstatustypekey json;
    v_homephone json;
    v_cellphone json;
    v_residentialaddress json;
    v_mailingaddress json;
    v_prefixcode json;
    v_suffixcode json;
   v_lang json;
   
   v_active_sw varchar(50);
   v_active_swvalue varchar(50);
   v_mdmgolderpersondetailsid uuid;    
   v_mdmgoldenpersonnamesid uuid;
   v_mdmgoldenpersonphonesid uuid;
   v_mdmgoldenpersonaddressid uuid;
   v_mdmgoldenpersonemailsid uuid;
   v_homephonecount int ;
   v_cellphonecount int ;
   v_resiaddcount int;
   v_mailaddcount int;
  v_email json;
  v_emailcount int;
  v_languagecount int;
 v_is_mergedsync int;
v_mdmdetailsid uuid;
 

  
	BEGIN 
		
	v_persondetails := persondetails;
	v_personid :=  v_persondetails ->>'personid'; 
	v_clientinfo :=  v_persondetails ->>'clientInfo'; 

	v_firstname := v_persondetails-> 'firstname';  
	v_middlename := v_persondetails-> 'middlename';
    v_lastname := v_persondetails-> 'lastname'; 
    v_prefixcode := v_persondetails-> 'prefixcode'; 
    v_suffixcode := v_persondetails-> 'suffixcode'; 
    v_ssnno := v_persondetails-> 'ssnno';
    v_dob := v_persondetails-> 'dob';
    v_gendertypekey := v_persondetails-> 'gendertypekey';
    v_maritalstatustypekey := v_persondetails-> 'maritalstatustypekey';
    v_homephone := v_persondetails-> 'homephone';
    v_cellphone := v_persondetails-> 'cellphone';
    v_residentialaddress := v_persondetails-> 'residentialaddress';
    v_mailingaddress := v_persondetails-> 'mailingaddress';
    v_email  := v_persondetails-> 'email';
      v_lang  := v_persondetails-> 'languagecd';
	
     
  
  INSERT INTO cjams.personauditlog
 ( personid, personjson, typekey, insertedon, insertedby, updatedby, updatedon, activeflag, old_id)
 VALUES( v_personid, v_clientinfo, 'MDM_log', now(), v_securityusersid, v_securityusersid, now(), 1, null);


		
		if jsonb_array_length( v_firstname::jsonb ) > 0 then
		
		for v_firstname in select
			*
		from
			json_array_elements(v_firstname)		
		
			loop
		
			  v_active_sw:= v_firstname ->>'active_sw';	
			 v_mdmgoldenpersonnamesid:= v_firstname ->>'mdmgoldenpersonnamesid';
			 v_active_swvalue='A';
			
			 if(v_active_sw = 'A'  ) then
			 
			 update person set firstname=(v_firstname->>'firstname'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
			 update mdmgoldenpersonnames set firstname_sw='A', firstnameapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
			 
			 else
			 
			 update mdmgoldenpersonnames set firstname_sw=v_active_sw , firstnameapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
			 
			 end if;
		
		
		end loop;
		
		end if;
	
	/* middle name */
	
	if jsonb_array_length( v_middlename::jsonb ) > 0 then
	
	for v_middlename in select
		*
	from
		json_array_elements(v_middlename)		
	
		loop
	
		  v_active_sw:= v_middlename ->>'active_sw';
		  v_mdmgoldenpersonnamesid:= v_middlename ->>'mdmgoldenpersonnamesid';
		 
		 if(v_active_sw = 'A') then
		 
		 update person set middlename=(v_middlename->>'middlename'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
		 update mdmgoldenpersonnames set middlename_sw='A' , middlenameapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
		 
		 else
		 
		 update mdmgoldenpersonnames set middlename_sw=v_active_sw , middlenameapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
		 
		 end if;
	
	
	end loop;
	
	end if;

			
			/* last name */
			
			if jsonb_array_length( v_lastname::jsonb ) > 0 then
			
			for v_lastname in select
				*
			from
				json_array_elements(v_lastname)		
			
				loop
			
				  v_active_sw:= v_lastname ->>'active_sw';	
				 v_mdmgoldenpersonnamesid:= v_lastname ->>'mdmgoldenpersonnamesid';
				 
				 if(v_active_sw = 'A') then
				 
				 update person set lastname=(v_lastname->>'lastname'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
				 update mdmgoldenpersonnames set lastname_sw='A' , lastnameapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
				 
				 else
				 
				 update mdmgoldenpersonnames set lastname_sw=v_active_sw , lastnameapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
				 
				 end if;
			
			
			end loop;
			
			end if;
		
		/* prefixcode */
			
			if jsonb_array_length( v_prefixcode::jsonb ) > 0 then
			
			for v_prefixcode in select
				*
			from
				json_array_elements(v_prefixcode)		
			
				loop
			
				  v_active_sw:= v_prefixcode ->>'active_sw';	
				 v_mdmgoldenpersonnamesid:= v_prefixcode ->>'mdmgoldenpersonnamesid';
				 
				 if(v_active_sw = 'A') then
				 
				 update person set prefx=(v_prefixcode->>'prefixcode'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
				 update mdmgoldenpersonnames set prefix_sw='A' , prefixapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
				 
				 else
				 
				 update mdmgoldenpersonnames set prefix_sw=v_active_sw , prefixapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
				 
				 end if;
			
			
			end loop;
			
			end if;
		
		/* sufixcode */
			
			if jsonb_array_length( v_suffixcode::jsonb ) > 0 then
			
			for v_suffixcode in select
				*
			from
				json_array_elements(v_suffixcode)		
			
				loop
			
				  v_active_sw:= v_suffixcode ->>'active_sw';	
				 v_mdmgoldenpersonnamesid:= v_suffixcode ->>'mdmgoldenpersonnamesid';
				 
				 if(v_active_sw = 'A') then
				 
				 update person set suffix=(v_suffixcode->>'suffixcode'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
				 update mdmgoldenpersonnames set suffix_sw='A' , suffixapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
				 
				 else
				 
				 update mdmgoldenpersonnames set suffix_sw=v_active_sw , suffixapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonnamesid=v_mdmgoldenpersonnamesid;
				 
				 end if;
			
			
			end loop;
			
			end if;
		
		
			
			/* ssnno */

if jsonb_array_length( v_ssnno::jsonb ) > 0 then

for v_ssnno in select
	*
from
	json_array_elements(v_ssnno)		

	loop

	  v_active_sw:= v_ssnno ->>'active_sw';	 
	 v_mdmgolderpersondetailsid :=  v_ssnno ->>'mdmgolderpersondetailsid';
	 
	 if(v_active_sw = 'A') then
	 
	 update person set ssnno=(v_ssnno->>'ssnno'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
	 update mdmgoldenpersondetails set ssn_sw='A' , ssnapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
	 
	 else
	 
	 update mdmgoldenpersondetails set ssn_sw=v_active_sw , ssnapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
	 
	 end if;


end loop;

end if;


			/* DOB */
			
			if jsonb_array_length( v_dob::jsonb ) > 0 then
			
			for v_dob in select
				*
			from
				json_array_elements(v_dob)		
			
				loop
			
				  v_active_sw:= v_dob ->>'active_sw';	 
				 v_mdmgolderpersondetailsid :=  v_dob ->>'mdmgolderpersondetailsid';
				 
				 if(v_active_sw = 'A') then
				 
				 update person set dob=(v_dob->>'dob')::"timestamp", updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
				 update mdmgoldenpersondetails set dob_sw='A' , dobapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
				 
				 else
				 
				 update mdmgoldenpersondetails set dob_sw=v_active_sw , dobapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
				 
				 end if;
			
			
			end loop;
			
			end if;


/* gendertypekey */

if jsonb_array_length( v_gendertypekey::jsonb ) > 0 then

for v_gendertypekey in select
	*
from
	json_array_elements(v_gendertypekey)		

	loop

	  v_active_sw:= v_gendertypekey ->>'active_sw';	 
	 v_mdmgolderpersondetailsid :=  v_gendertypekey ->>'mdmgolderpersondetailsid';
	 
	 if(v_active_sw = 'A') then
	 
	 update person set gendertypekey=(v_gendertypekey->>'gendertypekey'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
	 update mdmgoldenpersondetails set genderapp_sw='A' , genderapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
	 
	 else
	 
	 update mdmgoldenpersondetails set genderapp_sw=v_active_sw , genderapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
	 
	 end if;


end loop;

end if;

		
		
				/* maritalstatustypekey */
				
				if jsonb_array_length( v_maritalstatustypekey::jsonb ) > 0 then
				
				for v_maritalstatustypekey in select
					*
				from
					json_array_elements(v_maritalstatustypekey)		
				
					loop
				
					  v_active_sw:= v_maritalstatustypekey ->>'active_sw';	 
					 v_mdmgolderpersondetailsid :=  v_maritalstatustypekey ->>'mdmgolderpersondetailsid';
					 
					 if(v_active_sw = 'A') then
					 
					 update person set maritalstatustypekey=(v_maritalstatustypekey->>'maritalstatustypekey'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
					 update mdmgoldenpersondetails set marital_sw='A' , maritalapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
					 
					 else
					 
					 update mdmgoldenpersondetails set marital_sw=v_active_sw , maritalapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
					 
					 end if;
				
				
				end loop;
				
				end if;
			
			
			/* languagecd */
				
				if jsonb_array_length( v_lang::jsonb ) > 0 then
				
				for v_lang in select
					*
				from
					json_array_elements(v_lang)		
				
					loop
				
					  v_active_sw:= v_lang ->>'active_sw';	 
					 v_mdmgolderpersondetailsid :=  v_lang ->>'mdmgolderpersondetailsid';
					 
					 if(v_active_sw = 'A') then
					 
					 update person set primarylanguageid=(v_lang->>'languagecd'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and activeflag=1;
					 update mdmgoldenpersondetails set language_sw='A' , languageapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
					 
					 else
					 
					 update mdmgoldenpersondetails set language_sw=v_active_sw , languageapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid=v_mdmgolderpersondetailsid;
					 
					 end if;
				
				
				end loop;
				
				end if;


			
	
		/* homephone */
				
				if jsonb_array_length( v_homephone::jsonb ) > 0 then
				
				for v_homephone in select
					*
				from
					json_array_elements(v_homephone)		
				
					loop
				
					  v_active_sw:= v_homephone ->>'active_sw';	 
					 v_mdmgoldenpersonphonesid :=  v_homephone ->>'mdmgoldenpersonphonesid';
					 
					 if(v_active_sw = 'A') then
					 
					 select count(*) into v_homephonecount from personphonenumber where personid=v_personid and personphonetypekey='1667' and activeflag=1;
					
					
					if (v_homephonecount > 0) then
					 
					 update personphonenumber set phonenumber=(v_homephone->>'phonenumber'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and  personphonetypekey='1667' and activeflag=1;
					 update mdmgoldenpersonphones set home_sw='A' , homeapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonphonesid=v_mdmgoldenpersonphonesid;
					
					else
					
					INSERT INTO personphonenumber
  					 ( personid, activeflag, personphonetypekey, phonenumber,   updatedby, updatedon, insertedby, insertedon, effectivedate)
 					 VALUES( v_personid , 1, '1667', (v_homephone ->>'phonenumber'), v_securityusersid, now(), v_securityusersid, now(), now());

					 update mdmgoldenpersonphones set home_sw='A' , homeapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonphonesid=v_mdmgoldenpersonphonesid;
 					
					end if;
				
					 
					 else
					 
					 update mdmgoldenpersonphones set home_sw=v_active_sw , homeapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonphonesid=v_mdmgoldenpersonphonesid;
					 
					 end if;
				
				
				end loop;
				
				end if;

		
			
			/* v_cellphone */
				
				if jsonb_array_length( v_cellphone::jsonb ) > 0 then
				
				for v_cellphone in select
					*
				from
					json_array_elements(v_cellphone)		
				
					loop
				
					  v_active_sw:= v_cellphone ->>'active_sw';	 
					 
					 v_mdmgoldenpersonphonesid :=  v_cellphone ->>'mdmgoldenpersonphonesid';
					 
					 if(v_active_sw = 'A') then
					 
					 select count(*) into v_cellphonecount from personphonenumber where personid=v_personid and personphonetypekey='1664' and activeflag=1;
					
					
					if (v_cellphonecount > 0) then
					 
					 update personphonenumber set phonenumber=(v_cellphone->>'phonenumber'), updatedon = now(), updatedby = v_securityusersid where personid=v_personid and  personphonetypekey='1664' and activeflag=1;
					 update mdmgoldenpersonphones set cell_sw='A' , cellapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonphonesid=v_mdmgoldenpersonphonesid;
					
					else
					
					INSERT INTO personphonenumber
  					 ( personid, activeflag, personphonetypekey, phonenumber,   updatedby, updatedon, insertedby, insertedon, effectivedate)
 					 VALUES( v_personid , 1, '1664', (v_cellphone ->>'phonenumber'), v_securityusersid, now(), v_securityusersid, now(), now());

					 update mdmgoldenpersonphones set cell_sw='A' , cellapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonphonesid=v_mdmgoldenpersonphonesid;
 					
					end if;
				
					 
					 else
					 
					 update mdmgoldenpersonphones set cell_sw=v_active_sw , cellapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonphonesid=v_mdmgoldenpersonphonesid;
					 
					 end if;
				
				
				end loop;
				
				end if;
			
				/* residentialaddress */
				
				if jsonb_array_length( v_residentialaddress::jsonb ) > 0 then
				
				for v_residentialaddress in select
					*
				from
					json_array_elements(v_residentialaddress)		
				
					loop
				
					  v_active_sw:= v_residentialaddress ->>'active_sw';	 
					 
					 v_mdmgoldenpersonaddressid :=  v_residentialaddress ->>'mdmgoldenpersonaddressid';
					 
					 if(v_active_sw = 'A') then
					 
					
					select count(*) into v_resiaddcount from personaddress pa where pa.activeflag=1 and pa.personaddresstypekey='RES' and personid=v_personid;
					
					
					if (v_resiaddcount > 0) then
					 
					 update personaddress set address=coalesce((v_residentialaddress->>'addressline1'),address),address2=coalesce((v_residentialaddress->>'addressline2'),address2),
					city=coalesce((v_residentialaddress->>'addresscity'),city),state=coalesce((v_residentialaddress->>'addressstate'),state),zipcode=coalesce((v_residentialaddress->>'addresszip'),zipcode)
				    , updatedon = now(), updatedby = v_securityusersid where personid=v_personid and  personaddresstypekey='RES' and activeflag=1;
					 update mdmgoldenpersonaddress set residential_sw='A' , residentialapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonaddressid=v_mdmgoldenpersonaddressid;
					
					else
					
 					INSERT INTO cjams.personaddress
                   ( personid, activeflag, personaddresstypekey, address, zipcode, city, state,  updatedby, updatedon, insertedby, insertedon,  address2,currentlocationflag)
                    VALUES( v_personid, 1, 'RES', (v_residentialaddress->>'addressline1'), (v_residentialaddress->>'addresszip'), 
                   (v_residentialaddress->>'addresscity'), (v_residentialaddress->>'addressstate'),v_securityusersid,  now(), v_securityusersid, now(),(v_residentialaddress->>'addressline2'),0);


					 update mdmgoldenpersonaddress set residential_sw='A' , residentialapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonaddressid=v_mdmgoldenpersonaddressid;
 					
					end if;
				
					 
					 else
					 
					 update mdmgoldenpersonaddress set residential_sw=v_active_sw , residentialapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonaddressid=v_mdmgoldenpersonaddressid;
					 
					 end if;
				
				
				end loop;
				
				end if;
			
			/* mailingaddress */
				
				if jsonb_array_length( v_mailingaddress::jsonb ) > 0 then
				
				for v_mailingaddress in select
					*
				from
					json_array_elements(v_mailingaddress)		
				
					loop
				
					  v_active_sw:= v_mailingaddress ->>'active_sw';	 
					 
					 v_mdmgoldenpersonaddressid :=  v_mailingaddress ->>'mdmgoldenpersonaddressid';
					 
					 if(v_active_sw = 'A') then
					 
					
					select count(*) into v_mailaddcount from personaddress pa where pa.activeflag=1 and pa.personaddresstypekey='MAI' and personid=v_personid ;
					
					
					if (v_mailaddcount > 0) then
					 
					 update personaddress set address=coalesce((v_mailingaddress->>'addressline1'),address),address2=coalesce((v_mailingaddress->>'addressline2'),address2),
					city=coalesce((v_mailingaddress->>'addresscity'),city),state=coalesce((v_mailingaddress->>'addressstate'),state),zipcode=coalesce((v_mailingaddress->>'addresszip'),zipcode), updatedon = now(), updatedby = v_securityusersid
				    where personid=v_personid and  personaddresstypekey='MAI' and activeflag=1;
					 update mdmgoldenpersonaddress set mailing_sw='A' , mailingapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonaddressid=v_mdmgoldenpersonaddressid;
					
					else
					
 					INSERT INTO cjams.personaddress
                   ( personid, activeflag, personaddresstypekey, address, zipcode, city, state,  updatedby, updatedon, insertedby, insertedon,  address2,currentlocationflag)
                    VALUES( v_personid, 1, 'MAI', (v_mailingaddress->>'addressline1'), (v_mailingaddress->>'addresszip'), 
                   (v_mailingaddress->>'addresscity'), (v_mailingaddress->>'addressstate'),  v_securityusersid,now(), v_securityusersid, now(), (v_mailingaddress->>'addressline2'),0);


					 update mdmgoldenpersonaddress set mailing_sw='A' , mailingapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonaddressid=v_mdmgoldenpersonaddressid;
 					
					end if;
				
					 
					 else
					 
					 update mdmgoldenpersonaddress set mailing_sw=v_active_sw , mailingapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonaddressid=v_mdmgoldenpersonaddressid;
					 
					 end if;
				
				
				end loop;
				
				end if;
			
			
			
			/* Email  */
				
				if jsonb_array_length( v_email::jsonb ) > 0 then
				
				for v_email in select
					*
				from
					json_array_elements(v_email)		
				
					loop
				
					  v_active_sw:= v_email ->>'active_sw';	 
					 
					 v_mdmgoldenpersonemailsid :=  v_email ->>'mdmgoldenpersonemailsid';
					 
					 if(v_active_sw = 'A') then
					 
					
					select count(*) into v_emailcount from personemail pa where pa.activeflag=1 and pa.personemailtypekey='P' and personid=v_personid ;
					
					
					if (v_emailcount > 0) then
					 
					 update personemail set email=(v_email->>'emailaddress'), updatedon = now(), updatedby = v_securityusersid
				    where personid=v_personid and  personemailtypekey='P' and activeflag=1;
					 update mdmgoldenpersonemails set email_sw='A' , emailapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonemailsid=v_mdmgoldenpersonemailsid;
					
					else
					
 					INSERT INTO personemail
					( personid, activeflag, personemailtypekey, email, updatedby, updatedon, insertedby, insertedon, effectivedate)
					VALUES(v_personid, 1, 'P', (v_email->>'emailaddress'), v_securityusersid, now(), v_securityusersid, now(), now());


					 update mdmgoldenpersonemails set email_sw='A' , emailapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonemailsid=v_mdmgoldenpersonemailsid;
 					
					end if;
				
					 
					 else
					 
					  update mdmgoldenpersonemails set email_sw=v_active_sw , emailapp_date=now(), updatedon = now(), updatedby = v_securityusersid where mdmgoldenpersonemailsid=v_mdmgoldenpersonemailsid;
					 
					 end if;
				
				
				end loop;
				
				end if;

		

		
	
			
			select count (*) into v_is_mergedsync from person p
inner join mdmgoldenpersondetails mpd on   p.personid=mpd.personid  and mpd.ssn_sw is not null and mpd.dob_sw is not null and mpd.genderapp_sw is not null and mpd.marital_sw is not null and 
mpd.language_sw is not null 
inner join mdmgoldenpersonaddress mpa on mpa.mdmgolderpersondetailsid = mpd.mdmgolderpersondetailsid   
and mpa.residential_sw is not null and mpa.addresstype='RES'
inner join mdmgoldenpersonaddress mpaa on mpaa.mdmgolderpersondetailsid = mpd.mdmgolderpersondetailsid   
and mpaa.mailing_sw is not  null and mpaa.addresstype='MAI'
inner join mdmgoldenpersonemails mpe on mpe.mdmgolderpersondetailsid = mpe.mdmgolderpersondetailsid and mpe.email_sw is not null and  
mpe.emailtype='PERSONAL'
inner join mdmgoldenpersonnames mpn on mpn.mdmgolderpersondetailsid = mpn.mdmgolderpersondetailsid
and mpn.prefix_sw  is not null and mpn.suffix_sw is not null and mpn.firstname_sw  is not null and mpn.middlename_sw is not null 
and mpn.lastname_sw is not null and mpn.nametypecode='LEGAL'
inner join mdmgoldenpersonphones mpp on mpp.mdmgolderpersondetailsid = mpd.mdmgolderpersondetailsid 
and mpp.home_sw is not null and mpp.phonetype='PERSONAL'
inner join mdmgoldenpersonphones mppp on mppp.mdmgolderpersondetailsid = mpd.mdmgolderpersondetailsid 
and  mppp.cell_sw is not null and mppp.phonetype='BUSINESS'
where p.personid=v_personid and mpd.mdmgolderpersondetailsid in (select mdmgolderpersondetailsid from mdmgoldenpersondetails 
where personid = v_personid order by insertedon desc limit 3) ;
			

if (v_is_mergedsync > 0) then	

/*
select mdmgolderpersondetailsid from mdmgoldenpersondetails  into v_mdmdetailsid
where personid = v_personid order by insertedon desc limit 1;

*/
update mdmgoldenpersondetails  set is_mdm_sync=true, updatedon = now(), updatedby = v_securityusersid where mdmgolderpersondetailsid in (select mdmgolderpersondetailsid from mdmgoldenpersondetails 
where personid = v_personid order by insertedon desc limit 3) ;

end if;


v_message:='Person Updated Sucessfully';
  
     RETURN v_message;
	END;

$function$
