-- CIDM-3657 -  Measure 31 : 3194990 Incorrect Placement and This case should not be in Report
/*
-- Issue Description: 
	Closed Placements with Active CPA Homes
 
-- Category/ Module: Placement (Case Management) 
-- Root cause: User error.
-- Pull request# N/A
-- Reason why no related code fix: N/A
-- Status of the code fix if already submitted and expected prod fix date: N/A
*/

-- Before
select * 
from (  
select pl.alternateid as placement_id,
	pc.altproviderid as CPA_Home_provider_ID,
	pc.placementcpahomeid,
	pc.entrydt::date as CPA_Home_Entry_date,
	pc.exitdt::date as CPA_Home_Exit_date,
	pl.startdatetime::date as Placement_entry_date,
	pl.enddatetime::date as Placement_exit_date,
	(case when pc.entrydt::date > pl.enddatetime::date then 
		'Error' 
	 else 
	 	'Good'
	 end ) as test
from placementcpahomes pc,
	placement pl
where pc.placementid = pl.placementid 
	and pc.activeflag = 1
	and pl.activeflag = 1
	and pc.entrydt is not null
	and pc.exitdt is null
	and pl.enddatetime is not null
	and COALESCE(pl.isvoided, 0) <> 1 
) tab
where tab.test = 'Good' ;

