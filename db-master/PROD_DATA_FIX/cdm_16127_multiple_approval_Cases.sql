/*
   Issue Description: CDM-16127
   Category/ Module  :  case approval
   Root cause: user wants to remove
   Pull request# for code fix: 
   Reason why no related code fix: 
   
*/

update routing 
	set updatedby = 'CDM-16127', updatedon = now(), activeflag = 0
	where objectid in ('293f9a37-1ef0-4fb6-ac33-4bfba124069d', '2ab04b5f-400b-4aba-8565-163d18ff0203', 'c169b9d3-48b2-43e6-a031-708bf4c1c0a5', 'eb97b6fa-b334-4893-a32f-440d474b692a', '8a22456b-5ba1-4cf1-abd9-f2deb15aae39', '76218889-7763-4dc3-8c29-c19006e967ff');