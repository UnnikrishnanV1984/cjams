/*
   Issue Description: CJAMS-58014
   Category/ Module  : Narrative tab, sdm
   Root cause: user wants add the Narrative comments and also incheck the SEN flag and risk of harm
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
    Need to do data fix
*/

update person
set    substanceexposednewbornflag = NULL,  -- 1
       substanceexposednewbornsourcetypekey = NULL,  -- '2954'
       substanceexposednewbornsourceid = NULL,  -- 'I251013233808'
       substanceexposednewborntimetamp = NULL,  -- '2025-02-27 15:11:32.493'
       substanceclasses = NULL,  -- '["BMJA"]'
       senstatusflag = NULL,  -- 1
       updatedby = 'CJAMS-58014', 
       updatedon = now()
where  cjamspid = 204081310 and activeflag = 1;



UPDATE intakesnapshot
SET updatedby = 'CJAMS-58014',
    updatedon = now(),
    jsondata = jsonb_set(
        jsondata, 
        '{General}', 
        (jsondata->'General') - 'Narrative' || jsonb_build_object(
            'Narrative', 
            '<p>CCDSS social worker Emily Ridgely emailed an update to an open Risk of Harm case # <span style="background-color: rgb(255, 255, 255); color: rgb(35, 82, 124);">251030464049</span>.</p><p><br></p><p>Child:</p><p>Kadence Savage (White)</p><p>DOB: 02/09/2025</p><p><br></p><p>Parents:</p><p>Kristina White</p><p>DOB: 08/07/1991</p><p>127 W. Main Street, Westminster, MD 21157</p><p>(443) 583-3320</p><p><br></p><p>Wicasa Martinson</p><p>DOB: 04/14/1983</p><p>127 W. Main Street, Westminster, MD 21157</p><p><br></p><p>This worker visited with Ms. White and Mr. Martinson for a regularly scheduled visit at 2:00 P.M. on 2/26/25 at which time Ms. White informed this worker that Kadence had passed away that morning. This worker called Sally, the social worker at Sinai Hospital, to confirm. She stated that Kadence passed at 4:26 A.M. due to complications from premature birth (23 weeks gestation). Ms. White tested positive for THC at the time of delivery.</p><p><br></p><p>Referral reviewed with screening supervisor Kara Finamore on 2-27-25 at 9:30 AM, and the decision was made to screen out the referral as an FYI, check the fatality button, and forward as an FYI to the active worker.</p> Kadance Savage did not meet SEN criteria- no positive tox result, no displays of prenatal substance exposure, or no display of Fetal Alcohol Spectrum Disorder.</p>'
        )
    )
WHERE intakenumber = 'I251013233808' 
  AND activeflag = 1;
