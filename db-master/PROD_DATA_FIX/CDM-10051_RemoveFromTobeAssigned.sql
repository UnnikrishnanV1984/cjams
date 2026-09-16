-- CDM-10051 - Remove cases from To be assigned tab

update routing set activeflag =0 where routingid in ('081cddde-7168-4e50-a6fe-61bf65707a04','56d92fea-8d83-4a97-9c84-9bd1673d76dc',,'5d84e38b-c516-4a0e-86f1-b631ce968074') and activeflag =1;
