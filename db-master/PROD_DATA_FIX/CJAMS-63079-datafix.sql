/* 
    Issue Description: CJAMS-63079
  Category/ Module  :contact notes
  Root cause: user error, user requested to update contact notes
  Fix provided: Data fix has been applied to update contact notes
  Pull request# for code fix: 
  Reason why no related code fix: 
  Status of the code fix if already submitted and expected prod fix date: N/A
  Backup before update/ delete: 
*/

UPDATE progressnotedetail
SET
  updatedby = 'CJAMS-63079',
  updatedon = now(),
  description = '<p>The worker arrived to Choptank ES at 11am for Carter''s Child Find Assessment. Ms. Gross was found outside smoking a cigarette before joining the meeting. Mr. Brazzle was scheduled to attend the intake, however, did not participate. During the meeting, it was concluded that Carter would be assessed for social-emotional needs, communication, and Autism (educational only). The assessments were completed by the IEP coordinators from Child Find on October 11, 2025, and the results will be reviewed on November 5, 2025. Also during the intake, Carter was again referred for Occupational Therapy, Speech Therapy, Autism, Audiology, and a vision check. Following the visit, the worker completed a home visit with Carter, Royal, and the Foster Parent. The foster parent has indicated that Carter has become better at bathing and gives her little to no issues with brushing his teeth. The foster mother also stated that Carter gets along well with her two older children in the home, eats well, has no issues sleeping, and has become accustomed to his daily schedule. He enjoys listening to music and being outside. The worker asked the foster parent if she needed any assistance with getting Carter appointments scheduled, she reported that she did not need any assistance at the time. The foster parent reported that Royal is adjusting well to their care. Since October 1, 2025, Royal began services with Infants and Toddlers, and is scheduled for sessions 3 times monthly. He has had 1 session thus far. The foster parent was given stretches to help improve his stiffness in his neck and arms. Royal has also learned how to hold his bottle, sit up without assistance, roll, and can stand with assistance. The worker interacted with both Royal and Carter throughout the remainder of the visit. There are no concerns to report.</p>'
WHERE
  progressnoteid = '9776efeb-f940-4810-9cb0-bf6099f1014f'
  AND progressnotedetailid = 'ea815018-3610-4c56-84d4-55558190eadc'
  AND activeflag = 1;