-- Update Placement Exit Date as CPA Home Exit Date
update placementcpahomes set exitdt = '2013-03-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = 'db7ef0a4-be18-4cbd-8f23-1d77798b658e' ;
update placementcpahomes set exitdt = '2013-03-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = 'b85df45f-033f-44bb-8b71-d512ee85cc26' ;
update placementcpahomes set exitdt = '2011-04-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 22:00:00' where placementcpahomeid = '696a5586-97cf-48fa-ad9a-0b8d01f4cade' ;
update placementcpahomes set exitdt = '2011-04-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 22:00:00' where placementcpahomeid = '2ac3c3db-453c-4dbf-90d0-ffdc17de6eaa' ;
update placementcpahomes set exitdt = '2011-04-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 22:00:00' where placementcpahomeid = 'd912e709-1f6f-41c5-924b-c6f9d38f5526' ;
update placementcpahomes set exitdt = '2013-10-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '1c7bae6e-0858-4055-aea4-12337f907c6e' ;
update placementcpahomes set exitdt = '2009-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:01:00' where placementcpahomeid = 'a6f50a35-1b4b-4117-bde3-cd7ba1e566dc' ;
update placementcpahomes set exitdt = '2011-05-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '55eedc4b-10ca-4301-8f8e-03403ab29455' ;
update placementcpahomes set exitdt = '2014-02-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '42b3c5a4-7fd9-449a-a819-496882c999ed' ;
update placementcpahomes set exitdt = '2012-08-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = '5cc98bdf-fd76-4fa1-b60c-657c4d38bc16' ;
update placementcpahomes set exitdt = '2009-07-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '93708620-03ce-4d17-98ba-0237236e73a3' ;
update placementcpahomes set exitdt = '2010-02-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '90023263-f887-4e98-86da-9bc8c307dc40' ;
update placementcpahomes set exitdt = '2010-08-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00:00' where placementcpahomeid = '7a42c929-28d4-4b1e-83e6-d46deeb4e1ee' ;
update placementcpahomes set exitdt = '2010-06-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'f86f42f7-bb2e-451a-b134-ae721c9f89fe' ;
update placementcpahomes set exitdt = '2012-02-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '50b5e196-3c08-4e1d-9fd9-a01a4eb2d4a9' ;
update placementcpahomes set exitdt = '2012-06-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = 'b1aae2b9-6b4a-49b1-a363-01bd8efce3f7' ;
update placementcpahomes set exitdt = '2012-08-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '4220ca59-8fc4-41f1-9bea-236c452b370f' ;
update placementcpahomes set exitdt = '2021-03-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00:00' where placementcpahomeid = 'fb68a6a7-c79b-4d1d-b8df-0e20766f05e4' ;
update placementcpahomes set exitdt = '2009-06-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = 'bb92554b-cac1-4f09-9ddc-47bf2c9c6581' ;
update placementcpahomes set exitdt = '2013-06-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 21:00:00' where placementcpahomeid = 'c214f24d-fa97-4dd6-90c7-ef8d0238c133' ;
update placementcpahomes set exitdt = '2009-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = 'ec948703-3d83-45f7-bec6-b04dc633b2c7' ;
update placementcpahomes set exitdt = '2009-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '6ec0a1de-7f4a-4992-b879-36f7223f0cbe' ;
update placementcpahomes set exitdt = '2013-05-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = 'a7d158f4-05af-4da6-9750-5bb0b8a229c7' ;
update placementcpahomes set exitdt = '2013-01-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '4ebe63d4-311b-45e1-906b-6348e07d2cce' ;
update placementcpahomes set exitdt = '2016-03-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:42:14' where placementcpahomeid = '37bb00ba-41bc-41ce-bcb6-298fad2e2c04' ;
update placementcpahomes set exitdt = '2016-03-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:43:13' where placementcpahomeid = 'b7e1477d-4afd-4ca3-a731-cc71841d44cf' ;
update placementcpahomes set exitdt = '2016-03-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:43:46' where placementcpahomeid = '2d8634fd-9a8b-475e-8d4e-e0752e7fde22' ;
update placementcpahomes set exitdt = '2014-02-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:24:13' where placementcpahomeid = 'ef20b9f3-9b81-4922-8f73-1ebf5f0593fa' ;
update placementcpahomes set exitdt = '2011-02-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '77eb99b0-5e29-4448-9ca2-90616076efc9' ;
update placementcpahomes set exitdt = '2011-05-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = 'c4bcdd79-547b-42b9-8327-6b07df5e7c56' ;
update placementcpahomes set exitdt = '2010-04-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:45:00' where placementcpahomeid = '36c9f08c-0240-4c25-87f3-3df64bfdab13' ;
update placementcpahomes set exitdt = '2011-08-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = '663662d7-05bf-4510-b733-0146f2873f8a' ;
update placementcpahomes set exitdt = '2010-05-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = '679a5088-dd38-4d3b-a008-c6a79a61d973' ;
update placementcpahomes set exitdt = '2020-07-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 23:59:00' where placementcpahomeid = 'e7436964-e80a-4329-9e41-c5cc8851b0c9' ;
update placementcpahomes set exitdt = '2009-01-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = 'f40b57a1-7abd-4c32-bd8e-c40ee9776b6b' ;
update placementcpahomes set exitdt = '2009-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'bc567fb7-92ea-47e7-ad90-9e559ca3768b' ;
update placementcpahomes set exitdt = '2009-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '998e192b-0e7d-4df1-b8d9-437b4c1b085a' ;
update placementcpahomes set exitdt = '2012-08-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30:00' where placementcpahomeid = '952e2cf3-757f-4341-85f1-b370d13a8a1b' ;
update placementcpahomes set exitdt = '2009-12-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00:00' where placementcpahomeid = '270e12fd-4d9e-436f-8311-119c0bdbd7d9' ;
update placementcpahomes set exitdt = '2010-06-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30:00' where placementcpahomeid = '92e82bb3-7726-4a3b-b48d-50a6a754ece9' ;
update placementcpahomes set exitdt = '2016-03-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:44:22' where placementcpahomeid = '7ded0b2c-1da2-4686-9c5a-1dad265d0255' ;
update placementcpahomes set exitdt = '2014-06-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:50:00' where placementcpahomeid = '9d207c53-3de8-4e76-b8d9-ae505f396042' ;
update placementcpahomes set exitdt = '2011-01-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00:00' where placementcpahomeid = '867e6cde-448b-44d7-aab2-357dc78b1175' ;
update placementcpahomes set exitdt = '2010-06-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '39b66fae-af3a-43bc-873f-d98025f63609' ;
update placementcpahomes set exitdt = '2010-02-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '816f9cc3-f981-4ea5-8682-137b42582732' ;
update placementcpahomes set exitdt = '2014-01-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00:00' where placementcpahomeid = '5fcb72b2-c751-42e9-bd50-0cf0b0c6c39b' ;
update placementcpahomes set exitdt = '2010-03-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30:00' where placementcpahomeid = '5161f248-3377-4a50-8cfe-482572e63806' ;
update placementcpahomes set exitdt = '2010-03-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30:00' where placementcpahomeid = 'b346235b-e0c1-41e4-9545-aec33e3ffbf7' ;
update placementcpahomes set exitdt = '2012-09-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:05:00' where placementcpahomeid = '0f073363-ba67-4341-9f38-757635ac5554' ;
update placementcpahomes set exitdt = '2010-08-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'b3ca04ae-74bd-423f-b0a2-afd824cecb47' ;
update placementcpahomes set exitdt = '2010-08-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'ded4b581-42a7-4ab3-a907-9ab8249f8d6d' ;
update placementcpahomes set exitdt = '2010-02-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00:00' where placementcpahomeid = '85fae615-50fb-4869-b59c-440453a971e7' ;
update placementcpahomes set exitdt = '2010-02-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00:00' where placementcpahomeid = 'bcc9f8c3-3c38-4aa2-bd3f-43383bb7f59d' ;
update placementcpahomes set exitdt = '2011-03-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:30:00' where placementcpahomeid = '65ff82b8-3d2e-4165-879a-26dd3f652d6a' ;
update placementcpahomes set exitdt = '2010-04-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = 'b2a1774f-b3d4-41b8-b0b3-b20e587dd4b6' ;
update placementcpahomes set exitdt = '2011-03-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:30:00' where placementcpahomeid = '9427cac4-6454-4eb3-ac79-6fb381b3b990' ;
update placementcpahomes set exitdt = '2012-11-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = '6805edb6-faa0-43ae-872a-e28211e2a71c' ;
update placementcpahomes set exitdt = '2014-07-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = 'be65c75b-6108-40e1-abf0-f302970efbe1' ;
update placementcpahomes set exitdt = '2009-12-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00:00' where placementcpahomeid = '69f5e884-36a0-42a0-8066-805365bb28e2' ;
update placementcpahomes set exitdt = '2010-06-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = 'ff2dd8a1-2400-417c-ac2b-0b94439b08ae' ;
update placementcpahomes set exitdt = '2013-03-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '1996dffb-bab1-4eda-80af-57962f2498ab' ;
update placementcpahomes set exitdt = '2009-12-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'aed6f704-b10a-441e-b933-ea5b4a25777d' ;
update placementcpahomes set exitdt = '2011-03-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00:00' where placementcpahomeid = 'ccc759bd-bab6-49b9-9f94-ad8c5ece764e' ;
update placementcpahomes set exitdt = '2010-05-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30:00' where placementcpahomeid = '6bd3b750-5255-4c3b-8b51-752611c1dcc6' ;
update placementcpahomes set exitdt = '2010-06-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = 'f4ee93a1-29e3-4a4d-ae6f-608afd203bf9' ;
update placementcpahomes set exitdt = '2010-10-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = 'f54cb495-3bb4-488c-902a-cb3fa2ec9170' ;
update placementcpahomes set exitdt = '2010-07-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '8c395ed9-4783-4c15-ac8f-52a602cfce50' ;
update placementcpahomes set exitdt = '2010-09-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00:00' where placementcpahomeid = 'c996bc68-83f0-4034-bc5f-797883ba12c2' ;
update placementcpahomes set exitdt = '2010-03-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '65c17d92-8e53-4159-8f2f-effa3d819654' ;
update placementcpahomes set exitdt = '2011-01-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '6b191548-a246-46b0-b30f-216ce2d76642' ;
update placementcpahomes set exitdt = '2010-06-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '7b3a1fa7-e659-4fe4-9122-bc37fee81d67' ;
update placementcpahomes set exitdt = '2010-08-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '1af5f68e-c73b-49be-8994-3d74a0072d38' ;
update placementcpahomes set exitdt = '2011-03-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = 'b8f3c920-9dd2-48b7-962b-3eae55a6ca12' ;
update placementcpahomes set exitdt = '2010-09-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '277e6ca9-80cd-4a34-9ff0-418d2308dc23' ;
update placementcpahomes set exitdt = '2017-08-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00:00' where placementcpahomeid = '84072dbf-55ec-4558-bac9-e03977f69dc7' ;
update placementcpahomes set exitdt = '2010-09-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'b1a1b161-b73f-4a7d-8884-1a1602e5b2d5' ;
update placementcpahomes set exitdt = '2011-01-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = 'be219708-1bf4-4790-ae7c-9d7abd77a14b' ;
update placementcpahomes set exitdt = '2011-03-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = 'b05e761c-d1fc-4b51-921f-0be745071492' ;
update placementcpahomes set exitdt = '2012-02-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '8b3726c5-7083-4cc6-9391-224f5eb72316' ;
update placementcpahomes set exitdt = '2014-06-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:39:17' where placementcpahomeid = '9361e29f-71de-4c45-a328-dfba547aa351' ;
update placementcpahomes set exitdt = '2010-10-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = '4cf128b8-87de-4f30-bcad-f82f3f221a0b' ;
update placementcpahomes set exitdt = '2011-01-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '85d77da8-bbdb-4172-ae04-6ef6beddbf37' ;
update placementcpahomes set exitdt = '2012-12-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00:00' where placementcpahomeid = '49dce79d-40bb-4818-991b-24ba5e0d3f46' ;
update placementcpahomes set exitdt = '2011-11-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:30:00' where placementcpahomeid = '6df1a281-ce4b-456e-af5f-af1acec049ba' ;
update placementcpahomes set exitdt = '2014-05-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:03:52' where placementcpahomeid = '9d3766fb-fa57-48ea-9cf1-0b6916feba32' ;
update placementcpahomes set exitdt = '2013-09-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '98cc1501-bc1f-47c6-b7ab-722d46a964ef' ;
update placementcpahomes set exitdt = '2012-07-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = 'c2526f8d-18bb-49db-a26a-c568d6e0e7ee' ;
update placementcpahomes set exitdt = '2012-07-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '78b56943-ab9d-4855-918a-7f2fc4017d79' ;
update placementcpahomes set exitdt = '2012-05-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '49a1f89f-1d1f-44ef-8306-aeadac23592c' ;
update placementcpahomes set exitdt = '2014-06-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00:00' where placementcpahomeid = '118384e0-4224-40cd-98f7-fd253cc45e1e' ;
update placementcpahomes set exitdt = '2014-05-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '33045bea-8a34-4980-a61b-fffaa26a9d59' ;
update placementcpahomes set exitdt = '2017-03-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:32:11' where placementcpahomeid = 'e3f1268c-75bb-42fa-8cab-0cb24fa91520' ;
update placementcpahomes set exitdt = '2011-07-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30:00' where placementcpahomeid = 'f9c231ee-0088-4d3e-85d4-8db927f11387' ;
update placementcpahomes set exitdt = '2012-04-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00:00' where placementcpahomeid = '72a38dbe-1f73-48b5-badd-4988471e260f' ;
update placementcpahomes set exitdt = '2014-09-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:01:48' where placementcpahomeid = '6234ddbc-8ebb-42ef-89d1-3101f0e3b4de' ;
update placementcpahomes set exitdt = '2015-11-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:57:00' where placementcpahomeid = '4222a011-05fc-4cbc-ac78-927382f6ef2f' ;
update placementcpahomes set exitdt = '2014-06-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '9c0c7caa-aa87-4910-851c-a09cd1ddae2c' ;
update placementcpahomes set exitdt = '2011-08-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '0bc7f562-1249-47fe-ac76-c175c80357f4' ;
update placementcpahomes set exitdt = '2013-11-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '09a86419-1aa4-4186-a140-4a3a05631b24' ;
update placementcpahomes set exitdt = '2012-07-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00:00' where placementcpahomeid = '18d897bf-1f21-4dc6-9eea-0b29267df472' ;
update placementcpahomes set exitdt = '2011-03-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '9986ff47-8245-4d86-8d25-42fba965881d' ;
update placementcpahomes set exitdt = '2013-01-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'b053481d-3f58-4b0b-a179-c4025a8c31e5' ;
update placementcpahomes set exitdt = '2011-11-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '294b28d3-4175-4854-ad82-539dd23c7f7a' ;
update placementcpahomes set exitdt = '2020-12-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '0b2c8d24-1ea5-41cd-a6f0-4e7da4a4bca4' ;
update placementcpahomes set exitdt = '2020-12-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '73205abe-cfa3-4525-aee1-177908951c1a' ;
update placementcpahomes set exitdt = '2011-09-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = 'f6af1666-b452-48bd-b670-58b8cfb7c563' ;
update placementcpahomes set exitdt = '2013-07-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '3f250042-c568-458c-ada2-3d7e2e99a2d8' ;
update placementcpahomes set exitdt = '2013-11-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '344d2539-9249-41bf-82ba-933ec0a5e99c' ;
update placementcpahomes set exitdt = '2013-11-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '460c57dc-244f-4963-99ab-07356d515431' ;
update placementcpahomes set exitdt = '2013-11-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'f394dc03-0eb5-49ea-80ba-741c0c02405d' ;
update placementcpahomes set exitdt = '2011-12-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '7a3c8f17-9458-4cb9-9a40-84b4e513ded1' ;
update placementcpahomes set exitdt = '2011-09-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '4ce7de4a-d3e2-452f-b2ec-ad513a0c3617' ;
update placementcpahomes set exitdt = '2012-11-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = 'c96ff8c1-c4cf-4510-baf6-50c657b6f906' ;
update placementcpahomes set exitdt = '2014-01-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00:00' where placementcpahomeid = '0962095e-8b0e-4fd9-83a6-ca68d6880004' ;
update placementcpahomes set exitdt = '2016-06-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:10:39' where placementcpahomeid = 'b9c54b5a-3463-4c1f-824a-9c8b81545ab5' ;
update placementcpahomes set exitdt = '2012-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '6ca576ac-8819-4ef6-93eb-f3c9cffe322c' ;
update placementcpahomes set exitdt = '2012-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = 'b4188b11-ef0d-4a51-9815-3c4478a594a3' ;
update placementcpahomes set exitdt = '2014-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = '3df64123-542d-45db-b0dc-486866810625' ;
update placementcpahomes set exitdt = '2012-11-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = '63c6fafa-807e-4e27-af54-11e52f37065d' ;
update placementcpahomes set exitdt = '2017-06-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '9a389dc7-a4b1-4e6f-ae0d-ae66916b0509' ;
update placementcpahomes set exitdt = '2017-06-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '0bad60e5-cf49-47b3-b221-a16bca8be620' ;
update placementcpahomes set exitdt = '2017-06-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '8773768c-98b4-47c9-acfe-aca4798b365c' ;
update placementcpahomes set exitdt = '2014-09-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:25:12' where placementcpahomeid = '87335e38-4476-46a0-84d2-ef6f510baec4' ;
update placementcpahomes set exitdt = '2013-06-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '57b01363-bda6-45f6-8e76-d6b986dad493' ;
update placementcpahomes set exitdt = '2013-04-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '16d2dd04-1527-4a35-b6df-f3df736695ba' ;
update placementcpahomes set exitdt = '2012-06-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00:00' where placementcpahomeid = '8b6e5c4e-e0c5-41f4-9023-1432980ac306' ;
update placementcpahomes set exitdt = '2012-04-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '89cebd2a-e2f2-486f-b5d1-d1687be24c63' ;
update placementcpahomes set exitdt = '2012-01-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '2e8481b1-9803-4954-aee9-bebe57b82f1d' ;
update placementcpahomes set exitdt = '2014-05-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:40:23' where placementcpahomeid = '6a47d035-4c8d-4b1e-9246-05804b047e5a' ;
update placementcpahomes set exitdt = '2017-01-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:49:32' where placementcpahomeid = 'a86809b3-41e7-47ca-8f88-0f420e551eb5' ;
update placementcpahomes set exitdt = '2012-06-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = '2d934e55-2be6-4859-89ff-e2f4d1860403' ;
update placementcpahomes set exitdt = '2012-10-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '050ce6a3-f5b4-4f12-bba1-77b563c59d8c' ;
update placementcpahomes set exitdt = '2016-05-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:33:43' where placementcpahomeid = '6192b32f-b03d-4221-8795-44ae5333f19a' ;
update placementcpahomes set exitdt = '2016-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:39:54' where placementcpahomeid = 'dc28113c-0af0-4fa2-b306-85d7477aae24' ;
update placementcpahomes set exitdt = '2013-12-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '42c0ee55-3a25-4d87-9350-e998ecc5b7da' ;
update placementcpahomes set exitdt = '2020-08-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '269f6183-7106-4f9d-b616-1be451f81bc9' ;
update placementcpahomes set exitdt = '2013-02-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = 'f38583a4-6da5-4127-a8b8-ef5f70e0c551' ;
update placementcpahomes set exitdt = '2012-07-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:40:00' where placementcpahomeid = '79e0f84a-bc6e-44f6-8036-34a1fe3d3625' ;
update placementcpahomes set exitdt = '2012-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = 'cacd9f6a-46d6-42eb-8b25-1960fad51225' ;
update placementcpahomes set exitdt = '2014-03-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:12:36' where placementcpahomeid = 'f55e3e04-c1ba-4693-8b62-ae92c8d91e84' ;
update placementcpahomes set exitdt = '2012-10-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '8c134f2a-b546-415a-af77-b73de2b7a766' ;
update placementcpahomes set exitdt = '2012-10-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '0682a404-2f75-4c28-aa0d-aaf90fc90ac3' ;
update placementcpahomes set exitdt = '2015-12-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:11:00' where placementcpahomeid = 'dd777290-b50c-47f4-b8ce-49a72f143498' ;
update placementcpahomes set exitdt = '2020-12-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00' where placementcpahomeid = '7ee519b7-7cb5-4796-af38-5184f048e909' ;
update placementcpahomes set exitdt = '2014-03-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:15:59' where placementcpahomeid = 'd959323c-8c8b-437b-9035-b5bfa5f8369c' ;
update placementcpahomes set exitdt = '2014-03-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:43:31' where placementcpahomeid = '7b94315c-dea3-4135-acb1-2d819c1e9c4e' ;
update placementcpahomes set exitdt = '2013-03-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '5783d224-526f-47e5-89ad-e1666a71d5cf' ;
update placementcpahomes set exitdt = '2012-08-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '3fb7e4ec-1d4c-40b1-822d-9fd9bd92956e' ;
update placementcpahomes set exitdt = '2013-11-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 19:00:00' where placementcpahomeid = 'a65c3733-b788-4846-9683-e121fafbbc86' ;
update placementcpahomes set exitdt = '2015-02-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:51:45' where placementcpahomeid = '58bf14b8-d13b-476c-bf22-3b2e3e7678df' ;
update placementcpahomes set exitdt = '2014-02-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '47bd605e-b488-4e56-836e-009216199aa9' ;
update placementcpahomes set exitdt = '2015-02-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00:29' where placementcpahomeid = '51b3790e-3272-4b45-a91c-840aeac392b1' ;
update placementcpahomes set exitdt = '2013-09-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '828f6257-2fa6-4bcb-84a2-98f4abb99cd3' ;
update placementcpahomes set exitdt = '2014-05-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30:00' where placementcpahomeid = 'ab0100aa-c693-47f7-a315-09bb9273ad07' ;
update placementcpahomes set exitdt = '2014-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:01:09' where placementcpahomeid = '242ecdd2-c2ef-4408-bb6e-7b3aadafc647' ;
update placementcpahomes set exitdt = '2013-06-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '65b4583b-4a05-4316-bbac-e40c11046c73' ;
update placementcpahomes set exitdt = '2014-04-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:18:38' where placementcpahomeid = '9a051c8e-e547-445e-a066-3dd74dffb803' ;
update placementcpahomes set exitdt = '2012-11-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = '91201619-1b51-44cd-93a4-546a22d50638' ;
update placementcpahomes set exitdt = '2012-11-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '42f78768-ce43-4a64-9b93-427beed890e9' ;
update placementcpahomes set exitdt = '2013-03-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30:00' where placementcpahomeid = '7c09bfc3-3987-4c52-b24a-e111fff282f1' ;
update placementcpahomes set exitdt = '2013-12-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '20e3d282-e65b-42cd-b28b-18e63ef25e76' ;
update placementcpahomes set exitdt = '2015-06-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = 'be2ace62-0252-48cd-82f3-99bba3499ccd' ;
update placementcpahomes set exitdt = '2015-06-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '1507f40f-168a-4b25-a7e9-2fd0717751a8' ;
update placementcpahomes set exitdt = '2016-07-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:21:03' where placementcpahomeid = '2168cb11-94f1-4377-a0ec-b356d92d304e' ;
update placementcpahomes set exitdt = '2014-10-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:43' where placementcpahomeid = '2f6e3e0d-3153-4cf4-845f-7178402b85b2' ;
update placementcpahomes set exitdt = '2013-01-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = 'd76988ee-818a-4148-a203-be4362a9bba4' ;
update placementcpahomes set exitdt = '2013-06-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00:00' where placementcpahomeid = 'c6ee0753-3b31-44dd-ad9b-692b0e5dd2c0' ;
update placementcpahomes set exitdt = '2016-02-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:36:07' where placementcpahomeid = '335b6449-fa97-4c7e-a566-ae0712821faf' ;
update placementcpahomes set exitdt = '2014-10-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:11:40' where placementcpahomeid = '6973c6c3-57e4-4566-9faa-3ca58449ed65' ;
update placementcpahomes set exitdt = '2013-04-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00:00' where placementcpahomeid = '9d704786-410d-4041-aefb-eb08fd691a28' ;
update placementcpahomes set exitdt = '2013-02-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'a6dbd5f8-3a0a-4411-aa32-6f0219202e1d' ;
update placementcpahomes set exitdt = '2013-04-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '91b6d087-0565-4d88-8429-b8e5a1468e69' ;
update placementcpahomes set exitdt = '2014-07-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:30:00' where placementcpahomeid = 'ddafb8f6-f54a-458c-8eba-ef356de8b00c' ;
update placementcpahomes set exitdt = '2013-02-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'aebe8ed3-5e11-416b-bd80-23bd530a8564' ;
update placementcpahomes set exitdt = '2013-02-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'b5ea9174-c839-42ed-a9f9-a071fc894eb1' ;
update placementcpahomes set exitdt = '2013-05-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00:00' where placementcpahomeid = 'efd942e7-5d94-4ce3-a248-cb9bf4136e4a' ;
update placementcpahomes set exitdt = '2017-04-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:24:17' where placementcpahomeid = 'a64dbf24-1edb-4a06-9270-28e34e30691b' ;
update placementcpahomes set exitdt = '2015-07-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:01:42' where placementcpahomeid = '786e2d86-31c5-483f-85ac-328a28824020' ;
update placementcpahomes set exitdt = '2013-09-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:23:00' where placementcpahomeid = 'f47d7979-d75c-46c7-9921-d103de73a021' ;
update placementcpahomes set exitdt = '2013-05-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '9c48ee74-b27e-4093-9c28-0557fc26d6fc' ;
update placementcpahomes set exitdt = '2013-07-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = '90415075-164b-4550-a188-95c8f803bce5' ;
update placementcpahomes set exitdt = '2014-03-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = '0d33761d-a1d6-4453-8c6b-67a2f7c7df3e' ;
update placementcpahomes set exitdt = '2015-12-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:15:31' where placementcpahomeid = '0ee62dea-f13e-4861-951c-d9141b2ab6ae' ;
update placementcpahomes set exitdt = '2013-11-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '65b48d8e-5e9a-45ff-8f18-2e2d5a2089b5' ;
update placementcpahomes set exitdt = '2015-03-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:08:33' where placementcpahomeid = 'abacb127-38f2-4caf-a41c-3eb4034d2050' ;
update placementcpahomes set exitdt = '2016-10-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:54:41' where placementcpahomeid = '10bb75c6-4515-4c67-bfd8-0ae10d21e893' ;
update placementcpahomes set exitdt = '2015-07-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:43:04' where placementcpahomeid = 'dbc7816a-8b66-4bba-8692-46a6101c62a0' ;
update placementcpahomes set exitdt = '2016-04-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '18927d64-5376-4542-afda-1ef23339e488' ;
update placementcpahomes set exitdt = '2013-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30:00' where placementcpahomeid = '73d14c81-c798-4d1a-b900-4387aca91fae' ;
update placementcpahomes set exitdt = '2013-12-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = 'bcd12618-256d-4757-ac03-c63667b98203' ;
update placementcpahomes set exitdt = '2014-04-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:15' where placementcpahomeid = 'd6d9ec98-cca5-4781-85d1-5d8bb5abade1' ;
update placementcpahomes set exitdt = '2016-01-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:43:52' where placementcpahomeid = 'eba73419-90ee-41fc-94e3-39a71b7a2d09' ;
update placementcpahomes set exitdt = '2017-09-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:27:37' where placementcpahomeid = 'c97a4fbf-acd5-425e-ba08-687436633bfb' ;
update placementcpahomes set exitdt = '2017-09-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:27:05' where placementcpahomeid = 'a69dc69d-7919-419d-8004-aea91db641f4' ;
update placementcpahomes set exitdt = '2015-02-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '4b892aaa-f2ac-4e98-bc29-9582d4b263d6' ;
update placementcpahomes set exitdt = '2020-09-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '6333e3b2-2c8a-4908-9ba7-fb9f7a9caf85' ;
update placementcpahomes set exitdt = '2013-07-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'fdea4a65-7e70-48a5-89ee-9cfd16e373a4' ;
update placementcpahomes set exitdt = '2015-03-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:08:59' where placementcpahomeid = 'c89de588-83ed-47ff-8cce-d0da7e83a8e0' ;
update placementcpahomes set exitdt = '2015-07-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '86d704b1-b487-42e2-bba7-9030ac83d9ac' ;
update placementcpahomes set exitdt = '2016-05-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '2493229f-fe46-47b5-bdd8-bb2181619b99' ;
update placementcpahomes set exitdt = '2013-12-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00:00' where placementcpahomeid = 'dabba664-8193-4086-a11e-4e0d35a5d579' ;
update placementcpahomes set exitdt = '2013-12-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00:00' where placementcpahomeid = 'c91b68b8-ce44-4ea2-9228-a339fad5c9e0' ;
update placementcpahomes set exitdt = '2013-12-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 01:42:00' where placementcpahomeid = 'a2e86682-ef29-42c5-b820-56669f9b7b85' ;
update placementcpahomes set exitdt = '2014-08-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '3140e889-2b0e-48e5-8067-a844a37f303e' ;
update placementcpahomes set exitdt = '2017-08-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:22:16' where placementcpahomeid = '0d9a1e81-3b59-4243-8d17-0ecf5f1317a6' ;
update placementcpahomes set exitdt = '2017-08-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:22:34' where placementcpahomeid = '980a220d-371c-44b2-8bd6-f8e1d284f868' ;
update placementcpahomes set exitdt = '2017-06-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:38:59' where placementcpahomeid = '04df5b05-8662-4e41-a32f-ab022c9ebac2' ;
update placementcpahomes set exitdt = '2014-11-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00:00' where placementcpahomeid = 'caad881c-34b8-4c43-b017-9fc83adbc46a' ;
update placementcpahomes set exitdt = '2014-09-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:23:22' where placementcpahomeid = '63c1e82a-b769-40cc-952b-db6df33a5701' ;
update placementcpahomes set exitdt = '2021-02-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = 'c7de6cdb-0dcd-4cb5-8652-cb0cdbd332ec' ;
update placementcpahomes set exitdt = '2014-07-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '9e42452c-691c-4e66-8af3-b69149199c7b' ;
update placementcpahomes set exitdt = '2015-03-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:08:28' where placementcpahomeid = '055ce6e2-ea45-4d9d-acd8-57387425524a' ;
update placementcpahomes set exitdt = '2016-09-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:19:49' where placementcpahomeid = 'cc1a0cfd-ee63-40ff-ac2a-0aeb4a97e561' ;
update placementcpahomes set exitdt = '2015-11-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:27:46' where placementcpahomeid = 'a9bced54-23c4-4fe8-8ab2-d26b953c0b66' ;
update placementcpahomes set exitdt = '2014-05-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 21:45:00' where placementcpahomeid = '94cc05c4-3847-40a7-aca0-6cbb2208683d' ;
update placementcpahomes set exitdt = '2016-05-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '2be67e47-cfd8-4405-93a2-4a544c7fce88' ;
update placementcpahomes set exitdt = '2016-08-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:29:30' where placementcpahomeid = '89360080-a941-47c2-835c-5bbf02624dab' ;
update placementcpahomes set exitdt = '2016-08-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:28:09' where placementcpahomeid = 'e9be188f-4d1c-4813-9f98-67bc6d5bb25a' ;
update placementcpahomes set exitdt = '2016-10-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:21:41' where placementcpahomeid = '55818931-2d12-4274-802b-dc92f9cafea4' ;
update placementcpahomes set exitdt = '2016-10-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:20:49' where placementcpahomeid = '0d10d56f-6858-42e4-93b7-c4ab693141ea' ;
update placementcpahomes set exitdt = '2014-06-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:58:36' where placementcpahomeid = '6436f85c-a190-4c4a-81ba-ffa0bd871fa9' ;
update placementcpahomes set exitdt = '2014-06-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:04:43' where placementcpahomeid = 'b5723cb8-9e27-4b89-957b-7d0862906aba' ;
update placementcpahomes set exitdt = '2020-10-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '0020ea79-d398-4c1e-b70a-20268809bd41' ;
update placementcpahomes set exitdt = '2015-11-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:29:03' where placementcpahomeid = 'a37abd57-d490-449d-b36a-aacc0beec4d3' ;
update placementcpahomes set exitdt = '2014-05-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:07:54' where placementcpahomeid = '93aa9b8b-58ef-43af-8efc-1d4f881d7357' ;
update placementcpahomes set exitdt = '2015-11-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:39:10' where placementcpahomeid = 'faabf5cd-f8f6-4631-bb6d-1a84039b9b92' ;
update placementcpahomes set exitdt = '2015-11-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:38:22' where placementcpahomeid = '1d1699b4-46af-44cf-8d87-e0e7c9d7e250' ;
update placementcpahomes set exitdt = '2016-11-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30:00' where placementcpahomeid = '04787974-b52f-40ba-a618-3bbbb980a9d5' ;
update placementcpahomes set exitdt = '2015-01-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:35:40' where placementcpahomeid = 'eac8b225-11bf-422a-aeb4-a8c5c4e02278' ;
update placementcpahomes set exitdt = '2017-04-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = 'dc38fc41-464d-4c53-bc17-5329b93470e8' ;
update placementcpahomes set exitdt = '2020-10-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'fc7858d5-13f0-49c8-ad63-263819b0c2a2' ;
update placementcpahomes set exitdt = '2017-03-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:14:00' where placementcpahomeid = '8b69ff2d-021a-4b87-a5bc-63779ec53504' ;
update placementcpahomes set exitdt = '2015-08-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00:00' where placementcpahomeid = 'd1c72d18-56bc-4094-bf41-9e0133907e9d' ;
update placementcpahomes set exitdt = '2015-04-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:04:17' where placementcpahomeid = '92c7c617-468d-45d6-9ec5-31f9ab13f7a8' ;
update placementcpahomes set exitdt = '2020-10-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30' where placementcpahomeid = '97a2de58-4715-4360-9b8a-4622b9f24dbe' ;
update placementcpahomes set exitdt = '2015-07-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:02:10' where placementcpahomeid = '25657269-086c-43a2-9c76-4fb3b1762d0a' ;
update placementcpahomes set exitdt = '2014-08-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '798e66fc-ac77-4f6a-b0b2-bdaadd139551' ;
update placementcpahomes set exitdt = '2015-02-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:01:49' where placementcpahomeid = '84d9a768-11bd-4061-8132-1d45c13dffbf' ;
update placementcpahomes set exitdt = '2020-09-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '777b8285-95d5-42ef-bc8e-6ed442b59237' ;
update placementcpahomes set exitdt = '2016-02-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:46:53' where placementcpahomeid = '979879c0-7b6c-4ffe-9ce1-0d1c21660ecd' ;
update placementcpahomes set exitdt = '2016-08-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:51:23' where placementcpahomeid = 'd37ce84f-b443-41d1-bfe5-55177f4fa8db' ;
update placementcpahomes set exitdt = '2017-03-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '998f1973-76f1-4249-af16-33d272cdcc5d' ;
update placementcpahomes set exitdt = '2017-01-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:14:35' where placementcpahomeid = '11cf741e-565f-46d2-9b64-66ab09748ba7' ;
update placementcpahomes set exitdt = '2016-10-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00:27' where placementcpahomeid = '9ee43d4e-7a2c-4050-b32c-10809b6f4391' ;
update placementcpahomes set exitdt = '2018-06-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00:00' where placementcpahomeid = '7c537a28-9e01-430e-897c-2b7094f31f4e' ;
update placementcpahomes set exitdt = '2019-09-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'bf4e40a6-a5c6-4e25-9544-dc43a49b60d6' ;
update placementcpahomes set exitdt = '2019-10-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:25:47' where placementcpahomeid = 'd859d754-82ae-456e-a052-9fef10c8eda0' ;
update placementcpahomes set exitdt = '2017-12-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:43:13' where placementcpahomeid = 'c3565d94-fcee-4639-92d3-cde0f4a7b9af' ;
update placementcpahomes set exitdt = '2016-12-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:27:44' where placementcpahomeid = 'a7ab5306-d90a-4d6b-830d-c4822de90120' ;
update placementcpahomes set exitdt = '2016-02-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'ae913985-0ec8-4cfe-ac18-0787e017c31c' ;
update placementcpahomes set exitdt = '2015-07-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:21:05' where placementcpahomeid = '4ddfb88d-0a89-4585-9aad-7e34b0e0b4ef' ;
update placementcpahomes set exitdt = '2017-06-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:43:44' where placementcpahomeid = 'b5abb927-e4f6-4c98-b4ec-dec62957e477' ;
update placementcpahomes set exitdt = '2016-09-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:09:05' where placementcpahomeid = 'e8a4454a-7901-44b4-9801-8de8532e75b5' ;
update placementcpahomes set exitdt = '2019-09-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '4b7dfae5-f28a-443c-88f9-f48ec750a0ac' ;
update placementcpahomes set exitdt = '2017-05-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:52:23' where placementcpahomeid = 'e9060c1a-f265-4eb0-91f4-638ce1f2d8f6' ;
update placementcpahomes set exitdt = '2015-11-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:28:51' where placementcpahomeid = '8467c4c3-a98f-4dc8-a63b-35fa2fdd5422' ;
update placementcpahomes set exitdt = '2020-06-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30' where placementcpahomeid = '33700741-cc64-43e5-aa6b-3136c2907489' ;
update placementcpahomes set exitdt = '2015-03-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 19:00:00' where placementcpahomeid = '97ba800d-e40e-4202-af88-1c78c289dae6' ;
update placementcpahomes set exitdt = '2015-07-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'ada9b628-ed53-4bf0-bfc8-71b3641d0cfa' ;
update placementcpahomes set exitdt = '2017-04-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:23:23' where placementcpahomeid = 'ec13073c-0065-4555-b9cd-f553e4d65231' ;
update placementcpahomes set exitdt = '2021-02-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:30' where placementcpahomeid = '45c5ce2d-79e9-40cd-abd6-098017b7d012' ;
update placementcpahomes set exitdt = '2017-05-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:44:24' where placementcpahomeid = 'a7463430-5ed0-4162-8a52-f615153bc30c' ;
update placementcpahomes set exitdt = '2017-07-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:24:14' where placementcpahomeid = '0ba95225-6812-4d0b-8780-cac4f5bdd40a' ;
update placementcpahomes set exitdt = '2018-11-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:19:49' where placementcpahomeid = '221bdbd7-d247-4f70-a064-83475477fe26' ;
update placementcpahomes set exitdt = '2017-02-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:55:34' where placementcpahomeid = 'f6ab4cdb-adad-4d39-ab7b-e514c87554d3' ;
update placementcpahomes set exitdt = '2017-02-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:55:58' where placementcpahomeid = '70937330-002c-4518-88aa-dbe8f4723e0e' ;
update placementcpahomes set exitdt = '2020-07-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '009f5d90-5ccd-4f28-8743-0ad6d36e0153' ;
update placementcpahomes set exitdt = '2020-07-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = 'a3d01946-4aaf-4e1e-80c7-5679f62808e6' ;
update placementcpahomes set exitdt = '2015-10-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '1ad8f5ee-7c89-405d-acdc-7599c310f9f6' ;
update placementcpahomes set exitdt = '2016-01-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = 'c1ef60e7-f682-41f8-a407-185d8e6847c5' ;
update placementcpahomes set exitdt = '2016-08-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = 'dbfc696d-3bfc-481c-924b-585db859e735' ;
update placementcpahomes set exitdt = '2015-08-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = '5a707730-0261-40ed-bd8f-e96f069975d5' ;
update placementcpahomes set exitdt = '2017-06-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30:00' where placementcpahomeid = '95866c49-df23-4165-b348-bb870d28e02c' ;
update placementcpahomes set exitdt = '2015-09-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '6979182c-daab-4b70-a528-357f4cdbb708' ;
update placementcpahomes set exitdt = '2015-09-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '04ac921b-ed30-4146-baa5-4138351140c9' ;
update placementcpahomes set exitdt = '2016-04-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'ea24e546-08b2-4b3d-82af-0fb45f4e0e7a' ;
update placementcpahomes set exitdt = '2017-09-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:44:55' where placementcpahomeid = 'f23c29dd-2fe2-44c7-b082-e3b72624672d' ;
update placementcpahomes set exitdt = '2018-03-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:33:53' where placementcpahomeid = 'be22b639-a089-4e14-84d9-c17319b28f4a' ;
update placementcpahomes set exitdt = '2015-07-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 19:30:00' where placementcpahomeid = '39ba7d1a-5b1a-4d6a-8167-fdc73ae75ce0' ;
update placementcpahomes set exitdt = '2018-05-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:18:43' where placementcpahomeid = 'd8a0f199-a0e8-4b58-b109-9b25871dec04' ;
update placementcpahomes set exitdt = '2017-07-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00:00' where placementcpahomeid = '6569178d-4834-420c-b460-5c89034f503b' ;
update placementcpahomes set exitdt = '2017-09-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:50:04' where placementcpahomeid = 'ad320164-82df-4644-82c6-91b2b6525895' ;
update placementcpahomes set exitdt = '2021-01-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '2444369d-dfb6-4c29-bb24-d3bf9e5f8ed3' ;
update placementcpahomes set exitdt = '2020-11-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '49f6f6af-12cd-49f7-90a5-acd54297fa3e' ;
update placementcpahomes set exitdt = '2015-07-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '885c1d7d-684a-4178-a0f2-6d39a61281a6' ;
update placementcpahomes set exitdt = '2019-03-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:19:54' where placementcpahomeid = '5bc36161-3d33-44b5-a16c-bfcae68c5643' ;
update placementcpahomes set exitdt = '2021-02-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '289fc995-b670-422a-97ef-91c2175dd44a' ;
update placementcpahomes set exitdt = '2020-08-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '5ce8027c-158d-408c-a1d5-0d4b75a1e260' ;
update placementcpahomes set exitdt = '2016-06-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'a3ce1ae3-d265-4e8a-b22a-c840c8080867' ;
update placementcpahomes set exitdt = '2015-10-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00:00' where placementcpahomeid = 'e1bc31b3-6e5b-4955-b02e-1f0ba316973b' ;
update placementcpahomes set exitdt = '2016-07-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00:00' where placementcpahomeid = 'e1fd361f-bfe2-41df-9538-daa8a344ef5d' ;
update placementcpahomes set exitdt = '2020-07-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '91f47f10-4846-4654-906e-1405d35c9508' ;
update placementcpahomes set exitdt = '2016-07-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '89971883-b992-4e02-8135-79b2d00fae6c' ;
update placementcpahomes set exitdt = '2017-11-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:08:07' where placementcpahomeid = 'a16215ce-37d4-4999-a2c7-8fe75921887f' ;
update placementcpahomes set exitdt = '2017-09-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:52:23' where placementcpahomeid = '8efffc57-1e0a-4a36-b0be-29ab9b6417fe' ;
update placementcpahomes set exitdt = '2018-07-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:49:15' where placementcpahomeid = 'b1b44b1b-bad5-4efd-bd83-d8225176dc7a' ;
update placementcpahomes set exitdt = '2017-03-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:34:18' where placementcpahomeid = '6e503b0c-6cfc-41e8-82cd-1ec7c24f6bb9' ;
update placementcpahomes set exitdt = '2020-12-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'e18ff2b4-7b1b-4faa-b210-398b09a6e893' ;
update placementcpahomes set exitdt = '2020-09-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'acabdaf5-b6fd-41ca-842b-6428d2cbbe40' ;
update placementcpahomes set exitdt = '2016-01-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '94cf468c-0a20-4da5-b886-ffb0489648e0' ;
update placementcpahomes set exitdt = '2020-07-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:20' where placementcpahomeid = '8aa2f503-4971-4e29-af89-123647a9870c' ;
update placementcpahomes set exitdt = '2021-02-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:58' where placementcpahomeid = '78556423-8f66-4a6d-812a-02e494aad7c2' ;
update placementcpahomes set exitdt = '2018-09-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:10:34' where placementcpahomeid = '720cdc29-52bf-48aa-9a24-858a6dec3627' ;
update placementcpahomes set exitdt = '2018-06-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '616928ce-d8dc-4cf7-bee6-c229a0ee09ba' ;
update placementcpahomes set exitdt = '2018-06-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'd820011d-e348-4091-8dec-2d899a54ee35' ;
update placementcpahomes set exitdt = '2017-11-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:02:45' where placementcpahomeid = '75fbf798-b0fa-4a9c-a065-fd62958fef55' ;
update placementcpahomes set exitdt = '2017-05-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:51:34' where placementcpahomeid = 'd8060595-5533-42c7-a00f-60dee739b947' ;
update placementcpahomes set exitdt = '2020-07-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '92a93195-00bc-4e14-99fd-286a8a436696' ;
update placementcpahomes set exitdt = '2019-08-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:33:48' where placementcpahomeid = '95ba3ffb-3a2e-4e20-b10b-0bde451a08e1' ;
update placementcpahomes set exitdt = '2018-08-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '48af14a5-f202-4705-a8f8-8561b94ca852' ;
update placementcpahomes set exitdt = '2020-10-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '697253c6-2e9e-4ebb-aa73-f61ff096ef99' ;
update placementcpahomes set exitdt = '2017-05-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:05:14' where placementcpahomeid = '2ab6e931-30b5-47b6-b18d-a5cb0c22f00d' ;
update placementcpahomes set exitdt = '2018-09-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:52:52' where placementcpahomeid = '1b1699e5-2dea-4568-a81d-73dc490c2fa9' ;
update placementcpahomes set exitdt = '2016-09-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:08:06' where placementcpahomeid = '70a5eef6-b004-47d1-b055-f81f76d09277' ;
update placementcpahomes set exitdt = '2021-04-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '463d6043-62e8-4b85-ae1b-2dc304179fa7' ;
update placementcpahomes set exitdt = '2021-01-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = 'ce04c098-90ec-400b-966c-cabe3d29d86c' ;
update placementcpahomes set exitdt = '2017-02-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:57:50' where placementcpahomeid = '1f167836-1d8d-4922-8ae7-86121e31eb2e' ;
update placementcpahomes set exitdt = '2018-01-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:42:44' where placementcpahomeid = '2c4a0cfc-9d00-4b59-81c3-5d78c5c9704c' ;
update placementcpahomes set exitdt = '2016-05-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:51:25' where placementcpahomeid = '81f3acab-bae5-4b74-a36e-d3f7e50961ce' ;
update placementcpahomes set exitdt = '2016-05-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:51:44' where placementcpahomeid = '7388634f-51a7-4221-99b8-644e67a47ec1' ;
update placementcpahomes set exitdt = '2020-11-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'f03aee12-ef4b-4418-a255-d81564384642' ;
update placementcpahomes set exitdt = '2016-11-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:49:04' where placementcpahomeid = '0173fbc0-fde4-47d3-ae83-20d82a067cc4' ;
update placementcpahomes set exitdt = '2019-11-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:09:58' where placementcpahomeid = '39ca3014-257a-41d2-bef8-5faa4b04cbe4' ;
update placementcpahomes set exitdt = '2021-01-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '2ddbfbb3-85ef-419e-a1d8-641fcdc1ca03' ;
update placementcpahomes set exitdt = '2020-08-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'e74a6a02-7a98-4bd9-b12f-c81d4ab5c94e' ;
update placementcpahomes set exitdt = '2018-01-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:57:04' where placementcpahomeid = '77579058-1f2e-4923-b607-50b2e1068856' ;
update placementcpahomes set exitdt = '2016-06-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '88af2324-7763-4317-befd-2aa19a605772' ;
update placementcpahomes set exitdt = '2016-09-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:08:42' where placementcpahomeid = '90aaa2bb-4709-4089-8918-2c842bdb411a' ;
update placementcpahomes set exitdt = '2020-08-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '6f34a3bc-4f40-4f2b-8ad0-0fdeb1dec9be' ;
update placementcpahomes set exitdt = '2020-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 21:00' where placementcpahomeid = '7f7f96f2-1e28-4c21-8203-624d2d0a5686' ;
update placementcpahomes set exitdt = '2018-10-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:14:23' where placementcpahomeid = 'f8742f36-07f4-4c31-9473-e923d15b2532' ;
update placementcpahomes set exitdt = '2018-10-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:14:23' where placementcpahomeid = '51500c30-024f-4e29-a9ab-1e3801b98d16' ;
update placementcpahomes set exitdt = '2018-12-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '61abb01d-ada7-47d3-a89a-09f6336681c2' ;
update placementcpahomes set exitdt = '2020-09-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30' where placementcpahomeid = 'c3a9bacc-b12a-4479-831c-c7a59e040e3a' ;
update placementcpahomes set exitdt = '2017-11-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:13:32' where placementcpahomeid = 'c18dd581-845a-4992-8d2c-bcca5894753c' ;
update placementcpahomes set exitdt = '2017-03-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'a16dfc66-7926-4169-a2ab-76b6dbe6f640' ;
update placementcpahomes set exitdt = '2017-05-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:04:26' where placementcpahomeid = '1e1fc19a-a67b-4cc7-9034-43ac7be72aaa' ;
update placementcpahomes set exitdt = '2017-05-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:04:44' where placementcpahomeid = '29a184e0-8776-4eee-872e-e2777f2986af' ;
update placementcpahomes set exitdt = '2016-09-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00:00' where placementcpahomeid = 'd3d53d4a-39ae-48ea-a35d-0a60e64ff1e7' ;
update placementcpahomes set exitdt = '2017-11-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:29:59' where placementcpahomeid = '333226c9-d6af-4cf9-b257-109bca0b8306' ;
update placementcpahomes set exitdt = '2018-10-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:10:25' where placementcpahomeid = '1e1c4878-6701-439b-ba43-5043f19db2f8' ;
update placementcpahomes set exitdt = '2017-05-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:51:59' where placementcpahomeid = '99f8e7a1-c37a-474c-88a8-44f2ec791d81' ;
update placementcpahomes set exitdt = '2020-06-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = 'd6b4dbeb-052d-412c-a3f8-2ee74420c4d0' ;
update placementcpahomes set exitdt = '2018-09-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 23:48:26' where placementcpahomeid = '08f799b5-464d-4275-9ea8-9930fb6cbe76' ;
update placementcpahomes set exitdt = '2018-11-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:04:26' where placementcpahomeid = 'cd4adad8-5b6e-4325-9825-b12c3b2fa902' ;
update placementcpahomes set exitdt = '2020-03-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '3f7c7a7a-401d-482f-913e-468519fb8686' ;
update placementcpahomes set exitdt = '2020-10-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '9eb0c684-73bd-4495-aee8-e8c9b96df045' ;
update placementcpahomes set exitdt = '2020-07-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:25' where placementcpahomeid = '14ebdb90-8bb8-48a6-82f0-429d4a6f2ddf' ;
update placementcpahomes set exitdt = '2021-03-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '699127f8-e2ed-4394-8449-906f6d03a766' ;
update placementcpahomes set exitdt = '2019-04-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:01:09' where placementcpahomeid = '293e4475-6bb9-4bc5-94e9-66fc3b599f0a' ;
update placementcpahomes set exitdt = '2017-03-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:25:05' where placementcpahomeid = '110c465c-a53c-4d3a-b8ad-f80da72a235a' ;
update placementcpahomes set exitdt = '2020-08-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '5e3113ec-c698-4864-8daa-c6ca35fa7d20' ;
update placementcpahomes set exitdt = '2020-08-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '932981ed-a854-496f-825b-2481e553d915' ;
update placementcpahomes set exitdt = '2020-09-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '3f8b70f3-c844-49cb-96f0-bedf32e4f907' ;
update placementcpahomes set exitdt = '2020-09-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '1da55a54-b8b6-4142-a7a8-3b629b7e8e75' ;
update placementcpahomes set exitdt = '2020-09-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:30' where placementcpahomeid = '04197798-29eb-4562-8304-6de505fba2ab' ;
update placementcpahomes set exitdt = '2020-08-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '62810a47-bca4-4bc2-a8a3-53f9a4c7150b' ;
update placementcpahomes set exitdt = '2017-03-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00:00' where placementcpahomeid = '2e1dbb3c-5bad-4e90-89e4-d0201ce7377f' ;
update placementcpahomes set exitdt = '2020-06-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:30' where placementcpahomeid = '18766147-9f1b-4194-9efe-d3775e50690e' ;
update placementcpahomes set exitdt = '2019-11-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:21:10' where placementcpahomeid = 'e7b81575-6626-4329-9dc7-b5e25ba7250f' ;
update placementcpahomes set exitdt = '2018-11-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:25:23' where placementcpahomeid = 'a2329f35-3c44-4696-900a-f40389d8b676' ;
update placementcpahomes set exitdt = '2018-11-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:25:09' where placementcpahomeid = '4627355a-a880-4c83-86f8-724a26394d73' ;
update placementcpahomes set exitdt = '2017-05-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 23:00:00' where placementcpahomeid = '2bc35746-24fa-4294-8f60-3b8e58cb4699' ;
update placementcpahomes set exitdt = '2020-07-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '5be88cff-df26-4d79-aa44-ac0fbca83d74' ;
update placementcpahomes set exitdt = '2020-12-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '930a5716-7c1c-4833-82b0-c84a4ac6318e' ;
update placementcpahomes set exitdt = '2020-12-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '20dfed62-5f7e-472c-acde-571437a10121' ;
update placementcpahomes set exitdt = '2020-10-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '6e2b0db2-c5f1-45a2-82ef-f528023c5cd2' ;
update placementcpahomes set exitdt = '2021-03-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '2d88daef-8572-476e-a432-327f233eb241' ;
update placementcpahomes set exitdt = '2017-05-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:01:00' where placementcpahomeid = '21227c36-a2ec-4dc2-b340-555bd75ccdd5' ;
update placementcpahomes set exitdt = '2017-04-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00:00' where placementcpahomeid = 'e89a7f76-c1a4-469c-ad48-7c5323c88a53' ;
update placementcpahomes set exitdt = '2018-11-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:13:19' where placementcpahomeid = '25bbfd98-e5f8-48d7-964c-9812676556f8' ;
update placementcpahomes set exitdt = '2021-01-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '9d896f29-dcd8-4873-87de-0add8132cbba' ;
update placementcpahomes set exitdt = '2018-01-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:10:18' where placementcpahomeid = 'c65b3704-efd6-4147-b173-f4a384b5bcdb' ;
update placementcpahomes set exitdt = '2020-09-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = '530e6362-9209-4ba1-a985-e5ad591a5f2b' ;
update placementcpahomes set exitdt = '2017-06-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'e267bcfe-fe2a-4c1c-b5da-320bc15232fc' ;
update placementcpahomes set exitdt = '2020-08-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '6d1fc1af-98ed-41c0-ac5c-b383b97ef412' ;
update placementcpahomes set exitdt = '2017-04-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:01:15' where placementcpahomeid = '907cef3e-93a8-4807-8a72-4625628dac3c' ;
update placementcpahomes set exitdt = '2017-04-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:54:03' where placementcpahomeid = '40b81aa5-1610-44a4-bfba-f83617d7d229' ;
update placementcpahomes set exitdt = '2017-04-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:53:27' where placementcpahomeid = 'c42d2c14-aa94-40a6-9dac-b7e3849a6b01' ;
update placementcpahomes set exitdt = '2017-08-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00:00' where placementcpahomeid = 'c602f655-02bf-4789-a9cd-4c298c93aa12' ;
update placementcpahomes set exitdt = '2017-04-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:52:27' where placementcpahomeid = '4fb74d8c-6a37-457f-a63a-dfa786b250e4' ;
update placementcpahomes set exitdt = '2017-04-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30:00' where placementcpahomeid = 'c0a923ab-5032-4f9c-a458-98f19b447804' ;
update placementcpahomes set exitdt = '2017-04-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30:00' where placementcpahomeid = '7598f593-93ef-46da-bac9-1e08fd4394bf' ;
update placementcpahomes set exitdt = '2020-03-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '645a699e-cc50-48e4-8a77-fa7eb8acf914' ;
update placementcpahomes set exitdt = '2020-08-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '3c75ede4-d3eb-4996-bc81-793482061f42' ;
update placementcpahomes set exitdt = '2020-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '9fdfd224-67d6-4baa-8fb3-1a71be140478' ;
update placementcpahomes set exitdt = '2018-10-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:26:24' where placementcpahomeid = 'b8a428a1-9af9-4dc1-8352-7521687f071d' ;
update placementcpahomes set exitdt = '2020-06-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:35:02' where placementcpahomeid = 'd900ab99-965d-4326-bc44-61579e29b506' ;
update placementcpahomes set exitdt = '2020-09-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'fa35cb52-4a4b-4506-969a-b1a9e3f1533a' ;
update placementcpahomes set exitdt = '2020-12-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:20' where placementcpahomeid = 'eee5cc86-5a7d-4384-8bbc-8b9138bff047' ;
update placementcpahomes set exitdt = '2020-08-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'd802d93c-1d09-44cd-82ce-9f528e1cf271' ;
update placementcpahomes set exitdt = '2018-01-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:57:33' where placementcpahomeid = 'd618a0f0-a127-4649-b499-3d0da21ce1f9' ;
update placementcpahomes set exitdt = '2017-07-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = '844f4412-dfae-4ab5-a224-9ce860455c96' ;
update placementcpahomes set exitdt = '2019-01-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '04b1b012-5dfe-4a43-8bab-884439175863' ;
update placementcpahomes set exitdt = '2020-04-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '83583172-99ab-4057-a801-6a0c3d97432f' ;
update placementcpahomes set exitdt = '2018-01-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'fa31a2c4-cc45-4c30-be8c-6937e9f1bf92' ;
update placementcpahomes set exitdt = '2020-06-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '5c258801-c995-4199-8ff5-610c2ceeddc0' ;
update placementcpahomes set exitdt = '2020-08-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'c96e8403-d395-45aa-bfa0-2b5e1e0ed873' ;
update placementcpahomes set exitdt = '2017-12-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30:00' where placementcpahomeid = 'ede81aec-3eb4-41ec-b988-bf5e5cffdb35' ;
update placementcpahomes set exitdt = '2018-08-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00:00' where placementcpahomeid = '1389207e-bb50-4a7c-8e0b-0a8a0424329b' ;
update placementcpahomes set exitdt = '2020-08-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '263ac863-5475-4786-8ae3-e9abfdbe9793' ;
update placementcpahomes set exitdt = '2020-08-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '28ce49b7-6e83-42e0-8682-16473b3f2502' ;
update placementcpahomes set exitdt = '2020-08-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '330431a5-db20-4e59-8cee-d87eadfcceaf' ;
update placementcpahomes set exitdt = '2020-09-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '4eda5d99-73cc-4a48-8c68-7ee6f368f305' ;
update placementcpahomes set exitdt = '2020-05-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30' where placementcpahomeid = '394dbcb5-83af-4f38-842c-8e57e10a2890' ;
update placementcpahomes set exitdt = '2018-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '2d0c868b-911d-47ec-bf72-07688d3eab9c' ;
update placementcpahomes set exitdt = '2020-06-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '23574ea9-6778-4794-9158-c7079ba483e3' ;
update placementcpahomes set exitdt = '2020-11-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '80812f86-5130-40cb-acd7-f4ea382450ae' ;
update placementcpahomes set exitdt = '2020-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '82822064-6104-48d8-9547-67dfe89d1bc3' ;
update placementcpahomes set exitdt = '2020-06-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'f46eb208-e6d1-4d8b-bc06-6b44372ee4b1' ;
update placementcpahomes set exitdt = '2021-01-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:45' where placementcpahomeid = '7f173c25-2db0-4ea5-9971-b1d43eca5378' ;
update placementcpahomes set exitdt = '2018-01-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = 'f7e2667e-03a5-4cd2-92cf-87fd19a77862' ;
update placementcpahomes set exitdt = '2018-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:10:49' where placementcpahomeid = '7dafd0a1-da0f-472e-bf31-5c3e947394f1' ;
update placementcpahomes set exitdt = '2020-07-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'bd8bf8ec-1980-4f91-ae75-23327305c9c5' ;
update placementcpahomes set exitdt = '2021-01-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '8c7c1ff8-af9e-45a1-b327-49c40b1a7a84' ;
update placementcpahomes set exitdt = '2020-10-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = 'fcf2c0c6-03b9-463f-8ad0-58849eac2c78' ;
update placementcpahomes set exitdt = '2019-04-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 22:30:00' where placementcpahomeid = '3666482f-a24f-4035-9e33-aa9ec9d56392' ;
update placementcpahomes set exitdt = '2019-01-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:20:05' where placementcpahomeid = 'f0527f11-cd05-4cf0-bb84-569b1a824b30' ;
update placementcpahomes set exitdt = '2019-08-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30:00' where placementcpahomeid = 'f871aeac-0275-419c-b4ff-c37c5ae25015' ;
update placementcpahomes set exitdt = '2020-11-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:10' where placementcpahomeid = 'ddfa180e-baf9-461c-af24-63651e5140b9' ;
update placementcpahomes set exitdt = '2018-06-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = '929d1274-0021-4e54-b5d9-3722c99dae82' ;
update placementcpahomes set exitdt = '2020-12-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '7a1adb9e-5e89-4e68-87f8-87c5462fe824' ;
update placementcpahomes set exitdt = '2020-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = '32d97b18-5835-43e4-b13c-853474d43fe8' ;
update placementcpahomes set exitdt = '2020-08-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '71a630a9-b7bc-4156-b515-fa60795ede5f' ;
update placementcpahomes set exitdt = '2020-09-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '81c9eba9-6b21-4a68-b0b1-d87cea705a52' ;
update placementcpahomes set exitdt = '2020-09-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = 'd837145a-5a3f-45ce-a802-efc7f162fa0b' ;
update placementcpahomes set exitdt = '2020-12-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'ab6db10d-6d28-43c4-affb-692e5ba247f5' ;
update placementcpahomes set exitdt = '2018-12-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'b4fc2e4a-e2c2-4ce8-8f27-6e5cf283c78c' ;
update placementcpahomes set exitdt = '2020-11-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = '2a33b3aa-2021-4d68-ad8f-9630fdc99803' ;
update placementcpahomes set exitdt = '2018-11-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:50:44' where placementcpahomeid = '6e490605-6280-44f9-9c45-7ef25885da7f' ;
update placementcpahomes set exitdt = '2021-02-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'c53c4ee8-1ecf-432e-ae10-ce19b54ee3d7' ;
update placementcpahomes set exitdt = '2021-01-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:03' where placementcpahomeid = '0fb56282-5907-4959-867b-17ddda49062f' ;
update placementcpahomes set exitdt = '2018-09-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 23:49:45' where placementcpahomeid = '45c3de17-ffc9-44c3-8443-d8d9b052fc97' ;
update placementcpahomes set exitdt = '2020-01-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'a11b1d44-b1ea-4aa1-9350-d59a445614b1' ;
update placementcpahomes set exitdt = '2021-03-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 22:00' where placementcpahomeid = '272de766-8e96-4b11-b92f-ce4fdd643e80' ;
update placementcpahomes set exitdt = '2020-07-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '4dc9da3c-f2ce-4c12-b335-2a689a0b0e66' ;
update placementcpahomes set exitdt = '2021-01-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '873e485f-cb39-4d9b-8fb8-9091f99750fa' ;
update placementcpahomes set exitdt = '2020-11-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30' where placementcpahomeid = 'd8e849ef-0a2b-4c96-b9a7-96dadb1b92ce' ;
update placementcpahomes set exitdt = '2020-08-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '17b65616-e1c1-4072-ac42-1d591ed8c966' ;
update placementcpahomes set exitdt = '2019-04-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'b1639a94-e880-4ed3-a70e-0ee343d66a60' ;
update placementcpahomes set exitdt = '2019-04-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = '7fb310c7-5ec6-4d82-83db-3419713f1853' ;
update placementcpahomes set exitdt = '2020-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:19' where placementcpahomeid = '5749bf6e-fe28-4e3a-800b-f409274cf472' ;
update placementcpahomes set exitdt = '2019-07-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:46:54' where placementcpahomeid = '226c520c-277c-4fbe-b10e-cde8521379fe' ;
update placementcpahomes set exitdt = '2020-10-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '0e3aa493-122f-44f5-84a5-ac5cf13fec06' ;
update placementcpahomes set exitdt = '2020-05-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '0f1edc95-0ae0-4298-a7c5-af8f3bfd9ce3' ;
update placementcpahomes set exitdt = '2020-07-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:54' where placementcpahomeid = '4731fefa-f554-4447-9c8e-3467228da162' ;
update placementcpahomes set exitdt = '2020-07-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:54' where placementcpahomeid = '24d61a2a-1642-4790-9b9e-c600083a9e92' ;
update placementcpahomes set exitdt = '2020-06-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = 'ddf7a34f-e903-4d3c-9e91-1003f22b2f24' ;
update placementcpahomes set exitdt = '2020-06-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = 'be8f1975-4d49-4371-9fc0-74b8716b5416' ;
update placementcpahomes set exitdt = '2020-09-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '59a2a305-501f-479e-9b2a-ca35d3008072' ;
update placementcpahomes set exitdt = '2020-09-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '62727f4b-aa27-4f7c-ab13-831f4b2cd0ab' ;
update placementcpahomes set exitdt = '2021-03-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '25599ca2-e733-42c5-a901-c7af8f26f535' ;
update placementcpahomes set exitdt = '2021-03-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '7aedc8ad-013f-4e6a-8897-f9e41b62bcb6' ;
update placementcpahomes set exitdt = '2020-12-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '5e6107ca-509d-4650-8dda-39f46a666b54' ;
update placementcpahomes set exitdt = '2020-12-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '0bbaecfb-55aa-4622-88e9-f6fd014534fa' ;
update placementcpahomes set exitdt = '2020-11-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:01' where placementcpahomeid = 'af975d85-bc99-4730-951f-b0d397b1329b' ;
update placementcpahomes set exitdt = '2020-09-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00' where placementcpahomeid = 'adea374f-3ee2-45be-8cf7-86ade277c9ad' ;
update placementcpahomes set exitdt = '2020-12-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '9feb42c9-8e39-4ecb-a316-5d6c7519626c' ;
update placementcpahomes set exitdt = '2020-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '3f8cd9d0-10ec-4073-b139-f70f2ece1486' ;
update placementcpahomes set exitdt = '2020-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = 'bb4b0caf-9f9b-4092-97be-2c572d1c79c3' ;
update placementcpahomes set exitdt = '2019-06-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '54f30801-c1eb-4215-86e3-a580eb4fb22d' ;
update placementcpahomes set exitdt = '2019-08-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00:00' where placementcpahomeid = 'b4c3c80a-da63-4a6d-9c8d-d4bc3c99d24c' ;
update placementcpahomes set exitdt = '2020-07-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '95b50602-f98d-4e04-8160-b2b27abbb619' ;
update placementcpahomes set exitdt = '2020-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:18' where placementcpahomeid = 'c7a143de-f97c-4e38-bcfc-ac5ff647ed01' ;
update placementcpahomes set exitdt = '2020-11-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = '2a1ac8c1-0c6c-4fd8-91e3-40510e167214' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:09' where placementcpahomeid = '82b7e6f1-a9bc-4525-bc09-f86119939cc4' ;
update placementcpahomes set exitdt = '2018-11-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:50:01' where placementcpahomeid = 'ac14d614-0f61-40a1-a8f6-313d9a2d8dfa' ;
update placementcpahomes set exitdt = '2019-11-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = 'b3df732b-8cbe-4a3a-8d43-efc5fffe4903' ;
update placementcpahomes set exitdt = '2019-11-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = 'c09b4f80-0ac0-424f-a79b-c7b81047ffee' ;
update placementcpahomes set exitdt = '2021-03-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '0ce49994-d325-4bac-ab70-1cb4a4bfbb69' ;
update placementcpahomes set exitdt = '2021-03-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'd509521c-69d9-4ae5-8502-15f46bc83dc3' ;
update placementcpahomes set exitdt = '2020-11-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00' where placementcpahomeid = '78ba5e00-8b10-4412-a375-2be15841ca5b' ;
update placementcpahomes set exitdt = '2020-08-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'd01ca577-f22a-4e1a-972f-4ad1776c9305' ;
update placementcpahomes set exitdt = '2020-08-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'b53e6e9f-3e4e-4287-85f1-af0f98a07c1e' ;
update placementcpahomes set exitdt = '2020-08-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = 'a872f09f-8e47-49ba-9eac-0ca22ed46acf' ;
update placementcpahomes set exitdt = '2020-10-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 02:00' where placementcpahomeid = '4db92349-2e93-4ec3-8129-3e4a3afec419' ;
update placementcpahomes set exitdt = '2020-12-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = 'a3ca6c5b-3a53-4965-a20b-deb84fa9f551' ;
update placementcpahomes set exitdt = '2020-09-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = 'da870dc1-a934-45cd-845f-9bfa6c72f27c' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:43' where placementcpahomeid = '1265d557-4c13-40d6-ac78-24db899c41cb' ;
update placementcpahomes set exitdt = '2019-02-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:23:11' where placementcpahomeid = '8f7fa82f-7c02-49db-8540-985f4a4de731' ;
update placementcpahomes set exitdt = '2020-12-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '0bc3153c-6085-4764-9192-3038661d26bf' ;
update placementcpahomes set exitdt = '2020-09-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '3e98286a-ab9c-47cf-a992-1fde91658580' ;
update placementcpahomes set exitdt = '2020-09-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '644c5720-38bf-4b1b-8f7a-18d4bb0b4453' ;
update placementcpahomes set exitdt = '2020-12-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:30' where placementcpahomeid = 'b6478664-f85c-4902-a087-0f7564e8363d' ;
update placementcpahomes set exitdt = '2020-12-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '43d84813-605a-4ec0-bd4a-ecb38cebcdbc' ;
update placementcpahomes set exitdt = '2020-02-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '1614c7aa-30dc-4e35-bcbf-87be033d132c' ;
update placementcpahomes set exitdt = '2021-01-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:06' where placementcpahomeid = '40d428e3-a991-4f89-8b55-fdda3deae576' ;
update placementcpahomes set exitdt = '2020-11-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30' where placementcpahomeid = 'b2836146-c572-4496-abbc-a8cdeff9e92a' ;
update placementcpahomes set exitdt = '2021-01-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = 'f05e426e-485a-4021-8b88-b3827e4d5fab' ;
update placementcpahomes set exitdt = '2020-09-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '7dd35a15-8c59-4358-8bc6-a3b5963bc01a' ;
update placementcpahomes set exitdt = '2020-02-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '6ceb24b3-9272-45a6-b7df-fa6f77637a96' ;
update placementcpahomes set exitdt = '2020-06-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '1ebe0ada-72fd-499e-bb1b-b169f71cc650' ;
update placementcpahomes set exitdt = '2020-03-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '0c4b08da-2bac-45f4-a70a-0ef870070f14' ;
update placementcpahomes set exitdt = '2020-06-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '56181d59-623c-4fd6-8197-028c3dd82f04' ;
update placementcpahomes set exitdt = '2020-06-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = 'c8340aa2-f1b3-4520-9f78-f73dd7d9fb71' ;
update placementcpahomes set exitdt = '2020-06-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '246e062d-a14c-4c9b-ab1f-ebf9e50b3372' ;
update placementcpahomes set exitdt = '2020-04-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '72ad0e51-89db-4422-b1cd-f0e730659f23' ;
update placementcpahomes set exitdt = '2020-01-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00' where placementcpahomeid = '3c8daa94-43f7-400d-9380-abff818d0a49' ;
update placementcpahomes set exitdt = '2020-09-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '7cd13ad2-bb7c-4611-90c6-94793b2511f9' ;
update placementcpahomes set exitdt = '2020-08-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 23:00' where placementcpahomeid = 'e2d9d381-c48d-496d-bd7e-1ab43d47047c' ;
update placementcpahomes set exitdt = '2020-07-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:30' where placementcpahomeid = 'cf3439c5-266b-406e-b41a-34f0dc98765c' ;
update placementcpahomes set exitdt = '2020-12-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'e262e722-7750-4890-8e7c-f543b86e725b' ;
update placementcpahomes set exitdt = '2020-07-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:30' where placementcpahomeid = 'c06db832-b628-4f42-9384-738085d110aa' ;
update placementcpahomes set exitdt = '2020-12-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30' where placementcpahomeid = 'b752cef9-1492-4e23-a0c1-1de4749a2a4e' ;
update placementcpahomes set exitdt = '2020-10-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'b2dc4ca7-66c5-46c0-976b-ed31db7e8c6c' ;
update placementcpahomes set exitdt = '2020-01-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = 'e04d4efc-7f00-41e3-ab2a-7c8ce8252c2f' ;
update placementcpahomes set exitdt = '2020-09-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00' where placementcpahomeid = 'bbf5ce17-dcae-4e78-802a-586d87ff402b' ;
update placementcpahomes set exitdt = '2020-07-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '2b13b033-379d-42ec-b8fb-a88849640a5a' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = 'e23065a8-5c2b-40bf-a714-36f5deb0aa6f' ;
update placementcpahomes set exitdt = '2021-01-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '79212c2c-33c7-4361-92fa-405ac6861013' ;
update placementcpahomes set exitdt = '2020-12-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '785431a6-25dc-437c-b26b-5524212b3c01' ;
update placementcpahomes set exitdt = '2021-03-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:30' where placementcpahomeid = 'bb5e8c79-5d3d-4d5a-90de-ecd8b5cf65fa' ;
update placementcpahomes set exitdt = '2019-11-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '391143a1-041d-4637-b96d-bfbed11cfc5b' ;
update placementcpahomes set exitdt = '2020-09-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00' where placementcpahomeid = 'c7a2805e-d994-419a-a6f5-9d65051713c7' ;
update placementcpahomes set exitdt = '2020-10-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:30' where placementcpahomeid = '923002bc-151f-4d25-8a09-47bf8755e298' ;
update placementcpahomes set exitdt = '2021-02-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'b961cce3-9d2c-43c3-9e00-9ca7a6168935' ;
update placementcpahomes set exitdt = '2021-02-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '8e965220-b811-4c40-944b-78af9e08f961' ;
update placementcpahomes set exitdt = '2021-02-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'fdce6c8f-be4a-49ca-9edd-f45eda6e2f2b' ;
update placementcpahomes set exitdt = '2021-01-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '4b694b81-170a-4149-b59b-6c615680c792' ;
update placementcpahomes set exitdt = '2020-04-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:15' where placementcpahomeid = 'db94f69e-45cd-4547-9894-0fbca54a53aa' ;
update placementcpahomes set exitdt = '2021-03-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:30' where placementcpahomeid = '82539919-4562-4db2-9c12-387ea3400ff8' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:30' where placementcpahomeid = '6ad6f8c8-4d0c-4430-98a6-d3db71bc187a' ;
update placementcpahomes set exitdt = '2020-07-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'b8b8b741-b8da-491b-9c7f-3f7c2733d519' ;
update placementcpahomes set exitdt = '2021-04-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'cc6d01cc-afcd-4edd-b1b3-5083a0c6bc42' ;
update placementcpahomes set exitdt = '2021-04-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '261166e9-75c7-4044-8dbe-db7e2782f96e' ;
update placementcpahomes set exitdt = '2021-01-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:56' where placementcpahomeid = 'f5cf5c58-e3ed-468c-bc38-0e8fc09b4bc7' ;
update placementcpahomes set exitdt = '2021-01-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:56' where placementcpahomeid = '19afe5f8-0005-4efe-9427-0d2488679ae0' ;
update placementcpahomes set exitdt = '2021-01-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:56' where placementcpahomeid = '50dbee44-acfe-4882-9833-c2cae9f280eb' ;
update placementcpahomes set exitdt = '2020-11-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 21:00' where placementcpahomeid = 'd6351bfd-e328-4cc3-90ba-51ea0c66a817' ;
update placementcpahomes set exitdt = '2020-11-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = '9adc1d6c-4405-4a60-95c5-c4ae187bfcc5' ;
update placementcpahomes set exitdt = '2020-08-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '54c0cf7d-f5ce-442a-a432-168c58dc59fc' ;
update placementcpahomes set exitdt = '2020-10-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '216e5603-4865-43d3-875e-101138b65a28' ;
update placementcpahomes set exitdt = '2020-10-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '25b7b1c6-ba30-4d03-b92e-dd6f804f9f52' ;
update placementcpahomes set exitdt = '2021-02-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:10' where placementcpahomeid = 'b6bcb7b8-e297-4552-a0ca-fdb4cbeef655' ;
update placementcpahomes set exitdt = '2020-10-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '25d49f46-ff87-4c41-ab27-18dfa3e2e72b' ;
update placementcpahomes set exitdt = '2020-12-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '61046a8d-dc91-43f2-a27b-611873835cd9' ;
update placementcpahomes set exitdt = '2020-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '124e36a1-62d4-4502-a919-11ed9e9ab729' ;
update placementcpahomes set exitdt = '2020-12-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 22:47' where placementcpahomeid = '30365fb9-7bd9-4944-bd59-b7fa95687264' ;
update placementcpahomes set exitdt = '2021-03-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '9860a6a8-527e-4dc5-9a2b-2251418efb65' ;
update placementcpahomes set exitdt = '2021-04-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30' where placementcpahomeid = '61061375-971e-464a-90e0-439ee9161ef0' ;
update placementcpahomes set exitdt = '2020-10-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'e0565bd1-769a-4cc0-afbd-cfb7cea39143' ;
update placementcpahomes set exitdt = '2020-12-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:30' where placementcpahomeid = 'ea902be9-6d81-42ab-b412-48bf60546f30' ;
update placementcpahomes set exitdt = '2020-08-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:40' where placementcpahomeid = '74bbec8a-b89a-4843-b512-c30f07a55bb3' ;
update placementcpahomes set exitdt = '2019-05-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00:00' where placementcpahomeid = 'd8666517-42cc-4b04-95a5-3e9482610dc8' ;
update placementcpahomes set exitdt = '2021-02-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:40' where placementcpahomeid = 'b647dc30-0fed-49e5-948c-abe5f53375a5' ;
update placementcpahomes set exitdt = '2021-02-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '074faa2e-8e68-4bca-bdaa-978e44f86734' ;
update placementcpahomes set exitdt = '2020-10-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = 'cd8297a6-078b-43b8-bd74-0d1df854fa45' ;
update placementcpahomes set exitdt = '2020-08-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30' where placementcpahomeid = 'ef2d341c-3ad7-4c42-9cc7-09bd9833efe1' ;
update placementcpahomes set exitdt = '2020-12-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'a705d828-32ba-4875-8aba-1f81a7bcc2fe' ;
update placementcpahomes set exitdt = '2020-12-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '654f0860-629d-45dc-8121-3de140e6e597' ;
update placementcpahomes set exitdt = '2020-10-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '990e9938-593e-43c1-9423-6fbef31716f7' ;
update placementcpahomes set exitdt = '2020-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30' where placementcpahomeid = '9db1d994-03d0-46a1-83e9-cb293fae89e1' ;
update placementcpahomes set exitdt = '2020-09-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'a716f65b-bef6-409f-be7a-42c23d0d7557' ;
update placementcpahomes set exitdt = '2020-08-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '830fc7bc-a2b2-4177-94d5-0eb15cdb5421' ;
update placementcpahomes set exitdt = '2020-08-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '05971562-6776-443c-a9a3-9bc0294f467b' ;
update placementcpahomes set exitdt = '2020-05-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = 'ccace507-60eb-448c-8317-3474acf8b531' ;
update placementcpahomes set exitdt = '2020-10-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '0dc8ade1-30b2-4fbc-8d85-e3164c22cfdd' ;
update placementcpahomes set exitdt = '2019-07-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'c7fc5818-8218-4b5c-9217-a73326eff578' ;
update placementcpahomes set exitdt = '2021-01-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '80185e86-9054-43c3-934f-9561e031159d' ;
update placementcpahomes set exitdt = '2021-01-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '6139b094-ab06-4fba-a187-3b0da054a894' ;
update placementcpahomes set exitdt = '2021-01-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '465076b4-f0bf-4c47-9a02-419d0a67f741' ;
update placementcpahomes set exitdt = '2020-09-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'fd45b34c-0728-4085-ae74-ec271012dda1' ;
update placementcpahomes set exitdt = '2021-04-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = 'de18a19f-46fe-459e-8131-43856f9f033f' ;
update placementcpahomes set exitdt = '2021-03-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = 'b9b1064a-5dee-4967-99b8-e2dab87a3066' ;
update placementcpahomes set exitdt = '2021-03-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = 'aaa8e68f-7d1e-4778-a944-ef32c2bf08f1' ;
update placementcpahomes set exitdt = '2021-01-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'c220bf43-9052-4a5d-ba71-66100b96352a' ;
update placementcpahomes set exitdt = '2021-03-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '03f2d570-8ea0-4a62-9120-b66c136b9bbf' ;
update placementcpahomes set exitdt = '2021-02-03 15:15:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00' where placementcpahomeid = '89730d7e-9649-41f5-ba0a-2e984f98bd24' ;
update placementcpahomes set exitdt = '2021-02-03 15:15:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 00:00' where placementcpahomeid = '5ad3b9d7-65a7-4d5d-b927-924226476c9c' ;
update placementcpahomes set exitdt = '2020-08-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '06ba856c-3ddd-4631-87bc-9d57c0e9f632' ;
update placementcpahomes set exitdt = '2020-06-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '2884df8e-1c13-49ee-a417-3572354b6f69' ;
update placementcpahomes set exitdt = '2020-08-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00' where placementcpahomeid = '7cd92810-6ef9-4717-ad2b-0649bff8dc58' ;
update placementcpahomes set exitdt = '2020-02-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = 'a1ef359a-4296-484b-a856-546ed7ba00fb' ;
update placementcpahomes set exitdt = '2020-07-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:13' where placementcpahomeid = '2f3bfc86-1eb7-450f-ab7c-3966c18540a8' ;
update placementcpahomes set exitdt = '2020-03-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:09:42' where placementcpahomeid = '677bead1-cbe9-409a-9b00-b8ec0c605db3' ;
update placementcpahomes set exitdt = '2020-04-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'e310ae31-8623-488a-9cb9-5ce4f68c65e8' ;
update placementcpahomes set exitdt = '2020-10-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:45' where placementcpahomeid = '2d4fee94-a6d7-49c2-a134-5c30bc33b193' ;
update placementcpahomes set exitdt = '2020-07-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:13' where placementcpahomeid = '9dd99917-b480-4ef5-96fc-be84c27ee14d' ;
update placementcpahomes set exitdt = '2020-12-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'd091b010-2881-4a0c-abb5-254d4bd03a0b' ;
update placementcpahomes set exitdt = '2021-03-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:01' where placementcpahomeid = 'e4d2f9a3-0c8b-49b5-b7fa-6c1395bdf068' ;
update placementcpahomes set exitdt = '2020-04-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00:00' where placementcpahomeid = 'e17c0d3e-0b2a-4e79-a7fe-7fa5dc53d723' ;
update placementcpahomes set exitdt = '2020-07-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '7b5b3fdd-c049-4dab-82a7-3f214152ac16' ;
update placementcpahomes set exitdt = '2020-11-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 06:00' where placementcpahomeid = '57307b23-aa8b-47f3-9492-e1d03b6e271a' ;
update placementcpahomes set exitdt = '2020-08-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '17eaf39d-f435-4557-b880-461e72345025' ;
update placementcpahomes set exitdt = '2020-11-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '046e15fa-4d81-4314-8570-b11bb897521c' ;
update placementcpahomes set exitdt = '2020-05-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00:00' where placementcpahomeid = '1e0259bb-7530-49f3-b8a5-c5ea617e6657' ;
update placementcpahomes set exitdt = '2020-01-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '9e5d06b1-f4ca-4aaf-bcfd-5b825d304668' ;
update placementcpahomes set exitdt = '2021-02-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:43' where placementcpahomeid = '2a3bd45e-38fe-47f4-ba87-6630f2f8787e' ;
update placementcpahomes set exitdt = '2020-12-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '2886b39f-0109-4871-bf4d-7470d372bcae' ;
update placementcpahomes set exitdt = '2020-10-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '49d79c49-762f-4ee9-b410-88eb1f38bc51' ;
update placementcpahomes set exitdt = '2021-04-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = '3f0c8e17-0d52-49ab-8d6e-e6c0063b6f37' ;
update placementcpahomes set exitdt = '2021-04-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = 'a26add03-c4f3-474e-9638-4a7db06ac29b' ;
update placementcpahomes set exitdt = '2020-08-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30' where placementcpahomeid = '60ef0a27-0265-4fc9-a14c-99e8d0a9a409' ;
update placementcpahomes set exitdt = '2020-09-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:30' where placementcpahomeid = '13b219aa-f2c7-46b4-b82c-49b54a6c6722' ;
update placementcpahomes set exitdt = '2020-09-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'ca0b319c-ac55-44a0-b616-58ad402ed496' ;
update placementcpahomes set exitdt = '2020-12-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '71e3f94a-b466-4c9e-bb9a-1be6939e6968' ;
update placementcpahomes set exitdt = '2020-03-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00' where placementcpahomeid = 'bf772f5d-0ee6-4fa6-98d8-e74a5abbbc76' ;
update placementcpahomes set exitdt = '2020-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:30' where placementcpahomeid = '7356ac18-0515-414a-9fce-2e78758001a1' ;
update placementcpahomes set exitdt = '2020-07-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '5e847f22-8cd1-46a9-82e1-648a83ae3c23' ;
update placementcpahomes set exitdt = '2020-08-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '4d52a985-f3d8-46a2-9367-960f83811c06' ;
update placementcpahomes set exitdt = '2020-11-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = 'a764756d-248f-4d38-b26e-73594e7ae57a' ;
update placementcpahomes set exitdt = '2020-10-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:09' where placementcpahomeid = 'e5ac9f98-e73d-4f71-88c1-8f7e9c1a39ba' ;
update placementcpahomes set exitdt = '2020-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30' where placementcpahomeid = 'f3fe38ff-38e6-48c6-b55f-e3eb1b2edef5' ;
update placementcpahomes set exitdt = '2021-03-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:15' where placementcpahomeid = 'd7ca379c-3d64-4481-8a58-c6e6f39ad15f' ;
update placementcpahomes set exitdt = '2020-09-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '8457ed03-0456-496c-b22c-bbaf94cae3ee' ;
update placementcpahomes set exitdt = '2020-07-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '781f37c1-0106-40fc-ab2c-f63ffb3ad086' ;
update placementcpahomes set exitdt = '2020-10-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '8c9eacde-f024-4fc9-91ff-e7388203ab14' ;
update placementcpahomes set exitdt = '2020-10-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '913e7efd-80de-404b-b184-dd7f35423144' ;
update placementcpahomes set exitdt = '2020-07-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'ea710c6f-bcaf-41d3-a291-c95a853babd2' ;
update placementcpahomes set exitdt = '2020-09-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:42' where placementcpahomeid = '6318c735-cb6b-4417-8585-5c4449c39d97' ;
update placementcpahomes set exitdt = '2020-09-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '83bc4157-3e05-42b9-95ee-3711553cf6b8' ;
update placementcpahomes set exitdt = '2020-11-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '49601145-06ca-40f7-a84a-ec4751af1bfe' ;
update placementcpahomes set exitdt = '2020-11-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = 'c3726af8-bf68-462b-afc1-0926d6ab3137' ;
update placementcpahomes set exitdt = '2020-10-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '99f6bfc3-aaf4-4092-ada2-d26e24b0981d' ;
update placementcpahomes set exitdt = '2020-09-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:59' where placementcpahomeid = '63df71db-6639-4101-9a28-f61f4081cf97' ;
update placementcpahomes set exitdt = '2021-03-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'db35b825-8a70-4987-8e20-b6fd7d2155f6' ;
update placementcpahomes set exitdt = '2021-02-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = 'cc1f52a9-63a7-4742-b95c-7cc19ef45d7f' ;
update placementcpahomes set exitdt = '2021-01-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '038dd318-d22d-4af4-b5d5-86d5de8985dd' ;
update placementcpahomes set exitdt = '2020-09-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30' where placementcpahomeid = 'f4345169-2592-465a-bf87-c1ba7058ba86' ;
update placementcpahomes set exitdt = '2020-09-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:13' where placementcpahomeid = '7f47bce0-a1ed-45f0-a075-3f0f6122418b' ;
update placementcpahomes set exitdt = '2020-06-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:08:12' where placementcpahomeid = '57bd93f7-41c8-4fc4-9f77-12f41e3863d1' ;
update placementcpahomes set exitdt = '2020-10-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30' where placementcpahomeid = 'e2b558ad-605d-482f-8a6d-7eab8d0d604a' ;
update placementcpahomes set exitdt = '2020-08-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '819c1efa-3b3a-4a2c-a048-1cd7b51425ff' ;
update placementcpahomes set exitdt = '2020-11-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '1ae49170-65de-4b64-9a0e-09096610833e' ;
update placementcpahomes set exitdt = '2020-08-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = 'fd3bd149-1556-4553-a38b-f4bd5306f59e' ;
update placementcpahomes set exitdt = '2020-07-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '0e316fec-f8da-424f-8e00-5d6ff3761a7e' ;
update placementcpahomes set exitdt = '2020-09-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = 'e818b7d8-0fa6-4297-a3b7-c63e335cee2a' ;
update placementcpahomes set exitdt = '2021-04-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'f2d8afe3-fc5e-4030-9133-930d5642e8de' ;
update placementcpahomes set exitdt = '2020-02-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '1e19ade8-c950-4755-8491-0f5ad87ee2af' ;
update placementcpahomes set exitdt = '2020-11-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '607d4252-b2f7-40c8-8833-54df80d87725' ;
update placementcpahomes set exitdt = '2020-11-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '9117688d-5bf4-4ec6-84ac-6c4d41f46e28' ;
update placementcpahomes set exitdt = '2020-10-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'b0b49816-b6b3-41ef-b4e2-2f8109e91695' ;
update placementcpahomes set exitdt = '2020-05-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '16f82c1c-586b-4f88-b961-3a3cc320ad15' ;
update placementcpahomes set exitdt = '2020-02-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '86935fea-28c5-41a8-a1f7-453d818cc508' ;
update placementcpahomes set exitdt = '2020-02-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '62dd2541-4968-4ad1-8f36-b78cf20b8606' ;
update placementcpahomes set exitdt = '2020-10-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = 'c743d91d-24b3-4b49-bd5f-ce11f62c83fb' ;
update placementcpahomes set exitdt = '2020-08-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '9a963b0b-85d5-4fbc-82c5-eab9d2f6de3d' ;
update placementcpahomes set exitdt = '2020-09-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 03:10' where placementcpahomeid = '6aedd798-b901-4bbe-8852-a4cb715c1ca1' ;
update placementcpahomes set exitdt = '2020-08-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '25af7922-12d2-471d-a2d1-b2ddbad3d2ac' ;
update placementcpahomes set exitdt = '2021-02-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = 'c43d90c7-88c6-4db7-9fd0-e8bebd1e52a9' ;
update placementcpahomes set exitdt = '2021-03-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'e13999ca-abff-4fc0-8552-81fc9b89ec8c' ;
update placementcpahomes set exitdt = '2021-03-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = '498fb9b5-5440-45bc-ac0a-bb127dfc5c0f' ;
update placementcpahomes set exitdt = '2020-11-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:30' where placementcpahomeid = '17c02c4e-a7d1-4497-b95f-a22da01873d7' ;
update placementcpahomes set exitdt = '2021-05-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '12bd5d86-5fd7-4297-a912-3ba072edf147' ;
update placementcpahomes set exitdt = '2020-07-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 23:59' where placementcpahomeid = '6e10d770-3d57-47ea-8bbb-fc45d7603a88' ;
update placementcpahomes set exitdt = '2020-10-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = '5f767d1c-4f85-44e8-8b38-75445a30d35f' ;
update placementcpahomes set exitdt = '2020-12-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = 'f23ee095-5fb5-4ea1-aa5c-16f97bc51804' ;
update placementcpahomes set exitdt = '2020-12-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '0e53868c-9f05-4c20-937a-929ff5e370c3' ;
update placementcpahomes set exitdt = '2020-08-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:20' where placementcpahomeid = 'da210715-cc32-4f1e-b7d1-13ec8fc067d3' ;
update placementcpahomes set exitdt = '2021-04-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:05' where placementcpahomeid = '55435fec-aab9-4144-9abc-5c4195c7dba3' ;
update placementcpahomes set exitdt = '2020-07-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'ecf478c4-188f-469c-8a15-aea7c32db7f0' ;
update placementcpahomes set exitdt = '2020-12-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'd1a4360e-394a-4d2e-96c2-b5cf0910b93f' ;
update placementcpahomes set exitdt = '2020-09-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '9714b76f-54f7-426e-b91a-32c0ae57d759' ;
update placementcpahomes set exitdt = '2020-07-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'f43f4ed3-e265-4437-9539-c41111c256f8' ;
update placementcpahomes set exitdt = '2020-07-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:46' where placementcpahomeid = 'b1115d23-4175-453f-b33e-40966353288e' ;
update placementcpahomes set exitdt = '2020-09-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = '348e461d-1699-413f-84c5-1d044e5b7c38' ;
update placementcpahomes set exitdt = '2020-06-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:15' where placementcpahomeid = '46823faf-5691-428a-9802-63377e5b3481' ;
update placementcpahomes set exitdt = '2021-03-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = 'b1a799f7-47d6-4d93-b170-eb29edf92b50' ;
update placementcpahomes set exitdt = '2020-09-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '5f1ec619-4076-4c43-a134-bc25cc506a93' ;
update placementcpahomes set exitdt = '2020-09-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '060480eb-259b-4189-a52a-fd9a79058b42' ;
update placementcpahomes set exitdt = '2020-10-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '9e862470-054e-4c44-954a-612de70d912f' ;
update placementcpahomes set exitdt = '2021-02-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = 'd52a9e96-16c9-4f0b-a661-a3ce2f95771c' ;
update placementcpahomes set exitdt = '2021-02-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30' where placementcpahomeid = '278e1c6d-54cd-4569-885c-c6db251ffea3' ;
update placementcpahomes set exitdt = '2021-02-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:30' where placementcpahomeid = '3d15c5b2-502e-4c3b-b4ee-fb4a198709ab' ;
update placementcpahomes set exitdt = '2021-02-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:30' where placementcpahomeid = 'beade709-0cd3-49d5-ae53-491f38703206' ;
update placementcpahomes set exitdt = '2021-03-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = 'd7e450f9-9a76-49b4-bbde-c4a3c855d6b7' ;
update placementcpahomes set exitdt = '2020-10-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'f0c58cf6-dc88-4468-8f33-4dcc86c00ab8' ;
update placementcpahomes set exitdt = '2020-07-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'a5f8c3d3-d3f0-49a6-9289-1d443b0b2e9f' ;
update placementcpahomes set exitdt = '2020-09-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = 'ceeae7ba-aec5-4317-ba16-9270250f8881' ;
update placementcpahomes set exitdt = '2020-08-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'f95b0adc-0f51-4b0a-94a1-57bfe40162e6' ;
update placementcpahomes set exitdt = '2020-08-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'f1bc1c53-3ef8-40d3-b0bc-a5649dd67dff' ;
update placementcpahomes set exitdt = '2021-02-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '5b07f7c3-302c-4093-a92e-f1beed7eea40' ;
update placementcpahomes set exitdt = '2020-09-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '26936aa1-169e-4916-8597-73d2bf7fd6a5' ;
update placementcpahomes set exitdt = '2021-02-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:15' where placementcpahomeid = 'f419ca41-40a6-4f51-ac5e-dbaaa0094a2e' ;
update placementcpahomes set exitdt = '2020-08-03 12:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '31b9b97c-ab8b-47d0-a77e-73a5ae110c0f' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'c1df665d-bf09-4705-b7a9-9530be34646b' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'b005a8d6-0a54-44a6-b01f-d84a1a8c8787' ;
update placementcpahomes set exitdt = '2021-01-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30' where placementcpahomeid = '341f9b71-bb95-461a-9c9b-8864883e65fc' ;
update placementcpahomes set exitdt = '2020-12-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '0fc89865-42d7-46fe-afc7-71c1ba80d68a' ;
update placementcpahomes set exitdt = '2020-08-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '59e877fd-978b-4e20-9a09-a68b736a64c8' ;
update placementcpahomes set exitdt = '2021-02-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '974b4916-c355-4cad-81c3-5e3b43ade539' ;
update placementcpahomes set exitdt = '2020-06-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '5f050bd1-9a97-4685-8801-9bef85f2a61c' ;
update placementcpahomes set exitdt = '2020-06-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = 'a02a99e4-121b-4f0e-8bb1-1359b0ce65bf' ;
update placementcpahomes set exitdt = '2020-10-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:30' where placementcpahomeid = 'f458e3cc-c794-466f-b5ea-9cefc4829a66' ;
update placementcpahomes set exitdt = '2020-08-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 19:14' where placementcpahomeid = '365133e9-fc7e-4e3c-9d0c-29c3bf06f628' ;
update placementcpahomes set exitdt = '2020-05-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:40' where placementcpahomeid = 'f4b512a0-cd98-43e5-b246-c2fbc545d13b' ;
update placementcpahomes set exitdt = '2020-02-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00:00' where placementcpahomeid = 'f67c96eb-6669-475c-99ea-2854bf2c253d' ;
update placementcpahomes set exitdt = '2021-02-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '82979535-7c4d-41ea-b253-4a18860a42ef' ;
update placementcpahomes set exitdt = '2020-07-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = 'fb66434f-eaa9-4952-9e2c-8b90a9f65f6b' ;
update placementcpahomes set exitdt = '2021-01-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'b2a895a5-9735-407a-b8a2-c37acd620c38' ;
update placementcpahomes set exitdt = '2020-07-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '53fe8716-c75e-4f81-8cf2-fbcd64c0ed23' ;
update placementcpahomes set exitdt = '2020-09-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:43' where placementcpahomeid = 'f22fa465-5e9a-4175-9ce2-19b0d03c3eb5' ;
update placementcpahomes set exitdt = '2021-02-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '51751763-6ed4-4a9c-89d4-76344fe99846' ;
update placementcpahomes set exitdt = '2021-02-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:15' where placementcpahomeid = '8d93d275-834c-4aac-b06b-c6b8b31eb704' ;
update placementcpahomes set exitdt = '2020-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30' where placementcpahomeid = '95c9feca-21f3-40fc-acb4-df634ae8dda4' ;
update placementcpahomes set exitdt = '2020-05-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 05:00' where placementcpahomeid = 'c434c227-4f19-4fc0-8518-f9f1f0a7ff49' ;
update placementcpahomes set exitdt = '2020-05-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 05:00' where placementcpahomeid = '02d172c3-169b-4629-8b91-1033b8718ef5' ;
update placementcpahomes set exitdt = '2020-08-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '4fe164f4-880c-4b4f-b5b9-02de1a428128' ;
update placementcpahomes set exitdt = '2020-05-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'b8616795-a1c3-4de9-9db0-c7d003d4612c' ;
update placementcpahomes set exitdt = '2020-08-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '5c4aecc0-42a1-4796-8c5f-3e956a00a392' ;
update placementcpahomes set exitdt = '2020-07-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '09767d49-b687-4e39-913c-c35f0f705f2c' ;
update placementcpahomes set exitdt = '2020-07-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '0401201b-c028-4865-88e3-bf190f3f7963' ;
update placementcpahomes set exitdt = '2020-07-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:09' where placementcpahomeid = '8fb4b9c2-f831-46dd-9235-0f14a470149e' ;
update placementcpahomes set exitdt = '2021-02-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 23:00' where placementcpahomeid = '4e11d10c-74e1-4b26-b52c-971c3ee1d2c0' ;
update placementcpahomes set exitdt = '2021-04-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30' where placementcpahomeid = '1c78e7ab-ce98-47e1-9086-1d77c6f447dc' ;
update placementcpahomes set exitdt = '2020-09-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:30' where placementcpahomeid = 'e7283ea9-d5f2-4dee-8b4b-8cbd696048c8' ;
update placementcpahomes set exitdt = '2020-09-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'a76ce80a-a7fe-4957-bbb6-f00a83dd9223' ;
update placementcpahomes set exitdt = '2020-09-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = '73f1199c-8ec9-43aa-a095-aa3e107df2e7' ;
update placementcpahomes set exitdt = '2020-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'ef8830a7-e7ca-4633-a1f2-ba38ba3c0ed3' ;
update placementcpahomes set exitdt = '2019-12-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '7edcbee0-49af-4e5b-b79e-86923ab37bfd' ;
update placementcpahomes set exitdt = '2021-01-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '6e62084a-930c-4b50-bc69-73aa4c026ccb' ;
update placementcpahomes set exitdt = '2020-12-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '08451185-cabd-4400-b19a-ce74b58a89a2' ;
update placementcpahomes set exitdt = '2020-09-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:30' where placementcpahomeid = 'f8ca9d30-bba4-452c-afe9-940efb0d183a' ;
update placementcpahomes set exitdt = '2020-11-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = 'b5405830-45fd-4886-8f6c-3136442e91f9' ;
update placementcpahomes set exitdt = '2020-10-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'a6eff3e4-5d66-4b5a-83b3-a124f7430cee' ;
update placementcpahomes set exitdt = '2020-10-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '99517997-abfb-4de1-b30f-95303e698cd2' ;
update placementcpahomes set exitdt = '2021-01-27 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '6571b558-26f4-400f-987a-fb858e3ff20f' ;
update placementcpahomes set exitdt = '2020-08-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '5996700e-d8c7-466a-bdd0-3754a12dd3ef' ;
update placementcpahomes set exitdt = '2021-03-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '9aeff797-d891-4eb7-9a79-cffb9c6724a6' ;
update placementcpahomes set exitdt = '2020-07-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '9eedd079-2635-44f0-a25e-5aced6ef442f' ;
update placementcpahomes set exitdt = '2021-01-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = 'c503a144-0952-4902-8054-5660a0ae90bc' ;
update placementcpahomes set exitdt = '2020-11-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:30' where placementcpahomeid = 'cc5521f9-fcdf-4a52-9c22-f72f8aff5842' ;
update placementcpahomes set exitdt = '2020-10-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = '2ab7f806-44cc-45ec-b3a6-23a6c7e25b0c' ;
update placementcpahomes set exitdt = '2020-07-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:41' where placementcpahomeid = 'f74687e5-d2b6-4448-b624-70bc775d1754' ;
update placementcpahomes set exitdt = '2020-12-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:15' where placementcpahomeid = '6a8b1511-b598-4082-8dda-07ec2df6ed0c' ;
update placementcpahomes set exitdt = '2020-09-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'b5b7a441-b860-4289-b21f-ed99a9c03161' ;
update placementcpahomes set exitdt = '2020-07-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:30' where placementcpahomeid = '5d93a478-d835-46b3-820a-f66c1c3940a8' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '1c9bfc69-20dd-4c33-ade5-ae4244556504' ;
update placementcpahomes set exitdt = '2021-02-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 21:00' where placementcpahomeid = '84a68e91-d072-4d10-ba49-5613b02d4764' ;
update placementcpahomes set exitdt = '2020-12-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '0286cdc5-114d-4050-966e-d6ae70de50d4' ;
update placementcpahomes set exitdt = '2020-06-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:33' where placementcpahomeid = '4b9269a1-7726-4167-bb54-8e8602e0a06f' ;
update placementcpahomes set exitdt = '2020-10-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '3b74be47-5d6d-457a-b345-35d9b38f74c1' ;
update placementcpahomes set exitdt = '2020-10-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30' where placementcpahomeid = '9735bcac-e632-42d9-ab2e-ed58ee18f045' ;
update placementcpahomes set exitdt = '2020-10-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30' where placementcpahomeid = '1c7f0268-7305-479a-acca-cd66f1866906' ;
update placementcpahomes set exitdt = '2020-08-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = 'bfb5aff9-7d81-4018-869a-b6e2667a429e' ;
update placementcpahomes set exitdt = '2020-10-20 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:45' where placementcpahomeid = '54d45bd7-c77c-4b40-9af3-c2a16e7087f3' ;
update placementcpahomes set exitdt = '2020-10-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '38f6d068-d8e1-4e7d-b0b3-a2af9d66f0af' ;
update placementcpahomes set exitdt = '2020-07-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '0c80159e-7dab-4629-a7e9-dd04c3fe8ea8' ;
update placementcpahomes set exitdt = '2020-10-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 21:00' where placementcpahomeid = '545b2a2e-062c-4f46-a949-1c5ef76eaac9' ;
update placementcpahomes set exitdt = '2020-05-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '050aa210-77bb-4b27-9c98-429b6a435f15' ;
update placementcpahomes set exitdt = '2020-11-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'a0ef9016-a38b-4da2-9f38-f4cb958da8ec' ;
update placementcpahomes set exitdt = '2021-03-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '147319e7-d2d9-494c-9583-0b108e962605' ;
update placementcpahomes set exitdt = '2020-01-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '0d05c7f3-0f5d-4ca9-a9bc-1e795cc0e095' ;
update placementcpahomes set exitdt = '2020-07-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = 'bd9a979a-cc1e-407d-ada1-1267c0a0ea21' ;
update placementcpahomes set exitdt = '2020-12-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '1f3a1fd5-d7dd-43d1-9ef2-dabdb3bf90d6' ;
update placementcpahomes set exitdt = '2020-08-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '10d90c03-db71-4838-a0e0-378ecd4d37a9' ;
update placementcpahomes set exitdt = '2020-10-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'ab57749d-e916-4381-af09-b3a2491e0524' ;
update placementcpahomes set exitdt = '2020-12-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '3821573e-775f-4364-b19e-9c488e6a7c73' ;
update placementcpahomes set exitdt = '2020-06-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '32218f89-ea77-4971-bce0-7a6b8e1c1cda' ;
update placementcpahomes set exitdt = '2020-12-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:39' where placementcpahomeid = 'c7d1100d-edb4-4e1f-a3b4-6ac50c9fdc06' ;
update placementcpahomes set exitdt = '2020-07-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '49377828-2ad0-4800-b278-059df138a54e' ;
update placementcpahomes set exitdt = '2020-08-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30' where placementcpahomeid = 'c207a6aa-1f8d-452e-8a51-714edd23d2cc' ;
update placementcpahomes set exitdt = '2020-08-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:30' where placementcpahomeid = 'd6302739-c566-42f5-9cb9-734dbf73c8c6' ;
update placementcpahomes set exitdt = '2020-10-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'bf56f16f-d79b-4bb2-bdbd-f106ee0a68a5' ;
update placementcpahomes set exitdt = '2020-09-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:26' where placementcpahomeid = 'f3087016-fd8a-4ba1-9725-b86fa3d8d109' ;
update placementcpahomes set exitdt = '2020-08-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = 'e79d05f8-bc43-4a88-9798-3ec6c5bdae06' ;
update placementcpahomes set exitdt = '2021-02-11 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:30' where placementcpahomeid = '6790362e-0671-4bf4-b854-1a5ab0ad4af9' ;
update placementcpahomes set exitdt = '2020-09-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:30' where placementcpahomeid = '0590b0f9-ae13-4527-8341-5b02f5234436' ;
update placementcpahomes set exitdt = '2020-08-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '3ccb6d5c-023c-4f46-983e-2ce47db297b0' ;
update placementcpahomes set exitdt = '2020-10-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'cfca69f0-3d73-4dfe-883a-1271fe8ad2a0' ;
update placementcpahomes set exitdt = '2020-10-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'fcac48fa-2821-4ba6-9aa4-bb30e5c9b801' ;
update placementcpahomes set exitdt = '2020-04-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '9a8cfd2a-105d-4ecc-bd1c-7a01e4a97dc3' ;
update placementcpahomes set exitdt = '2020-04-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '876984f7-b820-46b4-8c0e-18953ec34ce1' ;
update placementcpahomes set exitdt = '2020-05-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00' where placementcpahomeid = 'bdb1538c-dcc4-4549-a265-215946f6651f' ;
update placementcpahomes set exitdt = '2020-04-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:00' where placementcpahomeid = '42113ff2-c481-4ef3-a6c4-7a80b38e0fb0' ;
update placementcpahomes set exitdt = '2020-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '3fb86c0a-6b51-4073-b6bd-ae2ffb3d7ff4' ;
update placementcpahomes set exitdt = '2020-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '05b5c5f8-9c72-4d77-924f-831a37028545' ;
update placementcpahomes set exitdt = '2020-11-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '64ba8e0d-2b89-457e-8c14-a637111dedfa' ;
update placementcpahomes set exitdt = '2021-02-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '79a9dac7-a0cb-4ab1-9796-ab87c46a0260' ;
update placementcpahomes set exitdt = '2020-07-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '40e5cb69-8b75-409b-849c-2b442c73c42d' ;
update placementcpahomes set exitdt = '2020-11-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '310c03e2-c362-4589-8bfd-904f5fb8b7a8' ;
update placementcpahomes set exitdt = '2020-06-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:15' where placementcpahomeid = '6da4ba0c-c1a1-492c-9430-1a1086391b64' ;
update placementcpahomes set exitdt = '2020-06-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:30' where placementcpahomeid = '929c1c3f-0af8-45d7-bddd-d0f0fe775329' ;
update placementcpahomes set exitdt = '2020-11-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '5a86f86a-e8f1-494f-91d1-7adae8f7a78c' ;
update placementcpahomes set exitdt = '2020-08-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '71e820b1-e134-434a-a585-2c1527bdb195' ;
update placementcpahomes set exitdt = '2020-09-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '85fb54c3-55c2-4d0e-a8aa-ab99f6a774a0' ;
update placementcpahomes set exitdt = '2020-10-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00' where placementcpahomeid = '22ec4e83-b76b-45de-ae7b-41b3a0e63bbf' ;
update placementcpahomes set exitdt = '2020-07-21 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:15' where placementcpahomeid = 'cd0752c8-8df2-495c-b4de-4771c1ad6806' ;
update placementcpahomes set exitdt = '2020-07-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30' where placementcpahomeid = '727c79d1-00c6-46c0-99c4-0adbd7008525' ;
update placementcpahomes set exitdt = '2020-07-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30' where placementcpahomeid = '014cd5f3-093d-49b0-ab02-f8cd171a332f' ;
update placementcpahomes set exitdt = '2021-03-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:30' where placementcpahomeid = 'c8422ba0-de26-4799-b32e-c0639e1c35ab' ;
update placementcpahomes set exitdt = '2020-08-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '04a04ebc-9cbf-42de-afc3-c39856080f3b' ;
update placementcpahomes set exitdt = '2020-10-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '1379d733-3ea9-4580-ad44-6ae62fa4cf0d' ;
update placementcpahomes set exitdt = '2021-01-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '8bcd9590-d94c-474c-8149-61f58146e36f' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:30' where placementcpahomeid = '5d43f0e8-0a19-4ea6-945f-77b0a508de2a' ;
update placementcpahomes set exitdt = '2020-10-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '9a894361-bb9a-4f01-b719-ee587ea30e01' ;
update placementcpahomes set exitdt = '2020-09-08 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '3e2105a4-9bd6-4b92-a7ac-3215c0a6a77a' ;
update placementcpahomes set exitdt = '2021-02-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:30' where placementcpahomeid = '201d8576-b01b-408d-ab84-be2f87bad17a' ;
update placementcpahomes set exitdt = '2021-02-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:30' where placementcpahomeid = '1826ecbd-b53a-4d9e-a53f-f64789a5e9dd' ;
update placementcpahomes set exitdt = '2021-02-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:30' where placementcpahomeid = 'ecb2e5ba-474f-456e-980e-be95f656e2e5' ;
update placementcpahomes set exitdt = '2021-01-29 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '81b43b2b-ab2c-4926-b48f-c3a9c473a542' ;
update placementcpahomes set exitdt = '2020-10-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '7d3bd4e4-03ab-4643-b5de-1005bbf3aeb6' ;
update placementcpahomes set exitdt = '2020-11-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '924cd703-b5cf-4b73-a38a-e62f10ee1d41' ;
update placementcpahomes set exitdt = '2020-12-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:15' where placementcpahomeid = '20feffa2-a97c-4aa9-9339-09ebeb841112' ;
update placementcpahomes set exitdt = '2020-09-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = 'ea86a317-d018-4fee-b47a-5d2d14a9111d' ;
update placementcpahomes set exitdt = '2020-09-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:30' where placementcpahomeid = 'd623fbcb-c571-4c43-924f-c15ae7df7ca4' ;
update placementcpahomes set exitdt = '2020-09-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:30' where placementcpahomeid = 'a5b50621-188a-404c-bcd2-235f5087bcc0' ;
update placementcpahomes set exitdt = '2020-09-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:30' where placementcpahomeid = '5834663b-610b-45cb-b286-9942736f9fc4' ;
update placementcpahomes set exitdt = '2020-11-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 19:20' where placementcpahomeid = '11bb9fe4-0162-43fb-a6ef-9423d0c5b26a' ;
update placementcpahomes set exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30' where placementcpahomeid = 'ee2b2401-87b0-4758-a6d1-ad66a2f840bd' ;
update placementcpahomes set exitdt = '2020-09-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:07' where placementcpahomeid = 'd3a87151-19f0-4fd2-b637-ed3d8c05fdbf' ;
update placementcpahomes set exitdt = '2021-01-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'f536ffef-0877-4787-b490-758f750feedc' ;
update placementcpahomes set exitdt = '2020-12-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '78b155b0-ad45-4f9f-b774-eba53a6d1ed4' ;
update placementcpahomes set exitdt = '2021-03-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '6c8ee5d8-6d2b-4ad1-a1e4-736a5af2b608' ;
update placementcpahomes set exitdt = '2020-09-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'b9310443-a65d-4eed-a653-a0eb32cc1468' ;
update placementcpahomes set exitdt = '2020-10-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:30' where placementcpahomeid = 'b05e3abb-9ca4-4efa-a1f9-e78482db99e2' ;
update placementcpahomes set exitdt = '2020-11-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '48a5c59e-ef84-49be-839e-c60dc682da52' ;
update placementcpahomes set exitdt = '2020-10-28 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:12' where placementcpahomeid = '928d132a-5de3-4020-9615-843960a9976d' ;
update placementcpahomes set exitdt = '2021-01-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:30' where placementcpahomeid = '14ee57b4-fd40-4fb0-a1d5-a947a8f7418f' ;
update placementcpahomes set exitdt = '2021-03-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:00' where placementcpahomeid = '1b1998b6-f701-4b4c-afae-ed58ac1204eb' ;
update placementcpahomes set exitdt = '2020-12-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '440d063f-8601-4fde-97fa-dca4b46fd621' ;
update placementcpahomes set exitdt = '2020-12-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '3c496f40-9fb5-4310-bff9-69fe081b512e' ;
update placementcpahomes set exitdt = '2020-07-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:00' where placementcpahomeid = '3b94c3dc-e954-433e-b89c-86b4bbe3859e' ;
update placementcpahomes set exitdt = '2020-11-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '114e7d80-3c59-4c97-80f9-eaeb617d3052' ;
update placementcpahomes set exitdt = '2020-09-23 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 23:00' where placementcpahomeid = 'c0f19b2a-aeb3-4a83-ba29-44181e9d1b6a' ;
update placementcpahomes set exitdt = '2020-12-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '9d3ed819-71a1-43b2-9b8f-5010834f7f4a' ;
update placementcpahomes set exitdt = '2020-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 21:09' where placementcpahomeid = '7046b8bf-74c8-4712-8a5e-ca1934a66f37' ;
update placementcpahomes set exitdt = '2020-11-05 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00' where placementcpahomeid = '5eec4548-8680-4404-8c30-6c0b336a72be' ;
update placementcpahomes set exitdt = '2021-03-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '77defd07-94c9-4648-9f18-2f3cd505e54a' ;
update placementcpahomes set exitdt = '2020-10-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00' where placementcpahomeid = 'b85d2c01-ea76-45c9-8407-288c0ed7e304' ;
update placementcpahomes set exitdt = '2021-02-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:58' where placementcpahomeid = '1c790294-12f3-413a-82bc-f372b6b4bc82' ;
update placementcpahomes set exitdt = '2021-02-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:58' where placementcpahomeid = '7fe85e3e-af7d-4dc0-bca0-0628d2e82528' ;
update placementcpahomes set exitdt = '2021-01-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:15' where placementcpahomeid = '502af8d0-fe6f-4d3b-a6ab-f26dcf3c52bf' ;
update placementcpahomes set exitdt = '2021-01-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:00' where placementcpahomeid = '94e1ccd8-09f9-4129-bcc5-b483943cfdd4' ;
update placementcpahomes set exitdt = '2021-03-02 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:30' where placementcpahomeid = '08585e26-c782-4789-9e15-785b4b2f9b5c' ;
update placementcpahomes set exitdt = '2020-12-10 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'ffb672c6-2690-47bb-90c6-6c1079803058' ;
update placementcpahomes set exitdt = '2021-01-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '0cf341a0-c62c-4883-890c-1778200a554d' ;
update placementcpahomes set exitdt = '2020-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '0bede2a7-83ad-4bb5-8121-4fb5a316dc7c' ;
update placementcpahomes set exitdt = '2021-01-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = '0e0a9822-a22b-4fff-a0c1-48ebbcc28efa' ;
update placementcpahomes set exitdt = '2021-01-14 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = 'd36ea365-abba-49f8-9947-d1fb41469134' ;
update placementcpahomes set exitdt = '2020-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '9d1d5085-e48e-4f64-aff0-78cc8bdd1b15' ;
update placementcpahomes set exitdt = '2020-12-15 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = 'b665fa92-7f14-4548-8cf4-de5e8f1f60f5' ;
update placementcpahomes set exitdt = '2021-02-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:15' where placementcpahomeid = '624d42b3-7f37-452d-a06e-1b3966a3d071' ;
update placementcpahomes set exitdt = '2020-12-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '60e453d7-5e5b-4ddc-bbfd-b11595066d83' ;
update placementcpahomes set exitdt = '2021-02-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '3d257607-8cb6-494c-aee4-918bbd6897e9' ;
update placementcpahomes set exitdt = '2021-02-17 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'a9bc3058-74f9-4ba8-9bfc-35a60ebe6585' ;
update placementcpahomes set exitdt = '2021-03-24 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'efb0139f-7246-4932-854d-63c0b7cc1e11' ;
update placementcpahomes set exitdt = '2021-02-04 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '54b9c5a5-2c6c-428f-9009-b56bd68e48dc' ;
update placementcpahomes set exitdt = '2021-02-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '8c3f9afb-bfd2-4dae-a069-7ac255d5b124' ;
update placementcpahomes set exitdt = '2020-12-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = 'cb76b56a-2f7f-44d4-9178-4829e3a1fc8f' ;
update placementcpahomes set exitdt = '2020-12-16 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 20:00' where placementcpahomeid = '06f6ca90-8934-4d4f-8c33-70172182d4ab' ;
update placementcpahomes set exitdt = '2021-01-22 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '0823d157-c85f-4c78-b056-15e85ce088c8' ;
update placementcpahomes set exitdt = '2021-01-07 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:00' where placementcpahomeid = '3333ea0a-8aca-4737-bc5d-b26096091de5' ;
update placementcpahomes set exitdt = '2020-11-19 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '2ed31350-2b0d-4829-a78a-5b01f0a63b6e' ;
update placementcpahomes set exitdt = '2021-03-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 14:00' where placementcpahomeid = '39f8b7bb-131c-48d5-b305-9f9da7f68c87' ;
update placementcpahomes set exitdt = '2021-02-25 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:45' where placementcpahomeid = '00b20eaf-6069-41ac-89f7-dc09639706fe' ;
update placementcpahomes set exitdt = '2021-03-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '2ba8a7b8-c521-4e4e-bee0-8d387fea5964' ;
update placementcpahomes set exitdt = '2021-03-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = '26cc4623-48d3-4342-bc1f-3a7911d513b4' ;
update placementcpahomes set exitdt = '2021-03-31 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 08:00' where placementcpahomeid = 'a1bbf8b9-c6a5-4a95-b259-24d02f2a73a6' ;
update placementcpahomes set exitdt = '2021-03-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30' where placementcpahomeid = '26eddbb3-92f0-4503-b83a-c4e96de9b24f' ;
update placementcpahomes set exitdt = '2021-02-03 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = 'd27f05ce-ccfd-41fd-9d93-2e9f99c30876' ;
update placementcpahomes set exitdt = '2021-03-26 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = 'b5967285-e68a-45fb-b1df-2cbbca1b504a' ;


