update referencevalues set activeflag = 0, teamtypekey = null  
where referencetypeid = 343 and ref_key not in ('ADNRE',
												'ADRE',
												'COCTRADR',
												'CORHADR',
												'DEATHOC',
												'EMANIND',
												'EMANMAR',
												'EMANMIL',
												'GNONREL',
												'GUARDR',
												'REUNIF',
												'RNAWAY',
												'TTONDA');

											
delete from referencevalues where referencetypeid = 343 and ref_key  in ('ADNRE', 'ADRE', 'COCTRADR', 'GUARDR');

INSERT INTO referencevalues (ref_key,referencetypeid,value_text,description,teamtypekey,activeflag,displayorder,insertedby,insertedon,updatedby,updatedon) VALUES
	 ('ADNRE',343,'Adoption Non-relative','Adoption Non-relative','CW',1,1,'CIDM-4292',now(),'CIDM-4292',now()),
	 ('ADRE',343,'Adoption Relative','Adoption Relative','CW',1,1,'CIDM-4292',now(),'CIDM-4292',now()),
	 ('COCTRADR',343,'Court ordered custody to a relative against DSS recommendation','Court ordered custody to a relative against DSS recommendation','CW',1,1,'CIDM-4292',now(),'CIDM-4292',now()),
	 ('GUARDR',343,'Guardianship Relative','Guardianship Relative','CW',1,1,'CIDM-4292',now(),'CIDM-4292',now());
