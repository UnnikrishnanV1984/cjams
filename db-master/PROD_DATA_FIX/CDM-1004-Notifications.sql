	update cjams.usernotification 
	set activeflag = 0 
	where securityusersid in ('6e0584d0-90b0-4d46-87ce-004e6b740419') 
	and activeflag = 1 and updatedby in ('89b8a123-0f97-4a11-976e-b2e20e5fe461',
	'930b0c8a-4aca-4420-8fad-07ab4945ffcd',
	'0f902b1c-bf32-4bfa-a223-c60727979297');