-- CPA Homes with entry date beyond Placement exit date
-- Before
select * 
from (  
select pl.alternateid as placement_id,
	pc.altproviderid as CPA_Home_provider_ID,
	pc.placementcpahomeid,
	pc.entrydt::date as CPA_Home_Entry_date,
	pc.exitdt::date as CPA_Home_Exit_date,
	pl.startdatetime::date as Placement_entry_date,
	pl.enddatetime::date as Placement_exit_date,
	(case when pc.entrydt::date > pl.enddatetime::date then 
		'Error' 
	 else 
	 	'Good'
	 end ) as test
from placementcpahomes pc,
	placement pl
where pc.placementid = pl.placementid 
	and pc.activeflag = 1
	and pl.activeflag = 1
	and pc.entrydt is not null
	and pc.exitdt is null
	and pl.enddatetime is not null
	and COALESCE(pl.isvoided, 0) <> 1 
) tab
where tab.test = 'Error' ;

-- Delete
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'e008072a-e190-4559-80cc-a0682c060ab3' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'adaf2cb8-a763-4433-a7a4-88d8baea99d0' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '489ca33e-1fa6-43c7-b9e8-f9a51a347fad' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '35bd3d68-019b-4521-b567-b3da4fcb5f50' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'b3b3b714-3c69-4845-8c70-456b3919990a' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'eaefd6dd-1c39-47ed-bebf-9952b2b112e2' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '6b3da8cb-a066-49ec-b065-0665fe66b255' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '8c9d9a95-727a-485a-8d2e-d75d65b95065' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '37bf95bc-1fca-4ff7-9e5f-4853c7fb3b76' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '36d6cb4c-da05-4402-bef0-4430622af490' ;


