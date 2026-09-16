-- CDM-26309- Duplicate case needs Screened Out
/*
   File Name: CDM-26309-intakedastaging-AppendcommentNarrativesection
-- Issue Description: 
    For the case 221020232533 user wants to append "this is a duplicate report see case #221020228079 and duplicate report selected under the recommendation and overrides tab" 
	in the Narrative section
    Customer Email ID:stephanie.cooke1@maryland.gov
  
-- Resolution: Updated the intakedastaging table

-- Category/ Module: Case Management
-- Root cause: User Error
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A

*/	
	
-- <p>Received t/c from SW Moshe, wanting to report a delayed reaction for a child to receive medical attention.  SW reports that the grandparents, Shannon Tucker and Denair Tucker brought the child, Blessing Tucker, to the hospital because mom allegedly dropped her curler iron on Blessings right foot while she was visiting with mom.  SW reports Blessing is usually with the grandparents, she just happen to go to her mom this weekend.  SW reports moms dad, Shannon, states he does not have an address for mom.  SW reports that Mr. Shannon just wanted to get Blessings foot looked at.  SW reports she has a 2cm bruise on her right foot.  Dr. Gonzalez reports she examined the child and the explanation is consistent with the bruise.  SW reports the Dr. does not want to submit a physical abuse report, but, will report medical neglect for delay in treatment.  There is currently no known address for mom and Blessing is currently at the grandparents home, 1344Kenton RD, Parkville, MD 410-908-1418.</p><p><br></p><p>THIS IS A MEDICAL NEGLECT ASSIGNED TO MARIA ADIBE, SUP, S. BROWN, DIV. 2</p><p><br></p><p>THIS CASE ENTERED BY MICHELLE FREEMAN WITH BRITTANY LEE LOG IN.</p>
update
	intakesnapshot
set
	jsondata = jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}', '"<p>Received t/c from SW Moshe, wanting to report a delayed reaction for a child to receive medical attention.  SW reports that the grandparents, Shannon Tucker and Denair Tucker brought the child, Blessing Tucker, to the hospital because mom allegedly dropped her curler iron on Blessings right foot while she was visiting with mom.  SW reports Blessing is usually with the grandparents, she just happen to go to her mom this weekend.  SW reports moms dad, Shannon, states he does not have an address for mom.  SW reports that Mr. Shannon just wanted to get Blessings foot looked at.  SW reports she has a 2cm bruise on her right foot.  Dr. Gonzalez reports she examined the child and the explanation is consistent with the bruise.  SW reports the Dr. does not want to submit a physical abuse report, but, will report medical neglect for delay in treatment.  There is currently no known address for mom and Blessing is currently at the grandparents home, 1344Kenton RD, Parkville, MD 410-908-1418.</p><p><br></p><p>THIS IS A MEDICAL NEGLECT ASSIGNED TO MARIA ADIBE, SUP, S. BROWN, DIV. 2</p><p><br></p><p>THIS CASE ENTERED BY MICHELLE FREEMAN WITH BRITTANY LEE LOG IN.</p><br><p>this is a duplicate report see case #221020228079 and duplicate report selected under the recommendation and overrides tab</p>"')),
	updatedby = 'CDM-263098',
	updatedon = now()
where
	intakenumber = 'I221010289365'
	and activeflag = 1;

-- <p>Received t/c from SW Moshe, wanting to report a delayed reaction for a child to receive medical attention.  SW reports that the grandparents, Shannon Tucker and Denair Tucker brought the child, Blessing Tucker, to the hospital because mom allegedly dropped her curler iron on Blessings right foot while she was visiting with mom.  SW reports Blessing is usually with the grandparents, she just happen to go to her mom this weekend.  SW reports moms dad, Shannon, states he does not have an address for mom.  SW reports that Mr. Shannon just wanted to get Blessings foot looked at.  SW reports she has a 2cm bruise on her right foot.  Dr. Gonzalez reports she examined the child and the explanation is consistent with the bruise.  SW reports the Dr. does not want to submit a physical abuse report, but, will report medical neglect for delay in treatment.  There is currently no known address for mom and Blessing is currently at the grandparents home, 1344Kenton RD, Parkville, MD 410-908-1418.</p><p><br></p><p>THIS IS A MEDICAL NEGLECT ASSIGNED TO MARIA ADIBE, SUP, S. BROWN, DIV. 2</p><p><br></p><p>THIS CASE ENTERED BY MICHELLE FREEMAN WITH BRITTANY LEE LOG IN.</p>
update
	intakedastaging
set
	jsondata = jsonb_set(jsondata, '{General}', jsonb_set(jsondata->'General', '{Narrative}', '"<p>Received t/c from SW Moshe, wanting to report a delayed reaction for a child to receive medical attention.  SW reports that the grandparents, Shannon Tucker and Denair Tucker brought the child, Blessing Tucker, to the hospital because mom allegedly dropped her curler iron on Blessings right foot while she was visiting with mom.  SW reports Blessing is usually with the grandparents, she just happen to go to her mom this weekend.  SW reports moms dad, Shannon, states he does not have an address for mom.  SW reports that Mr. Shannon just wanted to get Blessings foot looked at.  SW reports she has a 2cm bruise on her right foot.  Dr. Gonzalez reports she examined the child and the explanation is consistent with the bruise.  SW reports the Dr. does not want to submit a physical abuse report, but, will report medical neglect for delay in treatment.  There is currently no known address for mom and Blessing is currently at the grandparents home, 1344Kenton RD, Parkville, MD 410-908-1418.</p><p><br></p><p>THIS IS A MEDICAL NEGLECT ASSIGNED TO MARIA ADIBE, SUP, S. BROWN, DIV. 2</p><p><br></p><p>THIS CASE ENTERED BY MICHELLE FREEMAN WITH BRITTANY LEE LOG IN.</p><br><p>this is a duplicate report see case #221020228079 and duplicate report selected under the recommendation and overrides tab</p>"')),
	updatedby = 'CDM-263098',
	updatedon = now()
where
	intakenumber = 'I221010289365'
	and activeflag = 1;