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
      "age": "17 Yrs",
      "clientid": "3156484",
      "childname": "XZAVION DEONBREA COUPLIN"
    },
    {
      "age": "15 Yrs",
      "clientid": "3156486",
      "childname": "ZION TOWNES-BEY"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'a1927d07-9aa7-4b19-bedc-d026e8a147e1'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "11 Yrs",
      "clientid": "3129296",
      "childname": "DANIEL T DINGLE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'c2e3dcaf-4b3d-4472-a64c-2ad251498656'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "4028314",
      "childname": "KYRI BALL"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '962699ba-46f9-4855-b8d8-bed14349eec7'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "1 Yrs",
      "clientid": "200302466",
      "childname": "Rosanna Schissler"
    },
    {
      "age": "2 Yrs",
      "clientid": "200856502",
      "childname": "Elena Butcher"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '1818bb59-9e14-443d-ad3d-985148f4ddc9'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "9 Yrs",
      "clientid": "200936578",
      "childname": "Emmanuel Tanis"
    },
    {
      "age": "0 Yrs",
      "clientid": "200936580",
      "childname": "Jonathan Tanis"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '9dc87373-3099-4ca0-aea4-a6402409ea1b'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200936580",
      "childname": "Jonathan Tanis"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '9b9dab53-9507-4fcc-b62b-f8e1fd13dc32'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "12 Yrs",
      "clientid": "200859482",
      "childname": "Leonardo Calle"
    },
    {
      "age": "15 Yrs",
      "clientid": "4479204",
      "childname": "MIGUEL CALLE"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'a2e40ce9-3a70-4662-b34f-5e131ba48f6a'
	and activeflag = 1 ;
	
update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "200927374",
      "childname": "Ma''shay Cox"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '84d9ecbf-1897-47c5-885a-d243d1de8e0e'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "17 Yrs",
      "clientid": "3363594",
      "childname": "JULIANA ELIZABETH LEEKS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '55ff3c8a-3ca1-4a94-a107-19d80b5b464c'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200931773",
      "childname": "Violet Morley"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '62c88734-ead9-4c35-b85e-f58f126969d7'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4455534",
      "childname": "SHAWN A WILLIAMS"
    },
    {
      "age": "4 Yrs",
      "clientid": "4455533",
      "childname": "KENNEDI D WILLIAMS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '69130352-ca9e-4605-b37b-2e83a6ea7036'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200807685",
      "childname": "Teona Maffett"
    },
    {
      "age": "3 Yrs",
      "clientid": "200807681",
      "childname": "Taliyah Maffett"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '31016ed3-15cc-4912-b999-466abe7dd25b'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200933148",
      "childname": "Blair Randolph"
    },
    {
      "age": "5 Yrs",
      "clientid": "200933147",
      "childname": "Brandi Samuels"
    },
    {
      "age": "0 Yrs",
      "clientid": "200933150",
      "childname": "Brandon Randolph"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '8042b988-9811-48f2-ab8b-5fe47b28d4ec'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200928621",
      "childname": "lillia love"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '61e33b86-7425-4078-a4fb-794395543938'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200935039",
      "childname": "Jude Butler"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'ccf07a84-8934-4b2f-a3bc-b65f49ba7314'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "200935625",
      "childname": "Kiilay Daniels"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '125f5926-5326-4957-b4f6-0aa029040704'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "200935672",
      "childname": "Owen Liam Garrison"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '89b42141-a8aa-4953-bea9-935f6e1e5306'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200935532",
      "childname": "Ke''Wain Antonio Phillips"
    },
    {
      "age": "2 Yrs",
      "clientid": "200935531",
      "childname": "Ke''Lana A Phillips"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '7908480a-9b28-4955-aa68-77d5f831d09d'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "18 Yrs",
      "clientid": "200939093",
      "childname": "Laisha M Caceres"
    },
    {
      "age": "17 Yrs",
      "clientid": "200939094",
      "childname": "Jadie B Caceres"
    },
    {
      "age": "15 Yrs",
      "clientid": "200939095",
      "childname": "Hailey M Caceres"
    },
    {
      "age": "13 Yrs",
      "clientid": "200939097",
      "childname": "Geray N Caceres"
    },
    {
      "age": "9 Yrs",
      "clientid": "200936362",
      "childname": "Matthew Caceres"
    },
    {
      "age": "7 Yrs",
      "clientid": "200939098",
      "childname": "Kacey Y Caceres"
    },
    {
      "age": "4 Yrs",
      "clientid": "200939099",
      "childname": "Bridgett Caceres"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'e9c9410b-5c6e-454f-9e4f-703c96070ec1'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "3597446",
      "childname": "ROWAN HEINER"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'c2686ae8-7333-43a8-9de0-a43d4408c257'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "5 Yrs",
      "clientid": "4040255",
      "childname": "JUEL CARTER"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '4bfd090b-7a5c-4a12-98aa-a5f28ec1f191'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "4288204",
      "childname": "KALANI A ROGERS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '608e7fef-a0e3-4f0f-9c84-85610beb3f91'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "15 Yrs",
      "clientid": "3168523",
      "childname": "MADISON COLLINS"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'c52cbb70-3146-4755-99fe-b71f4c15c7c4'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200929216",
      "childname": "Isabella Ogbunigwe"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'fd3b1fa9-ee52-4d8a-9b87-a5fd2d399231'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "13 Yrs",
      "clientid": "2578153",
      "childname": "SANAI HOLLAND"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'c39dc41b-d5e8-4bfb-98c5-bb2d58b57d1b'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "3849779",
      "childname": "IAN A MCARDLE"
    },
    {
      "age": "4 Yrs",
      "clientid": "4420039",
      "childname": "SELAH Raven WALTER"
    },
    {
      "age": "4 Yrs",
      "clientid": "200939117",
      "childname": "Athena Elizabeth Taylor"
    },
    {
      "age": "3 Yrs",
      "clientid": "200824129",
      "childname": "Octavia Voelker"
    },
    {
      "age": "4 Yrs",
      "clientid": "4230873",
      "childname": "EZRA M JONES"
    },
    {
      "age": "6 Yrs",
      "clientid": "3951490",
      "childname": "CHARLES SYRUS HILL"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '9e7e0a3d-2761-4aa7-9156-0a8a316a5078'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "10 Yrs",
      "clientid": "200937687",
      "childname": "Jinghan Chen"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '58ba1ff8-dc2c-4128-8337-10bdc0c56697'
	and activeflag = 1 ;

update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "6 Yrs",
      "clientid": "200937907",
      "childname": "Amarie Tinsley"
    },
    {
      "age": "122 Yrs",
      "clientid": "200937908",
      "childname": "Xavier Tinsley"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = 'bc222a0a-48d5-416f-8a8c-07a986a5a2ac'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "16 Yrs",
      "clientid": "3641806",
      "childname": "AALIYAH ANN ALFRED"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '1aca2dbe-4ace-439a-9c04-8769e04ba6bb'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200937920",
      "childname": "Camdon Kieta"
    },
    {
      "age": "1 Yrs",
      "clientid": "200939077",
      "childname": "Bennett Kieta"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '64c161af-7874-43ee-9b2f-7c4bc2c979b7'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "4 Yrs",
      "clientid": "200148393",
      "childname": "LAILAH JOHNSON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '1f19e2dd-62f6-4b04-ae2b-d7d3b1519292'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "3 Yrs",
      "clientid": "200813983",
      "childname": "Jaxon Chance"
    },
    {
      "age": "4 Yrs",
      "clientid": "200813980",
      "childname": "Brooklyn Rose Chance"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '089ce48d-dcf0-43ef-90d6-f2589a6dbe4b'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "0 Yrs",
      "clientid": "200938137",
      "childname": "KAIDEN ELIAS JACKSON"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '001d1364-8205-448b-858a-6e9d9855b873'
	and activeflag = 1 ;


update assessment
set submissiondata = jsonb_set(submissiondata, '{childdatagrid}','[
    {
      "age": "14 Yrs",
      "clientid": "200938534",
      "childname": "Dileydi Garcia Cordero"
    },
    {
      "age": "18 Yrs",
      "clientid": "200938014",
      "childname": "Rosalind Cordero"
    },
    {
      "age": "12 Yrs",
      "clientid": "200938535",
      "childname": "German Garcia Cordero"
    }
    ]')
--	,updatedby = 'CIDM-5492-R3'
--	,updatedon = now()
where assessmentid = '9cdb2d92-3539-45c6-b2f6-783b191f67fa'
	and activeflag = 1 ;
