drop function if exists cjams.expungementbatch();
CREATE OR REPLACE FUNCTION cjams.expungementbatch()
 RETURNS void
 LANGUAGE plpgsql
AS $function$

declare 
	v_allrows record ;
	v_currentdate date ;
v_activity  record;
	
begin


FOR  v_activity  IN
select personid::varchar as v_personid,intakeserviceid::varchar as v_intakeserviceid  from intakeservicerequestactor where spexpungementflag=1 and intakeservicerequestpersontypekey='AM' 
loop
update intakeservicerequestactor 
set spexpungementflag=1 
where 
personid::varchar=v_activity.v_personid  and 
intakeserviceid::varchar=v_activity.v_intakeserviceid;
end loop;



	v_currentdate  := (select current_date - interval '5 years')  ;

for v_allrows in select  ig.finalfinding, ig.investigationfindingtypekey , ig.investigationallegationid ,imt.oahearingdecision ,
  						 ig.insertedon,ig.updatedon ,ig.investigationfindingid, ia.maltreatmentid, imt.intakeservicerequestactorid
  				 from investigationfinding ig 
				 join investigationallegationmaltreators imt on ig.investigationallegationid = imt.investigationallegationid
				 join investigationallegation ia  on ia.investigationallegationid = ig.investigationallegationid
				 where ig.activeflag = 1

			
loop
	
	if  (lower(v_allrows.finalfinding) = lower('RO') ) and (DATE_TRUNC('day',v_allrows.insertedon) <= v_currentdate :: date )
	 then 
		
		update Investigationallegationmaltreators set expungementflag= 1 , updatedon = now() 
   		where  investigationallegationid  = v_allrows.investigationallegationid ;
   		
   		delete from expungement where investigationfindingid= v_allrows.investigationfindingid and maltreatmentid = v_allrows.maltreatmentid;
   	
   	    INSERT INTO cjams.expungement 
   	    		( investigationfindingid, isunsubstansiated, isindicated, isremovemaltreator, donotexpunge, manualexpunge, 
				  unsubstansiateddate, indicateddate, removemaltreatordate, investigationfinding, appealfinding, finalfinding,
                  resultoflawenforcement, insertedon, insertedby, updatedon, updatedby, activeflag, investigationnarrative, maltreatmentid)
			   values
				(v_allrows.investigationfindingid, NULL, NULL, true, NULL, false,
				 null,NULL, NULL, v_allrows.investigationfindingtypekey, v_allrows.oahearingdecision, v_allrows.finalfinding,
				 '', now(), '', now(), '', 1, '', v_allrows.maltreatmentid);
		
		update intakeservicerequestactor set activeflag = 1 , spexpungementflag = 1 ,updatedon = now()
	    where  intakeservicerequestpersontypekey='AM' and intakeservicerequestactorid = v_allrows.intakeservicerequestactorid;
   
	elseif (v_allrows.finalfinding is null or  v_allrows.finalfinding !='' ) 
   			and (lower(v_allrows.oahearingdecision) = lower('RO')) and (DATE_TRUNC('day',v_allrows.insertedon) <= v_currentdate :: date) 
   	then 
 		
    	update Investigationallegationmaltreators set expungementflag = 1, updatedon = now()
   		where  investigationallegationid  = v_allrows.investigationallegationid ;	
   		
   		delete from expungement where investigationfindingid= v_allrows.investigationfindingid and maltreatmentid = v_allrows.maltreatmentid;
   
  	 	INSERT INTO cjams.expungement 
   	    		( investigationfindingid, isunsubstansiated, isindicated, isremovemaltreator, donotexpunge, manualexpunge, 
				  unsubstansiateddate, indicateddate, removemaltreatordate, investigationfinding, appealfinding, finalfinding,
                  resultoflawenforcement, insertedon, insertedby, updatedon, updatedby, activeflag, investigationnarrative, maltreatmentid)
			   values
				(v_allrows.investigationfindingid, NULL, NULL, true, NULL, false,
				 null,NULL, NULL, v_allrows.investigationfindingtypekey, v_allrows.oahearingdecision, v_allrows.finalfinding,
				 '', now(), '', now(), '', 1, '', v_allrows.maltreatmentid);
				
		update intakeservicerequestactor set activeflag = 1 , spexpungementflag= 1, updatedon = now()
	    where  intakeservicerequestpersontypekey='AM'and  intakeservicerequestactorid = v_allrows.intakeservicerequestactorid;		
  
	   elseif (v_allrows.oahearingdecision is null or v_allrows.oahearingdecision !='') 
    		and (lower(v_allrows.investigationfindingtypekey) = lower('RO'))  and (DATE_TRUNC('day',v_allrows.insertedon) <= v_currentdate :: date) 
    then  
	
		update Investigationallegationmaltreators set expungementflag = 1, updatedon = now()
   		where  investigationallegationid    = v_allrows.investigationallegationid ;
   		 	
   		delete from expungement where investigationfindingid= v_allrows.investigationfindingid and maltreatmentid = v_allrows.maltreatmentid;
   
   	    INSERT INTO cjams.expungement 
   	    		( investigationfindingid, isunsubstansiated, isindicated, isremovemaltreator, donotexpunge, manualexpunge, 
				unsubstansiateddate, indicateddate, removemaltreatordate, investigationfinding, appealfinding, finalfinding,
                resultoflawenforcement, insertedon, insertedby, updatedon, updatedby, activeflag, investigationnarrative, maltreatmentid)
			   values
				(v_allrows.investigationfindingid, NULL, NULL, true, NULL, false,
				 null,NULL, NULL, v_allrows.investigationfindingtypekey, v_allrows.oahearingdecision, v_allrows.finalfinding,
				 '', now(), '', now(), '', 1, '', v_allrows.maltreatmentid);
				
		update intakeservicerequestactor set activeflag = 1, spexpungementflag = 1, updatedon = now()
	    where   intakeservicerequestpersontypekey='AM' and intakeservicerequestactorid = v_allrows.intakeservicerequestactorid;
   end if ;   
end loop ;

end $function$
;
