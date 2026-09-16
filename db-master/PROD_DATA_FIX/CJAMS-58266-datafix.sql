/*
   Issue Description: CJAMS-58266
   Category/ Module  : Decision
   Root cause: User request to update the override comment for the intake# I251013216400
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

update administrativeoverrides 
set comments = 'This referral was to be screened in as an ROH. Due to the error received on 1/28/2025, these allegations were re-entered 
and screened-in as and an ROH under referral # # I251013217231 and active service case # #251030455866.  It is important 
to note that without the original error, this referral would have been screened in as an ROH.  THIS WAS NOT AN APPROPRIATE AR RESPONSE.', 
updatedby = 'CJAMS-58266', updatedon = now()
where referralsnapshotid = 'c36d211a-9620-497a-9dce-06c6975a382b'
and activeflag = 1;