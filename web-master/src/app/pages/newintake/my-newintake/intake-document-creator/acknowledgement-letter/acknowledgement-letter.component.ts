import { Component, OnInit, Input, Injector } from '@angular/core';

import { InvolvedPerson, PreIntakeDisposition } from '../../_entities/newintakeModel';
import { General, EvaluationFields, IntakeAppointment, CourtDetails } from '../../_entities/newintakeSaveModel';
import { Subject } from 'rxjs';
import jsPDF from 'jspdf';
import _ from 'lodash';
import { HttpService } from '../../../../../@core/services/http.service';
import { AuthService, DataStoreService, AlertService } from '../../../../../@core/services';
import { School } from '../../../../case-worker/_entities/caseworker.data.model';
import { IntakeStoreConstants } from '../../my-newintake.constants';
import { DynamicObject } from '../../../../../@core/entities/common.entities';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { Html2CanvasService } from '../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
const APPOINTMENT_COMPLETED = 'Completed';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'acknowledgement-letter',
    templateUrl: './acknowledgement-letter.component.html',
    styleUrls: ['./acknowledgement-letter.component.scss'],
    standalone: false
})
export class AcknowledgementLetterComponent implements OnInit {
    // tslint:disable-next-line:no-input-rename

    @Input() persons!: InvolvedPerson[];
    @Input() general!: General;
    // @Input() dispositionOutPut$ = new Subject<DispostionOutput[]>();
    // @Input() evalFieldsOutputSubject$ = new Subject<EvaluationFields>();
    @Input() generatedDocuments$ = new Subject<string[]>();
    @Input() preIntakeDisposition!: PreIntakeDisposition;
    // @Input() offenceCategoriesInputSubject$ = new Subject<any[]>();
    @Input() evalFields!: EvaluationFields;
    // @Input() preIntakedispositionPost$ = new Subject<PreIntakeDisposition>();
    @Input() appointments: IntakeAppointment[] = [];
    @Input() courtDetails!: CourtDetails;
    appointment!: IntakeAppointment;
    casehead!: InvolvedPerson;
    listOfChildrenNames!: string;
    documentsToDownload: string[] = [];
    supComments = '';
    reason = '';
    comments = '';
    addedPersons: InvolvedPerson[] = [];
    youth!: InvolvedPerson | null | undefined;
    fatherObj!: InvolvedPerson | null | undefined;
    motherObj!: InvolvedPerson | null | undefined;
    guardianObj!: InvolvedPerson | null | undefined;
    downloadInProgress!: boolean;
    complaintID!: string;
    complaintReceiveDate!: string;
    selectedAllegedOffenseIDs: any[] = [];
    allegedOffenseDate!: string;
    allAllegedOffense!: string;
    offenses: any[] = [];
    loggedInUser!: string;
    preintakeAppointmentDate!: string;
    finalNotificationDate!: Date;
    youthName!: string;
    youthDob: any;
    youthPhoneNumber!: string;
    youthGender!: string;
    youthId!: string;
    victimName!: string;
    victimAddress!: string;
    victimPhoneNumber!: string;
    currentDateString: any;
    mother!: { name: string, phoneNumber: string, address: string };
    father!: { name: string, phoneNumber: string, address: string };
    guardian!: { name: string, phoneNumber: string, address: string };
    appointmentHeld = false;
    appointmentNotes = '';
    offenseString!: string;
    parentOrGaurdianAddress!: string | null;
    parentOrGaurdianName!: string | null;
    youthLastSchool!: School;
    currentdate = new Date();
    victims: InvolvedPerson[] = [];
    caseNumber!: string;
    createdCase: any;
    complaints: any;
    IsAnonymousReporter!: boolean;
    petitionID!: string;
    youthAge!: number | null;
    reporteddate = new Date();
    reportername = '';
    reporteraddress = '';
    reporteraddress2 = '';
    reporteremail = '';
    incidenthappened = '';
    screenername = '';
    screenerphonenumber = '(521)452-1412';
    screeneraddress1 = '';
    screeneraddress2 = '';
    supervisorphonenumber = '';
    supervisorname = '';
    usercounty = '';
    organizationname!: string;
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    private store: DynamicObject;
    supervisorDetails: any;
    intakenumber: any;
    private html2canvas:Html2CanvasService;
    private _store: DataStoreService

