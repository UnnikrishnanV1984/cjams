CREATE OR REPLACE FUNCTION cjams.f_nytd_client_chk_ele20_33(al_client_id uuid, adt_start_dt_srv date, adt_end_dt_srv date)
 RETURNS character varying
 LANGUAGE plpgsql
AS $function$
------------------------------------------------------------------------
-- SQL Stored Procedure
-- Description:  Generate Foster Care AFCARS report
-- Revision(s)
-- 10/20/2020 - Vineet Tirodkar - Changes for Performance improvements
------------------------------------------------------------------------
DECLARE VS_INDEPENDENT_ASSESS VARCHAR(3);
DECLARE VS_ACADEMIC_SUPPORT VARCHAR(3);
DECLARE VS_POST_SECNDRY_EDU_SUPPORT  VARCHAR(3);
DECLARE VS_CAREER_PREPARATION  VARCHAR(3);
DECLARE VS_OTH_FIN_ASSISTANCE  VARCHAR(3);
DECLARE VS_EDU_FINANCIAL_ASSIST  VARCHAR(3);
DECLARE VS_RM_BRD_FIN_ASSIST  VARCHAR(3);
DECLARE VS_SUPVD_IND_LIVING  VARCHAR(3);
DECLARE VS_MENTORING   VARCHAR(3);
DECLARE VS_FM_SUPP_MARG_EDU  VARCHAR(3); 
DECLARE VS_HEALTH_EDU_RISK_PREVENTION  VARCHAR(3); 
DECLARE VS_HOUS_EDUCATION  VARCHAR(3); 
DECLARE VS_FIN_MANGT  VARCHAR(3); 
DECLARE VS_VOC_TRAINING  VARCHAR(3); 
DECLARE VS_CLNT_CHK	VARCHAR(1);
DECLARE VI_CLIENT_ID UUID;
DECLARE VD_START_DT_SRV1 DATE;
DECLARE VD_END_DT_SRV1 DATE;
DECLARE VI_CJAMSPID BIGINT;

