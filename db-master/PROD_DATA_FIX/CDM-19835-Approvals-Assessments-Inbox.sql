/*
   Issue Description: CDM-19835
   Category/ Module : Approval Inbox - Assessments
   
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/

select 	activeflag, servicerequestnumber, routingstatustypeid, * 
from 	routing 
where 	servicerequestnumber in ('202107006511', '202106006283','3188953','3201847','3243830','3300079','3304897','3308013') 
		and eventcode = 'ASST' and tosecurityusersid = '2f784d3d-00a5-4798-9f36-fb5e0cb8d68b' and activeflag = 1 and routingstatustypeid = 15;


update 	routing
set 	activeflag = 0,
		updatedby = 'CDM-19835',
		updatedon = now()
where 	activeflag = 1 and 
		routingid in ('4d0628e3-772f-4754-85f5-5c3583b48d22', 'd5ec17a3-ef7d-4d21-a4e3-f50c61334d48', '9c3f3ac9-878a-4b23-8734-6ba330b9466e', 
					'afd57b7a-6a91-40be-8fd6-5ec3451dce0e',
					'73ebc472-5454-48b0-914e-74080c51c06f',
					'2bf5a15e-1a18-4fab-9755-8078cb744a6a',
					'4fb55db6-21c7-4650-8740-7ff96e12d1ad',
					'c0dd6732-999a-476b-beb9-d74e508bfb10',
					'dc6a88da-7e33-42cc-a3ce-120c58682186',
					'93ac1f63-6f8c-433e-b6c1-5962e12e741c',
					'a686b4f3-b4bd-4e27-9793-642af5f99f90');
