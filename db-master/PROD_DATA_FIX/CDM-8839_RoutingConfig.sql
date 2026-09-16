insert into routingconfig (eventcode ,targetrolekey ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate ,expirationdate ,sourcerolekey)
   values('FINALDIS','IVESV',1,'CDM-8839',now(),'CDM-8839',now(),now(),null,'FNSFW');
  
  insert into routingconfig (eventcode ,targetrolekey ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate ,expirationdate ,sourcerolekey)
   values('FINALDIS','FNSFS',1,'CDM-8839',now(),'CDM-8839',now(),now(),null,'IVESV');
  
  insert into routingconfig (eventcode ,targetrolekey ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate ,expirationdate ,sourcerolekey)
   values('FINALDIS','IVESV',1,'CDM-8839',now(),'CDM-8839',now(),now(),null,'FNSFS');
  
  insert into routingconfig (eventcode ,targetrolekey ,activeflag ,insertedby ,insertedon ,updatedby ,updatedon ,effectivedate ,expirationdate ,sourcerolekey)
   values('FINALDIS','IVESV',1,'CDM-8839',now(),'CDM-8839',now(),now(),null,'IVESV');