Drop function if exists cjams.sp_ive_eligibility_worksheet_judicial_info(json);

CREATE OR REPLACE FUNCTION cjams.sp_ive_eligibility_worksheet_judicial_info(reqobj json)
 RETURNS void
 LANGUAGE plpgsql
AS $function$ 

DECLARE
	v_client_id bigint;
  	v_removal_id bigint;
	v_count bigint;
	v_period_type varchar(50);
	v_date_agency_lost_legal_responsibility timestamp;
	v_refpp_not_due varchar(50);
	v_clientidofsubjectctwfinding int8;
    v_nameofsubjectctwfinding VARCHAR;
    v_relationshipofsubjectctwfinding int4;
    v_isiveagencyresponsibleforplacementandcare VARCHAR;
	v_ctwcourtorderid VARCHAR;
	v_reasonablecourtorderid VARCHAR;
	v_redetcourtorderid VARCHAR;
	v_dateofcourthearing timestamp;
	v_magistrateorjudgename varchar;
	v_issignedbyjudge varchar;
	v_ctwdecision varchar;
    v_dateoffindingctwdecision timestamp;
    v_dateofnexthearing timestamp;
    v_courtorderdelayremoval VARCHAR;
	v_courtorderdelaytimedays VARCHAR;
	v_typeofcourthearing VARCHAR;
	v_reasonableeffortsmade VARCHAR;
	v_dateofreasonableeffortscourthearing timestamp;
	v_reasonableeffortsnotnecessaryduetoemergentcircumstances varchar;
	v_dateofjudicialfindingofrefpp timestamp;
	v_dateofsubsequentjudicialfindingofrefpp timestamp;
    v_dateofpreviousjudicialfindingofrefpp timestamp;
    v_fostercarepermanencyplandesc VARCHAR;
    v_dateofcurrentjudicialfindingofbestinterest timestamp;
	v_dateofsubsequentfindingofbestinterest timestamp;
	v_dateofpreviousbestinterestfinding timestamp;
	v_fostercarepermanencyplan			VARCHAR;

   
