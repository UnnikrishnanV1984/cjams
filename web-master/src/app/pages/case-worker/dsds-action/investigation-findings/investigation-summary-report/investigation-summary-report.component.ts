import { Component, OnInit, Input, Output, EventEmitter } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { CommonHttpService, ValidationService, AlertService } from '../../../../../@core/services';
import { DSDSActionSummary } from '../../../../providers/_entities/provider.data.model';
import { DataStoreService } from '../../../../../@core/services/data-store.service';
import { Observable } from 'rxjs';
import { InvolvedPerson } from '../../involved-persons/_entities/involvedperson.data.model';
import { HttpService } from '../../../../../@core/services/http.service';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';
import {PersonComar } from '../_entities/investigation-finding-data.models';
import {ComarFindings} from './investigation-summary-report-config';
import moment from 'moment';
import _ from 'lodash';
import { NewUrlConfig } from '../../../../newintake/newintake-url.config';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';

@Component({
    selector: 'investigation-summary-report',
    templateUrl: './investigation-summary-report.component.html',
    styleUrls: ['./investigation-summary-report.component.scss'],
    standalone: false
})
export class InvestigationSummaryReportComponent implements OnInit {
    id!:string;
    dahistoryData: any;
    currentDate = new Date();
    printData: any = {};
    @Input() investigationFind: any;
    @Input() addedpersons: any;
    @Input() reportType: any;
    @Output() close = new EventEmitter<void>();
    dsdsActionsSummary = new DSDSActionSummary();
    isServiceCase!: string;
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    reporter_nm: any;
    dsdsobject: any;
    involevedPerson$!: Observable<InvolvedPerson[]>;
    personComar = new PersonComar();
    selectedallegedperson: any;
    maltreator: any;
    supervisorApprovalDetails: any[]= [];
    emailForm!: FormGroup;
    reportcomarfindings: any;
    comarFindingsKey: any;
    countyList: any[] = [];
    investigation :  any;
    children : any[] = [];
    others : any[] = [];
    referralReason : any;
    closureDate : any;
    recommendation : any;
    reason : any;
    closuretype : any;
    riskissues : any;
    notes : any;
    status : any;
    serviceninterventions : any = [];
    servicelist : any;
    investigationClosureDate: any;
    investigationAuditList: any = [];

    mentalinjuryabuse = 'MENTAL INJURY- ABUSE';
    mentalinjuryneglect = 'MENTAL INJURY- NEGLECT';
    physicalabuse = 'PHYSICAL ABUSE';
    sexualabuse = 'SEXUAL ABUSE';
    dtformat = 'MM/DD/YYYY';

