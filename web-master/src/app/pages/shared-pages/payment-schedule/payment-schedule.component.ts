import { Component, OnInit, Injector } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';

import { ActivatedRoute, Router } from '@angular/router';
import { InvolvedPerson } from '../../../@core/common/models/involvedperson.data.model';
import { AlertService, DataStoreService, CommonHttpService, AuthService } from '../../../@core/services';
import { PaymentScheduleService } from './payment-schedule.service';
import moment from 'moment';
import { IntakeStoreConstants } from '../../newintake/my-newintake/my-newintake.constants';
import { CommonUrlConfig } from '../../../@core/common/URLs/common-url.config';
import { PaginationInfo } from '../../../@core/entities/common.entities';
import { IntakeUtils } from '../../_utils/intake-utils.service';
import { AppUser } from '../../../@core/entities/authDataModel';
import { AppConstants } from '../../../@core/common/constants';
import { GLOBAL_MESSAGES } from '../../../@core/entities/constants';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'payment-schedule',
    templateUrl: './payment-schedule.component.html',
    styleUrls: ['./payment-schedule.component.scss'],
    standalone: false
})
export class PaymentScheduleComponent implements OnInit {

  paymentScheduleForm!: FormGroup;
  residentialExists: boolean=false;
  actionText!: string;
  actionBtnText!: string;
  id!: string;
  victims!: InvolvedPerson[];
  pageSource!: string;
  isCasePage = false;
  frequencyList:any[]= [];
  cases:any = [];
  relations:any[] = [];
  youth:InvolvedPerson | null = new InvolvedPerson();
  placementDetails: any;
  paymentSchedules:any = [];
  paymentSchedule: any;
  index!: number;
  isEdit!: boolean;
  isView!: boolean;
  minDate = new Date();
  paginationInfo: PaginationInfo = new PaginationInfo();
  totalRecords!: number;
  isRCPage!: boolean;
  isSourceCourt!: boolean;
  userRole: AppUser;
  isccuEnable = false;
  isCCUPage = false;
  isDjs!: boolean;
  installmentEnable!: boolean;
  deleteresourcepopupid = '#delete-resource-popup';

   
    private _formBuilder: FormBuilder;
    private route: ActivatedRoute;
    private router: Router;
    private service: PaymentScheduleService;
    private _alertService: AlertService;
    private _datastoreService: DataStoreService;
    private _commonHttpService: CommonHttpService;
    private _utils: IntakeUtils;
    private _authService: AuthService;

