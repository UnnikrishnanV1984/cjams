import { sdmData } from './../../_data/sdm';
import { Component, OnInit, Input, Injector } from '@angular/core';
import {
    InvolvedPerson,
    CpsDocInput,
    SDMDescription,
    Sdm,
    Narrative
} from '../../_entities/newintakeModel';
import _ from 'lodash';
import { HttpService } from '../../../../../@core/services/http.service';
import { ActivatedRoute } from '@angular/router';
import { CommonHttpService, AlertService, AuthService, DataStoreService } from '../../../../../@core/services';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { General, EvaluationFields } from '../../_entities/newintakeSaveModel';
import jsPDF from 'jspdf';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { IntakeStoreConstants } from '../../my-newintake.constants';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import { Html2CanvasService } from '../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
// import { readFileSync } from 'fs';
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'cps-doc-letter',
    templateUrl: './cps-doc-letter.component.html',
    styleUrls: ['./cps-doc-letter.component.scss'],
    standalone: false
})
export class CpsDocLetterComponent implements OnInit {
    persons!: any[];
    general!: General |null |undefined ;
    evalFields!: EvaluationFields;
    @Input() cpsdocData!: CpsDocInput;
    // @Input() cpsdocGenAction: Subject<string>;
    reviewStatus!: string;
    // @Input() sdmReport$ = new Subject<Sdm>();
    // @Input() narrativeOutputSubject$ = new Subject<Narrative>();
    casehead!: InvolvedPerson |null |undefined;
    addedPersons!: any[];
    householdMem: InvolvedPerson[] = [];
    nonHouseholdMem: InvolvedPerson[] = [];
    imgname: any;
    currentDate = new Date();
    narrative = '';
    cpsHistoryInfo = '';
    cpsHistPresent = false;
    narrativePresent = false;
    id: any;
    sdmJsonData!: SDMDescription;
    supervisorApprovalDetails:any[] = [];
    sdmFormData!: Sdm | null | undefined;
    narrativeFormData!: Narrative;
    roleId!: AppUser | null |undefined;
    pdfFiles: {
        fileName: string;
        images: { image: string; height: any; name: string }[];
    }[] = [];
    PAGE_HEIGHT = 920;
    public store: any;
    intakenumber: any;
    typeOfMaltreatment!: string[];
    isAuthorized :any; //for fortify issues 
    referralSource: any;
    householdsection = 'ref-parti-in-household';
    cpsintakeheaderid = 'cps-intake-header';
    cpsintakefooterid = 'cps-intake-footer';
    private html2canvas:Html2CanvasService;
    private _http: HttpService;
    private route: ActivatedRoute;
    private _alertService: AlertService;

