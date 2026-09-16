import { Component, OnInit, Input } from '@angular/core';

import { InvolvedPerson, PreIntakeDisposition } from '../../_entities/newintakeModel';
import { General, EvaluationFields, IntakeAppointment, CourtDetails } from '../../_entities/newintakeSaveModel';
import { Subject } from 'rxjs';
import jsPDF from 'jspdf';
import { AuthService, DataStoreService } from '../../../../../@core/services';
import { School } from '../../../../case-worker/_entities/caseworker.data.model';
import { IntakeStoreConstants } from '../../my-newintake.constants';
import { DynamicObject } from '../../../../../@core/entities/common.entities';
import { Html2CanvasService } from '../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
const APPOINTMENT_COMPLETED = 'Completed';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'notice-preintake-letter',
    templateUrl: './notice-preintake-letter.component.html',
    styleUrls: ['./notice-preintake-letter.component.scss'],
    standalone: false
})
export class NoticePreintakeLetterComponent implements OnInit {
    // tslint:disable-next-line:no-input-rename

    @Input() persons!: InvolvedPerson[];
    @Input() general!: General | null;
    // @Input() dispositionOutPut$ = new Subject<DispostionOutput[]>();
    // @Input() evalFieldsOutputSubject$ = new Subject<EvaluationFields>();
    @Input() generatedDocuments$ = new Subject<string[]>();
    @Input() preIntakeDisposition!: PreIntakeDisposition;
    // @Input() offenceCategoriesInputSubject$ = new Subject<any[]>();
    @Input() evalFields!: EvaluationFields | null |undefined;
    // @Input() preIntakedispositionPost$ = new Subject<PreIntakeDisposition>();
    @Input() appointments: IntakeAppointment[] = [];
    @Input() courtDetails!: CourtDetails | null |undefined;
    appointment!: IntakeAppointment;
    documentsToDownload: string[] = [];
    supComments = '';
    reason = '';
    comments = '';
    addedPersons: InvolvedPerson[] = [];
    youth!: InvolvedPerson | undefined | null;
    fatherObj!: InvolvedPerson | undefined | null;
    motherObj!: InvolvedPerson | undefined | null;
    guardianObj!: InvolvedPerson | undefined | null;
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
    mother!: { name: string, phoneNumber: string, address: string } | null |undefined;
    father!: { name: string, phoneNumber: string, address: string } | null |undefined;
    guardian!: { name: string, phoneNumber: string, address: string }| null |undefined;
    appointmentHeld = false;
    appointmentNotes = '';
    offenseString!: string;
    parentOrGaurdianAddress!: string | null;
    parentOrGaurdianName!: string | null;
    youthLastSchool!: School | null;
    currentdate = new Date();
    victims: InvolvedPerson[] = [];
    caseNumber!: string;
    createdCase: any;
    complaints: any;

    petitionID!: string;
    youthAge!: number | null;
    reporteddate = new Date();
    reportername = '';
    reporteraddress = '';
    reporteraddress2 = '';
    reporteremail = 'N/A';
    screenername = '';
    screenerphonenumber = '(521)452-1412';
    screeneraddress1 = '1510 Guilford Avenue';
    screeneraddress2 = 'Baltimore, Maryland 21202';
    supervisorphonenumber = '(521)452-1456';
    supervisorname = '';

    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    private store: DynamicObject;
    parrentAddress: any;
    constructor(private _authService: AuthService, private _store: DataStoreService,private html2canvas:Html2CanvasService) {
        this.store = this._store.getCurrentStore();
    }

    ngOnInit() {
        this.loggedInUser = this._authService.getCurrentUser().user.userprofile.displayname;
        this.persons = this.store[IntakeStoreConstants.addedPersons];
        this.general = this.store[IntakeStoreConstants.general];
        this.reportername = this.store.addNarrative.Firstname +' '+ this.store.addNarrative.Lastname;
        this.reporteraddress = this.store.addNarrative.requesteraddress1 +','+  this.store.addNarrative.requesteraddress2;
        this.reporteraddress2 = this.store.addNarrative.requestercity  +','+this.store.addNarrative.requesterstate +','+ this.store.addNarrative.ZipCode;


        const currentDate = new Date();
       currentDate.setDate(currentDate.getDate() + 10);
        this.finalNotificationDate = currentDate;
        // this.dispositionOutPut$.subscribe(data =>
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
        }// );
        // this.generatedDocuments$.subscribe(data =>
        // {
            const generatedDocuments = this.store[IntakeStoreConstants.generatedDocumentDownloadKey];
            if (generatedDocuments) {
                this.documentsToDownload = generatedDocuments;
                this.resetInputs();
                this.processInputs();
                const elmnt: any = document.getElementById('doc-gen');
                elmnt.scrollIntoView();

            }
        //  }
        // );