  constructor(private injector : Injector){
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this.router = this.injector.get<Router>(Router);
    this.service = this.injector.get<PaymentScheduleService>(PaymentScheduleService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._datastoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._utils = this.injector.get<IntakeUtils>(IntakeUtils);
    this._authService = this.injector.get<AuthService>(AuthService);
    
   
    this.userRole = this._authService.getCurrentUser();
    this.service.id = this.route?.snapshot?.parent?.parent?.parent?.parent?.params['id'];
    this.service.daNumber = this.route?.snapshot?.parent?.parent?.parent?.parent?.params['daNumber'];
    if (this.userRole.role.name === AppConstants.ROLES.CASE_WORKER) {
      this.service.id = this.route?.snapshot?.parent?.parent?.parent?.parent?.parent?.parent?.params['id'];
      this.service.daNumber = this.route?.snapshot?.parent?.parent?.parent?.parent?.parent?.parent?.params['daNumber'];
    }
    this.route?.data?.subscribe((response:any) => {
      this.service.pageSource = response?.pageSource;
      this.isRCPage = this.service.isRCPage();
      if (this.isRCPage) {
        this.route.queryParams.subscribe(params => {
          if (params['IsCCUenable']) {
            this.service.setCcuenable(params['IsCCUenable']);
          }
          if (params['pageFrom'] === 'CCU') {
            this.service.setCcuPage(true);
          } else {
            this.service.setCcuPage(false);
          }
        });
        this.service.intakeserreqrestitutionid = this.route?.snapshot?.parent?.params['restituionid'];
        this.service.id = this.route?.snapshot?.parent?.params['id'];
      }
    });
  }

  ngOnInit() {
    this.isCasePage = this.service.isCasePage();
    this.isDjs = this._authService.isDJS();
    this.loadFrequency();
    if (this.isRCPage) {
      this.isccuEnable = this.service.getCcuenable();
      this.isCCUPage = this.service.getCcuPage();
      if  (this.isCCUPage) {
      (<any>$(':button')).prop('disabled', true);
      (<any>$('.ccuapprovebutton')).prop('disabled', false);
        this.isccuEnable = false;
      }
      this.loadPaymentSchedules();
      this.service.processInvolvedVictims();
    } else {
      this.service.loadCases();
      this.cases = this.service.cases;
      this.service.processInvolvedVictims();
      if (!this.isCasePage) {
        this.youth = this.service.youth;
        const addedPaymentSchedules = this._datastoreService.getData(IntakeStoreConstants.paymentSchedule);
        this.paymentSchedules = addedPaymentSchedules ? addedPaymentSchedules : [];
      } else {
        this.loadPaymentSchedules();
      }
      this.extractPlacementDetails();
    }
    this.paymentScheduleForm = this._formBuilder.group({
      victim: [''],
      amount: [''],
      duedate: [''],
      defferedduedate: [''],
      isdefferedbycourt: [''],
      installmentamount: [''],
      initialpaymentdate: [''],
      isyouthinresdentialplacement: [''],
      frequency: [''],
      case: [''],
      liableperson: [''],
      restitutionid: [''],
      restitutionnumber: ['']
    });
  }


  private loadPaymentSchedules() {
    if(this.youth) {
      this.youth.personid = this._datastoreService.getData('da_personid');
    }
    this._commonHttpService.getPagedArrayList({
      count: -1,
      page: this.paginationInfo.pageNumber,
      limit: this.paginationInfo.pageSize,
      where: {
        intakeserviceid: this.service.id,
        intakeserreqrestitutionid: this.service.intakeserreqrestitutionid ? this.service.intakeserreqrestitutionid : null
      },
      method: 'get'
    }, CommonUrlConfig.EndPoint.RESTITUTION.LIST_RESTITUTION).subscribe((res: any) => {
      this.paymentSchedules = res;
      if (this.isRCPage) {
        this.paymentSchedule = this.paymentSchedules.length ? this.paymentSchedules[0] : {};
        this.extractBasicDetails();
        this.extractPlacementDetails();
        this._datastoreService.setData(IntakeStoreConstants.restitution, this.paymentSchedule);
      }
      this.totalRecords = this.paymentSchedules.length ? this.paymentSchedules[0]?.totalcount : 0;
    });
  }

  pageChanged(pageInfo:any) {
    this.paginationInfo.pageNumber = pageInfo.page;
    this.loadPaymentSchedules();
  }

  loadFrequency() {
    this.frequencyList = [
      { id: 'week', value: 'Week' },
      { id: 'month', value: 'Month' },
      { id: 'onetime', value: 'One time' },
    ];
  }

  onFrequency(frequency:any) {
    if ( frequency === 'onetime') {
      this.installmentEnable = false;
      this.paymentScheduleForm?.get('installmentamount')?.disable();
    } else {
      this.installmentEnable = true;
      this.paymentScheduleForm?.get('installmentamount')?.enable();
    }
  }

  addPaymentSchedule() {
    this.clearItem();
    this.extractBasicDetails();
    this.extractPlacementDetails();
    this.isView = false;
    this.isEdit = false;
    if (this.isCasePage) {
      this.paymentScheduleForm?.get('case')?.setValue(this.cases[0]);
      this.paymentScheduleForm?.get('case')?.disable();
    }
    this.paymentScheduleForm?.get('isyouthinresdentialplacement')?.disable();
  }

  private extractBasicDetails() {
    if (!(this.isRCPage || this.isCasePage)) {
      this.victims = this.service.victims;
      this.cases = this.service.cases;
      this.relations = this.service.relations;
      this.youth = this.service.youth;
    } else {
      this.processCaseInvolvedPerson();
      if (this.isRCPage) {
      
        this.cases = [{
          serviceTypeID: this.paymentSchedule.caseid,
          ServiceRequestNumber: this.paymentSchedule.casenumber
        }];
        this.isSourceCourt = this.paymentSchedule.sources === 'court';
      }
    }
  }

  processCaseInvolvedPerson() {
    this.service.processInvolvedPerson().subscribe(result => {
      const persons = result.data;
      this.victims = persons ? persons.filter((person) => person.rolename === 'Victim') : [];
      this.relations = persons ? persons.filter((person) => (person.rolename !== 'Youth' && person.rolename !== 'Victim')) : [];
      this.youth = persons ? persons.filter((person) => person.rolename === 'Youth')[0] : null;
      if (this.isEdit) {
        this.patchEditForm();
      }
    });
  }

  private extractPlacementDetails() {
    if (this.youth) {
      this.service.getPlacementDetails(this.youth.personid).subscribe((placement: any) => {
        const palcementData = placement.data;
        if (palcementData && palcementData.length === 1) {
          this.residentialExists = palcementData[0].residentialexists;
          this.paymentScheduleForm?.get('isyouthinresdentialplacement')?.setValue(this.residentialExists);
          this.placementDetails = palcementData[0].placementdetails;
        }
      });
    }
  }

  caseChanged() {
    const paymentSchedule = this.paymentScheduleForm?.getRawValue();
    const disp = paymentSchedule.case.dispositioncodestatusdesc;
    const today = moment();
    if (disp) {
      switch (disp.trim()) {
        case 'Informal Adjustment 1':
          today.add(30, 'd');
          break;
        case 'Informal Adjustment 2':
          today.add(60, 'd');
          break;
        case 'Informal Adjustment 3':
          today.add(90, 'd');
          break;
      }
    }
    this.paymentScheduleForm?.get('duedate')?.setValue(today.format());
  }

  clearItem() {
    this.paymentScheduleForm.reset();
    this.paymentScheduleForm.enable();
    this.actionText = 'Add';
    this.actionBtnText = 'Save';
  }

  checkIfCaseVictimExists(victimid: string, casenumber: string): boolean {
    let isExists = false;
    if (!this.isEdit) {
      this.paymentSchedules.forEach((schedule:any) => {
        if (schedule.casenumber === casenumber && schedule.victim.pid === victimid) {
          isExists = true;
        }
      });
    }
    return isExists;
  }

  savePaymentSchedule() {
    const paymentSchedule = this.paymentScheduleForm?.getRawValue();
    if (this.checkIfCaseVictimExists(paymentSchedule.victim.personid, paymentSchedule.case.ServiceRequestNumber)) {
      this._alertService.warn('Restitution already added for Case & Victim combination.');
      return;
    } else if (Number(paymentSchedule.amount) > 10000) {
      this._alertService.warn('Amount should be less than $10,000.');
      return;
    } else if (Number(paymentSchedule.amount) < Number(paymentSchedule.installmentamount)) {
      this._alertService.warn('Installment Amount should be less than Restitution Amount.');
      return;
    } else if (moment(paymentSchedule.duedate).isBefore(moment(paymentSchedule.initialpaymentdate))) {
      this._alertService.warn('Initial payment date should be less than Restitution duedate.');
      return;
    }
    const paymentScheduleObject:any = this.paymentScheduleObjectDataFn(paymentSchedule);
    if (this.isCasePage || this.isRCPage) {
      this.isCaseOrRcPageIfConditionFn(paymentScheduleObject);
    } else {
      this.isCaseOrRcPageElseConditionFn(paymentScheduleObject);
    }
  }

  private isCaseOrRcPageElseConditionFn(paymentScheduleObject: { restitutionid: any; restitutionnumber: any; caseid: any; casenumber: any; dispositioncode: any; dispositioncodestatusdesc: any; focusperson: { pid: string; firstname: string; lastname: string; }; victim: { pid: any; firstname: any; lastname: any; }; amount: any; duedate: string; courtdeferredduedate: string; sources: string; liableperson: { pid: any; firstname: any; lastname: any; relationship: any; }; frequency: any; initialpaymentdate: string; installmentamount: any; }) {
    if (this.isEdit) {
      this.paymentSchedules[this.index] = paymentScheduleObject;
      this._alertService.success('Payment Schedule updated successfully.');
    } else {
      this.paymentSchedules.push(paymentScheduleObject);
      this._alertService.success('Payment Schedule added successfully.');
    }
    this.boardcastPaymentSchedules();
    (<any>$('#add')).modal('hide');
  }

  private isCaseOrRcPageIfConditionFn(paymentScheduleObject: { restitutionid: any; restitutionnumber: any; caseid: any; casenumber: any; dispositioncode: any; dispositioncodestatusdesc: any; focusperson: { pid: string; firstname: string; lastname: string; }; victim: { pid: any; firstname: any; lastname: any; }; amount: any; duedate: string; courtdeferredduedate: string; sources: string; liableperson: { pid: any; firstname: any; lastname: any; relationship: any; }; frequency: any; initialpaymentdate: string; installmentamount: any; }) {
    this._commonHttpService.create(paymentScheduleObject, CommonUrlConfig.EndPoint.RESTITUTION.ADD_UPDATE_RESTITUTION).subscribe(res => {
      if (res.addupdaterestitution) {
        const action = this.actionToPerformFn();
        this._alertService.success(`Payment Schedule ${action} successfully.`);
        this.loadPaymentSchedules();
        (<any>$('#add')).modal('hide');
      }
    });
  }

  private actionToPerformFn() {
    return this.actionBtnText === 'Add' ? 'added' : 'updated';
  }

  private paymentScheduleObjectDataFn(paymentSchedule: any) {
    return {
      restitutionid: paymentSchedule.restitutionid,
      restitutionnumber: paymentSchedule.restitutionnumber,
      caseid: paymentSchedule.case.serviceTypeID,
      casenumber: paymentSchedule.case.ServiceRequestNumber,
      dispositioncode: paymentSchedule.case.dispositioncode,
      dispositioncodestatusdesc: paymentSchedule.case.dispositioncodestatusdesc,
      focusperson: {
        pid: this.youth?.personid,
        firstname: this.youth?.firstname,
        lastname: this.youth?.lastname
      },
      victim: {
        pid: paymentSchedule.victim.personid,
        firstname: paymentSchedule.victim.firstname,
        lastname: paymentSchedule.victim.lastname
      },
      amount: paymentSchedule.amount,
      duedate: this._utils.extractDateOnly(paymentSchedule.duedate),
      courtdeferredduedate: this._utils.extractDateOnly(paymentSchedule.defferedduedate),
      sources: this.sourcesDataFn(),
      liableperson: {
        pid: paymentSchedule.liableperson.personid,
        firstname: paymentSchedule.liableperson.firstname,
        lastname: paymentSchedule.liableperson.lastname,
        relationship: paymentSchedule.liableperson.relationship
      },
      frequency: paymentSchedule.frequency,
      initialpaymentdate: this._utils.extractDateOnly(paymentSchedule.initialpaymentdate),
      installmentamount: paymentSchedule.installmentamount
    };
  }

  private sourcesDataFn() {
    return this.isCasePage ? 'court' : 'intake';
  }

  deletePaymentSchedule(index: number) {
    this.index = index;
    (<any>$(this.deleteresourcepopupid)).modal('show');
  }

  deleteConfirmPaymentSchedule() {
    if (this.isCasePage) {
      this._commonHttpService.remove(this.paymentSchedules[this.index].intakeserreqrestitutionid, {}, CommonUrlConfig.EndPoint.RESTITUTION.DELETE_RESTITUTION).subscribe(res => {
        if (res.count) {
          this._alertService.success('Payment Schedule removed successfully.');
          (<any>$(this.deleteresourcepopupid)).modal('hide');
          this.loadPaymentSchedules();
        } else {
          this._alertService.error('Please try again.');
        }
      });
    } else {
      this.paymentSchedules.splice(this.index, 1);
      this._alertService.success('Payment Schedule removed successfully.');
      this.boardcastPaymentSchedules();
      (<any>$(this.deleteresourcepopupid)).modal('hide');
    }
  }

  viewPaymentSchedule(index: number) {
    this.isEdit = false;
    this.isView = true;
    this.actionText = 'View';
    this.extractBasicDetails();
    const paymentSchedule = this.paymentSchedules[index];
    this.formatPaymentPatchValue(paymentSchedule);
    this.paymentScheduleForm.disable();
    (<any>$('#add')).modal('show');
  }

  editPaymentSchedule(index: number) {
    this.isEdit = true;
    this.isView = false;
    this.actionText = 'Update';
    this.actionBtnText = 'Update';
    this.index = index;
    this.extractBasicDetails();
    (<any>$('#add')).modal('show');
  }

  sendToCCU(index: number) {
    this.index = index;
    const restitutionnumber = this.paymentSchedules[this.index].restitutionnumber;
    const requestObj = {
      restitutionno: restitutionnumber,
      appevent: 'RCCUR'
    };
    this._commonHttpService.create(requestObj,
      CommonUrlConfig.EndPoint.RESTITUTION.CCU.SENDTO_CCU).subscribe(success => {
        this._alertService.success('CCU Sent succesfully.');
        (<any>$('.ccubutton')).prop('disabled', true);
      }, error => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      });

  }

