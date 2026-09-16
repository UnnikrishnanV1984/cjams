/*
Issue Description: TPR Reversal unable to be entered in CJAMS court tab.
Category/Module: Bug
Root cause: Seems like there was a data error where user entered info for the same child twice
Fix provided: DB query to insert a new record of the mother in TPR for the other child
Data/Code fix ticket#: CDM-42229
Regression Impacts: N/A
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: Data error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR

Backup before update/ delete:Query:
delete from tprdetails where tprrecommendationid = '3d2dfd0d-a33e-4280-aaea-70be2cca4b89'  and insertedby = 'CDM-42229'
and intakeservicerequestactorid = 'db3f2abd-577b-4d8a-a25e-0283adf5e52b' and activeflag = 1;
*/

--Inserting new record in tprdetails
insert into tprdetails
	(tprdetailsid, tprrecommendationid, intakeservicerequestactorid, terminationtypekey, appealdate, reason, activeflag, insertedby, insertedon,
	updatedby, updatedon, effectivedate, servicecaseid, isdenied, isgranted, tprdecisiondate, relationshiptypekey, singleparent,
	intakeservreqcourtorderid, tprpetitiondate, iscontested)
values (gen_random_uuid(), '3d2dfd0d-a33e-4280-aaea-70be2cca4b89', 'db3f2abd-577b-4d8a-a25e-0283adf5e52b', 'PARCRTWOVR',
	'2023-10-23 08:00:00.000', 'TPR contested. Mother did not attend TPR hearing.', 1, 'CDM-42229', now(), 'CDM-42229', now(),
	'2023-11-16 21:51:18.558', '652176e4-ae30-4c70-ae10-b2f1e7010580', null, true, '2023-10-23 04:00:00.000', 'BGMTHR', null,
	'8c8ecb3c-a756-42cf-a3c4-ab5a38c40bc1', '2023-10-23 08:00:00.000', true);