-- CPA Home Records with Provider ID null and Start & End dates are null
-- Before 
select pl.alternateid,
	pc.altproviderid,
	pc.placementcpahomeid,
	pc.entrydt,
	pc.exitdt,
	pl.startdatetime,
	pl.enddatetime
from placementcpahomes pc,
	placement pl
where pc.placementid = pl.placementid 
	and pc.activeflag = 1
	and pl.activeflag = 1
	and pc.entrydt is null
	and pc.exitdt is null
	and pl.enddatetime is not null
	and COALESCE(pl.isvoided, 0) <> 1 
	and pc.altproviderid is null ;
	
-- Delete
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '6cf9afb3-bf02-414f-8ade-8fa34319fa55' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '24a89552-1493-46d8-9ef5-d030ed87fee8' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '8b80377a-e931-4873-ad3c-4b997f6b9f0f' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '6134939e-5524-491e-8a62-8f28acf2ede2' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'dc3513f6-8aa3-4397-90f8-01713df2dee3' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'f46e0eea-51d1-4c73-85bc-c86da219cbe5' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'bd6e4be7-c91a-4ad5-baee-88c84872bb15' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '943bc9d0-8751-453b-aadc-a42a376fa8f2' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'e3a733a1-9f44-433e-b6ec-9fc78a65e15b' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'e948efc1-683a-4572-b929-8d97d9d24136' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '1ff27bf8-5eef-42bd-ad37-ed0d5a8858fc' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '645509b4-ac45-4788-8391-b5071b539068' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '328a40d8-f379-492a-9aeb-6c38973cfd0e' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '1bc8f3d9-9ef3-4080-9781-a2f3441f2333' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'f18ec4b0-a7da-4b8e-a360-2cc9f3e04e71' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '565eb736-a37d-456a-8a96-707c79d39f2b' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'f40ffcb4-fe33-4188-abee-4bef90ad8c46' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'ede90552-f733-447c-a5f6-3fbea502ee7f' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '29d71940-6c23-4d7c-87e3-f170e6ef0abc' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '0118c27d-890a-46fb-970b-44016cac83e8' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '2434b4c7-d3b9-4401-920e-4046db837500' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '1b2c4b0b-1d53-4241-ac59-35be9648965b' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'c4aa3c7b-879e-45df-a490-1d8802e7ac9a' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'ad4b05d8-69a1-4c59-9929-eec738fce1e8' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'b3e9bdc4-d95a-4df8-90e2-234c8126ed81' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '78ff3f52-6b94-407e-a0c3-e202249a19c7' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'fc922767-e8b9-457d-8091-01e829bb4073' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '193a37a1-c418-405c-b131-eac016536571' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'b5891bf9-cf21-46a3-a4d9-189f53718a32' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'b939318d-18a9-4510-b851-b82519ca5bb7' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '25eae8bb-f759-4df9-8fc2-56c9e418b4a9' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '27416001-9b3b-4535-85de-97464ad79a59' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '7fff37bd-92c7-45c9-97de-94ad9d58374e' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '23ec0547-984b-4e59-8217-69a602ba114d' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '8afcead5-051f-45d9-a0ae-888bd82b59ab' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '0a3bd95e-3a77-489a-a5b1-28aab9c28ce9' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'fb63f6ef-a302-4416-b75a-76d081597e55' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '5e3fa411-cca6-4814-93b2-b40ad66e8155' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'a4f70e1b-3d37-4c08-bfc8-cb3d2c0db1f0' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'd3e2e211-e7db-4f96-8f18-7a3f150ab9e7' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '409850dd-4e65-4f47-a6c7-873bb2175c2c' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '4574ade7-ce3f-404f-8ec8-ab9e20441221' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '4c425383-c958-4698-b52b-beae65e7e0d8' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '01cfd88a-00b8-4851-8f55-e9aac0331841' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'e23225a3-28dd-459b-9db9-c0d397e324b0' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '73fff5d8-52f3-4769-9ec7-8f200581ca93' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'cc0e5f9a-b047-449f-8927-c1aa206ca09d' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '0818298b-6d7d-4314-8cb6-9326d8a26049' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'dd9d7a50-8832-40f6-9c44-12a4f2901548' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '8dcfb0f8-f90f-496c-80f0-727c5463b04a' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '3cd1c428-eb29-4534-bbf0-f2c814719fdf' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'abf8f6d9-9d4a-4ff4-81e8-7481e02f9a3c' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '835da581-10e4-4428-b8c6-47db644e9368' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '4794d7cf-c110-4444-be64-392e94ad8c8f' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'c1fb1677-e233-4520-9c6f-1d75387fe3fd' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'a034e536-255c-42c4-a112-ef0c35d545a3' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '2cf9cf27-8613-4bb1-aa16-a4e1564bc2ac' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '0dcf85c8-1a39-4bca-9224-5066eebcbcce' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'cdecef4b-4d33-4d14-a14c-4581867a6f92' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '093063bd-161f-4b41-aaab-411e89733c82' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'bd694ac4-2222-4254-80e3-a1ba4da4937f' ; 	

