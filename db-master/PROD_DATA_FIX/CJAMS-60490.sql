
/*
Issue Description: 3171993:We need to update youth's permanency plan but this error message continues to pop up. We are unable to add a new permanency plan for this youth, who's permanency plan has changed to APPLA.
Root cause: User requested to move the persons from old to new service case,due to user do not have access to do that.
Fix provided: DB queries  update progressnote tables
Data/Code fix ticket#: CJAMS-60490
Regression Impacts: N/A 
Is Code fix Required?: No
Code fix ticket#: N/A
Reason why no related code fix: User Error
Status of the code fix if already submitted and expected prod fix date: data fix done, raising the PR
Backup before update/ delete:Query:
*/

--PART 1
update progressnote
set servicecaseid = '2af28137-e13f-421b-b6a1-052cf2bd1868'
where progressnoteid in (
	select distinct p2.progressnoteid from contactparticipant c
	inner join progressnote p2 on p2.progressnoteid = c.progressnoteid
	where p2.servicecaseid = 'e246ff09-2942-4312-a88f-3f8b1aa6bc55' and p2.activeflag = 1 and c.activeflag = 1
	and c.participantid in (
	'56f1e0d0-423c-4854-9209-8475b4c73b30', '136e9792-f1bd-4601-b719-55c5eb60ca60', '6d603da5-eb70-4ae3-bf8b-f108646bcb55'))
and activeflag = 1;

update contactparticipant
set participantid = case participantid
	when '56f1e0d0-423c-4854-9209-8475b4c73b30'::uuid then '56d6f4ba-1c4d-4382-8e8d-099b6e14ef2f'::uuid
	when '136e9792-f1bd-4601-b719-55c5eb60ca60'::uuid then '46e86190-75fa-4929-87f7-f1444f3a2f09'::uuid
	when '6d603da5-eb70-4ae3-bf8b-f108646bcb55'::uuid then 'f610549c-f6c0-4d2a-a02a-a456aca656b5'::uuid
end
where progressnoteid in (
	select distinct p2.progressnoteid from contactparticipant c1
	inner join progressnote p2 on p2.progressnoteid = c1.progressnoteid
	where p2.servicecaseid = '2af28137-e13f-421b-b6a1-052cf2bd1868' and p2.activeflag = 1 and c1.activeflag = 1
	and c1.participantid in (
	'56f1e0d0-423c-4854-9209-8475b4c73b30', '136e9792-f1bd-4601-b719-55c5eb60ca60', '6d603da5-eb70-4ae3-bf8b-f108646bcb55'))
and participantid in ('56f1e0d0-423c-4854-9209-8475b4c73b30', '136e9792-f1bd-4601-b719-55c5eb60ca60', '6d603da5-eb70-4ae3-bf8b-f108646bcb55')
and activeflag = 1;

update progressnote 
set focusperson = jsonb_set(
	focusperson::jsonb, '{focuspersonjson}', 
	(
		select jsonb_agg(
			elem || jsonb_build_object(
				'intakeservicerequestactorid', case elem->>'intakeservicerequestactorid'
					when '56f1e0d0-423c-4854-9209-8475b4c73b30' then '56d6f4ba-1c4d-4382-8e8d-099b6e14ef2f'
					when '136e9792-f1bd-4601-b719-55c5eb60ca60' then '46e86190-75fa-4929-87f7-f1444f3a2f09'
					when '6d603da5-eb70-4ae3-bf8b-f108646bcb55' then 'f610549c-f6c0-4d2a-a02a-a456aca656b5'
					else elem->>'intakeservicerequestactorid'
				end,
				'participantid', case elem->>'participantid'
					when '56f1e0d0-423c-4854-9209-8475b4c73b30' then '56d6f4ba-1c4d-4382-8e8d-099b6e14ef2f'
					when '136e9792-f1bd-4601-b719-55c5eb60ca60' then '46e86190-75fa-4929-87f7-f1444f3a2f09'
					when '6d603da5-eb70-4ae3-bf8b-f108646bcb55' then 'f610549c-f6c0-4d2a-a02a-a456aca656b5'
					else elem->>'participantid'
				end
			)
		) from jsonb_array_elements(focusperson::jsonb->'focuspersonjson') as x(elem)
	))