  ApproveCCU(index: number) {
    let apireqstatus = '';
    if (index === 0) {
      apireqstatus = 'approved';
    } else if (index === 1) {
      apireqstatus = 'rejected';
    }
    const restitutionnumber = this.paymentSchedules[0].restitutionnumber;
    const requestObj = {
      restitutionno: restitutionnumber,
      appevent: 'RCCUA',
      ccustatus: apireqstatus
    };
    this._commonHttpService.create(requestObj,
      CommonUrlConfig.EndPoint.RESTITUTION.CCU.APPROVE_REJECT).subscribe(success => {
        this._alertService.success(`CCU ${apireqstatus} succesfully.`);
        (<any>$('.ccuapprovebutton')).prop('disabled', true);
      }, error => {
        this._alertService.error(GLOBAL_MESSAGES.ERROR_MESSAGE);
      });

  }

  private patchEditForm() {
    const paymentSchedule = this.paymentSchedules[this.index];
    this.formatPaymentPatchValue(paymentSchedule);
    this.paymentScheduleForm.enable();
    this.paymentScheduleForm?.get('case')?.disable();
    this.paymentScheduleForm?.get('victim')?.disable();
    this.paymentScheduleForm?.get('isyouthinresdentialplacement')?.disable();
    this.paymentScheduleForm?.get('amount')?.disable();
    this.paymentScheduleForm?.get('liableperson')?.disable();
  }

