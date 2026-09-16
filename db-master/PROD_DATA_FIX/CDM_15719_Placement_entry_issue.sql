/*
   Issue Description: CDM-15719
   Category/ Module  :  Living Arrangement  
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   Status of the code fix if already submitted and expected prod fix date: 
*/


update placement
set updatedby = 'CDM-15719', updatedon = now(), activeflag = 0
where placementid in ('c169b9d3-48b2-43e6-a031-708bf4c1c0a5',
'eb97b6fa-b334-4893-a32f-440d474b692a', 
'8a22456b-5ba1-4cf1-abd9-f2deb15aae39', 
'76218889-7763-4dc3-8c29-c19006e967ff', 
'2ab04b5f-400b-4aba-8565-163d18ff0203', 
'293f9a37-1ef0-4fb6-ac33-4bfba124069d');

update livingarrangement
set updatedby = 'CDM-15719', updatedon = now(), activeflag = 0
where placementid in ('c169b9d3-48b2-43e6-a031-708bf4c1c0a5',
'eb97b6fa-b334-4893-a32f-440d474b692a', 
'8a22456b-5ba1-4cf1-abd9-f2deb15aae39', 
'76218889-7763-4dc3-8c29-c19006e967ff', 
'2ab04b5f-400b-4aba-8565-163d18ff0203', 
'293f9a37-1ef0-4fb6-ac33-4bfba124069d');