-- CPA Home Records with Start & End dates are null and other CPA Home count > 0
-- Before
select *
from (
select pl.alternateid,
	pc.altproviderid,
	pc.placementcpahomeid,
	pc.entrydt,
	pc.exitdt,
	pl.startdatetime,
	pl.enddatetime
	,(select count(*)
		from placementcpahomes pc1
	 where pc1.placementid = pc.placementid 	
	 	and pc1.activeflag = 1
	 	and pc1.placementcpahomeid  <> pc.placementcpahomeid 
	 	and pc1.entrydt is not null
	 ) as Other_CPA_Home	
from placementcpahomes pc,
	placement pl
where pc.placementid = pl.placementid 
	and pc.activeflag = 1
	and pl.activeflag = 1
	and pc.entrydt is null
	and pc.exitdt is null
	and pl.enddatetime is not null
	and COALESCE(pl.isvoided, 0) <> 1 
	and pc.altproviderid is not null 
) where Other_CPA_Home > 0;
	
-- Delete	
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'b587d87c-8e1d-4450-9208-d32482b81a6f' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'b41c686e-2ebf-4221-a043-b5bd50fa6822' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '92585dd8-aa25-4233-91ab-0d1921b627fe' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'd3e60098-03be-4dd9-a069-ed81efe77503' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'dfb9aded-9d36-4bd1-84c2-5210c5faae39' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '815bb4cf-e893-40a6-a9f1-728260a2faa7' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'fc028c15-3dfc-4b0d-af70-d02f0cae0412' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '10ac3457-1626-4620-980f-8a1e3db016d0' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '008c1628-78f0-4a6d-922c-9b7147c28453' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '0860ed5e-9e75-41f4-ab80-50c42a1e470b' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '575a5c85-2a7e-4982-bbd6-0de9bb43dc62' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'bacfec7d-7032-42f5-83ee-f9b300ea2c06' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'f8f545e4-3c45-419b-a027-311002460909' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '727ec718-e6f5-4158-a204-6c464b41e4ee' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '5d837aa3-763a-4871-a893-ce8bc79ac11d' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '7feaa2bc-ed0f-4907-962a-ec6600747d64' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'dab0eb0e-6b94-49fd-bc2f-76cdd88c7f42' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = 'e0d78f14-d033-4b0a-ba1e-574f2c357e82' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '5ca5cbbf-5804-4d61-bea6-1db12125e67c' ;
update placementcpahomes set activeflag = 0 , updatets = now(), updateuserid = 'CIDM-3657'  where placementcpahomeid = '8cbffdf0-3c47-4408-8f32-3677fbdc42e2' ;	

