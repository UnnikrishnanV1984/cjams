-- CDM-9314 - Change the reviewer for the case worker

update teammember set supervisorid = '760bbede-3181-44a0-9d99-36a9b86d777d', updatedby = 'CDM-9314', updatedon = now() where teammemberid = 'bf298f67-bfd0-4708-9ece-6153beb19b46' and activeflag = 1;