where progressnoteid in (
	select distinct p2.progressnoteid from contactparticipant c1
	inner join progressnote p2 on p2.progressnoteid = c1.progressnoteid
	where p2.servicecaseid = '2af28137-e13f-421b-b6a1-052cf2bd1868' and p2.activeflag = 1 and c1.activeflag = 1
	and c1.participantid in (
	'56d6f4ba-1c4d-4382-8e8d-099b6e14ef2f', '46e86190-75fa-4929-87f7-f1444f3a2f09', 'f610549c-f6c0-4d2a-a02a-a456aca656b5'))
and activeflag = 1;

--PART 2 A 
--'8eef21ec-5e13-45d5-be11-fb55072c7b8d','136e9792-f1bd-4601-b719-55c5eb60ca60'
--'6d603da5-eb70-4ae3-bf8b-f108646bcb55', 'e7b954ab-e135-4a10-bd8a-f842c0a3c830'
update assessment
set objectid = '2af28137-e13f-421b-b6a1-052cf2bd1868',
submissiondata = jsonb_set(submissiondata, '{assessmentactor}', 
	(
		select jsonb_agg(case 
			when elem->>'intakeservicerequestactorid' = '8eef21ec-5e13-45d5-be11-fb55072c7b8d'
			then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
			when elem->>'intakeservicerequestactorid' = '136e9792-f1bd-4601-b719-55c5eb60ca60'
			then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
			when elem->>'intakeservicerequestactorid' = '6d603da5-eb70-4ae3-bf8b-f108646bcb55'
			then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
			when elem->>'intakeservicerequestactorid' = 'e7b954ab-e135-4a10-bd8a-f842c0a3c830'
			then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
			else elem
		end
		) from jsonb_array_elements(submissiondata->'assessmentactor') elem
	)
),
actualdata = (
	(
		select jsonb_pretty(
			jsonb_set(
				actualdata::jsonb, '{assessmentactor}',
				(
					select jsonb_agg(case 
						when elem->>'intakeservicerequestactorid' = '8eef21ec-5e13-45d5-be11-fb55072c7b8d'
						then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
						when elem->>'intakeservicerequestactorid' = '136e9792-f1bd-4601-b719-55c5eb60ca60'
						then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
						when elem->>'intakeservicerequestactorid' = '6d603da5-eb70-4ae3-bf8b-f108646bcb55'
						then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
						when elem->>'intakeservicerequestactorid' = 'e7b954ab-e135-4a10-bd8a-f842c0a3c830'
						then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
						else elem
					end
					) from jsonb_array_elements(actualdata::jsonb->'assessmentactor') elem
				)
			)
		)::jsonb
	)::json
)
where assessmentid in (
'418e8fb2-0eb8-4ab9-b6e3-d19682e681a1',
'05d5a934-7cbf-4b9a-819f-e82c6160058c',
'3ba1a1f2-47a1-47f9-b29a-9537469a5e96',
'c43fb520-915d-4e67-a45f-8df53d444c06',
'42b8ac53-9380-4259-badb-823ec678b6f8',
'8e404c56-2d33-41e0-b61f-922e31dca05a');

