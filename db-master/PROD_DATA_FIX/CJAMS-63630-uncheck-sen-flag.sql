/*
Issue Description: CJAMS-63630 Substance Exposed Newborn checked
Category/Module: Intake did not case connect
Root cause: User error, First during the Intake creation the child was identified as a SEN child but later identified as the Child is not SEN. 
            The SEN flag connect be Deselected because the SEN flag become Historic, so data fix is need to deselect the SEN flag.Yes, User error, First during the Intake creation the child was identified as a SEN child but later identified as the Child is not SEN. The SEN flag connect be Deselected because the SEN flag become Historic, so data fix is need to deselect the SEN flag.
            Need data fix as mentioned below, 
            Intake# I251013389459
            CPS-IR Case# 251023153906
            Client ID : 204250619 (Kobe Muraawski)

            1. Add the below mentioned statement on the Intake and Service Case Narrative below the statement "Screen in as IR Neglect due to age of child and substance ingested."
            Statement:  '12/2/2025 Addendum: Kobe Muraawski did not meet the SEN criteria at the time the Intake was received due to age. SEN designation applies only to infants under 30 days old, and Kobe was 1 year old at the time of Intake. Therefore, the SEN flag will be deselected for Kobe.'
            2. Deselect the SEN Flag and the title should reflect as "Substance Exposed Newborn" instead of "Historic Substance Exposed Newborn" on the Person profile for the Client ID : 204250619 (Kobe Muraawski) in both the Intake and CPS IR case.
            3. Deselect the Substance Exposed Newborn checkbox in the SDM tab for both the Intake and CPS IR case.
Fix provided: Data fix has been done to make the changes as mentioned below to change the child to non-sen
            1. Add the below mentioned statement on the Intake and Service Case Narrative below the statement "Screen in as IR Neglect due to age of child and substance ingested."
            Statement:  '12/2/2025 Addendum: Kobe Muraawski did not meet the SEN criteria at the time the Intake was received due to age. SEN designation applies only to infants under 30 days old, and Kobe was 1 year old at the time of Intake. Therefore, the SEN flag will be deselected for Kobe.'
            2. Deselect the SEN Flag and the title should reflect as "Substance Exposed Newborn" instead of "Historic Substance Exposed Newborn" on the Person profile for the Client ID : 204250619 (Kobe Muraawski) in both the Intake and CPS IR case.
            3. Deselect the Substance Exposed Newborn checkbox in the SDM tab for both the Intake and CPS IR case.
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: No
Reason why no related code fix: User data entry error and data fix should resolve it. 
*/


--updating the narrative info
UPDATE intakesnapshot
SET jsondata = jsonb_set(
    jsondata, 
    '{General,Narrative}', 
    to_jsonb(
        replace(
            jsondata->'General'->>'Narrative', 
            'Assign to S. Showell.', 
            '12/2/2025 Addendum: Kobe Muraawski did not meet the SEN criteria at the time the Intake was received due to age. SEN designation applies only to infants under 30 days old, and Kobe was 1 year old at the time of Intake. Therefore, the SEN flag will be deselected for Kobe.<p><br></p><p>Assign to S. Showell.</p>'  
             
        )
    )
),
updatedby = 'CJAMS-63630',
updatedon = now()
WHERE jsondata->'General'->>'Narrative' LIKE '%Assign to S. Showell.%'
and intakenumber = 'I251013389459'
and activeflag = 1;

--Updating the substance exposed related fields in the intake snapshot
UPDATE intakesnapshot
SET 
    jsondata = jsonb_set(
        jsonb_set(
            jsonb_set(
                jsonb_set(
                    jsonb_set(
                    	jsonb_set(
	                        jsondata, 
	                        '{sdm,isnegrh_exposednewborn}', 
	                        CASE 
	                            WHEN jsondata->'sdm'->>'isnegrh_exposednewborn' = 'true' THEN 'false'::jsonb
	                            ELSE jsondata->'sdm'->'isnegrh_exposednewborn' 
	                        END
	                    ),
	                    '{sdm,riskofHarm,isnegrh_exposednewborn}', 
	                    CASE 
	                        WHEN jsondata->'sdm'->'riskofHarm'->>'isnegrh_exposednewborn' = 'true' THEN 'false'::jsonb
	                        ELSE jsondata->'sdm'->'riskofHarm'->'isnegrh_exposednewborn' 
	                    END
	                ),
	                '{persondetails,Person,0,senstatusflag}',
	                CASE 
	                    WHEN (jsondata->'persondetails'->'Person'->0->>'senstatusflag')::int = 1 THEN '0'::jsonb
	                    ELSE jsondata->'persondetails'->'Person'->0->'senstatusflag' 
	                END
	            ),
	            '{persondetails,Person,0,drugexposednewbornflag}',
	            CASE 
	                WHEN (jsondata->'persondetails'->'Person'->0->>'drugexposednewbornflag')::int = 1 THEN '0'::jsonb 
	                ELSE jsondata->'persondetails'->'Person'->0->'drugexposednewbornflag' 
	            END
	        ),
	        '{sdm,noImmediateList,isnoimmed_substantial_risk}',
	        CASE
	            WHEN jsondata->'sdm'->'noImmediateList'->>'isnoimmed_substantial_risk' = 'true' THEN 'false'::jsonb
	            ELSE jsondata->'sdm'->'noImmediateList'->'isnoimmed_substantial_risk'
	        END
	    ),
	    '{sdm,isnoimmed_substantial_risk}',
	        CASE
	            WHEN jsondata->'sdm'->>'isnoimmed_substantial_risk' = 'true' THEN 'false'::jsonb
	            ELSE jsondata->'sdm'->'isnoimmed_substantial_risk'
	        END
	 ),
    updatedby = 'CJAMS-63630',
    updatedon = now()
    WHERE intakenumber = 'I251013389459'
    AND activeflag = 1;


--updating the person sen flag

update person
set senstatusflag = null, 
    substanceexposednewbornflag = null, 
    substanceexposednewbornsourceid = null, 
    substanceexposednewbornsourcetypekey = null,
	substanceexposednewborntimetamp = null, 
    substanceclasses = null, 
    updatedby = 'CJAMS-63630', 
    updatedon = now()
where personid = '6068a97f-10a4-4285-96e2-18adf1561de0' and activeflag = 1;



--updating the case side sdm info
update intakeservicerequestsdm
set drugexposednewbornflag = 0,
    updatedon =now(),
    updatedby = 'CJAMS-63630'
where intakeserviceid = '6ab77b6e-0acd-44bb-ad10-5c1aeea367ac' and activeflag = 1;  


--updating the narrative in case side

update intakeservicerequest 
set narrative =   REGEXP_REPLACE(
        narrative, 
        '(Assign to S. Showell.)', 
        '12/2/2025 Addendum: Kobe Muraawski did not meet the SEN criteria at the time the Intake was received due to age. SEN designation applies only to infants under 30 days old, and Kobe was 1 year old at the time of Intake. Therefore, the SEN flag will be deselected for Kobe.</p><br></p><p>Assign to S. Showell.</p>'
    ),
    updatedon = now(),
    updatedby = 'CJAMS-63630'
where intakeserviceid = '6ab77b6e-0acd-44bb-ad10-5c1aeea367ac' 
and activeflag = 1;