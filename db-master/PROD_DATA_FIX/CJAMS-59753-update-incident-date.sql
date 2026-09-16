/*
Issue Description:CJAMS-59753 Incident date must be changed
Category/Module: Break the Link
Root cause: Data entry error and correction needed as data fix needed for the case 241021939872:The Incident Date needs to be changed to 4/10/2019.
Fix provided: Data fix has been provided for the case 241021939872 and Incident Date changed to 4/10/2019.
Data/Code fix ticket#: CJAMS-59733
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Date entry error.
*/


update investigationallegation
set incidentdate = '2019-04-10 00:00:00',
    enddate = '2019-04-10 00:00:00',
    comments = 'On 04/10/2019 at around 04:47p.m. Extended Hours worker received a call regarding possible sexual child abuse that occurred with 10-year-old Brend Avila when she was 4-5 years old. The caller reported that on 04/10/2024 Brenda disclosed the past sexual abuse to her PRP Specialist, Erica Bailey. The caller disclosed that Erica urged Brenda to report the incident to her current therapist. The caller reported that Brenda disclosed that her biological mother’s male friend inappropriately touched her on her chest when she was 4 years old. The caller reported that she believes Brenda’s mom is still friends with the man and that she possibly talks about him to Brenda. The caller reported that Brenda was removed from her biological mother years ago, but now has supervised visits with her every weekend. The caller also reported that Brenda disclosed being sexually confronted by her aunt’s ex-husband. The caller reported that Brenda disclosed that her aunt’s ex-husband pulled out his penis and tried to penetrate her when she was five years old (one year after the first incident). The caller informed that she believes this incident was previously reported, her aunt divorced her husband, and he is no longer in the household. The caller disclosed that Brenda currently resides with her foster mom, Annette Bright, at 6907 Richardson Road, Baltimore, MD 21207. The caller reported that Brenda’s biological mom has a history of substance use but is unsure if there is a history of domestic violence or mental illness.',
    updatedby = 'CJAMS-59753',
    updatedon = now()
where investigationallegationid in ('44c997a2-80b2-4eae-bc7f-17a045870c73', '41359cae-d015-49d3-8ecd-a6fb8ca56483') 
and activeflag = 1;