BEGIN

	  	v_client_id := reqObj ->> 'clientid';
	  	v_removal_id := reqObj ->> 'removalid';
	  	v_period_type := reqObj ->> 'periodtype';
	  	v_date_agency_lost_legal_responsibility := reqObj ->> 'dateagencylostlegalresponsibility';
		v_refpp_not_due := reqObj ->> 'refppnotdue';
		v_clientidofsubjectctwfinding := reqObj ->> 'clientidofsubjectctwfinding';
		v_nameofsubjectctwfinding := reqObj ->> 'nameofsubjectctwfinding';
		v_relationshipofsubjectctwfinding := reqObj ->> 'relationshipofsubjectctwfinding';
		v_isiveagencyresponsibleforplacementandcare := reqObj ->> 'isiveagencyresponsibleforplacementandcare';
		v_ctwcourtorderid := reqObj ->> 'ctwcourtorderid';
		v_reasonablecourtorderid := reqObj ->> 'reasonablecourtorderid';
		v_redetcourtorderid := reqObj ->> 'redetcourtorderid';
		v_dateofcourthearing := reqObj ->> 'dateofcourthearing';
		v_magistrateorjudgename := reqObj ->> 'magistrateorjudgename';
		v_issignedbyjudge := reqObj ->> 'issignedbyjudge';
		v_ctwdecision := reqObj ->> 'ctwdecision';
	    v_dateoffindingctwdecision := reqObj ->> 'dateoffindingctwdecision';
	    v_dateofnexthearing := reqObj ->> 'dateofnexthearing';
	    v_courtorderdelayremoval := reqObj ->> 'courtorderdelayremoval';
		v_courtorderdelaytimedays := reqObj ->> 'courtorderdelaytimedays';
		v_typeofcourthearing := reqObj ->> 'typeofcourthearing';
		v_reasonableeffortsmade := reqObj ->> 'reasonableeffortsmade';
		v_dateofreasonableeffortscourthearing := reqObj ->> 'dateofreasonableeffortscourthearing';
		v_reasonableeffortsnotnecessaryduetoemergentcircumstances := reqObj ->> 'reasonableeffortsnotnecessaryduetoemergentcircumstances';
		v_dateofjudicialfindingofrefpp := reqObj ->> 'dateofjudicialfindingofrefpp';
		v_dateofsubsequentjudicialfindingofrefpp := reqObj ->> 'dateofsubsequentjudicialfindingofrefpp';
	    v_dateofpreviousjudicialfindingofrefpp := reqObj ->> 'dateofpreviousjudicialfindingofrefpp';
	    v_fostercarepermanencyplandesc := reqObj ->> 'fostercarepermanencyplandesc';
	    v_dateofcurrentjudicialfindingofbestinterest := reqObj ->> 'dateofcurrentjudicialfindingofbestinterest';
		v_dateofsubsequentfindingofbestinterest := reqObj ->> 'dateofsubsequentfindingofbestinterest';
		v_dateofpreviousbestinterestfinding := reqObj ->> 'dateofpreviousbestinterestfinding';
		v_fostercarepermanencyplan := reqObj ->> 'fostercarepermanencyplan';



		SELECT count(*) INTO v_count FROM tb_foster_care_judicial tj WHERE tj.client_id = v_client_id and tj.removal_id=v_removal_id and tj.period_type=v_period_type;

		IF (v_count) = 0
		THEN
				INSERT 
				INTO tb_foster_care_judicial(client_id, 
								removal_id,
								period_type,
								date_agency_lost_legal_responsibility,
								refpp_not_due,
								clientidofsubjectctwfinding, nameofsubjectctwfinding, relationshipofsubjectctwfinding, isiveagencyresponsibleforplacementandcare,
								ctwcourtorderid, reasonablecourtorderid, redetcourtorderid,
								dateofcourthearing, magistrateorjudgename, issignedbyjudge, ctwdecision, dateoffindingctwdecision, dateofnexthearing, courtorderdelayremoval,
								courtorderdelaytimedays, typeofcourthearing, reasonableeffortsmade, dateofreasonableeffortscourthearing, reasonableeffortsnotnecessaryduetoemergentcircumstances,
								dateofjudicialfindingofrefpp, dateofsubsequentjudicialfindingofrefpp, dateofpreviousjudicialfindingofrefpp, fostercarepermanencyplandesc, dateofcurrentjudicialfindingofbestinterest,
								dateofsubsequentfindingofbestinterest, dateofpreviousbestinterestfinding, fostercarepermanencyplan,
								create_ts,
								update_ts) 
						VALUES( 
						        v_client_id,
							    v_removal_id,
							    v_period_type,
							    v_date_agency_lost_legal_responsibility,
							    v_refpp_not_due,
							    v_clientidofsubjectctwfinding, v_nameofsubjectctwfinding, v_relationshipofsubjectctwfinding, v_isiveagencyresponsibleforplacementandcare,
								v_ctwcourtorderid, v_reasonablecourtorderid, v_redetcourtorderid, v_dateofcourthearing, v_magistrateorjudgename , v_issignedbyjudge, v_ctwdecision,
								v_dateoffindingctwdecision, v_dateofnexthearing, v_courtorderdelayremoval, v_courtorderdelaytimedays, v_typeofcourthearing, v_reasonableeffortsmade,
								v_dateofreasonableeffortscourthearing, v_reasonableeffortsnotnecessaryduetoemergentcircumstances, v_dateofjudicialfindingofrefpp, v_dateofsubsequentjudicialfindingofrefpp,
								v_dateofpreviousjudicialfindingofrefpp, v_fostercarepermanencyplandesc, v_dateofcurrentjudicialfindingofbestinterest, v_dateofsubsequentfindingofbestinterest,
								v_dateofpreviousbestinterestfinding, v_fostercarepermanencyplan,
								current_timestamp,
								current_timestamp);
		ELSE
		
				UPDATE tb_foster_care_judicial tj	
				SET 	                 
					 date_agency_lost_legal_responsibility  = v_date_agency_lost_legal_responsibility,
					 refpp_not_due  = v_refpp_not_due,
					 clientidofsubjectctwfinding = v_clientidofsubjectctwfinding,
                     nameofsubjectctwfinding = v_nameofsubjectctwfinding,
                     relationshipofsubjectctwfinding = v_relationshipofsubjectctwfinding,
                     isiveagencyresponsibleforplacementandcare = v_isiveagencyresponsibleforplacementandcare,
					 ctwcourtorderid = v_ctwcourtorderid,
					 reasonablecourtorderid = v_reasonablecourtorderid,
					 redetcourtorderid = v_redetcourtorderid,
					 dateofcourthearing = v_dateofcourthearing, 
					 magistrateorjudgename = v_magistrateorjudgename,
					 issignedbyjudge = v_issignedbyjudge,
					 ctwdecision = v_ctwdecision,
					 dateoffindingctwdecision = v_dateoffindingctwdecision, 
					 dateofnexthearing = v_dateofnexthearing,
					 courtorderdelayremoval = v_courtorderdelayremoval,
					 courtorderdelaytimedays = v_courtorderdelaytimedays,
					 typeofcourthearing = v_typeofcourthearing, 
					 reasonableeffortsmade = v_reasonableeffortsmade, 
					 dateofreasonableeffortscourthearing = v_dateofreasonableeffortscourthearing,
					 reasonableeffortsnotnecessaryduetoemergentcircumstances = v_reasonableeffortsnotnecessaryduetoemergentcircumstances,
					 dateofjudicialfindingofrefpp = v_dateofjudicialfindingofrefpp,
					 dateofsubsequentjudicialfindingofrefpp = v_dateofsubsequentjudicialfindingofrefpp,
					 dateofpreviousjudicialfindingofrefpp = v_dateofpreviousjudicialfindingofrefpp,
					 fostercarepermanencyplandesc = v_fostercarepermanencyplandesc,
					 dateofcurrentjudicialfindingofbestinterest = v_dateofcurrentjudicialfindingofbestinterest,
					 dateofsubsequentfindingofbestinterest = v_dateofsubsequentfindingofbestinterest,
					 dateofpreviousbestinterestfinding = v_dateofpreviousbestinterestfinding,
					 fostercarepermanencyplan = v_fostercarepermanencyplan,
					 update_ts = current_timestamp
				WHERE tj.client_id = v_client_id and tj.removal_id=v_removal_id and tj.period_type=v_period_type;
				  
		END IF;	

END;
	
$function$
;