-- CPA Home Records with Start & End dates are null and other CPA Home count = 0
select *
from (   
select pl.alternateid as placement_id,
	pc.altproviderid as CPA_Home_provider_ID,
	pc.placementcpahomeid,
	pc.entrydt::date as CPA_Home_Entry_date,
	pc.exitdt as CPA_Home_Exit_date,
	pl.startdatetime::date as Placement_entry_date,
	pl.enddatetime as Placement_exit_date,
	pl.endtime as Placement_exit_time 
	,(select count(*)
		from placementcpahomes pc1
	 where pc1.placementid = pc.placementid 	
	 	and pc1.activeflag = 1
	 	and pc1.placementcpahomeid  <> pc.placementcpahomeid 
	 	and pc1.entrydt is not null
	 ) as Other_CPA_Home	
from placementcpahomes pc,
	placement pl
where pc.placementid = pl.placementid 
	and pc.activeflag = 1
	and pl.activeflag = 1
	and pc.entrydt is null
	and pc.exitdt is null
	and pl.enddatetime is not null
	and COALESCE(pl.isvoided, 0) <> 1 
	and pc.altproviderid is not null 
) 
where Other_CPA_Home = 0 ;

-- Update
update placementcpahomes  set entrydt = '2020-05-15', exitdt = '2021-02-13 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 09:00' where placementcpahomeid = '6c85d66c-512e-4beb-acd2-a7fb623c3e5f' ;
update placementcpahomes  set entrydt = '2020-06-12', exitdt = '2020-11-18 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 16:15' where placementcpahomeid = '900e00df-e145-4a78-9fcf-6681829add98' ;
update placementcpahomes  set entrydt = '2020-08-25', exitdt = '2020-09-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 17:30' where placementcpahomeid = '47ed0f4d-3959-40c4-808a-2df1cd3643ea' ;
update placementcpahomes  set entrydt = '2020-08-20', exitdt = '2020-10-06 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 10:00' where placementcpahomeid = '31f84115-ddac-480a-8d03-5e6c7bb02743' ;
update placementcpahomes  set entrydt = '2020-09-17', exitdt = '2020-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:34' where placementcpahomeid = '6c37efe3-0e36-42de-8291-095032269679' ;
update placementcpahomes  set entrydt = '2020-09-17', exitdt = '2020-10-30 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 15:30' where placementcpahomeid = '611fdedb-5ab3-45f0-bb1e-2c624674604e' ;
update placementcpahomes  set entrydt = '2020-09-15', exitdt = '2020-11-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 12:00' where placementcpahomeid = '399515e6-c85f-4b44-9373-a0a99d5c2f7a' ;
update placementcpahomes  set entrydt = '2020-12-09', exitdt = '2021-03-12 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 11:34' where placementcpahomeid = 'aecc34cd-4761-4587-ac5b-e0804671d77a' ;
update placementcpahomes  set entrydt = '2020-11-06', exitdt = '2020-12-09 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 18:00' where placementcpahomeid = '3073dea2-f644-4b8d-bbc5-7741a8ffb71f' ;
update placementcpahomes  set entrydt = '2020-04-15', exitdt = '2021-04-01 00:00:00', updatets = now(), updateuserid = 'CIDM-3657' , exittm = '1970-01-01 13:45' where placementcpahomeid = '5691dd44-67b8-406c-b567-fa7f0431dc0f' ;
