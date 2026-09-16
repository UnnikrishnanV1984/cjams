import { Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import jsPDF from 'jspdf';
import { PaginationRequest } from '../../../../@core/entities/common.entities';
import { AuthService } from '../../../../@core/services/auth.service';
import { DataStoreService } from '../../../../@core/services/data-store.service';
import { GenericService } from '../../../../@core/services/generic.service';
import { CaseWorkerUrlConfig } from '../../case-worker-url.config';
import { CASE_STORE_CONSTANTS } from '../../_entities/caseworker.data.constants';
import { Html2CanvasService } from '../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

const APPOINTMENT_COMPLETED = 'Completed';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'case-worker-document-creator',
    templateUrl: './case-worker-document-creator.component.html',
    styleUrls: ['./case-worker-document-creator.component.scss'],
    standalone: false
})
export class CaseWorkerDocumentCreatorComponent implements OnInit {
    // tslint:disable-next-line:no-input-rename
    persons: any[] = [];
    general: any;
    id!: string;
    daNumber!: string;
    preIntakeDisposition: any;
    documentsToDownload: string[] = [];
    supComments = '';
    reason = '';
    comments = '';
    addedPersons: any[] = [];
    youth: any;
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
    youthId!: string;
    victimName!: string;
    victimAddress!: string;
    victimPhoneNumber!: string;
    currentDateString: any;
    mother?: { name: string; phoneNumber: string; address: string; };
    father?: { name: string; phoneNumber: string; address: string; };
    guardian?: { name: string; phoneNumber: string; address: string; };
    appointmentHeld = false;
    appointmentNotes = '';
    offenseString!: string;
    parentOrGaurdianAddress!: string | undefined | null;
    parentOrGaurdianName!: string;

    petitionID!: string;
    evalFields: any;
    appointments: any[] = [];

    fatherObj: any;
    motherObj: any;
    guardianObj: any;
    youthLastSchool: any;
    appointment: any;

    courtDetails: any;
    youthAge!: number | null;

    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    private html2canvas:Html2CanvasService;
    private _authService: AuthService;

