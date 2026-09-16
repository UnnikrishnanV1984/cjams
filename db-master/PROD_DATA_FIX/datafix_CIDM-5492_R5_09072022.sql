-- CIDM-5492 - SAFE-C Data Fix needed (bulk cases)
/*
-- Issue Description: 
   Safe-C Assessments with missing child info. 
  
-- Category/ Module: Case Management
-- Root cause: Code was having falw and fix was deployed in production.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200172757",
      "childname": "Jordan Castillo Leighton"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '581f53b7-c62d-476f-b95d-2805dbcb79a0'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200834134",
      "childname": "Arianna Avilla-Altantar"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '14ff4fbb-906a-4166-a5ad-123781ea45d3'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200836793",
      "childname": "Landon Bryce Womack"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = 'e5285d6e-31ad-447a-85e9-a2787f610cf1'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "7 Yrs",
      "clientid": "3744080",
      "childname": "ISAAC JAY"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '6ec76d49-daf8-4283-9069-6d21d4e7e08e'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200159304",
      "childname": "Naafi James Adams"
    },
    {
      "age": "1 Yrs",
      "clientid": "200794518",
      "childname": "Hakim EUGENE Adams"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = 'ec7063b1-6466-41bc-ae07-737a5c5397a9'
	and activeflag = 1 ;										
										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200938242",
      "childname": "kayden gant"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '956a750e-3698-4503-b809-7317f4b0c8ce'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "200315689",
      "childname": "Skye Pruitt"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = 'c07c24f6-ac9d-4991-897a-43a98911fd69'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200938564",
      "childname": "Stone Elvey"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '81fa1599-74e3-414d-a626-618d46d51784'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200938643",
      "childname": "Maria Gomez"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '56fbbf05-eb1b-4276-a2f1-7de910544e08'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200938750",
      "childname": "Karlee Webb"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '9f45c780-93cf-4bd9-9d33-7489e5f2a068'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4027682",
      "childname": "JOANA MORALES"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '018d6db0-8f02-4321-a00f-9d0be203d022'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200938956",
      "childname": "Alayla Alford-Collins"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = 'aede6508-565f-48b8-a8c8-de73a113d8b0'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200939105",
      "childname": "Josue Cerros"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '01a4432c-debc-4dc4-9a55-9fbc3a296600'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200939105",
      "childname": "Josue Cerros"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = 'f8212314-0bbe-4720-bd50-fc8462a8beeb'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "200867637",
      "childname": "Morgan McGlasson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '05f60ccc-d1cd-45a0-b109-7a15797a104c'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "2299447",
      "childname": "BLAIR KENDLE"
    },
    {
      "age": "13 Yrs",
      "clientid": "3317562",
      "childname": "RIVER J KENDLE"
    },
    {
      "age": "6 Yrs",
      "clientid": "3943982",
      "childname": "AVYN A KENDLE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = '442ccd60-eb13-4438-8db3-1a69394c543d'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200939342",
      "childname": "Rece Johnson"
    },
    {
      "age": "4 Yrs",
      "clientid": "200939343",
      "childname": "Shepard Johnson"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = 'a8f5f378-ef4d-448d-aa37-2d7d4432dd74'
	and activeflag = 1 ;										
										
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "200889560",
      "childname": "Luis Jabree Santiago"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = 'b829b23f-8f54-4edb-b715-e8cc1b2720a2'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "2 Yrs",
      "clientid": "4454381",
      "childname": "SANTANA STEVENSON"
    },
    {
      "age": "5 Yrs",
      "clientid": "4454382",
      "childname": "SAVANNAH MAYE STEVENSON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R5'
--	,updatedon = now()
where assessmentid = 'c8ef7cfe-747a-4885-b114-b658882bcc28'
	and activeflag = 1 ;
