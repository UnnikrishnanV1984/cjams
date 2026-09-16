ALTER TABLE userprofileaddress
  DROP CONSTRAINT fk_userprofileaddress_userprofile;

ALTER TABLE userprofilephonenumber
  DROP CONSTRAINT fk_userprofilephonenumber_userprofile;
  
update userprofileaddress set securityusersid = '00000000-0000-0000-0000-000000000000' where securityusersid = '89c9c878-99ae-407f-ab39-978c55fc2f89';
update userprofilephonenumber set securityusersid = '00000000-0000-0000-0000-000000000000' where securityusersid = '89c9c878-99ae-407f-ab39-978c55fc2f89';
update userprofile set securityusersid = '00000000-0000-0000-0000-000000000000' where securityusersid = '89c9c878-99ae-407f-ab39-978c55fc2f89';
update muser set securityusersid = '00000000-0000-0000-0000-000000000000' where securityusersid = '89c9c878-99ae-407f-ab39-978c55fc2f89';


ALTER TABLE userprofileaddress
  ADD CONSTRAINT fk_userprofileaddress_userprofile FOREIGN KEY (securityusersid)
      REFERENCES userprofile (securityusersid);

ALTER TABLE userprofilephonenumber
ADD CONSTRAINT fk_userprofilephonenumber_userprofile FOREIGN KEY (securityusersid)
      REFERENCES userprofile (securityusersid);
	  

alter table tprrecommendation alter column remarks type character varying(5000);
alter table tprdetails alter column reason type character varying(5000);
alter table tprrecommendation add column fk_id character varying(12);
alter table adoptionemotionaldetails add column childimportance character varying(5000);
alter table intakeservicerequestpetition alter column intakeservicerequestid drop not null;
alter table intakeservicerequestcourtaction alter column intakeservicerequestid drop not null;
alter table intakeservreqcourtorder alter column intakeserviceid drop not null;
alter table intakeservreqchildremoval alter column removaladd1 type character varying(500);
alter table intakeservreqchildremoval alter column primarycaregiveradd type character varying(500);