        // this.evalFieldsOutputSubject$.subscribe(data =>
        {

            const evalFields = this.store[IntakeStoreConstants.evalFields];
            if (evalFields && evalFields.length) {
                this.complaintID = evalFields[0].complaintid;
                this.complaintReceiveDate = evalFields[0].complaintreceiveddate;
            // ©    // this.selectedAllegedOffenseIDs = data.allegedoffense;
                this.allegedOffenseDate = evalFields[0].allegedoffensedate;
            }
        }
    }

    resetInputs() {
        this.mother = { name: '', address: '', phoneNumber: '' };
        this.father = { name: '', address: '', phoneNumber: '' };
        this.guardian = { name: '', address: '', phoneNumber: '' };
    }

    processInputs() {
        this.createdCase = this.store[IntakeStoreConstants.createdCases];
        if (this.createdCase && this.createdCase.length) {
            this.caseNumber = this.returnCaseNumberFn();
        }
        this.complaints = this.store[IntakeStoreConstants.evalFields];

        this.currentDateString = this.currentDate();
        this.formatFamilyDetailsFn();

        this.offenseString = this.generateOffenseString();
        this.parentOrGaurdianAddress = this.getParentOrGaurdianAddress();
        this.parentOrGaurdianName = this.getParentOrGaurdianName();

        this.youth = this.getPerson('Youth');
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

    private formatFamilyDetailsFn() {
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
            if(this.mother){
            this.mother.name = mother.fullName;
            this.mother.address = this.getPersonAddress(mother);
            this.mother.phoneNumber = mother.primaryPhoneNumber;
            }
        }
        if (father) {
            if(this.father){
            this.father.name = father.fullName;
            this.father.address = this.getPersonAddress(father);
            this.father.phoneNumber = father.primaryPhoneNumber;
            }
        }
        if (guardian) {
            if(this.guardian){
            this.guardian.name = guardian.fullName;
            this.guardian.address = this.getPersonAddress(guardian);
            this.guardian.phoneNumber = guardian.primaryPhoneNumber;
        }
        }
        if (this.appointments && this.appointments.length > 0) {
            this.preintakeAppointmentDate = this.appointments[0].appointmentDate;
            this.appointmentHeld = (this.appointments[0].status === APPOINTMENT_COMPLETED);
            this.appointmentNotes = this.appointments[0].notes;

            this.appointment = this.appointments[0];
        }
        const victim = this.getPerson('Victim');
        if (victim) {
            this.victimName = victim.fullName;
            this.victimAddress = this.getPersonAddress(victim);
            this.victimPhoneNumber = victim.primaryPhoneNumber;

        }
    }

    private returnCaseNumberFn(): string {
        return (this.createdCase[0].caseID) ? this.createdCase[0].caseID : this.createdCase[0].ServiceRequestNumber;
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
        const personAddressInput = person.personAddressInput[0] ? `${person.personAddressInput[0].address1}, ${person.personAddressInput[0].Address2}<br>
        ${person.personAddressInput[0].city}, ${person.personAddressInput[0].county}<br>
        ${person.personAddressInput[0].zipcode}` : `<br><br><br>`;
        return `${personAddressInput}`;
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
            const personAddressInput = mother.personAddressInput[0] ? this.returnPersonAddInfoFn(mother) : `<br><br><br>`;
            
            return `${this.getParentOrGaurdianName()}<br>
                    ${personAddressInput}`;
        } else if (father) {
            const personAddressInput = father.personAddressInput[0] ? this.returnPersonAddInfoFn(father): `<br><br><br>`;

            return `${this.getParentOrGaurdianName()}<br>
                    ${personAddressInput}`;
        } else if (guardian) {
            const personAddressInput = guardian.personAddressInput[0] ? this.returnPersonAddInfoFn(guardian) : `<br><br><br>`;
            
            return `${this.getParentOrGaurdianName()}<br>
                    ${personAddressInput}`;
        } else {
            return null;
        }
    }

    private returnPersonAddInfoFn(info: InvolvedPerson) {
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
        const RecivedDate = this.general?.RecivedDate ? new Date(this.general?.RecivedDate): null;
        if(RecivedDate){
        return RecivedDate.setDate(RecivedDate.getDate() + 7);
        }
        else {
            return ''
        }
    }

    currentDate() {
        return new Date();
    }
    collectivePdfCreator() {
        this.downloadInProgress = true;
        const pdfList = this.documentsToDownload;
        pdfList.forEach((element) => {
            this.downloadCasePdf(element);
        });
    }
    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages = source.getElementsByClassName('pdf-page');
        let pageImages: any = [];
        for (let i = 0; i < pages.length; i++) {
            const pageName = pages.item(i).getAttribute('data-page-name');
            const isPageEnd = pages.item(i).getAttribute('data-page-end');
            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
                if (isPageEnd === 'true') {
                    this.pdfFiles.push({ fileName: pageName, images: pageImages });
                    pageImages = [];
                }
            });
        }
        this.convertImageToPdf();
    }

    convertImageToPdf() {
        var doc: any =null;

        this.pdfFiles.forEach((pdfFile) => {

          doc = new jsPDF();
            var width = doc.internal['pageSize'].getWidth()-10;
            var height = doc.internal['pageSize'].getHeight()-10;
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG',3,5,width,height);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
       // (<any>$('#docu-View')).modal('hide');
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

}