    constructor(private _authService: AuthService, private _alertService: AlertService,private readonly injector : Injector,private _http: HttpService) {
        this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);
        this._store = this.injector.get<DataStoreService>(DataStoreService);
        this.store = this._store.getCurrentStore();
    }

    ngOnInit() {
        if (_.has(this.store, 'da_intakenumber')) {
            this.intakenumber = this.store.da_intakenumber;
        }
        else if(_.has(this.store, 'intakenumber')){
            this.intakenumber = this.store.intakenumber;
        }
        this.persons = this.store[IntakeStoreConstants.addedPersons];
        this.general = this.store[IntakeStoreConstants.general];
        this.reporteddate = this.store[IntakeStoreConstants.receivedDate] ? this.store[IntakeStoreConstants.receivedDate] : new Date();
        if (_.has(this.store,'addNarrative')){
            this.hasAddNarrativeFn();
        }
        const currentDate = new Date();
        currentDate.setDate(currentDate.getDate() + 10);
        this.finalNotificationDate = currentDate;
        {
            const disposition = this.store[IntakeStoreConstants.disposition];
            if (disposition && disposition.length > 0) {
                this.supComments = disposition[0].supComments;
                this.reason = disposition[0].reason;
            }

            const persons = this.store[IntakeStoreConstants.addedPersons];
            if (!this.persons && persons) {
                this.persons = persons;
            }
        }
            const generatedDocuments = this.store[IntakeStoreConstants.generatedDocumentDownloadKey];
            if (generatedDocuments) {
                this.documentsToDownload = generatedDocuments;
                this.resetInputs();
                this.processInputs();
                const elmnt: any = document.getElementById('doc-gen');
                elmnt.scrollIntoView();

            }
        {

            const evalFields = this.store[IntakeStoreConstants.evalFields];
            if (evalFields && evalFields.length) {
                this.complaintID = evalFields[0].complaintid;
                this.complaintReceiveDate = evalFields[0].complaintreceiveddate;
                this.allegedOffenseDate = evalFields[0].allegedoffensedate;
            }
        }
        this.supervisorDetails = {};
        this.getSupervisorApprovalInfo();
    }

    private hasAddNarrativeFn() {
        this.IsAnonymousReporter = this.store.addNarrative.IsAnonymousReporter;
        this.reportername = this.returnReporternameFn();
        this.organizationname = this.store.addNarrative.organization ? this.store.addNarrative.organization : '';
        // tslint:disable-next-line: max-line-length
        this.reporteraddress = this.returnReporteraddressFn();
        // tslint:disable-next-line: max-line-length
        this.reporteraddress2 = this.returnReporteraddress2Fn();
        this.incidenthappened = (this.store.addNarrative.offenselocation ? (this.store.addNarrative.offenselocation + '') : '');
        this.reporteremail = this.store.addNarrative.email ? this.store.addNarrative.email : '';
        this.getListOfChildrenNames();
    }

    private returnReporteraddress2Fn(): string {
        return (this.store.addNarrative.requestercity ? (this.store.addNarrative.requestercity + ',') : '') + (this.store.addNarrative.requesterstate ? (this.store.addNarrative.requesterstate + ',') : '') + (this.store.addNarrative.ZipCode ? (this.store.addNarrative.ZipCode + ',') : '');
    }

    private returnReporteraddressFn(): string {
        return (this.store.addNarrative.requesteraddress1 ? (this.store.addNarrative.requesteraddress1 + ',') : '') + (this.store.addNarrative.requesteraddress2 ? this.store.addNarrative.requesteraddress2 : '');
    }

    private returnReporternameFn(): string {
        return (this.store.addNarrative.Firstname ? this.store.addNarrative.Firstname : '') + ' ' + (this.store.addNarrative.Middlename ? this.store.addNarrative.Middlename : '') + ' ' + (this.store.addNarrative.Lastname ? this.store.addNarrative.Lastname : '');
    }

    resetInputs() {
        this.mother = { name: '', address: '', phoneNumber: '' };
        this.father = { name: '', address: '', phoneNumber: '' };
        this.guardian = { name: '', address: '', phoneNumber: '' };
    }

    processInputs() {
        this.createdCase = this.store[IntakeStoreConstants.createdCases];
        if (this.createdCase && this.createdCase.length) {
            this.caseNumber = (this.createdCase[0].caseID) ? this.createdCase[0].caseID : this.createdCase[0].ServiceRequestNumber;
        }
        this.complaints = this.store[IntakeStoreConstants.evalFields];
        this.currentDateString = this.currentDate();
        this.familyDetailsFn();
        const victim = this.getPerson('Victim');
        if (victim) {
            this.victimName = victim.fullName;
            this.victimAddress = this.getPersonAddress(victim);
            this.victimPhoneNumber = victim.primaryPhoneNumber;

        }

        this.offenseString = this.generateOffenseString();
        this.parentOrGaurdianAddress = this.getParentOrGaurdianAddress();
        this.parentOrGaurdianName = this.getParentOrGaurdianName();

        this.youth = this.getPerson('Child');
        this.youthAge = this.getYouthAge();

        this.fatherObj = this.getPersonByRelation('father');
        this.motherObj = this.getPersonByRelation('mother');
        this.guardianObj = this.getPersonByRelation('guardian');

        if(this.persons && this.persons.length>0){
        this.persons.forEach(data => {
            if (data.Role === 'Victim') {
                this.victims.push(data);
            }
        });
    }

        if (this.youth) {
            const youthSchools = this.youth.school;

            if (youthSchools && youthSchools.length > 0) {
                this.youthLastSchool = youthSchools[youthSchools.length - 1];
            }
        }

    }

    private familyDetailsFn() {
        const mother = this.getPersonByRelation('mother');
        const father = this.getPersonByRelation('father');
        const guardian = this.getPersonByRelation('guardian');
        const person = this.getPerson('Youth');
        if (person) {
            this.youthName = person.fullName;
            this.youthDob = person.Dob;
            this.youthPhoneNumber = person.primaryPhoneNumber;
            this.youthGender = person.Gender === 'M' ? 'Male' : 'Female';
            this.youthId = person.cjamspid;
        }


        if (mother) {
            this.mother.name = mother.fullName;
            this.mother.address = this.getPersonAddress(mother);
            this.mother.phoneNumber = mother.primaryPhoneNumber;
        }
        if (father) {
            this.father.name = father.fullName;
            this.father.address = this.getPersonAddress(father);
            this.father.phoneNumber = father.primaryPhoneNumber;
        }
        if (guardian) {
            this.guardian.name = guardian.fullName;
            this.guardian.address = this.getPersonAddress(guardian);
            this.guardian.phoneNumber = guardian.primaryPhoneNumber;
        }
        if (this.appointments && this.appointments.length > 0) {
            this.preintakeAppointmentDate = this.appointments[0].appointmentDate;
            this.appointmentHeld = (this.appointments[0].status === APPOINTMENT_COMPLETED);
            this.appointmentNotes = this.appointments[0].notes;

            this.appointment = this.appointments[0];
        }
    }

    private getYouthAge() {
        if (!this.youth || (this.youth && !this.youth.Dob)) {
            return null;
        }
        const youthDob = new Date(this.youth.Dob);

        const offenceDate = new Date();

        const timeDiff = offenceDate.getTime() - youthDob.getTime();
        const youthAge = new Date(timeDiff); // miliseconds from epoch
        return Math.abs(youthAge.getUTCFullYear() - 1970);

    }

    getPersonAddress(person: any) {
        const personAddressInput = person.personAddressInput[0] ? this.returnPersonAddFn(person) : `<br><br><br>`;
        return `${personAddressInput}`;
    }
    // Assosiated with getPersonAddress method
    private returnPersonAddFn(person: any) {
        return `${person.personAddressInput[0].address1}, ${person.personAddressInput[0].Address2}<br>
        ${person.personAddressInput[0].city}, ${person.personAddressInput[0].county}<br>
        ${person.personAddressInput[0].zipcode}`;
    }

    getCaseHead() {
        if (this.persons) {
            this.persons.forEach(element => {
                if (element.personRole) {
                    const hascasehead = element.personRole.some(
                        item => item.rolekey === 'LG'
                    );
                    if (hascasehead) {
                        element.displayMultipleRole = element.personRole.map(
                            role => role.description
                        );
                        this.casehead = element;
                    }
                }
            });
        }
    }
    generateOffenseString(): string {
        if (this.evalFields && this.evalFields.allegedoffense && this.offenses) {
            const selectedIDs = this.evalFields.allegedoffense.map(offense => offense.allegationid);

            return this.offenses.filter(offense => {
                return selectedIDs.indexOf(offense.allegationid) !== -1;
            }).map(offense => offense.name).toString().replace(',', ', ');
        }

        return '';
    }

    getVictimName() {
        const person = this.getPerson('Victim');
        if (person) {
            return person.fullName;
        }
        return '';
    }

    getPerson(Role: string): InvolvedPerson | null | undefined {
        if (this.persons) {
            return this.persons.find((person) => person.Role === Role);
        }
        return null;
    }

    getPersonByRelation(Relationship: string): InvolvedPerson | null | undefined {
        if (this.persons) {
            return this.persons.find((person) => person.RelationshiptoRA === Relationship);
        }
        return null;
    }

    getParentOrGaurdianName() {
        const father = this.getPersonByRelation('father');
        const mother = this.getPersonByRelation('mother');
        const guardian = this.getPersonByRelation('guardian');

        if (mother) {
            return mother.fullName;
        } else if (father) {
            return father.fullName;
        } else if (guardian) {
            return guardian.fullName;
        } else {
            return null;
        }

    }

    getParentOrGaurdianAddress() {
        const father = this.getPersonByRelation('father');
        const mother = this.getPersonByRelation('mother');
        const guardian = this.getPersonByRelation('guardian');

        if (mother) {
            const personAddressInput = mother.personAddressInput[0] ? this.personAddFn(mother) : `<br><br><br>`;
            return `${this.getParentOrGaurdianName()}<br>
                    ${personAddressInput}`;
        } else if (father) {
            const personAddressInput = father.personAddressInput[0] ? this.personAddFn(father) : `<br><br><br>`;
            return `${this.getParentOrGaurdianName()}<br>
                    ${personAddressInput}`;
        } else if (guardian) {
            const personAddressInput = guardian.personAddressInput[0] ? this.personAddFn(guardian) : `<br><br><br>`;
            return `${this.getParentOrGaurdianName()}<br>
                    ${personAddressInput}`;
        } else {
            return null;
        }
    }

    private personAddFn(info: InvolvedPerson) {
        return `${info.personAddressInput[0].address1}, ${info.personAddressInput[0].Address2}<br>
            ${info.personAddressInput[0].city}, ${info.personAddressInput[0].county}<br>
            ${info.personAddressInput[0].zipcode}`;
    }

    getYouthName() {
        const person = this.getPerson('Youth');
        if (person) {
            return person.fullName;
        }
        return '';
    }
    getYouth(key: any) {
        const person: any = this.getPerson('Youth');
        let result = '';
        if (person) {
            result = person[key] ? person[key] : '-';
        }
        return result;
    }

    getVictimAddress() {
        const person = this.getPerson('Alleged Victim');
        if (person) {
            return person.fullAddress;
        }
        return '';
    }

    getMaltreatorName() {
        const person = this.getPerson('Alleged Maltreator');
        if (person) {
            return person.fullName;
        }
        return '';
    }

    getMaltreatorAddress() {
        const person = this.getPerson('Alleged Maltreator');
        if (person) {
            return person.fullAddress;
        }
        return '';
    }

    getPersonID(role: any) {
        const person = this.getPerson(role);
        if (person && person.Pid) {
            return person.Pid.substr(person.Pid.length - 8).toUpperCase();
        }
        return '';
    }

    appointmentDate() {
        const RecivedDate = new Date(this.general.RecivedDate);
        return RecivedDate.setDate(RecivedDate.getDate() + 7);
    }

    currentDate() {
        return new Date();
    }
    async collectivePdfCreator() {
        this.downloadInProgress = true;
        for (const element of this.documentsToDownload) {
            await this.downloadCasePdf(element);
        }
    }
    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages = source.getElementsByClassName('pdf-page');
        let pageImages: any = [];
        for (let i = 0; i < pages.length; i++) {
            const page = pages.item(i);
            const pageName = pages.item(i).getAttribute('data-page-name');
            const isPageEnd = pages.item(i).getAttribute('data-page-end');
            const canvas = await this.html2canvas.capture(<HTMLElement>page);
            const img = canvas.toDataURL('image/png'); 
            pageImages.push(img);
            if (isPageEnd === 'true') {
                this.pdfFiles.push({ fileName: pageName, images: pageImages });
                pageImages = [];
            }
        }
        this.convertImageToPdf();
    }

    convertImageToPdf() {
        const  doc : any = new jsPDF();
        let fileName = "";
        this.pdfFiles.forEach((pdfFile) => {
            var width = doc.internal['pageSize'].getWidth()-10;
            var height = doc.internal['pageSize'].getHeight()-10;
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG',3,5,width,height);
            });
            fileName = pdfFile.fileName;
            doc.addPage();
        });
        const pageCount = doc.internal.getNumberOfPages();
        doc.deletePage(pageCount)
        doc.save(fileName);
        this.pdfFiles = [];
        this.downloadInProgress = false;
    }

    isNotSelected(key: any) {
        let toHide = true;
        if (this.documentsToDownload) {
            toHide = this.documentsToDownload.indexOf(key) === -1;
        }
        return toHide;
    }

    getListOfChildrenNames() {
        this.listOfChildrenNames = '';
        if (this.persons) {
            const children = this.returnChildrensListFn();

            if (children.length) {
                this.loopListOfChildrenNamesFn(children);
            }
        }
    }

    private loopListOfChildrenNamesFn(children: InvolvedPerson[]) {
        children.forEach((child, index) => {
            if (index === 0) {
                this.listOfChildrenNames = (child.Firstname ? child.Firstname + ' ' : '') + (child.Lastname ? child.Lastname : '');
            } else if (index + 1 === children.length) {
                this.listOfChildrenNames = this.listOfChildrenNames + (child.Firstname ? ' and ' + child.Firstname + ' ' : '') + (child.Lastname ? child.Lastname : '');
            } else {
                this.listOfChildrenNames = this.listOfChildrenNames + (child.Firstname ? ', ' + child.Firstname + ' ' : '') + (child.Lastname ? child.Lastname : '');
            }
        });
    }

    private returnChildrensListFn() {
        return this.persons.filter(person => {
            if (person.personRole && person.personRole.some(
                role => (role.rolekey === 'CHILD' || role.rolekey === 'AV' || role.rolekey === 'OTHERCHILD')
            )) {
                return true;
            }
        });
    }

    getSupervisorApprovalInfo() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._store.getData('iscaseexpunged');
        this._http.post( CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CpsIntakeReport, {
            'intakenumber': this.intakenumber,
            'isExpungementSuperUser': isExpungementSuperUser,
            'iscaseexpunged': iscaseexpunged
        }).subscribe((response) => {
            if(response.data && response.data.getsupervisorapprovaldetails && response.data.getsupervisorapprovaldetails.length){
                this.supervisorDetails = response.data.getsupervisorapprovaldetails[0];}
            });
    }
}