    constructor(private route: ActivatedRoute, private readonly injector : Injector, private _dataStoreService: DataStoreService, private _reportSummaryService: GenericService<any>) {
        this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);
        this._authService = this.injector.get<AuthService>(AuthService);
    }

    ngOnInit() {
        const currentDate = new Date();
        currentDate.setDate(currentDate.getDate() + 10);
        this.finalNotificationDate = currentDate;
        this.loggedInUser = this._authService.getCurrentUser().user.userprofile.displayname;

        this._dataStoreService.currentStore.subscribe((store) => {
            if (store['documentsToDownload']) {
                this.documentsToDownload = store['documentsToDownload'];
                this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
                this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
                this.listReportSummary();
            }
            if (store['dsdsActionsSummary']) {
                const actionSummary = store['dsdsActionsSummary'];
                const jsonData = actionSummary['intake_jsondata'];
                if (jsonData) {
                    this.processIntakeData(jsonData);
                }
            }
        });
    }

    private listReportSummary() {
        this._reportSummaryService.getSingle(new PaginationRequest({}), CaseWorkerUrlConfig.EndPoint.DSDSAction.ReportSummary.ReportSummary + this.id).subscribe((result) => {
            this.offenseString = result.intakeservicerequestevaluation.allegations;
        });
    }

    processIntakeData(intakeData: any) {
        if (intakeData) {
            this.persons = intakeData.persons;
            this.evalFields = intakeData.evaluationFields;
            this.general = intakeData.General;
            this.courtDetails = intakeData.courtDetails;
            if (intakeData.appointments && intakeData.appointments.length > 0) {
                this.appointments = intakeData.appointments;
                this.preintakeAppointmentDate = intakeData.appointments[0].appointmentDate;

                this.appointment = this.appointments[0];
            }

            this.resetInputs();
            this.processInputs();
        }
    }

    resetInputs() {
        this.mother = { name: '', address: '', phoneNumber: '' };
        this.father = { name: '', address: '', phoneNumber: '' };
        this.guardian = { name: '', address: '', phoneNumber: '' };
    }

    processInputs() {
        const mother = this.getPersonByRelation('mother');
        const father = this.getPersonByRelation('father');
        const guardian = this.getPersonByRelation('guardian');
        this.currentDateString = this.currentDate();

        const person = this.getPerson('Youth');
        if (person) {
            this.youthName = person.fullName;
            this.youthDob = person.Dob;
            this.youthPhoneNumber = person.primaryPhoneNumber;
         
            this.youthId = person.Pid.substr(person.Pid.length - 8).toUpperCase();
        }

        if (mother && this.mother) {
            this.mother.name = mother.fullName;
            this.mother.address = this.getPersonAddress(mother);
            this.mother.phoneNumber = mother.primaryPhoneNumber;
        }
        if (father && this.father) {
            this.father.name = father.fullName;
            this.father.address = this.getPersonAddress(father);
            this.father.phoneNumber = father.primaryPhoneNumber;
        }
        if (guardian && this.guardian) {
            this.guardian.name = guardian.fullName;
            this.guardian.address = this.getPersonAddress(guardian);
            this.guardian.phoneNumber = guardian.primaryPhoneNumber;
        }
        if (this.appointments && this.appointments.length > 0) {
            this.preintakeAppointmentDate = this.appointments[0].appointmentDate;
            this.appointmentHeld = this.appointments[0].status === APPOINTMENT_COMPLETED;
            this.appointmentNotes = this.appointments[0].notes;
        }
        const victim = this.getPerson('Victim');
        if (victim) {
            this.victimName = victim.fullName;
            this.victimAddress = this.getPersonAddress(victim);
            this.victimPhoneNumber = victim.primaryPhoneNumber;
        }

        this.parentOrGaurdianAddress = this.getParentOrGaurdianAddress();
        this.parentOrGaurdianName = this.getParentOrGaurdianName();

        this.youth = this.getPerson('Youth');
        this.youthAge = this.getYouthAge();

        this.fatherObj = this.getPersonByRelation('father');
        this.motherObj = this.getPersonByRelation('mother');
        this.guardianObj = this.getPersonByRelation('guardian');

        if (this.youth) {
            const youthSchools = this.youth.school;
            if (youthSchools && youthSchools.length > 0) {
                this.youthLastSchool = youthSchools[youthSchools.length - 1];
            }
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
        const addressInfo = person.personAddressInput[0];
        if (addressInfo) {
            return `${addressInfo.address}, ${addressInfo.address2}<br>
                    ${addressInfo.city}, ${addressInfo.county}<br>
                    ${addressInfo.zipcode}`;
        }
        return `<br><br><br>`;
    }


    generateOffenseString(): string {
        if (this.evalFields && this.evalFields.allegedoffense && this.offenses) {
            const selectedIDs = this.evalFields.allegedoffense.map((offense: any) => offense.allegationid);

            return this.offenses
                .filter((offense) => {
                    return selectedIDs.indexOf(offense.allegationid) !== -1;
                })
                .map((offense) => offense.name)
                .toString()
                .replace(',', ', ');
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

    getPerson(Role: string): any {
        if (this.persons) {
            return this.persons.find((person) => person.Role === Role);
        }
        return null;
    }

    getPersonByRelation(Relationship: string): any {
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
        }
    }

    getParentOrGaurdianAddress() {
        const relations = ['mother', 'father', 'guardian'];
        const person = relations.map(relation => this.getPersonByRelation(relation)).find(Boolean);

        if (!person) return;

        const addressInfo = person.personAddressInput[0];
        const address = addressInfo
            ? `${addressInfo.address}, ${addressInfo.address2 || ''}<br>
               ${addressInfo.city}, ${addressInfo.county}<br>
               ${addressInfo.zipcode}`
            : `<br><br><br>`;

        return `${this.getParentOrGaurdianName()}<br>${address}`;
    }


    getYouthName() {
        const person = this.getPerson('Youth');
        if (person) {
            return person.fullName;
        }
        return '';
    }
    getYouth(key: any) {
        const person = this.getPerson('Youth');
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
    collectivePdfCreator() {
        this.downloadInProgress = true;
        const pdfList = this.documentsToDownload;
        pdfList.forEach((element) => {
            this.downloadCasePdf(element);
        });
    }
    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages = source.getElementsByClassName('pdf-page') ?? [];
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
        this.pdfFiles.forEach((pdfFile) => {
            const doc: any = new jsPDF();
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG', 0, 0);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
        (<any>$('#docu-View')).modal('hide');
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