begin

	VI_CLIENT_ID = al_client_id;

	VD_START_DT_SRV1 = adt_start_dt_srv;
	VD_END_DT_SRV1 = adt_end_dt_srv;

	-- Get VI_CJAMSPID
	select cjamspid
		into VI_CJAMSPID
		from person
	where personid = al_client_id
		and activeflag = 1 ;
	
	--element 20
	VS_INDEPENDENT_ASSESS 
		= (	SELECT  CASE WHEN assessmentdate BETWEEN (VD_START_DT_SRV1 - interval ' 7 MONTHS ') 
						AND (VD_END_DT_SRV1 + interval '7 MONTHS') THEN 
						'Yes' 
					ELSE 
						'No' 
					END
			FROM personlifeskillassessment 
			WHERE personid = VI_CLIENT_ID    -- personid not available in table personlifeskillassessment
			ORDER BY lifeskillassessid DESC limit 1 
		  );
				
	IF (VS_INDEPENDENT_ASSESS IS NULL) THEN
		VS_INDEPENDENT_ASSESS = 'No';
	END IF;

	IF	VS_INDEPENDENT_ASSESS = 'No' THEN
		-- Element ID 21 - Academic Support -
		VS_ACADEMIC_SUPPORT =
			(  SELECT (CASE WHEN ( SELECT COUNT(*) 
										FROM tb_service_log SL
								   WHERE SL.client_id = VI_CJAMSPID
									AND SL.delete_sw = 'N'                         
									AND SL.start_dt <= VD_END_DT_SRV1
									AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
									AND (SL.provider_service_id 
											IN (	SELECT provider_service_id
														FROM tb_provider_services
													WHERE delete_sw = 'N'
														AND service_id IN (1125,11364,11355,1122,1118,1119,1126,1121,11374)
												)
										OR SL.agency_service_ldss_id IN (11387,11378,1217,1223,1224,1219,11397,1220)
										OR SL.service_log_id 
											IN (	SELECT SL.service_log_id
														FROM tb_service_log SL
													WHERE SL.delete_sw='N'
														AND SL.provider_service_id IN (SELECT provider_service_id
																							FROM tb_provider_services
																						WHERE delete_sw = 'N'
																							AND service_id IN (11344,11401,1127)
																					   )
												)
										)
									) > 0 THEN
									'Yes'
								ELSE
									'No'
								END)
			);
			
		IF	VS_ACADEMIC_SUPPORT = 'No' THEN
			-- 	Element ID 22 - Post Secondary Educational Support
			VS_POST_SECNDRY_EDU_SUPPORT =
			(SELECT (CASE WHEN (SELECT COUNT(*)
									FROM tb_service_log SL
								WHERE SL.client_id = VI_CJAMSPID
									AND SL.delete_sw='N'
									AND SL.start_dt  <= VD_END_DT_SRV1
									AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
									AND (SL.provider_service_id IN (SELECT provider_service_id
																		FROM tb_provider_services
																	WHERE delete_sw = 'N'
																		AND service_id IN (11365,11356,11373)
																	)
									OR SL.agency_service_ldss_id IN (11388,11396,11379)
                                    )
								) > 0 THEN
								'Yes'
							ELSE
								'No'
							END)
			) ;
			
			IF	VS_POST_SECNDRY_EDU_SUPPORT = 'No' THEN
				-- 	Element ID 23 - Career Preparation 
				VS_CAREER_PREPARATION =
				(SELECT (CASE WHEN (SELECT COUNT(*)
										FROM tb_service_log SL
									WHERE SL.client_id = VI_CJAMSPID
										AND SL.delete_sw = 'N'
										AND SL.start_dt  <= VD_END_DT_SRV1
										AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
										AND (SL.provider_service_id IN (SELECT provider_service_id
																			FROM tb_provider_services
																		WHERE delete_sw = 'N'
																			AND service_id IN (11357,11366)
																		)
											OR SL.agency_service_ldss_id IN (11389,11380,1274,1271,1273,1275,1272,1276)
											OR SL.service_log_id IN (SELECT SL.service_log_id
																		FROM tb_service_log SL
																	  WHERE SL.delete_sw='N'
																		AND SL.provider_service_id 
																				IN ( SELECT provider_service_id
																						FROM tb_provider_services
																					WHERE delete_sw = 'N'
																						AND service_id IN (11346)
																					)
																	)
											)
								) > 0 THEN
							'Yes'
                        ELSE
							'No'
                        END)
				);
			
				IF	VS_CAREER_PREPARATION = 'No' THEN
					-- Element ID 24 - Employment Programs or Vocational Training
					VS_VOC_TRAINING =
					( SELECT (CASE WHEN (SELECT COUNT(*)
											FROM tb_service_log SL
										WHERE SL.client_id = VI_CJAMSPID
											AND SL.delete_sw='N'
											AND SL.start_dt  <= VD_END_DT_SRV1
											AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
											AND (SL.provider_service_id IN (SELECT provider_service_id
																				FROM tb_provider_services
																			WHERE delete_sw = 'N'
																				AND service_id IN (11367,11358,1130,1129,1120,1128,1131) --#13052
																			)
												OR SL.agency_service_ldss_id IN (11390,11381,1226,1228,1216,1221,1227)
												OR SL.service_log_id IN (SELECT SL.service_log_id
																			FROM tb_service_log SL
																		  WHERE SL.delete_sw='N'
																			AND SL.provider_service_id 
																				IN ( SELECT provider_service_id
																						FROM tb_provider_services
																					 WHERE delete_sw = 'N'
																						AND service_id IN (11347)
																				   )
																	 )
                                         )
								) > 0 THEN
							'Yes'
                         ELSE
							'No'
                         END)
					);
					
					IF	VS_VOC_TRAINING = 'No' THEN
						-- Element ID 25 - Budget and Financial Management
						VS_FIN_MANGT =
						(SELECT (CASE WHEN (SELECT COUNT(*)
												FROM tb_service_log SL
											 WHERE SL.client_id = VI_CJAMSPID
													AND SL.delete_sw='N'
													AND SL.start_dt  <= VD_END_DT_SRV1
													AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
													AND (SL.provider_service_id IN (SELECT provider_service_id
																						FROM tb_provider_services
																					WHERE delete_sw = 'N'
																						AND service_id IN (11368,11359,1124,1103)
																					)
														OR SL.agency_service_ldss_id IN (11391,11382,1218,1201)
														OR SL.service_log_id IN (SELECT SL.service_log_id
																					FROM tb_service_log SL
																				  WHERE SL.delete_sw='N'
																					AND SL.provider_service_id 
																						IN ( SELECT provider_service_id
																								FROM tb_provider_services
																							  WHERE delete_sw = 'N'
																								AND service_id IN (11348)
																						   )
																				)
														)
								) > 0 THEN
							'Yes'
                           ELSE
							'No'
                           END)
						);
						
						IF	VS_FIN_MANGT = 'No' THEN
							-- Element ID 26 - Housing Education and Home Management Training
							VS_HOUS_EDUCATION =
								(SELECT (CASE WHEN (	SELECT COUNT(*)
									FROM tb_service_log SL
								 WHERE SL.client_id = VI_CJAMSPID
									AND SL.delete_sw='N'
									AND SL.start_dt  <= VD_END_DT_SRV1
									AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
									AND (SL.provider_service_id IN (SELECT provider_service_id
																		FROM tb_provider_services
																	WHERE delete_sw = 'N'
																		AND service_id IN (11370,11361,11369,11360,1104)
																	)
										OR SL.agency_service_ldss_id IN (11393,11384,11392,11383,1200,1202,1203)
										OR SL.service_log_id IN (SELECT SL.service_log_id
																	FROM tb_service_log SL
																 WHERE SL.delete_sw='N'
																	AND SL.provider_service_id 
																		IN ( SELECT provider_service_id
																				FROM tb_provider_services
																			  WHERE delete_sw = 'N'
																				AND service_id IN (11349,11350)
																		   )
																 )
											)
								) > 0 THEN
									'Yes'
								ELSE
									'No'
								END)
							);
								
							IF	VS_HOUS_EDUCATION = 'No' THEN	
								-- Element ID 27 - Health Education and Risk Prevention
								VS_HEALTH_EDU_RISK_PREVENTION =
								 (  SELECT (CASE WHEN ( SELECT COUNT(*)
										FROM tb_service_log SL
									WHERE SL.client_id = VI_CJAMSPID
										AND SL.delete_sw='N'
										AND SL.start_dt  <= VD_END_DT_SRV1
										AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
										AND (SL.provider_service_id IN (SELECT provider_service_id
																			FROM tb_provider_services
																		WHERE delete_sw = 'N'
																			AND service_id IN (11362,11371,1195,1192,1304,1145,1147,1197,1108)
																		)
											OR SL.agency_service_ldss_id IN (11385,11394,1263,1262,1300,1244,1265,1264,1205,1252,1253)
											OR SL.service_log_id IN (SELECT SL.service_log_id
																FROM tb_service_log SL
																WHERE SL.delete_sw='N'
																AND SL.provider_service_id IN ( SELECT provider_service_id
																								FROM tb_provider_services
																								WHERE delete_sw = 'N'
																								AND service_id IN (11351,1196)
																							  )
																)
											)
										) > 0 THEN
										'Yes'
									ELSE
										'No'
									END)
								) ;
								
								IF	VS_HEALTH_EDU_RISK_PREVENTION = 'No' THEN
									-- Element ID 28 - Family Support/Healthy Marriage Education -
									VS_FM_SUPP_MARG_EDU =
									(SELECT (CASE WHEN ( SELECT COUNT(*)
										FROM tb_service_log SL
									 WHERE SL.client_id = VI_CJAMSPID
										AND SL.delete_sw='N'
										AND SL.start_dt  <= VD_END_DT_SRV1
										AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
										AND (SL.provider_service_id IN (SELECT provider_service_id
																			FROM tb_provider_services
																		WHERE delete_sw = 'N'
																			AND service_id IN (11363,11372,1100,1157,1144,1117,1101,1107)
																		)
											OR SL.agency_service_ldss_id IN (11395,11386,1198,1245,1241,1214,1199,1204)
											OR SL.service_log_id IN (SELECT SL.service_log_id
																		FROM tb_service_log SL
																	 WHERE SL.delete_sw='N'
																		AND SL.provider_service_id 
																			IN (SELECT provider_service_id
																					FROM tb_provider_services
																				WHERE delete_sw = 'N'
																					AND service_id IN (11352)
																				)
																	)
												)
											) > 0 THEN
												'Yes'
										ELSE
											'No'
										END)
									) ;
									
									IF	VS_FM_SUPP_MARG_EDU = 'No' THEN
										-- Element ID 29 - Mentoring -
										VS_MENTORING =
										(SELECT (CASE WHEN ( SELECT COUNT(*)
											FROM tb_service_log SL
										 WHERE SL.client_id = VI_CJAMSPID
											AND SL.delete_sw='N'
											AND SL.start_dt  <= VD_END_DT_SRV1
											AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
											AND (SL.provider_service_id IN (SELECT provider_service_id
																				FROM tb_provider_services
																			WHERE delete_sw = 'N'
																				AND service_id IN (11375,1150,1153)
																			)
												OR SL.agency_service_ldss_id IN (11398,1254,1259,1258,1260)
												OR SL.service_log_id IN (SELECT SL.service_log_id
																			FROM tb_service_log SL
																		 WHERE SL.delete_sw='N'
																			AND SL.provider_service_id 
																				IN ( SELECT provider_service_id
																						FROM tb_provider_services
																					WHERE delete_sw = 'N'
																						AND service_id IN (11353)
																				    )
																		)
												)
										) > 0 THEN
											'Yes'
										ELSE
											'No'
										END)                               
									) ;
									
									IF	VS_MENTORING = 'No' THEN
										-- Element ID 30 - Supervised Independent Living
										 VS_SUPVD_IND_LIVING =
										 (  SELECT ( CASE WHEN (	select count(*)
												from personprogramarea cpa
											where cpa.personid = VI_CLIENT_ID
												and cpa.startdate <= VD_END_DT_SRV1
												and (cpa.enddate is null or cpa.enddate::date >= VD_START_DT_SRV1 )
												and cpa.programkey in ( 'IL', 'OOH' )
												-- and cpa.agency_program_area_id IN (2,4) -- agencyprogramareaid not found in table personprogramarea
												and cpa.personid  
													in (	select personid
																from placement
															where activeflag = 1
																and startdatetime <= VD_END_DT_SRV1
																and (enddatetime is null 
																		or enddatetime::date >= VD_START_DT_SRV1 )
																and service_id = 1 
																--and placement_structure_id = 1  -- field NA in table placement
															order by insertedon desc
															-- order by placementid desc
															fetch first 1 row only
														  )
											) > 0 THEN
												'Yes'
											WHEN (	select count(*)
														from personprogramarea cpa
													where cpa.personid = VI_CLIENT_ID
														and cpa.startdate <= VD_END_DT_SRV1
														and (cpa.enddate is null or cpa.enddate::date >= VD_START_DT_SRV1 )
														and cpa.programkey in ( 'IL', 'OOH' )
														-- and cpa.agency_program_area_id IN (2,4) -- agencyprogramareaid not found in table personprogramarea
														and cpa.personid in (	select personid
																					from placement
																				where activeflag = 1
																					and startdatetime::date <= VD_END_DT_SRV1
																					and (enddatetime is null or enddatetime::date >= VD_START_DT_SRV1 )
																					and service_id = 75 
																					--and placement_structure_id = 75   -- field NA in table placement
																					order by insertedon desc
																					-- order by placementid desc
																					fetch first 1 row only
																			)
												) > 0 THEN
												'Yes'
											WHEN (	SELECT COUNT(*)
														FROM livingarrangement     
													WHERE livingarrangementtypekey = '13071'
														AND personid = VI_CLIENT_ID
														AND livingstartdate <= VD_END_DT_SRV1
														AND (livingenddate IS NULL OR livingenddate >= VD_START_DT_SRV1)) > 0 THEN
												'Yes'
											ELSE
												'No'
											END)
										);
									
										IF	VS_SUPVD_IND_LIVING = 'No' THEN
											-- Element ID 31 - Room and Board Financial Assistance
											VS_RM_BRD_FIN_ASSIST =
											(SELECT ( CASE WHEN ( SELECT COUNT(*)
												FROM tb_service_log SL
											 WHERE SL.client_id = VI_CJAMSPID
												AND SL.delete_sw='N'
												AND SL.start_dt  <= VD_END_DT_SRV1
												AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
												AND (SL.provider_service_id IN (SELECT provider_service_id
																					FROM tb_provider_services
																				WHERE delete_sw = 'N'
																					AND service_id IN (1133,1134,11377,1132,1135,
																										11376,1136,1137,1138,1109)
																				)
													OR SL.agency_service_ldss_id IN (1232,1233,11400,1283,1229,1230,
																					 11399,1231,1234,1235,1236,1206)
													OR SL.service_log_id IN (SELECT SL.service_log_id
																				FROM tb_service_log SL
																			  WHERE SL.delete_sw='N'
																				AND SL.provider_service_id 
																					IN  (SELECT provider_service_id
																							FROM tb_provider_services
																						 WHERE delete_sw = 'N'
																							AND service_id IN (11343,1033,1034,1032,1035,
																												1036,1037,11342,1039)
																						)
																				)
													)
												) > 0 THEN
												'Yes'
											WHEN (SELECT COUNT(*)
													FROM livingarrangement
												  WHERE livingarrangementtypekey = '13071'
													AND personid = VI_CLIENT_ID
													AND livingstartdate <= VD_END_DT_SRV1
													AND (livingenddate IS NULL OR livingenddate >= VD_START_DT_SRV1)) > 0 THEN
												'Yes'
											WHEN (	select count(*)       
														from personprogramarea cpa
													where cpa.personid = VI_CLIENT_ID
														and cpa.startdate <= VD_END_DT_SRV1
														and (cpa.enddate is null or cpa.enddate >= VD_START_DT_SRV1 )
														and cpa.programkey in ( 'IL', 'OOH' )
														--and cpa.agency_program_area_id IN (2,4) -- field NA in personprogramarea  
														and cpa.personid in (	select personid
																					from placement
																				where activeflag = 1
																					and startdatetime <= VD_END_DT_SRV1
																					and (enddatetime is null or enddatetime >= VD_START_DT_SRV1 )
																					and service_id = 73 
																					--and placement_structure_id = 73   -- field not available
																					order by insertedon desc
																					-- order by placementid desc
																					fetch first 1 row only
																			)
												) > 0 THEN
													'Yes'
												ELSE
													'No'
												END)
											) ;
										
											IF	VS_RM_BRD_FIN_ASSIST = 'No' THEN
												-- Element ID 32 - education financial assistance
												 VS_EDU_FINANCIAL_ASSIST =
												 (  SELECT (	CASE WHEN ( SELECT COUNT(*)
														FROM tb_service_log SL
													WHERE SL.client_id = VI_CJAMSPID
														AND SL.delete_sw='N'
														AND SL.start_dt  <= VD_END_DT_SRV1
														AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
														AND (SL.service_log_id IN ( SELECT SL.service_log_id
																						FROM tb_service_log SL
																					WHERE SL.delete_sw='N'
																						AND SL.provider_service_id
																							IN (SELECT provider_service_id
																									FROM tb_provider_services
																								WHERE delete_sw = 'N'
																									AND service_id IN (1018,1019,1021,1022,1025,1026,1027,11322
																													  ,11324,11326,11328,11345)
																								)
																					)
																OR SL.agency_service_ldss_id IN (1225)
															)
														) > 0 THEN
															'Yes'
														ELSE
															'No'
														END)
													);
													
													IF	VS_EDU_FINANCIAL_ASSIST = 'No' THEN
														-- Element ID 33 - Other Financial Assistance
														VS_OTH_FIN_ASSISTANCE =
														( SELECT (CASE WHEN (SELECT COUNT(*)
															FROM tb_service_log SL
														  WHERE SL.client_id = VI_CJAMSPID
															AND SL.delete_sw='N'
															AND SL.start_dt  <= VD_END_DT_SRV1
															AND (SL.end_dt IS NULL OR SL.end_dt >= VD_START_DT_SRV1)
															AND ( SL.service_log_id IN (SELECT SL.service_log_id
																							FROM tb_service_log SL
																						WHERE SL.delete_sw='N'
																							AND SL.provider_service_id 
																								IN (SELECT provider_service_id
																										FROM tb_provider_services
																									WHERE delete_sw = 'N'
																										AND service_id IN (1066,11341)
																									)
																						)
																OR SL.agency_service_ldss_id IN (1266)	
																OR SL.provider_service_id IN (SELECT provider_service_id
																								FROM tb_provider_services
																							  WHERE delete_sw = 'N'
																								AND service_id IN (1166)
																							  )											
																	)
																) > 0 THEN
																	'Yes'
																ELSE
																	'No'
																END)
														) ;
													END IF;
												END IF;
											END IF;
										END IF;
									END IF;	
								END IF;			
							END IF;				
						END IF;
					END IF;	
				END IF;
			END IF;
		END IF;
	END IF;	

	IF 	(RTRIM(LTRIM(VS_INDEPENDENT_ASSESS)) = 'Yes') OR 
		(RTRIM(LTRIM(VS_ACADEMIC_SUPPORT)) = 'Yes') OR 
		(RTRIM(LTRIM(VS_POST_SECNDRY_EDU_SUPPORT)) = 'Yes') OR 
		(RTRIM(LTRIM(VS_CAREER_PREPARATION)) = 'Yes') OR
		(RTRIM(LTRIM(VS_OTH_FIN_ASSISTANCE))  = 'Yes') OR 
		(RTRIM(LTRIM(VS_EDU_FINANCIAL_ASSIST)) = 'Yes') OR 
		(RTRIM(LTRIM(VS_RM_BRD_FIN_ASSIST)) = 'Yes') OR 
		(RTRIM(LTRIM(VS_SUPVD_IND_LIVING)) = 'Yes') OR 
		(RTRIM(LTRIM(VS_MENTORING)) = 'Yes') OR 
		(RTRIM(LTRIM(VS_FM_SUPP_MARG_EDU)) = 'Yes') OR  
		(RTRIM(LTRIM(VS_HEALTH_EDU_RISK_PREVENTION)) = 'Yes') OR  
		(RTRIM(LTRIM(VS_HOUS_EDUCATION)) = 'Yes') OR  
		(RTRIM(LTRIM(VS_FIN_MANGT)) = 'Yes') OR 
		(RTRIM(LTRIM(VS_VOC_TRAINING)) = 'Yes') THEN

		 VS_CLNT_CHK = 'Y';
	ELSE
		 VS_CLNT_CHK = 'N';
	END IF;


	return VS_CLNT_CHK;

END;
$function$
;
