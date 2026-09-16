export class Kinship {
    kinshipcareid?: string;
    intakeserviceid!: string;
	primaryisractorid!: string;
	secondaryisractorid!: string;
	acceptcharacteristics!: string;
	cpsclearance!: string;
	cjsinfo!: string;
	dhhreport!: string;
	isreceiveddisciplinepolicy!: string;
    isapproveddisciplinepolicy!: string;
    checklist!: Checklist[];
    documents!: Document[];
}
export class Checklist {
    amtaskid!: string;
}

export class Document {
    documentpropertiesid!: string;
}
export class KinshipList {
    routinginfo!: RoutingInfo[];
    kinshipcarelist!: KinshipcareList[];
}
export class RoutingInfo {
    status!: string;
    remarks!: string;
    fromsecurityusersid!: string;
    fromusename!: string;
    tosecurityusersid!: string;
    tousername!: string;
    comments!: string;
}
export class KinshipcareList {
    kinshipcareid?: string;
    intakeserviceid!: string;
	primaryisractorid!: string;
	secondaryisractorid!: string;
	acceptcharacteristics!: string;
	cpsclearance!: string;
	cjsinfo!: string;
	dhhreport!: string;
	isreceiveddisciplinepolicy!: string;
    isapproveddisciplinepolicy!: string;
    kinshipcaredocuments!: KinshipcareDocument[];
    kinshipcarechecklist!: KinshipcareChecklist[];
    activeflag?: number;
}

export class KinshipcareChecklist{
    kinshipcarechecklistid!: string;
	checklistid!: string;
	kinshipcareid!: string;
}

export class KinshipcareDocument{
    kinshipcaredocumentsid!: string;
    documentpropertiesid!: string;
    kinshipcareid!: string;
}