    constructor(
        private _authService: AuthService,
        private _commonService: CommonHttpService,
        private _store: DataStoreService,
        private readonly injector : Injector
    ) {
        this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);
        this._http = this.injector.get<HttpService>(HttpService);
        this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
        this._alertService = this.injector.get<AlertService>(AlertService);
        this.store = this._store.getCurrentStore();
        this.id = this.route?.snapshot?.parent?.parent?.parent?.params['id'];
    }

    ngOnInit() {
        this.isAuthorized= this._store.isAuthorized(); //for fortify issues
        // console.log("STORE in CPS Intake Report OnInit :", this.store);
        this.loadPersons();

    }

    ngAfterViewChecked() {

        if(this.cpsHistPresent)
        {
            const ch = document?.getElementById('cps-history-div')?.children;
            let element:any;
            for( element of Array.from(( ch as any))){
                if(element?.tagName === 'pre' || element.tagName === 'PRE'){
                    element?.setAttribute('style','white-space: pre-line;');
                }
            }
        }
        if(this.narrativePresent){
            const cn = document?.getElementById('narrative-div')?.children;
            let element:any;
            for(element of Array.from((cn as any))){
                if(element?.tagName === 'pre' || element.tagName === 'PRE'){
                    element.setAttribute('style','white-space: pre-line;');
                }
            }
        }
    }
    mapdata() { 
        this.general = this.store[IntakeStoreConstants.general]; 
        this.persons = this.addedPersons; 
        this.getSupervisorApprovalInfo();
        this.evalFields = this.store[IntakeStoreConstants.evalFields];
        this.reviewStatus = this.store[IntakeStoreConstants.reviewStatus];
        this.referralSource = this.store[IntakeStoreConstants.REFERALSOURCE];
        if (_.has(this.store, 'addNarrative.Narrative')) {
            this.narrative = this.store.addNarrative.Narrative;
            this.narrativePresent = true;
        }
        if(this.store.addNarrative && this.store.addNarrative.cpsHistoryClearance !== '' && this.store.addNarrative.cpsHistoryClearance != null){
            this.cpsHistoryInfo = this.store.addNarrative.cpsHistoryClearance;
            this.cpsHistPresent = true;
        }

        this.cpsdocData = new CpsDocInput();
        this.cpsdocData.intakePurpose = this.store[IntakeStoreConstants.intakeServiceGrid];
        this.sdmJsonData = sdmData;
        // const imgBase64 = readFileSync('src/assets/images/draft.png', 'base64');
        // this.imgname = `data:image/png;base64,${imgBase64}`;
        this.roleId = this._authService.getCurrentUser();
        const cpsDocument = this.store[IntakeStoreConstants.cpsDocument];
        if (cpsDocument === 'generate') {
            if ($('#vir-csp').children().length === 0) {
                this.createpreview();
            }
        } else if (cpsDocument === 'download') {
            this.downloadCasePdf('vir-csp');
        }

        this.sdmFormData = this.store[IntakeStoreConstants.intakeSDM];
        this.getTypeOfReferral();

        this.narrativeFormData = this.store[IntakeStoreConstants.addNarrative];
        this.getCaseHead();
        this.getMembersOfHousehold();
    }


    loadPersons() {
        if (_.has(this.store, 'da_intakenumber')) {
            this.intakenumber = this.store.da_intakenumber;
        }
        else if(_.has(this.store, 'intakenumber')){
            this.intakenumber = this.store.intakenumber;
        }
        
        let isExpungementSuperUser= this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._store.getData('iscaseexpunged');
        let url = '';
        if(isExpungementSuperUser=== 1) {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedExpungedPersonListCWUrl;
        } else {
            url = CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.InvolvedPersonListCWUrl;
        }
        this._commonService
        .getPagedArrayList(
          new PaginationRequest({
            page: 1,
            limit: 20,
            method: 'get',
            //where: condition
            where: {
                intakenumber: this.intakenumber,
                isExpungementSuperUser: isExpungementSuperUser,
                iscaseexpunged: iscaseexpunged
            }
          }),
          url + '?filter'
        ).subscribe(response => {
          this.addedPersons = response.data;
          this.mapdata();
        });
    }


    sdmKeys(obj:any) {
        if (obj) {
            const sdmObject:any[] = [];
            Object.keys(obj).forEach(key => {
                if (obj[key] === true) {
                    sdmObject.push(key);
                }
            });
            return sdmObject;
        }
    }
    generatePageDiv() {
        const pageDiv = document.createElement('div');
        pageDiv.className = 'pdf-page sizeA4 page-paddings';
        return pageDiv;
    }

    genrateContainerDiv() {
        const container = document.createElement('div');
        container.className = 'pdf-container';
        return container;
    }

    getSections() {
        const list = [
            'record-of-contact',
            'rocommended-response-time',
            'referral-casehead',
            'add-n-contact',
            'referral-narrative',
            'other-mem-of-household',
            this.householdsection,
            'oth-mem-not-in-household',
            'out-home-maltrtmt',
            'order-of-shelter',
            'law-enf',
            'allg-pert-chld',
            'recomm-n-over',
            'work-approvals',
            'related-cases',
            'source-referral'
        ];
        const containers :any[]= [];
        list.forEach(element => {
            if (element === this.householdsection) {
                const householdMeminfos = document.getElementsByClassName(
                    'householdMeminfo'
                );
                const householdMemaddinfos = document.getElementsByClassName(
                    'householdMemaddinfo'
                );
                const householdMemconinfos = document.getElementsByClassName(
                    'householdMemconinfo'
                );
                const householdMeminfoheader = document.getElementsByClassName(
                    'householdMeminfoheader'
                );

                for (let i = 0; i < this.householdMem.length; i++) {
                    containers.push(householdMeminfos[i]);
                    containers.push(householdMeminfoheader[i]);
                    containers.push(householdMemaddinfos[i]);
                    containers.push(householdMemconinfos[i]);
                }
            } /* else if (element === this.householdsection) {          //SonarQube - This branch duplicates the one on line 274
                const householdMeminfos = document.getElementsByClassName(
                    'outhouseholdMeminfo'
                );
                const householdMemaddinfos = document.getElementsByClassName(
                    'outhouseholdMemaddinfo'
                );
                const householdMemconinfos = document.getElementsByClassName(
                    'outhouseholdMemconinfo'
                );
                const householdMeminfoheader = document.getElementsByClassName(
                    'outhouseholdMeminfoheader'
                );

                for (let i = 0; i < this.householdMem.length; i++) {
                    containers.push(householdMeminfos[i]);
                    containers.push(householdMeminfoheader[i]);
                    containers.push(householdMemaddinfos[i]);
                    containers.push(householdMemconinfos[i]);
                }
            } */ else {
                containers.push(document.getElementById(element));
            }
        });
        return containers;
    }

    createpreview() {
        const virelement = document.getElementById('vir-csp');
        const header = document.getElementById(this.cpsintakeheaderid);
        const footer = document.getElementById(this.cpsintakefooterid);
        if(footer){
        footer.className = 'mt-10 cps-footer';
        }
        let divele = this.generatePageDiv();
        let wraper = this.genrateContainerDiv();
        if(header){
        divele.appendChild(header);
        }
        divele.appendChild(wraper);
        let pageHeight = this.PAGE_HEIGHT;
        this.getSections().forEach(element => {
            const offsetheight = element.offsetHeight;
            if (pageHeight - offsetheight > 0) {
                wraper.appendChild(element);
                pageHeight = pageHeight - offsetheight;
            } else {
                pageHeight = this.PAGE_HEIGHT;
                if(footer){
                divele.appendChild(footer.cloneNode(true));
                }
                virelement?.appendChild(divele);
                divele = this.generatePageDiv();
                wraper = this.genrateContainerDiv();
                if(header){
                divele.appendChild(header.cloneNode(true));
                }
                wraper.appendChild(element);
                pageHeight = pageHeight - offsetheight;
                divele.appendChild(wraper);
            }
        });

        footer ? divele.appendChild(footer): '';
        virelement?.appendChild(divele);
        const pages: any = virelement?.getElementsByClassName('page-index');
        if(pages){
        for (let i = 0; i < pages?.length; i++) {
            pages.item(i).innerHTML = i + 1 + ' of ' + pages?.length;
        }
    }
    const cpsIntakeLetter = document.getElementById('CPS-Intake-Letter');
    if(cpsIntakeLetter) {
        cpsIntakeLetter.hidden = true;
    }
    }

   async downloadCPSIntakePdf() {
        const req = {
            ...this.store,
            ...this.general,
            'username' : (this.roleId && this.roleId.user && this.roleId.user.username) ? this.roleId.user.username : '',
            ...this.casehead,
            'sdmJsonData' : this.sdmJsonData,
            'sdmFormData' : this.sdmFormData,
            'narrativeFormData': this.narrativeFormData,
            'typeOfMaltreatment' : this.typeOfMaltreatment,
            'nonHouseholdMem' : this.nonHouseholdMem,
            'householdMem' : this.householdMem,
            'supervisorApprovalDetails': this.supervisorApprovalDetails
        };

        const payload = {
            method: 'post',
            count: -1,
            page: 1,
            limit: 20,
            where: req,
            documntkey: [
                    'cpsintakereport'
                ]
          };

        this._commonService.create(payload, 'Intakeservicerequestdispositioncodes/getreportcpsintake').subscribe(
            response => {
              setTimeout(() => window.open(response.data.documentpath), 2000);
        });

    }


    async downloadCasePdf(element: string) {
        const source = document.getElementById(element);
        const pages = source?.getElementsByClassName('pdf-page');
        let pageImages:any[] = [];
        if(pages){
        for (let i = 0; i < pages?.length; i++) {
            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
            });
        }
    }
        const pageName = 'pageName';
        this.pdfFiles.push({ fileName: pageName, images: pageImages });
        pageImages = [];
        this.convertImageToPdf();
    }
    convertImageToPdf() {
        
        this.pdfFiles.forEach(pdfFile => {
            const doc = new jsPDF();
            var width = doc.internal.pageSize.getWidth() - 10;
      var height = doc.internal.pageSize.getHeight() - 10;
            pdfFile.images.forEach((image:any, index:any) => {
                doc.addImage(image, 'JPEG', 0, 0,width,height);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            if (
                this.reviewStatus !== 'Review' &&
                this.reviewStatus !== 'Accepted'
            ) {
                this.addWaterMark(doc);
            }
            doc.save(pdfFile.fileName);
        });
        (<any>$('#intake-complaint-pdf1')).modal('hide');
        this.pdfFiles = [];
    }

    cpsPdfCreator() {
        const element = document.getElementById('CPS-Intake-Letter');

        const pdf = new jsPDF('p', 'pt', 'a4');
        pdf.internal.scaleFactor = 3.75;

        const w = element?.clientWidth;
        const h = element?.clientHeight;
        const newCanvas = document.createElement('canvas');
        newCanvas.width = w? w * 2:0;
        newCanvas.height = h ? h * 2 : 0;
        newCanvas.style.width = w + 'px';
        newCanvas.style.height = h + 'px';
        const context = newCanvas.getContext('2d');
        context?.scale(2, 2);

        const doc = new jsPDF();

        doc.setFontSize(14);
        
    }

    addWaterMark(doc: jsPDF) {
        const totalPages = (doc as any).internal.getNumberOfPages();
        var width = doc.internal.pageSize.getWidth() - 10;
      var height = doc.internal.pageSize.getHeight() - 10;
        for (let i = 1; i <= totalPages; i++) {
            doc.setPage(i);
            doc.addImage(this.imgname, 'PNG', 0, 0,width,height);
        }

        return doc;
    }

    getCaseHead() {
        if (this.persons) {
            this.persons.forEach(element => {
                if (element.roles) {
                    const hascasehead = element.isheadofhousehold;
                    this.ifHascaseheadFn(hascasehead, element);
                }
            });
        }
    }

    private ifHascaseheadFn(hascasehead: any, element: any) {
        if (hascasehead) {
            element.displayMultipleRole = element.roles.map(
                (role:any) => role.typedescription
            );
            this.casehead = element;
            if (this.casehead && this.casehead.race && this.casehead.race.length > 0) {
                let caseheadrace = Array.isArray(this.casehead.race) ? this.casehead.race : [];
                caseheadrace = caseheadrace.map(item => item.value_text);
                const caseheadracelist = new Set(caseheadrace);
                this.casehead['raceList'] = [...Array.from(caseheadracelist)];
            }
        }
    }

    getSupervisorApprovalInfo() {
        const isExpungementSuperUser = this._authService.isExpungementSuperUser();
        const iscaseexpunged = this._store.getData('iscaseexpunged');
        this._http.post( CaseWorkerUrlConfig.EndPoint.DSDSAction.InvolvedPerson.CpsIntakeReport, {
            'intakenumber': this.intakenumber,
            'isExpungementSuperUser': isExpungementSuperUser,
            'iscaseexpunged': iscaseexpunged
        }).subscribe((response) => {
            this.supervisorApprovalDetails = response.data.getsupervisorapprovaldetails;
            });
    }

    getMembersOfHousehold() {
        if (this.persons) {
            this.persons
                .filter(item => item.rolename !== 'LG')
                .forEach(element => {
                    if (element.roles) {
                        this.houseHoldeFilterResponseFn(element);
                    }
                });
        }
    }

    private houseHoldeFilterResponseFn(element: any) {
        const casehead = element.roles.filter(
            (item :any)=> item.intakeservicerequestpersontypekey === 'LG'
        );
        if (!casehead.length) {
            element.displayMultipleRole = element.roles.map(
                (role:any) => role.typedescription
            );

            if (element.ssn !== null && element.ssn !== undefined && element.ssn !== '') {
                element.isDataAvailable = 'Yes';
            } else {
                element.isDataAvailable = 'No';
            }

            if (element.RelationshiptoRA === 'A3') {
                this.nonHouseholdMem.push(element);
            } else {
                this.householdMem.push(element);
            }
        }
    }

    getTypeOfReferral() {
        this.typeOfMaltreatment = [];
        //if (this.sdmFormData) {           // SonarQube code complexity fix
            if (this.sdmFormData && (this.sdmFormData.ismalpa_suspeciousdeath || this.sdmFormData.ismalpa_nonaccident ||
                this.sdmFormData.ismalpa_injuryinconsistent || this.sdmFormData.ismalpa_insjury || this.sdmFormData.ismalpa_childtoxic
                || this.sdmFormData.ismalpa_caregiver)) {
                this.typeOfMaltreatment.push('Physical Abuse');
            } 
            if (this.sdmFormData && (this.sdmFormData.ismalsa_sexualmolestation || this.sdmFormData.ismalsa_sexualact
                || this.sdmFormData.ismalsa_sexualexploitation || this.sdmFormData.ismalsa_physicalindicators)) {
                this.typeOfMaltreatment.push('Sexual Abuse');
            } 
            if (this.sdmFormData && (this.sdmFormData.isnegfp_cargiverintervene || this.sdmFormData.isnegab_abandoned ||
                this.sdmFormData.isnegmn_unreasonabledelay ||
                this.sdmFormData.isneguc_leftunsupervised || this.sdmFormData.isneguc_leftaloneinappropriatecare || this.sdmFormData.isneguc_leftalonewithoutsupport ||
                this.sdmFormData.isneggn_suspiciousdeath || this.sdmFormData.isneggn_signsordiagnosis || this.sdmFormData.isneggn_inadequatefood || 
                this.sdmFormData.isneggn_childdischarged)) {
                this.typeOfMaltreatment.push('General Neglect');
            } 
            if (this.sdmFormData && (this.sdmFormData.ismenab_psycologicalability || this.sdmFormData.ismenng_psycologicalability)) {
                this.typeOfMaltreatment.push('mental injury');
            } 
            if (this.sdmFormData && (this.sdmFormData.isnegrh_exposednewborn || this.sdmFormData.isnegrh_priordeath || this.sdmFormData.isnegrh_domesticviolence
                || this.sdmFormData.isnegrh_sexualperpetrator || this.sdmFormData.isnegrh_basicneedsunmet || this.sdmFormData.isnegrh_treatmenthealthrisk)) {
                this.typeOfMaltreatment.push('Risk of harm');
            }
        //}
    }
}
