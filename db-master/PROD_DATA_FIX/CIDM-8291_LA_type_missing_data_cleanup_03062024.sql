-- CIDM-8291 - Adhoc Living arrangement type missing report
/*
-- Issue Description: 
   Living arrangement with missing LA type
      
-- Category/ Module: Living Arrangement (Case Management)
-- Root cause: CJAMS is not having length restrictions (validation) for LA address1, address2 & city etc. on application screen
--			   Due to which multiple Living Arrangement are missing data in livingarrangement table    	
-- Fix Provided: Datafix has been promoted to fix or soft-delete the living arrangement record(s) based on the user input.
-- Note: Code fix has been promoted as a part of CIDM-8269
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3099551	1054212		MELVIN E GRUBB 	1355731			5/1/1989	5/8/1989
-- Living Arrangment is in triplicate. Delete two with least information and do not have appovals
-- 59fb2287-f43d-441e-be07-f9ec8b12fc71	1355731
-- 26651dbc-fdf0-402e-a7bf-376002d9987d	1355733

	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3226923	1485516	CATRINA  BANKES 	1369423	8/18/2002	8/18/2002
-- comments: Delete Previous living arrangement is documented as Own Home when she aged out
-- ae3ea763-85aa-4830-a5bb-d2d488d9ddab	1369423

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	231030092347	1737937	ALISHA J FAUST 	1060740	12/12/2004	8/29/2006
-- comments: Delete No information
-- fbdf4fad-2131-4d09-88c6-c2659088c711	1060740	
	
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3169787	2252610		KYLEE ADAMS		1675477			5/30/2023	5/30/2023
-- comments: There is 2 Living Arrangments with this time frame. Please delete both. 
-- eba4b70f-7ff5-41d8-881c-1c8ac5ea8a9b	1673239
-- b65d5be1-284a-4587-b283-cdd89641f30a	1675477

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3288360	1733525		DIAMOND  LAGROOM 	1677488			5/28/2023	7/27/2023
-- comments: There is 1 Living Arrangment with this time frame. Please delete it.
-- 55a6de58-37ad-415b-aad3-0847915e41ce	1677488


-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	211030008900	1716688		KIMBERLY  CAMPBELL 	1598287			1/11/2023	1/11/2023
-- comments: There is 1 Living Arrangment with this time frame. Please delete it.
-- aa6eed3a-0ba0-4448-bd8e-79d6df6d0316	1598287

-- County			Case ID			Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	221030016828	200924040	Junior  Akili 	1572788			6/19/2022	6/23/2022
-- comments: There are 2 Living Arrangments with these time frames. Please delete the one with the least information
-- 78b99ae6-14ad-4ee4-ad2f-66899483cee9	1572788

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3236684	3637750		JADEN C CAMPBELL 	1569356			12/22/2021	12/22/2021
-- comments: There are 2 Living Arrangments with this time frame.  Please delete the one with the least information
-- 28f38808-06ba-4ec0-9334-2d0401b4294d	1569356

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3220667	4342741		SAKIRA  MATTHEWS 	1568381			11/27/2021	11/27/2021
-- comments: There is 1 Living Arrangment with this time frame. Please delete it.
-- e2a79acb-4ef7-4625-b245-0a82191a18e1	1568381

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3152758	1691817		ZION  DAVIS 	1568695			11/18/2021	11/18/2021
-- comments: There is one Living Arrangment with this time frame. Please delete it.
-- ba049b42-c30b-486f-b882-08302b9fd598	1568695

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3304703	4449427		MARYAM  JONES 	1568140			10/23/2021	10/23/2021
-- comments: There are 2 Living Arrangments with this time frame.  Please delete the one with the least information
-- 4c6ace71-4045-4679-8e1d-45c9e971d105	1568140

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3117999	3796794		JOHNATHAN K BARNES 	1566948			10/1/2021	10/1/2021
-- comments: There is 1 Living Arrangement with this time frame.  Please delete
-- 93c2b8b6-c7f2-40e4-adf7-c2c39bf649f3	1566948

-- County			Case ID	Client ID	Client Name					Placement ID	Entry Date	Exit Date
-- Baltimore City	3270986	4005971		AUSTIN COURTNEY POLSTON 	1567789			9/28/2021	9/28/2021
-- comments: There are 2 Living Arrangments with this timeframe. Delete the one with no information
-- e49da942-d568-4694-832e-02553d04501d	1567789

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3239116	4307140		AUBREE  VANSTORY 	1566519			9/16/2021	9/20/2021
-- comments: There are 2 Living Arrangements with this time frame.  Please delete one 
--		     and add to the other Living Arrangment that the type is Respite and the Primary caregive is Jacqeline Hardwick
-- 9b700350-a0b7-4787-adf4-6b2d5ba724ab	1566519

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3187605	1699946		VALENZO R DAVIS 	1566380			9/8/2021	9/28/2021
-- comments: There is 1 Living Arrangment for these dates.  Please delete as corret provider placement is completed
-- 1d22a18b-40ec-4cc8-b2d9-d89f4ca74109	1566380

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3057171	200794740	Tyler   Thompson 	1565668			8/16/2021	8/17/2021
-- comments: 
-- 499fc8db-9816-4841-a52e-a8133b6b3f45	1565663
-- a29f3c83-eddb-4c97-b7ee-48874d9b3a8f	1565668
-- ff6fd733-30be-44d9-996e-e101cbda28ce	1565665
-- 14ceaf5a-bba7-43eb-a18d-e3cc0e98e441	1565666
-- d72501bd-328e-4020-98b0-91cb61d75196	1565664

-- County			Case ID			Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202107706677	200643036	Raheem  Moore 	1565615			8/16/2021	8/16/2021
-- comments: There are three Living Arrangments with this time frame.  Please delete all three entrees
-- f534f48a-e441-4ed8-a85c-0960a6877e3b	1565614
-- a92b26f1-ac07-4594-b74e-ecb5eaeca7b6	1565615
-- 9a78ad09-8534-4772-8aba-f53ee675c631	1565616

-- County			Case ID	Client ID	Client Name				Placement ID	Entry Date	Exit Date
-- Baltimore City	3282617	3244551		DEMARCO Jamal GLADDEN 	1565354			8/10/2021	8/10/2021
-- comments: There are 2 Living Arrangments with this time frame.  Please delete both entrees
-- a1683caa-30ef-413b-9db0-1e98989953e1	1565354
-- 85fcfd34-7882-46f2-9592-f970750119cb	1565353

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3117965	4223399		JUSTICE  STINYARD 	1565534			8/9/2021	8/9/2021
-- comments: There is one Living Arrangement with this time frame.  Please delete it.
-- 60ff28da-4896-4675-a5e7-b5c0b7dfe5e3	1565534

-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	2020023202483	200142994	Adrianne  Lynch 	1565266			8/8/2021	8/21/2021
-- comments: There are 2 Living Arrangments with this time frame.  Please the delete the 1 without any nmae and adress
-- af9308cb-24ad-4371-845a-40826f7016c6	1565266

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3124983	1738376		ELIZABETH V DELLY 	1565325			8/5/2021	8/5/2021
-- comments: There is one Living Arrangment with this time frame. Please delete it.
-- 5898ea64-7f60-414b-9019-c753fc531a2f	1565325

-- County			Case ID			Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	211030009550	4357900		KHALIL  NEWTON 	1564809			7/18/2021
-- comments: There is one Living Arrangement with this start date. Please delete it. 
--  The other living arrangment that is there also needs a start and end date of 7/18/21 with permentnely leaving custoy and care. Reunify with parent
-- 079a412a-fdc0-416e-bd71-af866d89e17f	1564809

-- County			Case ID			Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	211030009550	2646328		DEAYSHA  CLARK 	1564805			7/18/2021	10/6/2021
-- comments: There are 2 Living arrangments wit the same time frame. Delete the one that has  no name or address
-- b174cd5c-dca3-4c50-9222-79fb08fa1963	1564805

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3253062	3795334		KEVON  SAUNDERS 	1564729			7/16/2021	7/16/2021
-- comments: There is 1 Living Arrangement with this time frame. Please delete.
-- ab04206b-42b4-40ac-b56a-0276f3ad1635	1564729

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3115803	3643748		DESHAuN C SATCHELL 	1564838			7/18/2021	7/18/2021
-- comments: There is 1 Living Arrangement with this time frame. Please delete.
-- 8887a49e-1b5d-4d05-926b-15aef026a139	1564838

	
-- County			Case ID	Client ID	Client Name						Placement ID	Entry Date	Exit Date
-- Baltimore City	3239449	3501924		SHARDYONNIE PATRICIA BALDWIN 	1564413			7/6/2021	7/6/2021
-- comments: There is 1 Living Arrangment with this timeframe. Delete it.
-- 2d745b87-8cb6-4c83-9654-ef52ab0147e1	1564413

-- County			Case ID	Client ID	Client Name				Placement ID	Entry Date	Exit Date
-- Baltimore City	3301596	2767010		TYMARI EUGENE WOODLEY 	1565564			7/2/2021	7/2/2021
-- comments: There are 3 Living arrangments wit the same time frame. Delete the 2 that have no name or address
-- 38175385-a627-42a2-b5d2-3dfbc2e8b9d8	1565564
-- f31eff6f-1747-4594-b754-bf527f02727b	1565565

-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	211030008184	200668550	Miracle  Sparrow 	1564174			6/29/2021	6/29/2021
-- comments: There are 3 living arrangments with this time frame.  
-- Delete the one with no information and one of the other two are duplicates
-- f24f583b-1512-4910-a9f5-d4b03bc7bb3a	1564174
-- 6e74dcc6-5862-4ca3-9f6e-c39296c52615	1564822

-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	202109507053	200649726	Malik Tyewon Banks 	1564797			6/28/2021	6/28/2021
-- comments: There are 2 living arrangments with this time frame. Delete the one with no name or address
-- ff3cd824-eb7f-4ed8-b79b-ee75cdb3ccf0	1564797

-- County			Case ID	Client ID	Client Name				Placement ID	Entry Date	Exit Date
-- Baltimore City	3258581	4491419		JAYVION King EVERETT 	1564883			6/24/2021	2/8/2023
-- comments: Delete Living arrangement with no information.  These are duplicate documentation.
-- b1506e4d-4d0b-4cf2-8e45-fc4ee790e4f2	1564883

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3110807	3988327	ISAIAH  SANDERS 	1393752			2019-10-08 2019-10-19 
-- comments: Found one additional 
-- 6a278aa2-f338-4d51-98ef-e183fe546ca5	1393752	

-- County			Case ID			Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2021012307617	200660293	sean  white 	1564790			6/24/2021	6/24/2021
-- comments: There is 1 Living Arrangment with this time frame.  Please delete.
-- 69263f6d-9c31-4431-821a-252c8f853e21	1564790

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3212844	1708191		PRECIOUS G PRINCE 	1564451			6/18/2021	8/9/2021
-- comments: There is 1 Living Arrangment with this time frame.  Please delete.
-- a800e0c7-b43f-4eb0-8e18-c8f8a375415e	1564451

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3292114	2838207		MAKAYLA A HOGAN 1564278			6/17/2021	6/17/2021
-- comments: THere are 2 Living Arrangments with these time frames. Delete the one with No name or address
-- 0e4b5522-ce85-4958-a595-c8518c22c0d8	1564278

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3199884	200772446	Danielle Carol Schneider 	1563896	6/13/2021	6/16/2021
-- comments: There are 2 Living Arrangments with these dates.  Please delete the one with the least information
-- 589be9bc-7466-49e3-be02-02fb38e8e64f	1563896

-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	2020030403921	3856017		KHALIL D DAVIES 	1564496			5/19/2021	12/16/2021
-- comments: There is 1 Living Arrangment with this timeframe. Please delete
-- 76380890-1940-47a1-81e8-752bac5ff5f5	1564496

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	211030008034	4255546	AIDYN  PITTS 	1563441	5/15/2021	5/15/2021
-- comments: There is 1 Living Arrangment with this time frame. Please delete
-- eac0d445-32e4-4525-93b8-0bb1925f8d61	1563441

-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	211030008034	4255540		TRENDON LEON PITTS 	1563442			5/15/2021	5/15/2021
-- comments: There is 1 Living Arrangment with this time frame. Please delete
-- a73f632a-965b-4ab1-80e8-d2f693c0b281	1563442

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2021013207833	200664027	Jaydan C Womack 	1564424	5/11/2021	5/14/2021
-- comments: There are 2 Living Arrangments with these dates.  Please delete the one with no information
-- 705a3ae4-9280-4617-b202-c4eff59f0ab1	1564424

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3120563	1668947	KYIESHA  PIERCE 	1563195	5/5/2021	5/6/2021
-- comments: There is 1 Living Arrangment with this time frame.  Please delete.
-- a27c885b-9c4d-474c-a4bf-797bbfcb37cd	1563195

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3128862	4437011	KYLINDA MON'AE BROWN 	1567339	4/26/2021	4/26/2021
-- comments: There is 1 Living Arrangement with this time frame. Please delete.
-- 7c21a6f3-3a6b-46f8-a422-237185cc3b91	1567339

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3248919	3746767	JASMINE  HARRIS 	1562702	4/9/2021	4/10/2021
-- comments: There is 1 Living Arrangment with this time frame. Please Delete
-- caa3f8a4-27ad-4685-90fc-7b1810fcdc7a	1562702

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3293462	4292716	DAMONIAN  DAVIS 	1562288	4/6/2021	4/6/2021
-- comments: There is 1 Living Arrangment with this time frame. Please delete
-- a0f3e670-da69-4723-90cf-f685e3693f21	1562288

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3251768	3232346	SHYTERRA  COLE 	1562545	4/5/2021	4/6/2021
-- comments: There is 1 Living arrangment for this timeframe.  Please delete.
-- 3697bef1-d155-4824-86ba-2f1965b38d21	1562545

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202109807135	3596505	CHARLI ADRIANNE RAGIN 	1562939	4/2/2021	4/2/2021
-- comments: There is 1 Living arrangment for this timeframe.  Please delete.
-- 87c52d17-3597-4da9-bab9-135d15e2c9ff	1562939

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202107806692	4419469	CARTER  THOMPSON 	1561762	3/23/2021	3/24/2021
-- comments: There is 1 Living arrangment for this timeframe.  Please delete.
-- 0a946326-1303-4116-8e76-42dd4a3aa220	1561762

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3307652	4492777	AARON JAY HORNE 	1562052	3/23/2021	3/23/2021
-- comments: There is 2 Living Arrangments with thits time frame. Please Delete the 1 with no information
-- db6264c9-3312-4489-9d9b-c07eb390b4a8	1562052

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3307652	4454286	Amir   HORNE 	1562051	3/23/2021	3/23/2021
-- comments: There is 2 Living Arrangments with this time frame. Please Delete tthe one with no information
-- f140f54d-1528-4cb9-a9dd-7bdc404c1e8f	1562051

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3223042	3046230	KENDAL  FENWICK JR 	1561712	3/19/2021	3/19/2021
-- comments: There is 1 Living Arrangment with thits time frame. Please Delete this entree
-- 722fb44a-4c7b-4a3b-84ea-9c9fc338b877	1561712

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3276610	3581726	TAYVION E BROWN 	1561558	3/18/2021	4/23/2021
-- comments: There is 1 Living Arrangment with thits time frame. Please Delete this entree
-- 335c386c-d590-4888-8216-b22af72029bb	1561558

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3208682	3324325	AUTUMN C FAGAN 	1561099	3/18/2021	3/19/2021
-- comments: There is 1 Living Arrangment with thits time frame. Please Delete this entree
-- 21823691-8b3d-4800-a3b9-79ebd4ada28a	1561099

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3290576	4262079	GENESIS MARIE BLUE 	1562723	3/12/2021	3/12/2021
-- comments: Please delete the living arrangment with this timeframe
-- ae39ab3c-9950-4f08-b59c-78c42aa0c465	1562723

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3303859	4426594	GIANNI R MCGUIRE 	4426594	3/9/2021	3/10/2021
-- comments: There is 1 lving arangement with this time frame.  Please delete it.
-- bf7c9e45-4d7e-48e7-883d-40fa109ed038	1561668

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3157325	3760903	WILLIAM  WALLACE 	1562231	3/8/2021	5/8/2021
-- comments: There is 1 lving arangement with this time frame.  Please delete it.
-- 61a552b7-e8e7-4540-8f77-315b963e623b	1562231

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2020025803008	200150070	SHALEAH M PURDIE 	1561322	3/1/2021	3/2/2021
-- comments: There is one living arrangmen with this time frame.  Please delete.
-- 649d2f1c-aea0-458f-bd33-f1abc36bfdde	1561322

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3306203	4470199	HARMONII J CARLTON 	1561412	2/27/2021	3/15/2021
-- comments: There is 1 Living Arrangment with this time period.  Please delete
-- 71c72a7b-1617-4589-a583-142630bfefd4	1561412

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3290051	4259765	SELASSIE  ADUNA-BOATIN 	1561009	2/16/2021	2/16/2021
-- comments: There are two Living Arrangements with this time frame.  Delete the one that has no information
-- d6c84e37-1500-43b2-8fac-bffdb506253a	1561009

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3253314	3759779	TYRELL  NICHOLSON-HEARN 	1560768	2/4/2021	2/5/2021
-- comments: There is one Living Arrangment with this time frame.  Please delete as it was a duplicate entree
-- ab8dc74c-a5f6-4e23-b75b-5296ed3bed9e	1560768

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3253314	3759781	TYSHAWN  NICHOLSON-HEARN 	1560809	2/4/2021	2/4/2021
-- comments: There is one Living Arrangment with these dates. Please delete it as the correct Living Arrangment and dates are there.
-- 2eec1ffa-b82f-49dc-834c-1cc6b9a76c1f	1560809

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3114602	4482508	BENTLEY  COLLINS 	1560725	2/2/2021	2/3/2021
-- comments: There is one Living Arrangment for these dates. Please delete it.
-- 566760d0-e7f1-48aa-b810-59117fe1a978	1560725

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3078564	200298170	Ilana  Pearson-Smith 	1560527	1/25/2021	1/25/2021
-- Baltimore City	3078564	200298170	Ilana  Pearson-Smith 	1560526	1/25/2021	1/25/2021
-- comments: There are 3 Living Arrangments. Delete the 2 without any information. Also, 
-- please add Robin Ricks as the PRimary Caregiver for the one with Rleative/ficitive kin Living Arrangment
-- 5c852985-6a0c-40c5-ac6f-fcad2f852188	1560526
-- 3d85c897-6806-4a41-9aa5-1e42d04b8d13	1560527

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202100805275	4040674	Kaylee Michele Brown 	1562630	1/8/2021	1/8/2021
-- comments: There is one Living Arrangment with these dates. Please delete it.
-- ae66019e-7a48-4fd3-95a0-529b4c4d03be	1562630

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3118040	1692805	ASHANTI R PHILLIP 	1564460	1/7/2021	9/30/2021
-- Baltimore City	3118040	1692805	ASHANTI R PHILLIP 	1564446	1/7/2021	9/30/2021
-- comments: THere are 3 Living Arrangments. Delete the 2 blank ones
-- 6e850204-234f-460b-968a-9dff6dea44f0	1564460
-- a2fd9251-3792-42f4-baf6-5c3bb660300d	1564446

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3272566	3821872	DECOURSEY  WILSON 	1559877	12/26/2020	12/26/2020
-- comments: There are 2 Living Arrangments with these dates.  Please delete the one with no information
-- a37ff63d-5011-4742-adbe-1a2b5e71cb44	1559877

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3285399	2449130	TORI L CARTER-CHAMBERS 	1560096	12/18/2020	12/18/2020
-- comments: There are 3 living arrangments. Please delete the one with no information and the one that says incorrect in the comments
-- b2617f4b-74e1-4d36-b503-602c054c335f	1560096	
-- 286d8feb-4012-460e-bbff-bb95d3d20028	1571071 - LA 6d80d8f3-aebb-4aa9-ba26-860b52ff7c0a


-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3120466	1656041	CHAONAINE S GRACE 	1559708	12/16/2020	7/22/2021
-- comments: there are 2 entrees for these dates.  The Living Arrangement can be deleted
-- e539ac22-dfa2-4409-bbaf-d56c03310931	1559708

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2020024402740	200146174	Serenity  Woodrum 	1559785	12/4/2020	12/4/2020
-- comments: There is 1 entree with this date.  Please delete.
-- b4ef02c7-d11b-4928-8fb7-47cde704adf7	1559785

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2020030904002	200168334	Dior  Gaither 	1559917	12/3/2020	12/3/2020
-- comments: There are 3 entrees with this date.  Please delete all 3
-- 86be6995-3630-491c-b164-d0911cf027b5	1559917
-- d9acefa2-82f8-448b-a7b3-f488eb9e3a79	1559913 -- LA 46eac7be-637d-40bf-b2db-40270a52d862
-- d7f26348-ffee-427b-b47a-9cfa5c4076bb	1559918 -- LA 83af01ab-b6ba-4f28-9707-49369d9e8556

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3273829	4430433	JACARI  JONES 	1559378	11/25/2020	11/25/2020
-- comments: There is 1 entree with these dates. Please delete as it was a duplicate living arrangment
-- 425994fa-8c0c-4568-b5ed-6bd39beca720	1559378

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3252051	3779262	AMELIE  WILLIAMS 	1559665	11/18/2020	11/18/2020
-- comments: There is 1 entree with these dates. Please delete as it was a rejection of placement
-- eb722a01-bc0e-44ec-ba0a-f6aeabdde859	1559665

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3275593	3837097	NYLAH  BOND 	1559076	11/13/2020	11/13/2021
-- comments: There is 1 entree with these dates. Please delete as it was a rejection of placement
-- 6838f318-d1b2-4f34-92ec-cc86174bd625	1559076

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2020030203863	4335047	KHALIF MARVIN-JAD FARRAR 	1559056	11/6/2020	11/6/2020
-- comments: There are 2 living arrangmens with these dates.  Please delete the one with no information
-- e9d9d7ff-bf21-4a5e-8166-d20765f49d44	1559056

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3189660	3217783	JANAE AZORIA BEY 	1558861	11/5/2020	11/5/2020
-- comments: There is one living arrangement with this date. Please delete as it is a duplicate
-- af1c47d6-0efa-4152-aaf0-c7cc8ec33f61	1558861

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3128506	1658402	JOSEPH O GREEN 	1559059	10/28/2020	1/4/2021
-- comments: There are 2 living arrangmens with these dates.  Please delete the one with no information
-- 8deab945-eb59-4fac-affb-b9cf36c9cd3e	1559059

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3115518	1644969	SHANELLE  PITT 	1559547	5/22/2020	
-- comments: There are 2 Living Arrangments with same dates. Delete the one with the least info.
-- 246bccef-6fff-4cce-bf12-8b0808f04258	1559547

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3619061	JOSHUA LEE SCHLOTHAUER 	1388174	10/24/2018	10/24/2018
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 2875dd33-ac88-45ce-bcf4-13b60c063db3	1388174

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3619061	JOSHUA LEE SCHLOTHAUER 	1388175	6/8/2018	10/24/2018
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 993cbf26-8ddc-4d5a-bc2c-6859b3776d23	1388175

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3279070	1487840	BRITANY  GUARNERA 	1369449	8/27/2017	9/26/2017
-- comments: Ther are 2 Living Arrangements with these dates. Delete the one with the least information.
-- 61191917-0a2c-45f0-a136-78f136cd9855	1369449

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234197	1566744	GERALD  FRISBY 	1345465	6/26/2017	1/18/2018
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- a63cb156-6e6d-4894-a488-60cafddd3fce	1345465

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234197	1566744	GERALD  FRISBY 	1345462	8/11/2016	10/11/2016
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 93e9b283-df41-4a13-aaa3-7caba15ac523	1345462

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234197	1566744	GERALD  FRISBY 	1345463	10/11/2016	4/3/2017
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 3d452d0c-d8e4-4347-9565-80662c118778	1345463

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234197	1566744	GERALD  FRISBY 	1345460	5/29/2009	12/22/2010
-- comments: There are three with this same time frame.  Delete the 2 Living Arrangments
-- 18f4f574-b590-405c-8099-28088b1029eb	1345460

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234197	1566744	GERALD  FRISBY 	1345464	4/3/2017	6/26/2017
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 1b493cec-1578-4b9a-aa3b-deed6b5c07e2	1345464

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3133212	BROOKE  BENNETT 	1381212	5/3/2017	5/3/2017
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- af447e1c-88cc-4b45-987c-1f8a2250355e	1381212

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3619061	JOSHUA LEE SCHLOTHAUER 	1388176	2/22/2017	6/8/2018
-- comments: There are 4 entries with these same dates. Delete the 3 Living Arrangements. 
-- 558644c4-a2d6-4762-9063-cf8bb80482b3	1388176

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3619061	JOSHUA LEE SCHLOTHAUER 	1388178	11/6/2014
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 4f867eb4-b91e-4441-a7a0-7df73f2a0e89	1388178

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3619061	JOSHUA LEE SCHLOTHAUER 	1388179	10/21/2014	11/6/2014
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 2ab5cbe1-3d47-4d75-9489-c61b364b2949	1388179

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3619061	JOSHUA LEE SCHLOTHAUER 	1388180	5/15/2014	10/21/2014
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 6ca783c1-2ac7-4467-8597-dff951a182de	1388180

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3619061	JOSHUA LEE SCHLOTHAUER 	1388181	5/14/2014	5/15/2014
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 10535833-473e-4d26-b19b-6273a6c68730	1388181

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3279070	1487840	BRITANY  GUARNERA 	1369450	11/3/2016	11/3/2016
-- comments: Ther are 2 Living Arrangements with these dates. Delete the one with the least information.
-- c5ea510c-291f-444c-a296-86225e222666	1369450

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3241328	3524584	KRYLON S ARTHUR 	1386766	5/13/2016	8/5/2016
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 84cfa09a-a92b-4fea-87f4-1c62218119a0	1386766

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3133212	BROOKE  BENNETT 	1381214	11/6/2014	7/19/2016
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- 9f49ff76-1153-401a-baca-cdfda37ac307	1381214

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3241449	1427897	TATIANA Y TAYLOR 	1368966	7/16/2014	7/16/2014
-- Baltimore City	3241449	1427897	TATIANA Y TAYLOR 	1368967	7/16/2014	7/16/2014
-- comments: 6 entrees with same dates. 4 living arraagments and 2 Providers. 
-- Delete all except Provider with exit type -permently leaving custody and care
-- 641faac3-de4f-4797-8009-9c2ed96949d0	1368966
-- 64fe2af0-f40c-4e3f-b844-14fdd68ba5b2	1368967

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3241449	1427897	TATIANA Y TAYLOR 	1368972	2/9/2007	6/19/2010
-- comments: There are same time frames in Triplicate. Delete both Living Arrangments
-- 0b8a1798-2823-4e02-ae47-f101c544f532	1368972

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- 3241449	1427897	TATIANA Y TAYLOR 	1368971	6/19/2010	8/5/2010
-- comments: Triplicate time frames. Delete 2 Living Arrangments
-- 2b4c09c9-c058-454b-95bc-ddf1ae8e1055	1368971

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3241449	1427897	TATIANA Y TAYLOR 	1368970	8/5/2010	3/16/2012
-- comments: Triplicate time frames. Delete 2 Living Arrangments
-- 29870d81-16e1-4136-a24a-05e1a0a8ae3c	1368970

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3241449	1427897	TATIANA Y TAYLOR 	1368969	3/16/2012	9/10/2012
-- comments: 3 entries with same dates. Delete Living Arrangments
-- cea1b3ad-339c-4dab-a23a-66d5648c5b91	1368969

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3241449	1427897	TATIANA Y TAYLOR 	1368968	9/10/2012	7/16/2014
-- comments: 3 entries with same dates. Delete Living Arrangments
-- e6304679-c21d-44f9-8b47-99b068fead51	1368968

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3133212	BROOKE  BENNETT 	1381216	5/15/2014	10/21/2014
-- comments: There are 4 entreies with these dates. Delete the 3 Living Arrangments
-- 8d48ee4d-daff-48e5-b023-aa8f421d6302	1381216

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3133212	BROOKE  BENNETT 	1381219	8/21/2013	4/16/2014
-- comments: Ther are 3 entries with these same dates. Delete the 2 Living Arrangements. 
-- f712dc81-e066-405f-9b16-25516c732f95	1381219

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3133212	BROOKE  BENNETT 	1381220	8/9/2013	8/12/2013
-- comments: There are 3 entries with these same dates. Delete the 2 Living Arrangements
-- 79f79fb7-1c25-42ac-9498-2fa68c3f1548	1381220

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3234756	3133212	BROOKE  BENNETT 	1381223	8/8/2013	8/9/2013
-- comments: Ther are 3 entries with these same dates. Delete the 2 Living Arrangements
-- 46ed4b0a-dd44-4ead-8f34-0229d3ecd8ae	1381223

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	221030014062	1283251	TEAUNA  SANDERS 	1362830	4/26/2013	4/26/2013
-- comments: Ther are 3 entries with these same dates. Delete the 2 Living Arrangements
-- e6b92a52-6f41-40e5-a33e-7d8b13cd8ac1	1362830

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	221030014062	1283251	TEAUNA  SANDERS 	1362831	4/23/2013	4/26/2013
-- comments: Ther are 3 entries with these same dates. Delete the 2 Living Arrangements
-- 065ceaf6-f30f-46f4-bed2-ed566485de60	1362831

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	221030014062	1283251	TEAUNA  SANDERS 	1362832	9/22/2011	4/23/2013
-- comments: Triplicate time frames. Delete 2 Living Arrangments
-- 2bf3ec27-90a5-47dd-a6a2-c5423c768bf7	1362832

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	221030014062	1283251	TEAUNA  SANDERS 	1362833	6/7/2010	9/22/2011
-- comments: Triplicate time frames. Delete 2 Living Arrangments
-- 0ac995ea-fffd-490d-ba54-8eae2ffe0e23	1362833

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	221030014062	1283251	TEAUNA  SANDERS 	1362834	12/4/2009	1/4/2010
-- comments: Triplicate time frames.  Delete 2 Living Arrangments
-- 41fd34bf-b4ed-40e0-bbb3-78a403d9d047	1362834

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342215	5/8/2012	6/7/2012
-- comments: Found Duplicate
-- 91f0e99d-e56a-4bbd-8993-02fe7969b454	1342215

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342213	1/17/2012	1/17/2012
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342214	1/17/2012	5/8/2012
-- comments: Found Duplicate
-- 6274779d-6534-4441-99ca-a3a31e6746da	1342213
-- 085680af-76b4-4c95-985e-7fe899bba8fb	1342214


-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342212	6/19/2009	1/17/2012
-- comments: Delete
-- a61181d9-5506-4704-a6a7-7def80f41344	1342212

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342211	3/24/2009	6/19/2009
-- comments: Delete
-- 57d0ac3e-5455-4ff9-89c7-53d749c54da7	1342211

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342210	2/13/2009	3/24/2009
-- comments: Delete
-- 1e152219-63cf-4616-aa17-a2b0c822165e	1342210

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342209	12/20/2008	2/13/2009
-- comments: Delete the placement is documented in the above  line.
-- 962c03d2-88b3-46b7-8623-bba828ae0813	1342209

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342208	7/13/2007	11/14/2007
-- comments: Delete
-- 4ea1daad-5d28-48c1-be01-68278ac102ec	1342208

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342206	7/2/2007	7/13/2007
-- comments: Delete
-- ab11274b-c680-46b5-9639-50bb16fb7f4a	1342206

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3161510	1430308	LARRY L MULLENAX 	1342204	5/22/2007	7/2/2007
-- comments: Delete
-- 94e3d6b4-fd43-4917-8457-f5bcc6540737	1342204

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3191667	1493047	JUSTIN N NESTOR 	1344063	10/10/2006	3/6/2008
-- comments: Living Arrangement is the same as the placement for the same dates.  Living Arrangements can be deleted.
-- 2d04630b-9b5d-40b1-8fa1-b6fc3807a8b2	1344063

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3191667	1493047	JUSTIN N NESTOR 	1344064	6/9/2008	10/6/2010
-- comments: There are same time frames in Triplicate. Delete both Living Arrangments
-- 4df42dcd-13f0-4973-a753-f494102fef33	1344064

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3191667	1493047	JUSTIN N NESTOR 	1344065	10/6/2010	10/12/2010
-- comments: Triplicate time frames. Delete 2 Living Arrangments
-- 5ea90f42-7b7f-4ebc-ac52-07c7c9364ef1	1344065

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3191667	1493047	JUSTIN N NESTOR 	1344067	10/12/2010	10/12/2010
-- comments: Triplicate time frames. Delete 2 Living Arrangments
-- a5f6e987-6272-4a23-a7c3-bfe21218ed0d	1344067

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3182372	1647524	SAM  MOSES 	1345818	1/6/2010	1/6/2010
-- comments: Triplicate time frames. Delete 2 Living Arrangments
-- 42c6afbb-a150-4f8a-8d67-52553b47720f	1345818

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City		1682676	FARONTA  ALLEN 	3105384	1/12/2009	1/15/2009
-- comments: There are same time frames in Triplicate. Delete both Living Arrangments
-- 21a9c8aa-f02b-48df-bc61-629b04dd2a07	1370794

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	221030018252	1278610	CHASITY N ZAHNER 	1362253	12/23/2008	12/18/2009
-- comments: Delete the Living Arrangment with no other infomation
-- 87962dd8-cf44-41f3-9725-75e71e099e67	1362253

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2021010507283	1682676	FARONTA  ALLEN 	1370796	11/18/2008	1/9/2009
-- comments: There is the same time frame in Triplicate. Delete the 2 Living Arrangments
-- d671d897-b198-443e-a942-06fb5af50984	1370796

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3131177	1415655	DAVID L FISHER 	1368844	11/1/2008	7/30/2009
-- comments: There is the same time frame in Triplicate. Delete the 2 Living Arrangments
-- cd23de41-958d-499d-bd1a-7e01bcf1239e	1368844

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2021010507283	1682676	FARONTA  ALLEN 	1370797	9/29/2008	9/30/2008
-- comments: There are same time frames in Triplicate. Delete both Living Arrangments
-- 8d095008-901b-4ab0-9c66-85d16bb05db7	1370797

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	221030018252	1278610	CHASITY N ZAHNER 	1362255	1/1/2007	7/21/2008
-- comments: There is a Living Arrangment and Provider Placement with these dates. Delete Living Arrangment
-- ebca145b-d75b-4270-8451-aba4ddcf0d55	1362255

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	231030092347	1737937	ALISHA J FAUST 	1060741	9/5/2006	10/15/2009
-- comments: Delete No Information
-- f6d573e6-d032-4d2f-b849-5a5adad07ccd	1060741

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3125809	1752622	JOSEPH E JACKSON 	1503185	6/28/2006	7/31/2006
-- comments: Delete No information
-- 6cd25f29-a239-4476-beba-321312429c43	1503185


-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	2021010507283	1682676	FARONTA  ALLEN 	1370791	7/16/2009	8/17/2009
-- comments: Duplicate time frames. Delete Living Arrangmnets
-- 14e94cce-5819-41f7-bfd9-5f9109d4cade	1370791

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3293462	4294990	DAMONIAN  DAVIS 	1562289	4/6/2021	4/7/2021
-- comments: There is 1 Living Arrangment with this time frame. Please delete. This was under wrong child.
-- 025c5f3f-c805-43c9-b851-176258094e76	1562289

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3294261	4304089	MAURICE  WRIGHT 	1564485	2/10/2019	2/10/2019
-- comments: There are 2 Living Arrangments with same dates. Delete the one with the least info. 
-- Add Change in placement structure to the Living Arrangement with the address.
-- 2e3e53a5-4532-46fb-a45b-b5de3a5e3ff2	1564485

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3223892	2217872	TAMIL SHAMERE SMITH 	1560744	11/13/2020	1/28/2021
-- comments: There is one entree for this date. Please delete and change prior living arrangment end date to 1/28/21 from 12/22/20.
-- eeeda088-3926-418b-8ef3-14f6e2eee3ad	1560744

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3251655	3097389	NATALIE CORDAE COLEMAN 	1559489	10/2/2020	10/15/2020
-- comments: There are 2 entrees for those dates. Please delete the Living Arrangement with no information.  
-- 2e009026-f027-45f9-bdc0-50b657512a2e	1559489

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3090750	1431436	ANNA L FORD 	1420968	5/19/2000	1/5/2001
-- comments: Unknown- Case is before 2007 when database started for BCDSS
-- 3bb346f1-6cb3-4fb9-a2b3-1cae8cadce95	1420968 -- LA cb9f4443-7201-42d1-a508-f5fc6af78016

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3247266	3731865	DAVAR TYRESE WILLIAMS 	3957268	3/2/2021	3/9/2021
-- comments: Delete 
-- 50cdab6d-2163-4e51-ad12-ac5e1421e0fd	1561149



-- New cases 
-- Baltimore City	3246407	200301094	Amour-dior Psalm O'Dell 	1560979	2021-02-03	2021-02-03
-- Baltimore City	3246407	200301094	Amour-dior Psalm O'Dell 	1560976	2021-02-03	2021-02-03
-- d6f6a032-8f54-4ef7-b5cb-3ba5c4cce7a6	1560979
-- 9a9ecd5e-9592-46f2-9fd7-3d9f94dcf4e7	1560976

update placement 
set activeflag = 0,
	updatedby = 'CIDM-8291',
	updatedon = now()
where placementid in ( 
	'59fb2287-f43d-441e-be07-f9ec8b12fc71', '26651dbc-fdf0-402e-a7bf-376002d9987d',
	'ae3ea763-85aa-4830-a5bb-d2d488d9ddab', 'fbdf4fad-2131-4d09-88c6-c2659088c711',
	'eba4b70f-7ff5-41d8-881c-1c8ac5ea8a9b', 'b65d5be1-284a-4587-b283-cdd89641f30a',
	'55a6de58-37ad-415b-aad3-0847915e41ce', 'aa6eed3a-0ba0-4448-bd8e-79d6df6d0316',
	'78b99ae6-14ad-4ee4-ad2f-66899483cee9', '28f38808-06ba-4ec0-9334-2d0401b4294d',
	'e2a79acb-4ef7-4625-b245-0a82191a18e1', 'ba049b42-c30b-486f-b882-08302b9fd598',
	'4c6ace71-4045-4679-8e1d-45c9e971d105', '93c2b8b6-c7f2-40e4-adf7-c2c39bf649f3',
	'e49da942-d568-4694-832e-02553d04501d', '9b700350-a0b7-4787-adf4-6b2d5ba724ab',
	'1d22a18b-40ec-4cc8-b2d9-d89f4ca74109', '499fc8db-9816-4841-a52e-a8133b6b3f45',
	'a29f3c83-eddb-4c97-b7ee-48874d9b3a8f', 'ff6fd733-30be-44d9-996e-e101cbda28ce',
	'14ceaf5a-bba7-43eb-a18d-e3cc0e98e441', 'd72501bd-328e-4020-98b0-91cb61d75196',
	'f534f48a-e441-4ed8-a85c-0960a6877e3b', 'a92b26f1-ac07-4594-b74e-ecb5eaeca7b6',
	'9a78ad09-8534-4772-8aba-f53ee675c631', 'a1683caa-30ef-413b-9db0-1e98989953e1', 
	'85fcfd34-7882-46f2-9592-f970750119cb', '60ff28da-4896-4675-a5e7-b5c0b7dfe5e3',
	'af9308cb-24ad-4371-845a-40826f7016c6', '5898ea64-7f60-414b-9019-c753fc531a2f',
	'079a412a-fdc0-416e-bd71-af866d89e17f', 'b174cd5c-dca3-4c50-9222-79fb08fa1963',
	'ab04206b-42b4-40ac-b56a-0276f3ad1635', '8887a49e-1b5d-4d05-926b-15aef026a139',
	'2d745b87-8cb6-4c83-9654-ef52ab0147e1', '38175385-a627-42a2-b5d2-3dfbc2e8b9d8',
	'f31eff6f-1747-4594-b754-bf527f02727b', 'f24f583b-1512-4910-a9f5-d4b03bc7bb3a',
	'6e74dcc6-5862-4ca3-9f6e-c39296c52615', 'ff3cd824-eb7f-4ed8-b79b-ee75cdb3ccf0',
	'b1506e4d-4d0b-4cf2-8e45-fc4ee790e4f2', '6a278aa2-f338-4d51-98ef-e183fe546ca5',
	'69263f6d-9c31-4431-821a-252c8f853e21', 'a800e0c7-b43f-4eb0-8e18-c8f8a375415e',
	'0e4b5522-ce85-4958-a595-c8518c22c0d8', '589be9bc-7466-49e3-be02-02fb38e8e64f',
	'76380890-1940-47a1-81e8-752bac5ff5f5', 'eac0d445-32e4-4525-93b8-0bb1925f8d61',
	'a73f632a-965b-4ab1-80e8-d2f693c0b281', '705a3ae4-9280-4617-b202-c4eff59f0ab1',
	'a27c885b-9c4d-474c-a4bf-797bbfcb37cd', '7c21a6f3-3a6b-46f8-a422-237185cc3b91',
	'caa3f8a4-27ad-4685-90fc-7b1810fcdc7a', 'a0f3e670-da69-4723-90cf-f685e3693f21',
	'3697bef1-d155-4824-86ba-2f1965b38d21', '87c52d17-3597-4da9-bab9-135d15e2c9ff',
	'0a946326-1303-4116-8e76-42dd4a3aa220', 'db6264c9-3312-4489-9d9b-c07eb390b4a8',
	'f140f54d-1528-4cb9-a9dd-7bdc404c1e8f', '722fb44a-4c7b-4a3b-84ea-9c9fc338b877',
	'335c386c-d590-4888-8216-b22af72029bb', '21823691-8b3d-4800-a3b9-79ebd4ada28a',
	'ae39ab3c-9950-4f08-b59c-78c42aa0c465', 'bf7c9e45-4d7e-48e7-883d-40fa109ed038',
	'61a552b7-e8e7-4540-8f77-315b963e623b', '649d2f1c-aea0-458f-bd33-f1abc36bfdde',
	'71c72a7b-1617-4589-a583-142630bfefd4', 'd6c84e37-1500-43b2-8fac-bffdb506253a',
	'ab8dc74c-a5f6-4e23-b75b-5296ed3bed9e', '2eec1ffa-b82f-49dc-834c-1cc6b9a76c1f',
	'566760d0-e7f1-48aa-b810-59117fe1a978', '5c852985-6a0c-40c5-ac6f-fcad2f852188',
	'3d85c897-6806-4a41-9aa5-1e42d04b8d13', 'ae66019e-7a48-4fd3-95a0-529b4c4d03be',
	'2e009026-f027-45f9-bdc0-50b657512a2e', '6e850204-234f-460b-968a-9dff6dea44f0',
	'a2fd9251-3792-42f4-baf6-5c3bb660300d', 'a37ff63d-5011-4742-adbe-1a2b5e71cb44',
	'b2617f4b-74e1-4d36-b503-602c054c335f', '286d8feb-4012-460e-bbff-bb95d3d20028',
	'e539ac22-dfa2-4409-bbaf-d56c03310931', 'b4ef02c7-d11b-4928-8fb7-47cde704adf7',
	'86be6995-3630-491c-b164-d0911cf027b5', 'd9acefa2-82f8-448b-a7b3-f488eb9e3a79',
	'd7f26348-ffee-427b-b47a-9cfa5c4076bb', '425994fa-8c0c-4568-b5ed-6bd39beca720',
	'eb722a01-bc0e-44ec-ba0a-f6aeabdde859', '6838f318-d1b2-4f34-92ec-cc86174bd625',
	'e9d9d7ff-bf21-4a5e-8166-d20765f49d44', 'af1c47d6-0efa-4152-aaf0-c7cc8ec33f61',
	'8deab945-eb59-4fac-affb-b9cf36c9cd3e', '246bccef-6fff-4cce-bf12-8b0808f04258',
	'2875dd33-ac88-45ce-bcf4-13b60c063db3', '993cbf26-8ddc-4d5a-bc2c-6859b3776d23',
	'61191917-0a2c-45f0-a136-78f136cd9855', 'a63cb156-6e6d-4894-a488-60cafddd3fce',
	'93e9b283-df41-4a13-aaa3-7caba15ac523', '3d452d0c-d8e4-4347-9565-80662c118778',
	'18f4f574-b590-405c-8099-28088b1029eb', '1b493cec-1578-4b9a-aa3b-deed6b5c07e2',
	'af447e1c-88cc-4b45-987c-1f8a2250355e', '558644c4-a2d6-4762-9063-cf8bb80482b3',
	'4f867eb4-b91e-4441-a7a0-7df73f2a0e89', '2ab5cbe1-3d47-4d75-9489-c61b364b2949',
	'6ca783c1-2ac7-4467-8597-dff951a182de', '10535833-473e-4d26-b19b-6273a6c68730',
	'c5ea510c-291f-444c-a296-86225e222666', '84cfa09a-a92b-4fea-87f4-1c62218119a0',
	'9f49ff76-1153-401a-baca-cdfda37ac307', '641faac3-de4f-4797-8009-9c2ed96949d0',
	'64fe2af0-f40c-4e3f-b844-14fdd68ba5b2', '0b8a1798-2823-4e02-ae47-f101c544f532',
	'2b4c09c9-c058-454b-95bc-ddf1ae8e1055', '29870d81-16e1-4136-a24a-05e1a0a8ae3c',
	'cea1b3ad-339c-4dab-a23a-66d5648c5b91', 'e6304679-c21d-44f9-8b47-99b068fead51',
	'8d48ee4d-daff-48e5-b023-aa8f421d6302', 'f712dc81-e066-405f-9b16-25516c732f95',
	'79f79fb7-1c25-42ac-9498-2fa68c3f1548', '46ed4b0a-dd44-4ead-8f34-0229d3ecd8ae',
	'e6b92a52-6f41-40e5-a33e-7d8b13cd8ac1', '065ceaf6-f30f-46f4-bed2-ed566485de60',
	'2bf3ec27-90a5-47dd-a6a2-c5423c768bf7', '0ac995ea-fffd-490d-ba54-8eae2ffe0e23',
	'41fd34bf-b4ed-40e0-bbb3-78a403d9d047', '91f0e99d-e56a-4bbd-8993-02fe7969b454',
	'6274779d-6534-4441-99ca-a3a31e6746da', '085680af-76b4-4c95-985e-7fe899bba8fb',
	'a61181d9-5506-4704-a6a7-7def80f41344', '57d0ac3e-5455-4ff9-89c7-53d749c54da7',
	'1e152219-63cf-4616-aa17-a2b0c822165e', '962c03d2-88b3-46b7-8623-bba828ae0813',
	'4ea1daad-5d28-48c1-be01-68278ac102ec', 'ab11274b-c680-46b5-9639-50bb16fb7f4a',
	'94e3d6b4-fd43-4917-8457-f5bcc6540737', '2d04630b-9b5d-40b1-8fa1-b6fc3807a8b2',
	'4df42dcd-13f0-4973-a753-f494102fef33', '5ea90f42-7b7f-4ebc-ac52-07c7c9364ef1',
	'a5f6e987-6272-4a23-a7c3-bfe21218ed0d', '42c6afbb-a150-4f8a-8d67-52553b47720f',
	'21a9c8aa-f02b-48df-bc61-629b04dd2a07', '87962dd8-cf44-41f3-9725-75e71e099e67',
	'd671d897-b198-443e-a942-06fb5af50984', 'cd23de41-958d-499d-bd1a-7e01bcf1239e',
	'8d095008-901b-4ab0-9c66-85d16bb05db7', 'ebca145b-d75b-4270-8451-aba4ddcf0d55',
	'f6d573e6-d032-4d2f-b849-5a5adad07ccd', '6cd25f29-a239-4476-beba-321312429c43',
	'14e94cce-5819-41f7-bfd9-5f9109d4cade', '025c5f3f-c805-43c9-b851-176258094e76',
	'2e3e53a5-4532-46fb-a45b-b5de3a5e3ff2', 'eeeda088-3926-418b-8ef3-14f6e2eee3ad',
	'd6f6a032-8f54-4ef7-b5cb-3ba5c4cce7a6', '9a9ecd5e-9592-46f2-9fd7-3d9f94dcf4e7',
	'3bb346f1-6cb3-4fb9-a2b3-1cae8cadce95', '50cdab6d-2163-4e51-ad12-ac5e1421e0fd'
 	)
	and activeflag = 1 ;
	
update placementrevision 
set activeflag = 0,
	updatedby = 'CIDM-8291',
	updatedon = now()
where placementid in ( 
	'59fb2287-f43d-441e-be07-f9ec8b12fc71', '26651dbc-fdf0-402e-a7bf-376002d9987d',
	'ae3ea763-85aa-4830-a5bb-d2d488d9ddab', 'fbdf4fad-2131-4d09-88c6-c2659088c711',
	'eba4b70f-7ff5-41d8-881c-1c8ac5ea8a9b', 'b65d5be1-284a-4587-b283-cdd89641f30a',
	'55a6de58-37ad-415b-aad3-0847915e41ce', 'aa6eed3a-0ba0-4448-bd8e-79d6df6d0316',
	'78b99ae6-14ad-4ee4-ad2f-66899483cee9', '28f38808-06ba-4ec0-9334-2d0401b4294d',
	'e2a79acb-4ef7-4625-b245-0a82191a18e1', 'ba049b42-c30b-486f-b882-08302b9fd598',
	'4c6ace71-4045-4679-8e1d-45c9e971d105', '93c2b8b6-c7f2-40e4-adf7-c2c39bf649f3',
	'e49da942-d568-4694-832e-02553d04501d', '9b700350-a0b7-4787-adf4-6b2d5ba724ab',
	'1d22a18b-40ec-4cc8-b2d9-d89f4ca74109', '499fc8db-9816-4841-a52e-a8133b6b3f45',
	'a29f3c83-eddb-4c97-b7ee-48874d9b3a8f', 'ff6fd733-30be-44d9-996e-e101cbda28ce',
	'14ceaf5a-bba7-43eb-a18d-e3cc0e98e441', 'd72501bd-328e-4020-98b0-91cb61d75196',
	'f534f48a-e441-4ed8-a85c-0960a6877e3b', 'a92b26f1-ac07-4594-b74e-ecb5eaeca7b6',
	'9a78ad09-8534-4772-8aba-f53ee675c631', 'a1683caa-30ef-413b-9db0-1e98989953e1', 
	'85fcfd34-7882-46f2-9592-f970750119cb', '60ff28da-4896-4675-a5e7-b5c0b7dfe5e3',
	'af9308cb-24ad-4371-845a-40826f7016c6', '5898ea64-7f60-414b-9019-c753fc531a2f',
	'079a412a-fdc0-416e-bd71-af866d89e17f', 'b174cd5c-dca3-4c50-9222-79fb08fa1963',
	'ab04206b-42b4-40ac-b56a-0276f3ad1635', '8887a49e-1b5d-4d05-926b-15aef026a139',
	'2d745b87-8cb6-4c83-9654-ef52ab0147e1', '38175385-a627-42a2-b5d2-3dfbc2e8b9d8',
	'f31eff6f-1747-4594-b754-bf527f02727b', 'f24f583b-1512-4910-a9f5-d4b03bc7bb3a',
	'6e74dcc6-5862-4ca3-9f6e-c39296c52615', 'ff3cd824-eb7f-4ed8-b79b-ee75cdb3ccf0',
	'b1506e4d-4d0b-4cf2-8e45-fc4ee790e4f2', '6a278aa2-f338-4d51-98ef-e183fe546ca5',
	'69263f6d-9c31-4431-821a-252c8f853e21', 'a800e0c7-b43f-4eb0-8e18-c8f8a375415e',
	'0e4b5522-ce85-4958-a595-c8518c22c0d8', '589be9bc-7466-49e3-be02-02fb38e8e64f',
	'76380890-1940-47a1-81e8-752bac5ff5f5', 'eac0d445-32e4-4525-93b8-0bb1925f8d61',
	'a73f632a-965b-4ab1-80e8-d2f693c0b281', '705a3ae4-9280-4617-b202-c4eff59f0ab1',
	'a27c885b-9c4d-474c-a4bf-797bbfcb37cd', '7c21a6f3-3a6b-46f8-a422-237185cc3b91',
	'caa3f8a4-27ad-4685-90fc-7b1810fcdc7a', 'a0f3e670-da69-4723-90cf-f685e3693f21',
	'3697bef1-d155-4824-86ba-2f1965b38d21', '87c52d17-3597-4da9-bab9-135d15e2c9ff',
	'0a946326-1303-4116-8e76-42dd4a3aa220', 'db6264c9-3312-4489-9d9b-c07eb390b4a8',
	'f140f54d-1528-4cb9-a9dd-7bdc404c1e8f', '722fb44a-4c7b-4a3b-84ea-9c9fc338b877',
	'335c386c-d590-4888-8216-b22af72029bb', '21823691-8b3d-4800-a3b9-79ebd4ada28a',
	'ae39ab3c-9950-4f08-b59c-78c42aa0c465', 'bf7c9e45-4d7e-48e7-883d-40fa109ed038',
	'61a552b7-e8e7-4540-8f77-315b963e623b', '649d2f1c-aea0-458f-bd33-f1abc36bfdde',
	'71c72a7b-1617-4589-a583-142630bfefd4', 'd6c84e37-1500-43b2-8fac-bffdb506253a',
	'ab8dc74c-a5f6-4e23-b75b-5296ed3bed9e', '2eec1ffa-b82f-49dc-834c-1cc6b9a76c1f',
	'566760d0-e7f1-48aa-b810-59117fe1a978', '5c852985-6a0c-40c5-ac6f-fcad2f852188',
	'3d85c897-6806-4a41-9aa5-1e42d04b8d13', 'ae66019e-7a48-4fd3-95a0-529b4c4d03be',
	'2e009026-f027-45f9-bdc0-50b657512a2e', '6e850204-234f-460b-968a-9dff6dea44f0',
	'a2fd9251-3792-42f4-baf6-5c3bb660300d', 'a37ff63d-5011-4742-adbe-1a2b5e71cb44',
	'b2617f4b-74e1-4d36-b503-602c054c335f', '286d8feb-4012-460e-bbff-bb95d3d20028',
	'e539ac22-dfa2-4409-bbaf-d56c03310931', 'b4ef02c7-d11b-4928-8fb7-47cde704adf7',
	'86be6995-3630-491c-b164-d0911cf027b5', 'd9acefa2-82f8-448b-a7b3-f488eb9e3a79',
	'd7f26348-ffee-427b-b47a-9cfa5c4076bb', '425994fa-8c0c-4568-b5ed-6bd39beca720',
	'eb722a01-bc0e-44ec-ba0a-f6aeabdde859', '6838f318-d1b2-4f34-92ec-cc86174bd625',
	'e9d9d7ff-bf21-4a5e-8166-d20765f49d44', 'af1c47d6-0efa-4152-aaf0-c7cc8ec33f61',
	'8deab945-eb59-4fac-affb-b9cf36c9cd3e', '246bccef-6fff-4cce-bf12-8b0808f04258',
	'2875dd33-ac88-45ce-bcf4-13b60c063db3', '993cbf26-8ddc-4d5a-bc2c-6859b3776d23',
	'61191917-0a2c-45f0-a136-78f136cd9855', 'a63cb156-6e6d-4894-a488-60cafddd3fce',
	'93e9b283-df41-4a13-aaa3-7caba15ac523', '3d452d0c-d8e4-4347-9565-80662c118778',
	'18f4f574-b590-405c-8099-28088b1029eb', '1b493cec-1578-4b9a-aa3b-deed6b5c07e2',
	'af447e1c-88cc-4b45-987c-1f8a2250355e', '558644c4-a2d6-4762-9063-cf8bb80482b3',
	'4f867eb4-b91e-4441-a7a0-7df73f2a0e89', '2ab5cbe1-3d47-4d75-9489-c61b364b2949',
	'6ca783c1-2ac7-4467-8597-dff951a182de', '10535833-473e-4d26-b19b-6273a6c68730',
	'c5ea510c-291f-444c-a296-86225e222666', '84cfa09a-a92b-4fea-87f4-1c62218119a0',
	'9f49ff76-1153-401a-baca-cdfda37ac307', '641faac3-de4f-4797-8009-9c2ed96949d0',
	'64fe2af0-f40c-4e3f-b844-14fdd68ba5b2', '0b8a1798-2823-4e02-ae47-f101c544f532',
	'2b4c09c9-c058-454b-95bc-ddf1ae8e1055', '29870d81-16e1-4136-a24a-05e1a0a8ae3c',
	'cea1b3ad-339c-4dab-a23a-66d5648c5b91', 'e6304679-c21d-44f9-8b47-99b068fead51',
	'8d48ee4d-daff-48e5-b023-aa8f421d6302', 'f712dc81-e066-405f-9b16-25516c732f95',
	'79f79fb7-1c25-42ac-9498-2fa68c3f1548', '46ed4b0a-dd44-4ead-8f34-0229d3ecd8ae',
	'e6b92a52-6f41-40e5-a33e-7d8b13cd8ac1', '065ceaf6-f30f-46f4-bed2-ed566485de60',
	'2bf3ec27-90a5-47dd-a6a2-c5423c768bf7', '0ac995ea-fffd-490d-ba54-8eae2ffe0e23',
	'41fd34bf-b4ed-40e0-bbb3-78a403d9d047', '91f0e99d-e56a-4bbd-8993-02fe7969b454',
	'6274779d-6534-4441-99ca-a3a31e6746da', '085680af-76b4-4c95-985e-7fe899bba8fb',
	'a61181d9-5506-4704-a6a7-7def80f41344', '57d0ac3e-5455-4ff9-89c7-53d749c54da7',
	'1e152219-63cf-4616-aa17-a2b0c822165e', '962c03d2-88b3-46b7-8623-bba828ae0813',
	'4ea1daad-5d28-48c1-be01-68278ac102ec', 'ab11274b-c680-46b5-9639-50bb16fb7f4a',
	'94e3d6b4-fd43-4917-8457-f5bcc6540737', '2d04630b-9b5d-40b1-8fa1-b6fc3807a8b2',
	'4df42dcd-13f0-4973-a753-f494102fef33', '5ea90f42-7b7f-4ebc-ac52-07c7c9364ef1',
	'a5f6e987-6272-4a23-a7c3-bfe21218ed0d', '42c6afbb-a150-4f8a-8d67-52553b47720f',
	'21a9c8aa-f02b-48df-bc61-629b04dd2a07', '87962dd8-cf44-41f3-9725-75e71e099e67',
	'd671d897-b198-443e-a942-06fb5af50984', 'cd23de41-958d-499d-bd1a-7e01bcf1239e',
	'8d095008-901b-4ab0-9c66-85d16bb05db7', 'ebca145b-d75b-4270-8451-aba4ddcf0d55',
	'f6d573e6-d032-4d2f-b849-5a5adad07ccd', '6cd25f29-a239-4476-beba-321312429c43',
	'14e94cce-5819-41f7-bfd9-5f9109d4cade', '025c5f3f-c805-43c9-b851-176258094e76',
	'2e3e53a5-4532-46fb-a45b-b5de3a5e3ff2', 'eeeda088-3926-418b-8ef3-14f6e2eee3ad',
	'd6f6a032-8f54-4ef7-b5cb-3ba5c4cce7a6', '9a9ecd5e-9592-46f2-9fd7-3d9f94dcf4e7',
	'3bb346f1-6cb3-4fb9-a2b3-1cae8cadce95', '50cdab6d-2163-4e51-ad12-ac5e1421e0fd'
	)
	and activeflag = 1 ;
	
update livingarrangement 
set activeflag = 0,
	updatedby = 'CIDM-8291',
	updatedon = now()
where placementid in ( 
	'59fb2287-f43d-441e-be07-f9ec8b12fc71', '26651dbc-fdf0-402e-a7bf-376002d9987d',
	'ae3ea763-85aa-4830-a5bb-d2d488d9ddab', 'fbdf4fad-2131-4d09-88c6-c2659088c711',
	'eba4b70f-7ff5-41d8-881c-1c8ac5ea8a9b', 'b65d5be1-284a-4587-b283-cdd89641f30a',
	'55a6de58-37ad-415b-aad3-0847915e41ce', 'aa6eed3a-0ba0-4448-bd8e-79d6df6d0316',
	'78b99ae6-14ad-4ee4-ad2f-66899483cee9', '28f38808-06ba-4ec0-9334-2d0401b4294d',
	'e2a79acb-4ef7-4625-b245-0a82191a18e1', 'ba049b42-c30b-486f-b882-08302b9fd598',
	'4c6ace71-4045-4679-8e1d-45c9e971d105', '93c2b8b6-c7f2-40e4-adf7-c2c39bf649f3',
	'e49da942-d568-4694-832e-02553d04501d', '9b700350-a0b7-4787-adf4-6b2d5ba724ab',
	'1d22a18b-40ec-4cc8-b2d9-d89f4ca74109', '499fc8db-9816-4841-a52e-a8133b6b3f45',
	'a29f3c83-eddb-4c97-b7ee-48874d9b3a8f', 'ff6fd733-30be-44d9-996e-e101cbda28ce',
	'14ceaf5a-bba7-43eb-a18d-e3cc0e98e441', 'd72501bd-328e-4020-98b0-91cb61d75196',
	'f534f48a-e441-4ed8-a85c-0960a6877e3b', 'a92b26f1-ac07-4594-b74e-ecb5eaeca7b6',
	'9a78ad09-8534-4772-8aba-f53ee675c631', 'a1683caa-30ef-413b-9db0-1e98989953e1', 
	'85fcfd34-7882-46f2-9592-f970750119cb', '60ff28da-4896-4675-a5e7-b5c0b7dfe5e3',
	'af9308cb-24ad-4371-845a-40826f7016c6', '5898ea64-7f60-414b-9019-c753fc531a2f',
	'079a412a-fdc0-416e-bd71-af866d89e17f', 'b174cd5c-dca3-4c50-9222-79fb08fa1963',
	'ab04206b-42b4-40ac-b56a-0276f3ad1635', '8887a49e-1b5d-4d05-926b-15aef026a139',
	'2d745b87-8cb6-4c83-9654-ef52ab0147e1', '38175385-a627-42a2-b5d2-3dfbc2e8b9d8',
	'f31eff6f-1747-4594-b754-bf527f02727b', 'f24f583b-1512-4910-a9f5-d4b03bc7bb3a',
	'6e74dcc6-5862-4ca3-9f6e-c39296c52615', 'ff3cd824-eb7f-4ed8-b79b-ee75cdb3ccf0',
	'b1506e4d-4d0b-4cf2-8e45-fc4ee790e4f2', '6a278aa2-f338-4d51-98ef-e183fe546ca5',
	'69263f6d-9c31-4431-821a-252c8f853e21', 'a800e0c7-b43f-4eb0-8e18-c8f8a375415e',
	'0e4b5522-ce85-4958-a595-c8518c22c0d8', '589be9bc-7466-49e3-be02-02fb38e8e64f',
	'76380890-1940-47a1-81e8-752bac5ff5f5', 'eac0d445-32e4-4525-93b8-0bb1925f8d61',
	'a73f632a-965b-4ab1-80e8-d2f693c0b281', '705a3ae4-9280-4617-b202-c4eff59f0ab1',
	'a27c885b-9c4d-474c-a4bf-797bbfcb37cd', '7c21a6f3-3a6b-46f8-a422-237185cc3b91',
	'caa3f8a4-27ad-4685-90fc-7b1810fcdc7a', 'a0f3e670-da69-4723-90cf-f685e3693f21',
	'3697bef1-d155-4824-86ba-2f1965b38d21', '87c52d17-3597-4da9-bab9-135d15e2c9ff',
	'0a946326-1303-4116-8e76-42dd4a3aa220', 'db6264c9-3312-4489-9d9b-c07eb390b4a8',
	'f140f54d-1528-4cb9-a9dd-7bdc404c1e8f', '722fb44a-4c7b-4a3b-84ea-9c9fc338b877',
	'335c386c-d590-4888-8216-b22af72029bb', '21823691-8b3d-4800-a3b9-79ebd4ada28a',
	'ae39ab3c-9950-4f08-b59c-78c42aa0c465', 'bf7c9e45-4d7e-48e7-883d-40fa109ed038',
	'61a552b7-e8e7-4540-8f77-315b963e623b', '649d2f1c-aea0-458f-bd33-f1abc36bfdde',
	'71c72a7b-1617-4589-a583-142630bfefd4', 'd6c84e37-1500-43b2-8fac-bffdb506253a',
	'ab8dc74c-a5f6-4e23-b75b-5296ed3bed9e', '2eec1ffa-b82f-49dc-834c-1cc6b9a76c1f',
	'566760d0-e7f1-48aa-b810-59117fe1a978', '5c852985-6a0c-40c5-ac6f-fcad2f852188',
	'3d85c897-6806-4a41-9aa5-1e42d04b8d13', 'ae66019e-7a48-4fd3-95a0-529b4c4d03be',
	'2e009026-f027-45f9-bdc0-50b657512a2e', '6e850204-234f-460b-968a-9dff6dea44f0',
	'a2fd9251-3792-42f4-baf6-5c3bb660300d', 'a37ff63d-5011-4742-adbe-1a2b5e71cb44',
	'b2617f4b-74e1-4d36-b503-602c054c335f', '286d8feb-4012-460e-bbff-bb95d3d20028',
	'e539ac22-dfa2-4409-bbaf-d56c03310931', 'b4ef02c7-d11b-4928-8fb7-47cde704adf7',
	'86be6995-3630-491c-b164-d0911cf027b5', 'd9acefa2-82f8-448b-a7b3-f488eb9e3a79',
	'd7f26348-ffee-427b-b47a-9cfa5c4076bb', '425994fa-8c0c-4568-b5ed-6bd39beca720',
	'eb722a01-bc0e-44ec-ba0a-f6aeabdde859', '6838f318-d1b2-4f34-92ec-cc86174bd625',
	'e9d9d7ff-bf21-4a5e-8166-d20765f49d44', 'af1c47d6-0efa-4152-aaf0-c7cc8ec33f61',
	'8deab945-eb59-4fac-affb-b9cf36c9cd3e', '246bccef-6fff-4cce-bf12-8b0808f04258',
	'2875dd33-ac88-45ce-bcf4-13b60c063db3', '993cbf26-8ddc-4d5a-bc2c-6859b3776d23',
	'61191917-0a2c-45f0-a136-78f136cd9855', 'a63cb156-6e6d-4894-a488-60cafddd3fce',
	'93e9b283-df41-4a13-aaa3-7caba15ac523', '3d452d0c-d8e4-4347-9565-80662c118778',
	'18f4f574-b590-405c-8099-28088b1029eb', '1b493cec-1578-4b9a-aa3b-deed6b5c07e2',
	'af447e1c-88cc-4b45-987c-1f8a2250355e', '558644c4-a2d6-4762-9063-cf8bb80482b3',
	'4f867eb4-b91e-4441-a7a0-7df73f2a0e89', '2ab5cbe1-3d47-4d75-9489-c61b364b2949',
	'6ca783c1-2ac7-4467-8597-dff951a182de', '10535833-473e-4d26-b19b-6273a6c68730',
	'c5ea510c-291f-444c-a296-86225e222666', '84cfa09a-a92b-4fea-87f4-1c62218119a0',
	'9f49ff76-1153-401a-baca-cdfda37ac307', '641faac3-de4f-4797-8009-9c2ed96949d0',
	'64fe2af0-f40c-4e3f-b844-14fdd68ba5b2', '0b8a1798-2823-4e02-ae47-f101c544f532',
	'2b4c09c9-c058-454b-95bc-ddf1ae8e1055', '29870d81-16e1-4136-a24a-05e1a0a8ae3c',
	'cea1b3ad-339c-4dab-a23a-66d5648c5b91', 'e6304679-c21d-44f9-8b47-99b068fead51',
	'8d48ee4d-daff-48e5-b023-aa8f421d6302', 'f712dc81-e066-405f-9b16-25516c732f95',
	'79f79fb7-1c25-42ac-9498-2fa68c3f1548', '46ed4b0a-dd44-4ead-8f34-0229d3ecd8ae',
	'e6b92a52-6f41-40e5-a33e-7d8b13cd8ac1', '065ceaf6-f30f-46f4-bed2-ed566485de60',
	'2bf3ec27-90a5-47dd-a6a2-c5423c768bf7', '0ac995ea-fffd-490d-ba54-8eae2ffe0e23',
	'41fd34bf-b4ed-40e0-bbb3-78a403d9d047', '91f0e99d-e56a-4bbd-8993-02fe7969b454',
	'6274779d-6534-4441-99ca-a3a31e6746da', '085680af-76b4-4c95-985e-7fe899bba8fb',
	'a61181d9-5506-4704-a6a7-7def80f41344', '57d0ac3e-5455-4ff9-89c7-53d749c54da7',
	'1e152219-63cf-4616-aa17-a2b0c822165e', '962c03d2-88b3-46b7-8623-bba828ae0813',
	'4ea1daad-5d28-48c1-be01-68278ac102ec', 'ab11274b-c680-46b5-9639-50bb16fb7f4a',
	'94e3d6b4-fd43-4917-8457-f5bcc6540737', '2d04630b-9b5d-40b1-8fa1-b6fc3807a8b2',
	'4df42dcd-13f0-4973-a753-f494102fef33', '5ea90f42-7b7f-4ebc-ac52-07c7c9364ef1',
	'a5f6e987-6272-4a23-a7c3-bfe21218ed0d', '42c6afbb-a150-4f8a-8d67-52553b47720f',
	'21a9c8aa-f02b-48df-bc61-629b04dd2a07', '87962dd8-cf44-41f3-9725-75e71e099e67',
	'd671d897-b198-443e-a942-06fb5af50984', 'cd23de41-958d-499d-bd1a-7e01bcf1239e',
	'8d095008-901b-4ab0-9c66-85d16bb05db7', 'ebca145b-d75b-4270-8451-aba4ddcf0d55',
	'f6d573e6-d032-4d2f-b849-5a5adad07ccd', '6cd25f29-a239-4476-beba-321312429c43',
	'14e94cce-5819-41f7-bfd9-5f9109d4cade', '025c5f3f-c805-43c9-b851-176258094e76',
	'2e3e53a5-4532-46fb-a45b-b5de3a5e3ff2', 'eeeda088-3926-418b-8ef3-14f6e2eee3ad',
	'd6f6a032-8f54-4ef7-b5cb-3ba5c4cce7a6', '9a9ecd5e-9592-46f2-9fd7-3d9f94dcf4e7',
	'3bb346f1-6cb3-4fb9-a2b3-1cae8cadce95', '50cdab6d-2163-4e51-ad12-ac5e1421e0fd'
	)
	and activeflag = 1 ;	

update routing 
set activeflag = 0,
	updatedby = 'CIDM-8291',
	updatedon = now()
where objectid in ( 
	'59fb2287-f43d-441e-be07-f9ec8b12fc71', '26651dbc-fdf0-402e-a7bf-376002d9987d',
	'ae3ea763-85aa-4830-a5bb-d2d488d9ddab', 'fbdf4fad-2131-4d09-88c6-c2659088c711',
	'eba4b70f-7ff5-41d8-881c-1c8ac5ea8a9b', 'b65d5be1-284a-4587-b283-cdd89641f30a',
	'55a6de58-37ad-415b-aad3-0847915e41ce', 'aa6eed3a-0ba0-4448-bd8e-79d6df6d0316',
	'78b99ae6-14ad-4ee4-ad2f-66899483cee9', '28f38808-06ba-4ec0-9334-2d0401b4294d',
	'e2a79acb-4ef7-4625-b245-0a82191a18e1', 'ba049b42-c30b-486f-b882-08302b9fd598',
	'4c6ace71-4045-4679-8e1d-45c9e971d105', '93c2b8b6-c7f2-40e4-adf7-c2c39bf649f3',
	'e49da942-d568-4694-832e-02553d04501d', '9b700350-a0b7-4787-adf4-6b2d5ba724ab',
	'1d22a18b-40ec-4cc8-b2d9-d89f4ca74109', '499fc8db-9816-4841-a52e-a8133b6b3f45',
	'a29f3c83-eddb-4c97-b7ee-48874d9b3a8f', 'ff6fd733-30be-44d9-996e-e101cbda28ce',
	'14ceaf5a-bba7-43eb-a18d-e3cc0e98e441', 'd72501bd-328e-4020-98b0-91cb61d75196',
	'f534f48a-e441-4ed8-a85c-0960a6877e3b', 'a92b26f1-ac07-4594-b74e-ecb5eaeca7b6',
	'9a78ad09-8534-4772-8aba-f53ee675c631', 'a1683caa-30ef-413b-9db0-1e98989953e1', 
	'85fcfd34-7882-46f2-9592-f970750119cb', '60ff28da-4896-4675-a5e7-b5c0b7dfe5e3',
	'af9308cb-24ad-4371-845a-40826f7016c6', '5898ea64-7f60-414b-9019-c753fc531a2f',
	'079a412a-fdc0-416e-bd71-af866d89e17f', 'b174cd5c-dca3-4c50-9222-79fb08fa1963',
	'ab04206b-42b4-40ac-b56a-0276f3ad1635', '8887a49e-1b5d-4d05-926b-15aef026a139',
	'2d745b87-8cb6-4c83-9654-ef52ab0147e1', '38175385-a627-42a2-b5d2-3dfbc2e8b9d8',
	'f31eff6f-1747-4594-b754-bf527f02727b', 'f24f583b-1512-4910-a9f5-d4b03bc7bb3a',
	'6e74dcc6-5862-4ca3-9f6e-c39296c52615', 'ff3cd824-eb7f-4ed8-b79b-ee75cdb3ccf0',
	'b1506e4d-4d0b-4cf2-8e45-fc4ee790e4f2', '6a278aa2-f338-4d51-98ef-e183fe546ca5',
	'69263f6d-9c31-4431-821a-252c8f853e21', 'a800e0c7-b43f-4eb0-8e18-c8f8a375415e',
	'0e4b5522-ce85-4958-a595-c8518c22c0d8', '589be9bc-7466-49e3-be02-02fb38e8e64f',
	'76380890-1940-47a1-81e8-752bac5ff5f5', 'eac0d445-32e4-4525-93b8-0bb1925f8d61',
	'a73f632a-965b-4ab1-80e8-d2f693c0b281', '705a3ae4-9280-4617-b202-c4eff59f0ab1',
	'a27c885b-9c4d-474c-a4bf-797bbfcb37cd', '7c21a6f3-3a6b-46f8-a422-237185cc3b91',
	'caa3f8a4-27ad-4685-90fc-7b1810fcdc7a', 'a0f3e670-da69-4723-90cf-f685e3693f21',
	'3697bef1-d155-4824-86ba-2f1965b38d21', '87c52d17-3597-4da9-bab9-135d15e2c9ff',
	'0a946326-1303-4116-8e76-42dd4a3aa220', 'db6264c9-3312-4489-9d9b-c07eb390b4a8',
	'f140f54d-1528-4cb9-a9dd-7bdc404c1e8f', '722fb44a-4c7b-4a3b-84ea-9c9fc338b877',
	'335c386c-d590-4888-8216-b22af72029bb', '21823691-8b3d-4800-a3b9-79ebd4ada28a',
	'ae39ab3c-9950-4f08-b59c-78c42aa0c465', 'bf7c9e45-4d7e-48e7-883d-40fa109ed038',
	'61a552b7-e8e7-4540-8f77-315b963e623b', '649d2f1c-aea0-458f-bd33-f1abc36bfdde',
	'71c72a7b-1617-4589-a583-142630bfefd4', 'd6c84e37-1500-43b2-8fac-bffdb506253a',
	'ab8dc74c-a5f6-4e23-b75b-5296ed3bed9e', '2eec1ffa-b82f-49dc-834c-1cc6b9a76c1f',
	'566760d0-e7f1-48aa-b810-59117fe1a978', '5c852985-6a0c-40c5-ac6f-fcad2f852188',
	'3d85c897-6806-4a41-9aa5-1e42d04b8d13', 'ae66019e-7a48-4fd3-95a0-529b4c4d03be',
	'2e009026-f027-45f9-bdc0-50b657512a2e', '6e850204-234f-460b-968a-9dff6dea44f0',
	'a2fd9251-3792-42f4-baf6-5c3bb660300d', 'a37ff63d-5011-4742-adbe-1a2b5e71cb44',
	'b2617f4b-74e1-4d36-b503-602c054c335f', '286d8feb-4012-460e-bbff-bb95d3d20028',
	'e539ac22-dfa2-4409-bbaf-d56c03310931', 'b4ef02c7-d11b-4928-8fb7-47cde704adf7',
	'86be6995-3630-491c-b164-d0911cf027b5', 'd9acefa2-82f8-448b-a7b3-f488eb9e3a79',
	'd7f26348-ffee-427b-b47a-9cfa5c4076bb', '425994fa-8c0c-4568-b5ed-6bd39beca720',
	'eb722a01-bc0e-44ec-ba0a-f6aeabdde859', '6838f318-d1b2-4f34-92ec-cc86174bd625',
	'e9d9d7ff-bf21-4a5e-8166-d20765f49d44', 'af1c47d6-0efa-4152-aaf0-c7cc8ec33f61',
	'8deab945-eb59-4fac-affb-b9cf36c9cd3e', '246bccef-6fff-4cce-bf12-8b0808f04258',
	'2875dd33-ac88-45ce-bcf4-13b60c063db3', '993cbf26-8ddc-4d5a-bc2c-6859b3776d23',
	'61191917-0a2c-45f0-a136-78f136cd9855', 'a63cb156-6e6d-4894-a488-60cafddd3fce',
	'93e9b283-df41-4a13-aaa3-7caba15ac523', '3d452d0c-d8e4-4347-9565-80662c118778',
	'18f4f574-b590-405c-8099-28088b1029eb', '1b493cec-1578-4b9a-aa3b-deed6b5c07e2',
	'af447e1c-88cc-4b45-987c-1f8a2250355e', '558644c4-a2d6-4762-9063-cf8bb80482b3',
	'4f867eb4-b91e-4441-a7a0-7df73f2a0e89', '2ab5cbe1-3d47-4d75-9489-c61b364b2949',
	'6ca783c1-2ac7-4467-8597-dff951a182de', '10535833-473e-4d26-b19b-6273a6c68730',
	'c5ea510c-291f-444c-a296-86225e222666', '84cfa09a-a92b-4fea-87f4-1c62218119a0',
	'9f49ff76-1153-401a-baca-cdfda37ac307', '641faac3-de4f-4797-8009-9c2ed96949d0',
	'64fe2af0-f40c-4e3f-b844-14fdd68ba5b2', '0b8a1798-2823-4e02-ae47-f101c544f532',
	'2b4c09c9-c058-454b-95bc-ddf1ae8e1055', '29870d81-16e1-4136-a24a-05e1a0a8ae3c',
	'cea1b3ad-339c-4dab-a23a-66d5648c5b91', 'e6304679-c21d-44f9-8b47-99b068fead51',
	'8d48ee4d-daff-48e5-b023-aa8f421d6302', 'f712dc81-e066-405f-9b16-25516c732f95',
	'79f79fb7-1c25-42ac-9498-2fa68c3f1548', '46ed4b0a-dd44-4ead-8f34-0229d3ecd8ae',
	'e6b92a52-6f41-40e5-a33e-7d8b13cd8ac1', '065ceaf6-f30f-46f4-bed2-ed566485de60',
	'2bf3ec27-90a5-47dd-a6a2-c5423c768bf7', '0ac995ea-fffd-490d-ba54-8eae2ffe0e23',
	'41fd34bf-b4ed-40e0-bbb3-78a403d9d047', '91f0e99d-e56a-4bbd-8993-02fe7969b454',
	'6274779d-6534-4441-99ca-a3a31e6746da', '085680af-76b4-4c95-985e-7fe899bba8fb',
	'a61181d9-5506-4704-a6a7-7def80f41344', '57d0ac3e-5455-4ff9-89c7-53d749c54da7',
	'1e152219-63cf-4616-aa17-a2b0c822165e', '962c03d2-88b3-46b7-8623-bba828ae0813',
	'4ea1daad-5d28-48c1-be01-68278ac102ec', 'ab11274b-c680-46b5-9639-50bb16fb7f4a',
	'94e3d6b4-fd43-4917-8457-f5bcc6540737', '2d04630b-9b5d-40b1-8fa1-b6fc3807a8b2',
	'4df42dcd-13f0-4973-a753-f494102fef33', '5ea90f42-7b7f-4ebc-ac52-07c7c9364ef1',
	'a5f6e987-6272-4a23-a7c3-bfe21218ed0d', '42c6afbb-a150-4f8a-8d67-52553b47720f',
	'21a9c8aa-f02b-48df-bc61-629b04dd2a07', '87962dd8-cf44-41f3-9725-75e71e099e67',
	'd671d897-b198-443e-a942-06fb5af50984', 'cd23de41-958d-499d-bd1a-7e01bcf1239e',
	'8d095008-901b-4ab0-9c66-85d16bb05db7', 'ebca145b-d75b-4270-8451-aba4ddcf0d55',
	'f6d573e6-d032-4d2f-b849-5a5adad07ccd', '6cd25f29-a239-4476-beba-321312429c43',
	'14e94cce-5819-41f7-bfd9-5f9109d4cade', '025c5f3f-c805-43c9-b851-176258094e76',
	'2e3e53a5-4532-46fb-a45b-b5de3a5e3ff2', 'eeeda088-3926-418b-8ef3-14f6e2eee3ad',
	'd6f6a032-8f54-4ef7-b5cb-3ba5c4cce7a6', '9a9ecd5e-9592-46f2-9fd7-3d9f94dcf4e7',
	'3bb346f1-6cb3-4fb9-a2b3-1cae8cadce95', '50cdab6d-2163-4e51-ad12-ac5e1421e0fd'
	)
	and eventcode = 'PLTR'
	and activeflag = 1 ;
	
-- Delete 
Delete from cjams.livingarrangement	
where insertedby = 'CIDM-8291'
	and updatedby = 'CIDM-8291'
	and activeflag = 1 ;
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	211030010338	4028439	ROSMERY  RIVERA-PAZ 	1761454	5/31/2023	6/14/2023
-- comments: Add Inpatent Psychiatric to Living Arrangmnet type.. 
--           PRimary Caregiver; Sheppard Pratt Hospital. Adress 6501 N Charles Street, Baltimore, MD. 
-- 1945cea7-e034-40ed-9b5a-7b12f04de8a5	1761454

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'PSYH', --  Inpatient Psychiatric Hospital
		'2023-05-31 00:00:00.000', '2023-06-14 00:00:00.000',
		'Sheppard Pratt Hospital', 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'BS', -- Business
		'S', '6501 N Charles Street', 'Baltimore', NULL, 'MD', 21204, NULL, 'USA', 
		'e0d433bc-6e56-4efe-9408-7b17d85efa91', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'1945cea7-e034-40ed-9b5a-7b12f04de8a5', -- placementid
		NULL, NULL, NULL, NULL
	);


-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3293781	3046501		VALERIE M GEISLER 	1572727			5/25/2022	7/15/2022
-- comments: There is one Living Arrangement with this time frame. Please add the Living Arrangment type as Runaway.
-- 9ef0cd2e-fa24-4e33-b4cc-459a198f76f4	1572727

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RNW', --  Runaway
		'2022-05-25 00:00:00.000', '2022-07-15 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL,
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		'c84234df-dcef-470c-b108-1e1cc4e8fdf2', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'9ef0cd2e-fa24-4e33-b4cc-459a198f76f4', -- placementid
		NULL, NULL, NULL, NULL
	);
	

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3239116	4307140		AUBREE  VANSTORY 	1566683			9/16/2021	9/20/2021
-- comments: There are 2 Living Arrangements with this time frame.  Please delete one 
--		     and add to the other Living Arrangment that the type is Respite 
--			 and the Primary caregive is Jacqeline Hardwick
-- 58743330-1342-4e8e-b8c7-aac85f4147f4	1566683

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'REC', --  Respite care
		'2021-09-16 00:00:00.000', '2021-09-20 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL,
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		'28780b16-1057-4554-bcc8-1839ad65fe8b', -- personid
		NULL, NULL, NULL, 'Jacqeline Hardwick', NULL, NULL, NULL,
		'58743330-1342-4e8e-b8c7-aac85f4147f4', -- placementid
		NULL, NULL, NULL, NULL
	);


-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3057171	200794740	Tyler   Thompson 	1565668			8/16/2021	8/17/2021
-- comments: Relative as Living Arrangmnet, 
--    Primary Caretaker, Fred Thompson, address: 5009 E Hoffman St. Baltimore, MD 21206 and Phone : 410-485-4607
-- 014a6b08-1afc-480e-9ae2-dcb73df3d8e3	1565667

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-08-16 00:00:00.000', '2021-08-17 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '5009 E Hoffman St.', 'Baltimore', NULL, 'MD', 21206, NULL, 'USA', 
		'1c001f8c-361b-401c-942a-1e3cc102d9ab', -- personid
		NULL, NULL, NULL, 'Fred Thompson', NULL, '4104854607', NULL,
		'014a6b08-1afc-480e-9ae2-dcb73df3d8e3', -- placementid
		NULL, NULL, NULL, NULL
	);
	

-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	211030010310	200776331	My'Asia  Cherry 	1569101			12/27/2021	1/1/2022
-- comments: There is 1 Living Arrangment with this timeframe. Please add, respite care 
--	and primary caregiver name: Janet Alexander, address, 4409 Parkton Street, Baltimore, Maryland 21229, 
--	Phone 410-917-7335
-- 3f0a16e4-b11b-4e3e-be4e-d60f896bacc4	1569101

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'REC', --  Respite care
		'2021-12-27 00:00:00.000', '2022-01-01 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'BS', -- Business
		'S', '4409 Parkton Street', 'Baltimore', NULL, 'MD', 21229, NULL, 'USA', 
		'576f9bba-4ab7-476c-b934-817b25b3d259', -- personid
		NULL, NULL, NULL, 'Janet Alexander', NULL, NULL, '4109177335',
		'3f0a16e4-b11b-4e3e-be4e-d60f896bacc4', -- placementid
		NULL, NULL, NULL, NULL
	);
	
-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	211030010310	200776338	Miracle  Cherry 	1569100			12/27/2021	1/1/2022
-- comments: There is 1 Living Arrangment with this timeframe. Please add, respite care 
-- 	and primary caregiver name: Janet Alexander, address, 4409 Parkton Street, Baltimore, Maryland 21229, 
--  Phone 410-917-7335
-- f56ee512-4bd1-4e45-9419-830ebdda76df	1569100

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'REC', --  Respite care
		'2021-12-27 00:00:00.000', '2022-01-01 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'BS', -- Business
		'S', '4409 Parkton Street', 'Baltimore', NULL, 'MD', 21229, NULL, 'USA', 
		'14e282a7-29a1-4bd1-b8dc-d4d0a2771628', -- personid
		NULL, NULL, NULL, 'Janet Alexander', NULL, NULL, '4109177335',
		'f56ee512-4bd1-4e45-9419-830ebdda76df', -- placementid
		NULL, NULL, NULL, NULL
	);
	
-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	211030011542	200817362	Aaliyha  Jackson 	1568567			10/8/2021	1/28/2022
-- comments: There is 1 Living Arrangment with this time frame.  
-- 	Please add to Living Arrangment , Relative /fictive kin,
--  Primary Caregiver,Sharlondia Brown, address;  2 Willow Tree Garth apt D, phone :(443-768-3433)
-- 981dbecd-2c1e-450b-9cec-225035980d8e	1568567


INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-10-08 00:00:00.000', '2022-01-28 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '2 Willow Tree Garth apt D', 'Cockeysville', NULL, 'MD', 21030, NULL, 'USA', 
		'094b81c6-221b-4c91-8822-8acc778bda7f', -- personid
		NULL, NULL, NULL, 'Sharlondia Brown', NULL, '4437683433', NULL,
		'981dbecd-2c1e-450b-9cec-225035980d8e', -- placementid
		NULL, NULL, NULL, NULL
	);
	

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3123174	3716920	MARIAH  EDWARDS 	1565356	8/5/2021	8/5/2021
-- comments: There is one Living Arrangment this time frame.  Can you please add that it is a relative/Fictive Kin. 
--     Caregiver is Jacqueline Jones, Address is 5981 Shering Rd., Baltimore MD 21206
-- 9bc5cac9-58a5-4049-9059-715d54429d3a	1565356

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-08-05 00:00:00.000', '2021-08-05 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '5981 Shering Rd.', 'Baltimore', NULL, 'MD', 21206, NULL, 'USA', 
		'8164e00e-51ab-4498-a23a-65f87a7f27a9', -- personid
		NULL, NULL, NULL, 'Jacqueline Jones', NULL, NULL, NULL,
		'9bc5cac9-58a5-4049-9059-715d54429d3a', -- placementid
		NULL, NULL, NULL, NULL
	);
	
-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3117999	3796794		JOHNATHAN K BARNES 	1565056			7/21/2021	8/2/2021
-- comments: THere is 1 Living Arrangment with this time frame.  Pease add Relative/Ficitive kin as LA type. 
-- Primary Caregive is Darien Stills,at 8811 Hunting Ln # 104 Laurel MD 20708
-- 3a6c77b9-7b98-4305-adaf-43070b2411ae	1565056

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-07-21 20:00:00.000', '2021-08-02 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '8811 Hunting Ln # 104', 'Laurel', NULL, 'MD', 20708, NULL, 'USA', 
		'b9514591-096c-4e21-ad24-19cb2acc0337', -- personid
		NULL, NULL, NULL, 'Darien Stills', NULL, NULL, NULL,
		'3a6c77b9-7b98-4305-adaf-43070b2411ae', -- placementid
		NULL, NULL, NULL, NULL
	);
	

-- County			Case ID	Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	3166130	2528575		JA'NELL M GRIFFIN 	1565072			7/10/2021	7/13/2021
-- comments: There is 1 Living Arrangment with this time frame. 
--  Please add Respite care to the Living Arrangment type
-- dcaaaabc-903c-463f-9669-86f9e8c04e74	1565072

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'REC', --  Respite care
		'2021-07-10 00:00:00.000', '2021-07-13 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL,
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		'3c8d84fd-d09e-4761-8d13-c23d31e669a8', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'dcaaaabc-903c-463f-9669-86f9e8c04e74', -- placementid
		NULL, NULL, NULL, NULL
	);
	


-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3110807	3988327		ISAIAH  SANDERS 1564520			6/24/2021	6/25/2021
-- comments: THere is 1 Living arrangment with this time frame. Add Living arrangment type: relative.ficitve kin. 
-- Primary caregiver is Lilita Cuncci and address is  5314 Den Wood Blatimore md 21206
-- 9583beb1-4e82-499b-a5c4-3bbc0063e486	1564520

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-06-24 00:00:00.000', '2021-06-25 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '5314 Den Wood', 'Baltimore', NULL, 'MD', 21206, NULL, 'USA', 
		'8158eb4b-8411-4606-a09d-7be3ec529567', -- personid
		NULL, NULL, NULL, 'Lilita Cuncci', NULL, '4104854607', NULL,
		'9583beb1-4e82-499b-a5c4-3bbc0063e486', -- placementid
		NULL, NULL, NULL, NULL
	);
	


-- County			Case ID	Client ID	Client Name				Placement ID	Entry Date	Exit Date
-- Baltimore City	3164127	4004776		SHAWN ABTAWN WILLIAMS 	1564717			6/14/2021	7/19/2021
-- comments: There is 1 Living Arrangment with this time frame.  Please add the living arrangmen type to DJS facility 
-- bf400d40-3b56-44cd-92de-8db2b18aaa79	1564717


INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'DJS', -- DJS Funded Facility/not detention
		'2021-06-14 00:00:00.000', '2021-07-19 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL,
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		'625316a1-70ec-4c42-8ee6-c8c4c36b512a', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'bf400d40-3b56-44cd-92de-8db2b18aaa79', -- placementid
		NULL, NULL, NULL, NULL
	);
	
-- County			Case ID			Client ID	Client Name			Placement ID	Entry Date	Exit Date
-- Baltimore City	211030008202	4197069		SENNAY C ALEMAYEHU 	1564040			6/10/2021	6/15/2021
-- comments: Thee is one Living Arrangment with this time frame. Please add to this livivng arrangment Structure -Ficitve kin, 
-- Primary Caregive:Varie Hill and adress: 817 Gilrubin court, apt 8. 
-- 6b075f30-78d5-4350-94c5-f87811280ec6	1564040	

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-06-10 00:00:00.000', '2021-06-15 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '817 Gilrubin court, apt 8', 'Baltimore', NULL, 'MD', 21212, NULL, 'USA', 
		'9bde0feb-2380-4eb3-8bb8-495d2757404e', -- personid
		NULL, NULL, NULL, 'Varie Hill', NULL, NULL, NULL,
		'6b075f30-78d5-4350-94c5-f87811280ec6', -- placementid
		NULL, NULL, NULL, NULL
	);
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3269902	4086077	JAYLAN J FULTON 	1563725	6/4/2021	6/9/2021
-- comments: There is 1 Living Arrangment with this time frame.  
-- Please add Living Arrangmnet type as Juvinle facility, 
-- Primary Caretaker, Charles Hickey Dentention Ctr., Address:9700 Old Harford Rd Parkville, MD 21234, Phone #(443) 588-0150
-- 113f10dd-3f2d-47b0-b0c8-374c3a3b4223	1563725	

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone, 
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'DJS', -- DJS Funded Facility/not detention
		'2021-06-04 00:00:00.000', '2021-06-09 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'BS', -- Business
		'S', '9700 Old Harford Rd', 'Parkville', NULL, 'MD', 21234, NULL, 'USA', 
		'5d050cf1-0597-4eb7-b43f-a8e8c786d83c', -- personid
		NULL, NULL, NULL, 'Charles Hickey Dentention Ctr.', NULL, NULL, '4435880150',
		'113f10dd-3f2d-47b0-b0c8-374c3a3b4223', -- placementid
		NULL, NULL, NULL, NULL
	);
	

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3219786	3458107	KENNEDY  JOHNSON 	1563734	5/11/2021	5/25/2021
-- comments: THere is 1 Living Arrangment with this timeframe.  
-- Please add as Inpatient Psch. Name Shepard Pratt Hosptial, 
-- 6501 N Charles St Baltimore, MD 21212,Phone #410-938-3000
-- f9507b40-2053-4053-b91f-ca0a954b98e5	1563734

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'PSYH', --  Inpatient Psychiatric Hospital
		'2021-05-11 00:00:00', '2021-05-25 00:00:00',
		'Sheppard Pratt Hospital', 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'BS', -- Business
		'S', '6501 N Charles Street', 'Baltimore', NULL, 'MD', 21204, NULL, 'USA', 
		'4e33d662-5103-4d4c-8b2b-951f3e08247b', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, '4109383000',
		'f9507b40-2053-4053-b91f-ca0a954b98e5', -- placementid
		NULL, NULL, NULL, NULL
	);
	
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3142343	4358320	JAZZELL  MICHIE 	1563229	5/10/2021	5/13/2021
-- comments: There is 1 Living Arrangement with this time frame.  
-- Please add the Living Arrangment as Inpatient Medical. The caretaker as Johns Hopkins (410-955-5000) 
-- 11ad7a89-7b9b-4dc4-9858-5a5b33a84b17	1563229

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'IMC', --  Inpatient Medical Care
		'2021-05-10 00:00:00', '2021-05-13 00:00:00',
		'Johns Hopkins Hospital', 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'BS', -- Business
		'S', '600 N Wolfe St # B110', 'Baltimore', NULL, 'MD', 21287, NULL, 'USA', 
		'3aa51dad-83d2-4dbf-86b4-12b33854300a', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, '4109555000',
		'11ad7a89-7b9b-4dc4-9858-5a5b33a84b17', -- placementid
		NULL, NULL, NULL, NULL
	);
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3251768	3776358	KEONTAY  DOWNS 	1562546	4/5/2021	5/20/2021
-- comments: There is 1 Living arrangment with this time frame.  
-- Please add that this is a Rleative Placement (maternal aunt) 
-- with Cherie Stocks at 6405 Whitwell Ct. Fort Washington, MD ( +1 (434) 219-9762)
-- efaef852-0ba5-4c92-be1e-0cf2b6528b12	1562546

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-04-05 00:00:00', '2021-05-20 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '6405 Whitwell Ct.', 'Fort Washington', NULL, 'MD', 20744, NULL, 'USA', 
		'659d0b58-1b3c-4c09-a4b5-9b3895e7514a', -- personid
		NULL, NULL, NULL, 'Cherie Stocks', NULL, '4342199762', NULL,
		'efaef852-0ba5-4c92-be1e-0cf2b6528b12', -- placementid
		'Maternal Aunt', NULL, NULL, NULL
	);
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202105406163	200567831	Kenia  Segovia-Alvarenga 	1562477	3/12/2021	3/17/2021
-- comments: There is 1 Living Arrangment for this timeframe.  
-- Please add the realtive placement as Maria Lopez-Maternal Aunt, 
-- 1745 E Pratt Street, Baltimore, MD. 21231, Phone # 443-722-4839
-- 42d0f7ab-1043-4666-afb7-96289a14b0ee	1562477

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-03-12 00:00:00', '2021-03-17 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '1745 E Pratt Street', 'Baltimore', NULL, 'MD', 21231, NULL, 'USA', 
		'4329b238-05cb-4417-9e01-2a01217c58c9', -- personid
		NULL, NULL, NULL, 'Maria Lopez', NULL, '4437224839', NULL,
		'42d0f7ab-1043-4666-afb7-96289a14b0ee', -- placementid
		'Maternal Aunt', NULL, NULL, NULL
	);
	

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202104105903	200316122	Alex  Ghiocel 	1561250	3/5/2021	5/14/2021
-- comments: There is 1 Living Arrangment with this time period.  
-- Please add Caretkaer name: Somna Mitita as Maternal Grandmother and Structure as relative placement.
-- bb7b042a-39a6-4f67-84d4-3d2f8395dc86	1561250

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-03-05 00:00:00', '2021-05-14 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'46cdad1e-9d13-4f94-be84-b004cef4de9a', -- personid
		NULL, NULL, NULL, 'Somna Mitita', NULL, NULL, NULL,
		'bb7b042a-39a6-4f67-84d4-3d2f8395dc86', -- placementid
		'Maternal Grandmother', NULL, NULL, NULL
	);
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202104105903	200316127	Elena  Ghiocel 	1561252	3/5/2021	5/14/2021
-- comments: There is 1 Living Arrangment with this time period.  
-- Please add Caretkaer name: Somna Mitita as Maternal Grandmother and Structure as relative placement.
-- bce8261d-17c3-4f21-8fe1-a86a97403cc2	1561252

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-03-05 00:00:00', '2021-05-14 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'b7b92a46-f317-45d3-bcba-1dd0fd6df4a6', -- personid
		NULL, NULL, NULL, 'Somna Mitita', NULL, NULL, NULL,
		'bce8261d-17c3-4f21-8fe1-a86a97403cc2', -- placementid
		'Maternal Grandmother', NULL, NULL, NULL
	);
	
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202104105903	200316124	Andrada  Ghiocel 	1561251	3/5/2021	5/14/2021
-- comments: There is 1 Living Arrangment with this time period.  
-- Please add Caretkaer name: Somna Mitita as Maternal Grandmother and Structure as relative placement.
-- 8d9f93bc-5ac7-4fea-a6f0-d3b4a04df5fa	1561251	

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-03-05 00:00:00', '2021-05-14 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL, 
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'923f90cf-2549-4bb2-b88f-deaef46710cd', -- personid
		NULL, NULL, NULL, 'Somna Mitita', NULL, NULL, NULL,
		'8d9f93bc-5ac7-4fea-a6f0-d3b4a04df5fa', -- placementid
		'Maternal Grandmother', NULL, NULL, NULL
	);


-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	202106206350	4422207	ALARA M MORRIS 	1563111	3/2/2021	
-- comments: The Living Arrangment with a start date of 3/2/21 need to be updated with ER Medical as Structure, 
-- Name of caretaker Johns Hopkins Hospital, 1800 Orleans St. The living arrangment also needs the end date of 3/3/21 added.
-- ebd110dd-7525-4c12-8299-071ee104d6fe	1563111


INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'ERM', --  ER Medical
		'2021-03-02 23:00:00', '2021-03-03 00:00:00',
		'Johns Hopkins Hospital', 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'BS', -- Business
		'S', '1800 Orleans St.', 'Baltimore', NULL, 'MD', 21287, NULL, 'USA', 
		'fe2dd0ab-c85f-4ede-bdd0-ea31fd494cb7', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'ebd110dd-7525-4c12-8299-071ee104d6fe', -- placementid
		NULL, NULL, NULL, NULL
	);
	
update placement
set enddatetime = '2021-03-03 00:00:00',
	exittypekey = 'CIPS', -- Change in Placement structure
	updatedby = 'CIDM-8291',
	updatedon = now()
where placementid = 'ebd110dd-7525-4c12-8299-071ee104d6fe'
	and activeflag = 1 
	and enddatetime is null ;
	
update placementrevision
set exitdate = '2021-03-03 00:00:00',
	exittypekey = 'CIPS', -- Change in Placement structure
	updatedby = 'CIDM-8291',
	updatedon = now()
where placementid = 'ebd110dd-7525-4c12-8299-071ee104d6fe'
	and activeflag = 1 
	and exitdate is null ;
			
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3279927	4129716	HAILEY R MCDONALD 	1561332	1/26/2021	1/28/2021
-- comments: Please add this living arrangment infoarmiton to the Living Arrangment for these dates.  
-- Sherri Pearre, Paternal Granmother, Relative placement,, 612 Franklin Ave, Esses, MD. 21221, Phone #443.834.9718
-- 7b1679e1-9246-43ec-bc89-667ffa752897	1561332	

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-01-26 00:00:00', '2021-01-28 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '612 Franklin Ave', 'Essex', NULL, 'MD', 21221, NULL, 'USA', 
		'3e1f08d4-7ec4-4e68-bd1b-b573ff97451b', -- personid
		NULL, NULL, NULL, 'Somna Mitita', NULL, '4438349718', NULL,
		'7b1679e1-9246-43ec-bc89-667ffa752897', -- placementid
		'Paternal Grandmother', NULL, NULL, NULL
	);

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3124974	1663075	DAQWAN T JAMISON 	1561574	12/4/2020	9/1/2021
-- comments: There is 1 Living Arrangemnt with these dates. 
-- Please add Adult Correctional Facility as Living Arrangment 
-- and add the name Baltimore City Central Booking with 
-- adress: 901 Greenmount Avenue Baltimore, Maryland 21202 , Phone #  (410) 332-4340
-- 6cefd877-f5b6-4b77-aa96-44b5a75a141f	1561574	

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone, 
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'DJS', -- DJS Funded Facility/not detention
		'2020-12-04 00:00:00', '2021-09-01 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'BS', -- Business
		'S', '901 Greenmount Avenue', 'Baltimore', NULL, 'MD', 21202, NULL, 'USA', 
		'c308c9ad-d049-4727-ab50-cae9590d54a4', -- personid
		NULL, NULL, NULL, 'Baltimore City Central Booking', NULL, NULL, '4103324340',
		'6cefd877-f5b6-4b77-aa96-44b5a75a141f', -- placementid
		NULL, NULL, NULL, NULL
	);
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3279598	3463999	KASSANDRA M PORTILLO 	1559726	12/4/2020	3/12/2021
-- comments: There is 1 entree with these dates. 
-- Please add Living Arrangment as Relative /Fictive Kin. 
-- Also add caretaker info: Karen Terry, 10090 Mill Run Circle, Unit 328, Owings Mills, Maryland 21117. 
-- Phone number is 410-736-9736. 
-- 1c436135-630a-4ae4-b299-8939c996a369	1559726	



INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2020-12-04 00:00:00', '2021-03-12 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '10090 Mill Run Circle, Unit 328', 'Owings Mills', NULL, 'MD', 21117, NULL, 'USA', 
		'ace76d3e-99e9-4fcd-bfd0-8c19ced22e9d', -- personid
		NULL, NULL, NULL, 'Karen Terry', NULL, '4107369736', NULL,
		'1c436135-630a-4ae4-b299-8939c996a369', -- placementid
		'Relative', NULL, NULL, NULL
	);
	

	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3122326	1666704	DEVARTEZ TYREEK COLEY 	1559627	12/2/2020	1/11/2021
-- comments: There is 1 entree with these dates. Please add DJS facility to Living Arrangment
-- 17a44312-4707-449c-8517-20b043ce89ab	1559627	

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'DJS', -- DJS Funded Facility/not detention
		'2020-12-02 04:20:00', '2021-01-11 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL,
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 
		'66348c31-6d65-4b59-8bc5-fe7839859904', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'17a44312-4707-449c-8517-20b043ce89ab', -- placementid
		NULL, NULL, NULL, NULL
	);


	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3119654	2536576	PHILESHA L QUEEN 	1559228	9/29/2020	11/18/2020
-- comments: There is one entree for these dates. 
-- Please add Paternal Aunt: Latarsha Chileta Payne	
-- Address: 737 Edgewood Street Baltimore, MD 21229 to Living Arrangment
-- 	d3244567-5410-4955-9fb2-f7ae24225b4f	1559228	

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2020-09-29 00:00:00', '2020-11-18 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '737 Edgewood Street', 'Baltimore', NULL, 'MD', 21229, NULL, 'USA', 
		'1e8db21c-67b0-41dd-a7ae-92abbeeb2a47', -- personid
		NULL, NULL, NULL, 'Latarsha Chileta Payne', NULL, NULL, NULL,
		'd3244567-5410-4955-9fb2-f7ae24225b4f', -- placementid
		'Paternal Aunt', NULL, NULL, NULL
	);
	
	
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3169787	2419735	Rose  Medley 	1557266	8/25/2020	11/13/2020
-- comments:  Ms. Vandonia Jackson Paternal grandmother address 3909 Wabash Ave 
-- d0cc3ddd-4cdb-491a-9aea-1b2d84d7ef64	1557266	

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2020-08-25 00:00:00', '2020-11-13 00:00:00',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		'H', -- Home
		'S', '3909 Wabash Ave', 'Baltimore', NULL, 'MD', 21215, NULL, 'USA', 
		'2726a242-01ca-4c94-a3b6-3bfe8ed91a5a', -- personid
		NULL, NULL, NULL, 'Ms. Vandonia Jackson', NULL, NULL, NULL,
		'd0cc3ddd-4cdb-491a-9aea-1b2d84d7ef64', -- placementid
		'Paternal Grandmother', NULL, NULL, NULL
	);
	
-- County			Case ID			Client ID	Client Name					Placement ID	Entry Date	Exit Date
-- Baltimore City	202105406166	4346994		KE'OIR  Whiters-FRANKLIN 	1561174			12/11/2020	2/28/2021
-- comments: Relative/fictive kin home
-- 21f37f11-544e-4c86-9048-673cc566105c	1561174

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2020-12-11 00:00:00.000', '2021-02-28 00:00:00.000',
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL,
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'4baf7909-a781-4233-83ca-c9b1f164ba25', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'21f37f11-544e-4c86-9048-673cc566105c', -- placementid
		NULL, NULL, NULL, NULL
	);
	
-- County			Case ID	Client ID	Client Name					Placement ID	Entry Date	Exit Date
-- Baltimore City	3253314	200172254	Tyshawn M Nicholson-hearn 	1560784			2/4/2021	2/4/2021
-- comments: Relatve/ficitve kin
-- cd211538-fb1f-435b-a5e5-32f020ce361c	1560784

INSERT INTO cjams.livingarrangement
	(	livingid, 
		livingarrangementtypekey, 
		livingstartdate, livingenddate, 
		livingfirstname, 
		insertedon, insertedby, updatedon, updatedby, activeflag, 
		addresstypekey, 
		addressformattypekey, streetname, cityname, countytypekey, statetypekey, zip5no, zip4no, country, 
		personid, 
		caregiverclientid, partnerid, streettext, primarycaregiver, secondarycaregiver, homephone, workphone,  
		placementid, 
		primaryrelationship, livingpriortoplacement, runawayreported,  runawayreportnumber 
	)
VALUES
	(	cjams.gen_random_uuid(), 
		'RFKH', --  Relative/fictive kin home
		'2021-02-04 15:00:00.000', NULL,
		NULL, 
		now(), 'CIDM-8291', now(), 'CIDM-8291', 1, 
		NULL,
		NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'b4b9bb65-61fd-4347-81c9-e88e24f6944b', -- personid
		NULL, NULL, NULL, NULL, NULL, NULL, NULL,
		'cd211538-fb1f-435b-a5e5-32f020ce361c', -- placementid
		NULL, NULL, NULL, NULL
	);

-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- 
-- comments: 
-- FCH	Foster Care - Home


-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3294261	4304089	MAURICE  WRIGHT 	1564485	2/10/2019	2/10/2019
-- comments: Add Change in placement structure to the Living Arrangement with the address.

update placement
set exittypekey = 'CIPS', -- Change in Placement structure
	updatedby = 'CIDM-8291',
	updatedon = now()
where placementid = 'ed5603cb-7f4d-4140-9d6f-6c1d2538433d'
	and activeflag = 1 ;
		
		
-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3223892	2217872	TAMIL SHAMERE SMITH 	1560744	11/13/2020	1/28/2021
-- comments: There is one entree for this date. Please delete and change prior living arrangment end date to 1/28/21 from 12/22/20.
-- 87ef2900-afc4-4658-a24c-755edfef2312	1560966

update placement
set enddatetime = '2021-01-28 00:00:00',
	updatedby = 'CIDM-8291',
	updatedon = now()
where placementid = '87ef2900-afc4-4658-a24c-755edfef2312'
	and activeflag = 1 
	and enddatetime is not null ;
	
update placementrevision
set exitdate = '2021-01-28 00:00:00',
	updatedby = 'CIDM-8291',
	updatedon = now()
where placementid = '87ef2900-afc4-4658-a24c-755edfef2312'
	and activeflag = 1 
	and exitdate is not null ;		


-- County			Case ID	Client ID	Client Name		Placement ID	Entry Date	Exit Date
-- Baltimore City	3251655	3097389	NATALIE CORDAE COLEMAN 	1559493	10/2/2020	10/15/2020
-- comments: Please to the other Living Arrangment with Rebecca Coleman to Relative/Kinship care 
-- from Medical hosptial and add her address, 204 Clyde Ave, Baltimore MD 21227.
-- 0d880134-1f06-4f50-86be-05048e613cd4	1559493	-- LA 2e427d34-0af7-4e3f-b564-84eeb4df1b77

update cjams.livingarrangement
set livingarrangementtypekey = 'RFKH', --  Relative/fictive kin home
	primarycaregiver = 'Rebecca Coleman',
	streetname = '204 Clyde Ave',
	cityname = 'Baltimore',
	statetypekey = 'MD',
	zip5no = 21227,
	country = 'USA',
	primaryrelationship = 'Relative',
	updatedon = now(), 
	updatedby = 'CIDM-8291'
where livingid = '2e427d34-0af7-4e3f-b564-84eeb4df1b77'
	and activeflag = 1 ;	
	
/*
select pr.cjamspid,
	la.livingid,
	pl.placementid,
	pl.alternateid,
	pl.startdatetime,
	pl.enddatetime,
	(SELECT count(*) 
          FROM routing
     WHERE routing.routingstatustypeid = 16 
     	AND routing.eventcode::text = 'PLTR'::text 
     	AND routing.activeflag = 1 
     	AND routing.objectid::text = pl.placementid::character varying::text
     ) as approved_cnt
,     pl.exitreasontypekey
,    pl.personid  
, la.workphone  
from placement pl
	left join livingarrangement la on la.placementid = pl.placementid, 
	person pr
where pl.personid = pr.personid 
	and pl.activeflag = 1
	and pr.cjamspid = 2528575
	and pl.startdatetime ::date = '7/10/2021'::date
	and pl.altproviderid is null
	-- and la.livingarrangementtypekey  = 'REC'
*/	