--PART 2 B
update assessment
set objectid = '2af28137-e13f-421b-b6a1-052cf2bd1868',
submissiondata = jsonb_set(submissiondata, '{assessmentactor}', 
	(
		select jsonb_agg(case 
			when elem->>'intakeservicerequestactorid' = '8eef21ec-5e13-45d5-be11-fb55072c7b8d'
			then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
			when elem->>'intakeservicerequestactorid' = '136e9792-f1bd-4601-b719-55c5eb60ca60'
			then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
			when elem->>'intakeservicerequestactorid' = '6d603da5-eb70-4ae3-bf8b-f108646bcb55'
			then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
			when elem->>'intakeservicerequestactorid' = 'e7b954ab-e135-4a10-bd8a-f842c0a3c830'
			then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
			else elem
		end
		) from jsonb_array_elements(submissiondata->'assessmentactor') elem
	)
),
actualdata = (
	(
		select jsonb_pretty(
			jsonb_set(
				actualdata::jsonb, '{assessmentactor}',
				(
					select jsonb_agg(case 
						when elem->>'intakeservicerequestactorid' = '8eef21ec-5e13-45d5-be11-fb55072c7b8d'
						then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
						when elem->>'intakeservicerequestactorid' = '136e9792-f1bd-4601-b719-55c5eb60ca60'
						then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
						when elem->>'intakeservicerequestactorid' = '6d603da5-eb70-4ae3-bf8b-f108646bcb55'
						then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
						when elem->>'intakeservicerequestactorid' = 'e7b954ab-e135-4a10-bd8a-f842c0a3c830'
						then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
						else elem
					end
					) from jsonb_array_elements(actualdata::jsonb->'assessmentactor') elem
				)
			)
		)::jsonb
	)::json
)
where assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035'
and objectid = 'e246ff09-2942-4312-a88f-3f8b1aa6bc55' and exists (
	select 1 from jsonb_array_elements(submissiondata->'assessmentactor') elem
	where elem->>'intakeservicerequestactorid' in ('8eef21ec-5e13-45d5-be11-fb55072c7b8d','136e9792-f1bd-4601-b719-55c5eb60ca60')
);

update assessment
set objectid = '2af28137-e13f-421b-b6a1-052cf2bd1868',
submissiondata = jsonb_set(submissiondata, '{assessmentactor}', 
	(
		select jsonb_agg(case 
			when elem->>'intakeservicerequestactorid' = '8eef21ec-5e13-45d5-be11-fb55072c7b8d'
			then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
			when elem->>'intakeservicerequestactorid' = '136e9792-f1bd-4601-b719-55c5eb60ca60'
			then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
			when elem->>'intakeservicerequestactorid' = '6d603da5-eb70-4ae3-bf8b-f108646bcb55'
			then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
			when elem->>'intakeservicerequestactorid' = 'e7b954ab-e135-4a10-bd8a-f842c0a3c830'
			then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
			else elem
		end
		) from jsonb_array_elements(submissiondata->'assessmentactor') elem
	)
),
actualdata = (
	(
		select jsonb_pretty(
			jsonb_set(
				actualdata::jsonb, '{assessmentactor}',
				(
					select jsonb_agg(case 
						when elem->>'intakeservicerequestactorid' = '8eef21ec-5e13-45d5-be11-fb55072c7b8d'
						then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
						when elem->>'intakeservicerequestactorid' = '136e9792-f1bd-4601-b719-55c5eb60ca60'
						then elem || '{"intakeservicerequestactorid": "46e86190-75fa-4929-87f7-f1444f3a2f09"}'
						when elem->>'intakeservicerequestactorid' = '6d603da5-eb70-4ae3-bf8b-f108646bcb55'
						then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
						when elem->>'intakeservicerequestactorid' = 'e7b954ab-e135-4a10-bd8a-f842c0a3c830'
						then elem || '{"intakeservicerequestactorid": "f610549c-f6c0-4d2a-a02a-a456aca656b5"}'
						else elem
					end
					) from jsonb_array_elements(actualdata::jsonb->'assessmentactor') elem
				)
			)
		)::jsonb
	)::json
)
where assessmenttemplateid = 'f6e4c466-72ae-4453-9997-a2a12fcf8035'
and objectid = 'e246ff09-2942-4312-a88f-3f8b1aa6bc55' and exists (
	select 1 from jsonb_array_elements(submissiondata->'assessmentactor') elem
	where elem->>'intakeservicerequestactorid' in ('6d603da5-eb70-4ae3-bf8b-f108646bcb55', 'e7b954ab-e135-4a10-bd8a-f842c0a3c830')
);