  private formatPaymentPatchValue(paymentSchedule: any) {
    const selectedCase = this.cases.find((c:any) => c.serviceTypeID === paymentSchedule.caseid);
    const victim = this.victims.find(v => v.personid === paymentSchedule.victim.pid);
    const liableperson = this.relations.find(relation => relation.personid === paymentSchedule.liableperson.pid);
    setTimeout(() => {
      this.paymentScheduleForm.patchValue({
        victim: victim,
        amount: paymentSchedule.amount,
        duedate: paymentSchedule.duedate,
        defferedduedate: paymentSchedule.courtdeferredduedate,
        isdefferedbycourt: paymentSchedule.courtdeferredduedate ? true : false,
        installmentamount: paymentSchedule.installmentamount,
        initialpaymentdate: paymentSchedule.initialpaymentdate,
        frequency: paymentSchedule.frequency,
        case: selectedCase,
        liableperson: liableperson,
        restitutionid: paymentSchedule.intakeserreqrestitutionid,
        restitutionnumber: paymentSchedule.restitutionnumber
      });
      this.isDefferedDueDateChange();
      this.extractPlacementDetails();
    }, 10);
  }

  isDefferedDueDateChange() {
    if (this.paymentScheduleForm?.get('isdefferedbycourt')?.value) {
      this.paymentScheduleForm?.get('defferedduedate')?.setValidators(Validators.required);
    } else {
      this.paymentScheduleForm?.get('defferedduedate')?.clearValidators();
      this.paymentScheduleForm?.get('defferedduedate')?.setValue(null);
    }
    this.paymentScheduleForm?.get('defferedduedate')?.updateValueAndValidity();
  }