    constructor(private _commonHttpService: CommonHttpService,
        private _http: HttpService,
        private formBuilder: FormBuilder,
        private _alertService: AlertService,
        private _dataStoreService: DataStoreService) {
    }
    ngOnInit() {
      
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.referralReason = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_REFERRAL_REASON);
        this.closureDate = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_CLOSURE_DATE);
        this.recommendation = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_RECOMMENDATION);
        this.reason = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_REASON_TEXT);
        this.closuretype = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_CLOSURE_TYPE);
        this.riskissues = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_RISK_ISSUES);
        this.notes = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_NOTES);
        this.status = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_STATUS);
        this.serviceninterventions = this._dataStoreService.getData(CASE_STORE_CONSTANTS.AR_SERVICES_INTERVENTIONS);

        this.dsdsobject = this._dataStoreService.getData('object');
        this.investigationClosureDate = '';
        this.investigationAuditList = this._dataStoreService.getData('investigationfindingauditlist'); 
        this.investigation = this.investigationFind.getRawValue();
        this.fixText();
        this.getdata(this.addedpersons);
        this.getSupervisorApprovalInfo();
        this.getcomardata();
        this.getChildrenInvolved(this.addedpersons);
        this.getOthersInvolved(this.addedpersons);
        this.victimInfo(this.addedpersons);
        this.emailForm = this.formBuilder.group({
            email: ['', ValidationService.mailFormat]
        });
        this.getCountyList();
    }

    getChildrenInvolved(person: InvolvedPerson[]) {
        this.children = [];
        if (person) {
            this.children = person.filter((item) => (item.rolename === 'CHILD'));            
        }
    }

    getOthersInvolved(person: InvolvedPerson[]) {
        this.others = [];
        if (person) {         

            this.others = person.filter((res) => {
             const tempRole = res.roles.filter((role) => 
                {
                    if ((role.intakeservicerequestpersontypekey !== 'AM' && role.intakeservicerequestpersontypekey !== 'LG' && role.intakeservicerequestpersontypekey !== 'AV' && role.intakeservicerequestpersontypekey !== 'CHILD')){
                        res.rolename = role.typedescription;
                        return true;
                    }                    
                });
                return res.roles.length && tempRole.length;

            
                
            })
        }
    }

    onClose() {
        this.close.emit();
    }

    formatText(s: any){
        s = s.replace(/\n/g, '<br>');
        s = s.replace(/↵/g, '<br>');
        return s;
    }
    fixText(){
        const keys = ['victim_explanation','sibling_explanation',
                        'guardian_explanation','maltreator_explanation',
                        'med_assessmnts','expert_assessmnts',
                        'collateral_interviews','criminal_history_inv',
                        'home_conditions','law_enforcement_inv','dispositionnarrative'];
        keys.forEach((key) => {
            this.investigation[key] = this.formatText(this.investigation[key] ? this.investigation[key].toString():'');
        });
        }
    getdata(persons: any) {
        if (persons) {
            const allegedarray = persons.filter((person: { personid: any; }) => person.personid === this.investigationFind.value.personid);
            this.selectedallegedperson = allegedarray[0];
            // @Simar -> I don't know what the following is trying to do, this.selectedmaltreator was assigned value down below and the check is being done here ?
            // this.selectedmaltreator.race is breaking because this.selectedmaltreator is undefined at this place
            // I'm guessing this is trying to populate the selectedallegedperson info so making the change for now
            if (this.selectedallegedperson && this.selectedallegedperson.race) {
                let allegedrace = Array.isArray(this.selectedallegedperson.race) ? this.selectedallegedperson.race : [];
                allegedrace = allegedrace.map((item: { value_text: any; }) => item.value_text);
                allegedrace = Array.from((new Set(allegedrace)).values());
                this.selectedallegedperson.raceList = [...allegedrace];
            }
            this.getMaltreator(persons);
        }
        if (!this.maltreator) {
            this.maltreator = [];
            this.maltreator.displayname = 'Unnamed Unnamed';
            this.maltreator.gendertypedesc = 'Unkown';
            if (this.investigationFind && this.investigationFind.maltreator) {
                this.maltreator.cjamspid = this.investigationFind.maltreator.cjamspid;
            }
        }
    }

    getMaltreator(persons: any) {
        let mal: any;
        if (this.investigationFind.maltreator) {
            persons.forEach((person: { personid: any; }) => {
                if (person.personid == this.investigationFind.maltreator.personid) {
                    mal = person;
                    mal['displayname'] = this.getFullName(person);
                }
            });
        }
        this.maltreator = mal;
        if (this.maltreator && this.maltreator.race) {
            let maltreatorrace = Array.isArray(this.maltreator.race) ? this.maltreator.race : [];
            maltreatorrace = maltreatorrace.map((item: { value_text: any; }) => item.value_text);
            maltreatorrace = Array.from((new Set(maltreatorrace)).values());
            this.maltreator.raceList = [...maltreatorrace];
        }
    }


    getFullName(person: any) {
        const nameKeys = [ 'prefx' , 'firstname' , 'middlename' , 'lastname' , 'suffix'];
        let name = '';
        nameKeys.forEach(key => {
        if(person && person.hasOwnProperty(key)){
            if ( (person[key] !== null) && (person[key] !== 'null') && (person[key] !== '') ) {
            name = name + person[key] + ' ';
            }}
        });
        return name;
    }
    getcomardata() {
        if (this.investigationFind.value.investigationfindings) {
           const key = this.getKey();
           const type = this.getType();
            switch (true) {
                case (type === this.mentalinjuryabuse && key === 'ID'):
                    this.comarFindingsKey = 'MENTAL-INJURY-ABUSE-ID'; break;
                case (type === this.mentalinjuryabuse && key === 'RO'):
                    this.comarFindingsKey = 'MENTAL-INJURY-ABUSE-RO'; break;
                case (type === this.mentalinjuryabuse && key === 'UD'):
                    this.comarFindingsKey = 'MENTAL-INJURY-ABUSE-UD'; break;
                case (type === this.mentalinjuryneglect && key === 'ID'):
                    this.comarFindingsKey = 'MENTAL-INJURY-NEGLECT-ID'; break;
                case (type === this.mentalinjuryneglect && key === 'RO'):
                    this.comarFindingsKey = 'MENTAL-INJURY-NEGLECT-RO'; break;
                case (type === this.mentalinjuryneglect && key === 'UD'):
                    this.comarFindingsKey = 'MENTAL-INJURY-NEGLECT-UD'; break;
                case (type === 'NEGLECT' && key === 'ID'):
                    this.comarFindingsKey = 'NEGLECTID'; break;
                case (type === 'NEGLECT' && key === 'RO'):
                    this.comarFindingsKey = 'NEGLECTRO'; break;
                case (type === 'NEGLECT' && key === 'UD'):
                    this.comarFindingsKey = 'NEGLECTUD'; break;
                case (type === this.physicalabuse && key === 'ID'):
                    this.comarFindingsKey = 'PHYSICAL-ABUSEID'; break;
                case (type === this.physicalabuse && key === 'RO'):
                    this.comarFindingsKey = 'PHYSICAL-ABUSERO'; break;
                case (type === this.physicalabuse && key === 'UD'):
                    this.comarFindingsKey = 'PHYSICAL-ABUSEUD'; break;
                case (this.checkSexualAbuse(key, type, 'ID')):
                    this.comarFindingsKey = 'SEXUAL-ABUSEID'; break;
                case (this.checkSexualAbuse(key, type, 'RO')):
                    this.comarFindingsKey = 'SEXUAL-ABUSERO'; break;
                case (this.checkSexualAbuse(key, type, 'UD')):
                    this.comarFindingsKey = 'SEXUAL-ABUSEUD'; break;
                case (this.checkSexTrafficking(key, type, 'ID')):
                    this.comarFindingsKey = 'SEX-TRAFFICKING-INDICATED'; break;
                case (this.checkSexTrafficking(key, type, 'RO')):
                    this.comarFindingsKey = 'SEX-TRAFFICKING-RULED-OUT'; break;
                case (this.checkSexTrafficking(key, type, 'UD')):
                    this.comarFindingsKey = 'SEX-TRAFFICKING-UNSUBSTANTIATED'; break;
            }
        }
    }
    getKey(){
        return this.investigationFind.value.investigationfindings[0].finalfinding ? this.investigationFind.value.investigationfindings[0].finalfinding : this.investigationFind.value.investigationfindings[0].investigationfindingtypekey;
    }
    getType(){
        return this.investigationFind.value.name ? this.investigationFind.value.name.toUpperCase() : this.investigationFind.value.name;
    }

    checkSexualAbuse(key: any, type: any, compkey: any){
        return (type === this.sexualabuse && key === compkey && this.investigationFind.value.sextrafficking === 0);
    }
    checkSexTrafficking(key: any, type: any, compkey: any){
        return (type === this.sexualabuse && key === compkey && this.investigationFind.value.sextrafficking === 1);
    }

    victimInfo(person: InvolvedPerson[]) {

        this.personComar.victimname = '';
        this.personComar.caretakername = '';
        this.personComar.victimdob = null;
        let victimdob = null;

        if (person) {
            const careTaker = person.filter((res) => {
                return res.roles.length && res.roles.filter((role) => role.intakeservicerequestpersontypekey === 'CARTKR').length;
            });
            if (careTaker.length > 0) {
                this.personComar.caretakername = careTaker[0].firstname + ' ' + careTaker[0].lastname;
            } else {
                this.personComar.caretakername = '';
            }
            const personData: any = person.filter((item) => item.personid === this.investigationFind.value.personid);
            if (personData.length > 0) {
                this.personComar.victimdob = new Date(personData[0].dob);
                if (this.personComar.victimdob) {
                    victimdob =  moment(this.personComar.victimdob).format(this.dtformat);
                }
            } else {
                this.personComar.victimdob = null;
            }

            this.personComar.victimname = this.investigationFind.value.personname;
        }
        this.reportcomarfindings = _.cloneDeep(ComarFindings.ComarFindingsList[this.comarFindingsKey]);

        this.updateReportFinds(victimdob);
    }

    updateReportFinds(victimdob: any){
        if (this.reportcomarfindings) {
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${comar?.victimname}', this.personComar.victimname);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${comar?.victimdob}', victimdob);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${harmchild}', (this.investigationFind.value.investigationfindings[0].isharm === 1 ? 'Yes' : 'No'));
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${riskofharm}',
                (this.investigationFind.value.investigationfindings[0].isharmsubstantial === 1 ? 'Yes' : 'No'));
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${circumstancescomments}', this.investigationFind.value.investigationfindings[0].harmdesc);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${intentionalinjurydesc}', this.investigationFind.value.investigationfindings[0].intentionalinjurydesc);
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${comar?.caretakername}', this.investigationFind.value.investigationfindings[0].omissiondesc?this.investigationFind.value.investigationfindings[0].omissiondesc:'');
            this.reportcomarfindings.value = this.reportcomarfindings.value.toString().replace('${findingcomments}', this.investigationFind.value.investigationfindings[0].findingcomments);
        }
    }

    getSupervisorApprovalInfo() {
        if (this.id) {
            this._commonHttpService
            .getPagedArrayList(
                new PaginationRequest({
                    page: 1,
                    limit: 100,
                        where: {
                            servicerequestid: this.id
                        },
                        method: 'get'
                    }),
                    'Intakeservicerequestdispositioncodes/GetHistory?filter'
                )
                .subscribe(
                    (result) => {
                        this.supervisorApprovalDetails = result.data;
                        this.investigationClosureDate = this.supervisorApprovalDetails.find(item => {
                            if(item.routingstatus == "Approved") {return item;}
                         }); 
                    },
                    (_error: any) => {
                        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
                    }
                );
        }
    }

    getCountyName(id: any) {
        const countyvalue =  this.countyList.filter(countyId => countyId.countyid === id);
        if (countyvalue[0]) {
            return countyvalue[0].countyname;
        }
        return '';
    }

    getCountyList () {
        this._commonHttpService.create(
            {
                where: {
                    activeflag: '1',
                    state: 'MD'
                },
                order: 'countyname asc',
                nolimit: true
            },
            NewUrlConfig.EndPoint.Intake.MDCountryListUrl
        ).subscribe((response) => {
            this.countyList = response;
        });
    }
    sendEmail () {
        const caseID = this.dsdsobject.intakenumber;
        const request = {
            email : this.emailForm.getRawValue().email,
            caseNumber: caseID,
            body: document.getElementById('investigation-summary-report')?.innerHTML
        };
        this._commonHttpService.create(request, 'Intakeservicerequestpurposes/sendemailcontact').subscribe(
            (result) => {
                this._alertService.success('Email Sent successfully!');
            }
        );
    }
    getPrintData(){
        this.printData['currentDate'] = this.formatDate(this.currentDate);
        this.printData['dsdsobject'] = this.dsdsobject ? this.dsdsobject : null;
        this.printData['countyname'] = this.getCountyName(this.dsdsobject && this.dsdsobject.countyid ? this.dsdsobject.countyid : null);
        this.printData['investigationFind'] = this.investigationFind.getRawValue();
        this.printData['investigation'] = this.investigation;
        this.printData['maltreator'] = this.maltreator ? this.maltreator : null;
        if(this.selectedallegedperson) {
            this.selectedallegedperson.dob = this.formatDate(this.selectedallegedperson.dob);
        }
        this.printData['selectedallegedperson'] = this.selectedallegedperson ? this.selectedallegedperson : null;

        this.supervisorApprovalDetails.forEach(element => {
            element.displaydate = this.formatDate(element.displaydate);
        });

        this.others.map(element => {
            element.dob = this.formatDate(element.dob);
        });
        
        this.children.map(element => {
            element.dob = this.formatDate(element.dob);
        });

        this.printData['supervisorApprovalDetails'] = this.supervisorApprovalDetails ? this.supervisorApprovalDetails : null;
        this.printData['reportcomarfindings'] = this.reportcomarfindings ? this.reportcomarfindings.value  : null;
        this.printData['others'] = this.others ? this.others : null;
        this.printData['children'] = this.children ? this.children : null;
        this.printData['investigationClosureDate'] = this.investigationClosureDate && this.investigationClosureDate.displaydate ? this.formatDate(this.investigationClosureDate.displaydate) : null;
    }

    formatDate(inputDate: any){
        return inputDate ? moment(inputDate).format(this.dtformat) : '';
    }

    async downloadCasePdf() {
        this.getPrintData();
        const inputRequest: any = {
            investigationsummaryreport: this.printData,
            isheaderrequired: false,
            documntkey:  'invsummaryreport' 
          };

          inputRequest.investigationsummaryreport['dsdsobject'].da_receiveddate = inputRequest.investigationsummaryreport['dsdsobject'].da_receiveddate ? moment(inputRequest.investigationsummaryreport['dsdsobject'].da_receiveddate).format(this.dtformat) : ''; 
          inputRequest.investigationsummaryreport['maltreator'].dob = inputRequest.investigationsummaryreport['maltreator'].dob ? moment(inputRequest.investigationsummaryreport['maltreator'].dob).format(this.dtformat) : ''; 
          inputRequest.investigationsummaryreport['assessmentdate'] = inputRequest.investigationsummaryreport['assessmentdate'] ? moment(inputRequest.investigationsummaryreport['assessmentdate']).format(this.dtformat) : ''; 
          
          if(this.reportType == 'IR') {
              inputRequest['name'] ='Investigation Summary Report-'+(this.dsdsobject ? this.dsdsobject.da_number : '');
          }
          else {
            inputRequest['name'] ='AR Summary Report-'+(this.dsdsobject ? this.dsdsobject.da_number : '');
          }

          if(this.investigationAuditList.length > 0 && inputRequest.investigationsummaryreport['investigationFind'].name) {
            inputRequest.investigationsummaryreport['investigationFind'].name = inputRequest.investigationsummaryreport['investigationFind'].name + ' (Maltreatment Type Changed on Appeal)'
          }

          const payload = {
            method: 'post',
            count: -1,
            page: 1,
            limit: 20,
            where: inputRequest,
          };
          this._commonHttpService.create(payload, 'Investigationfindings/downloadInvestigationSummaryReport').subscribe(
          (response) => {
            if (response) {
                 window.open(response.data.documentpath, '_blank');
            }
            }
          );
    }

}