  private boardcastPaymentSchedules() {
    this._datastoreService.setData(IntakeStoreConstants.paymentSchedule, this.paymentSchedules);
  }

  downloadPaymentSchedule(data:any) {
    const restiutionDocumentInfo = data;
    const intakeNumber = this._datastoreService.getData(IntakeStoreConstants.intakenumber);
    restiutionDocumentInfo.intakenumber = intakeNumber;
    this._datastoreService.setData(IntakeStoreConstants.restiutionDocumentInfo, restiutionDocumentInfo);
    this.router.navigate(['payment-schedule-document'], { relativeTo: this.route });
  }

  downloadPaymentSlip(data:any) {
    this._datastoreService.setData(IntakeStoreConstants.restiutionDocumentInfo, data);
    this.router.navigate(['payment-slip-document'], { relativeTo: this.route });
  }

  amountDecimal(index:any) {
    if (index === 1) {
      const amount = Number(this.paymentScheduleForm?.get('amount')?.value);
      this.paymentScheduleForm.patchValue({
        amount : amount.toFixed(2)
      });
    } else {
      const amount = Number(this.paymentScheduleForm?.get('installmentamount')?.value);
      this.paymentScheduleForm.patchValue({
        installmentamount : amount.toFixed(2)
      });
    }

  }
}
