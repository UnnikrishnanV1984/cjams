import { Component, Injector, OnInit } from '@angular/core';
import { FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CommonHttpService, AlertService, DataStoreService, AuthService } from '../../../../../@core/services';
import { PersonHealthService } from '../person-health.service';
import { PersonInfoService } from '../../person-info.service';
import { PaginationRequest } from '../../../../../@core/entities/common.entities';
import moment from 'moment';
import { ActivatedRoute } from '@angular/router';
import { ImmunizationConstants } from './config';
declare let $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'immunization-cw',
    templateUrl: './immunization-cw.component.html',
    styleUrls: ['./immunization-cw.component.scss'],
    standalone: false
})
export class ImmunizationCwComponent implements OnInit {
  isImmunizedforPerson!: boolean;
  immunizationData: any[] = [];
  fetchedImmunizationData: any[] = [];
  immunizationTypes: any[] = [];
  selectedImmunization: any;
  recordstatus: any = null;
  selectedImmunizationComments: any;
  maxDate = new Date();
  dateFilterTypes: any[] = [];
  dateFilter = null;
  reportMode = 'Add';
  disableDates = false;
  submitUpdate = 'Submit';
  editDoseDate = '';
  addVaccineForm!: FormGroup;
  filterDateForm!: FormGroup;
  personimmunizationconfigid: any;
  selectedVaccine: any;
  store: any;
  dob: any;
  isClosed = false;
  immunizationnotespopupid = '#immunization-notes-popup';
  addvaccinepopup = '#add-vaccine-popup';
  auditlogTrail: any;
  startDate = null;
  endDate = null;
  isModified = false;
  updatedonFromQuery = 0;
  tableVisibility: any[] = [];
  vaccinesWithData: any[] = [];
  buttonName = 'Expand All';
  ready = false;
  commentsTip = 'Click to view full comment';
  selectedRow: any;
  private readonly _formBuilder: FormBuilder;
  private readonly _commonHttpService: CommonHttpService;
  private readonly _healthService: PersonHealthService;
  private readonly _personInfoService: PersonInfoService;
  private readonly _alertService: AlertService;
  private readonly _dataStoreService: DataStoreService;
  private readonly _activatedRoute: ActivatedRoute;

  constructor(private readonly injector : Injector, public _authService: AuthService) {
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._alertService = this.injector.get<AlertService>(AlertService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._activatedRoute = this.injector.get<ActivatedRoute>(ActivatedRoute);

    this.store = this._dataStoreService.getCurrentStore();
  }

  ngOnInit() {
    this.isClosed = this._authService.iscaseclosed('personhealth') || !this._authService.isPersonSubTabViewable('person', 'person.Health.immunizationsave')
    this.isImmunizedforPerson = false;
    this.dateFilterTypes = ImmunizationConstants.filterDates;
    this.reportMode = 'Add';
    this.loadVaccineList();
    this.initForm();
    this.initFilterForm();
  }

  processImmunizationData(data: any) {
    this.immunizationData = [];

    data.forEach((element: any) => {
      this.dob = element.dob;
      const ageatvaccine = this.getAgeAtVaccine(element.immunizationdate, element.dob);
      let source = '';
      if (data.source) { source = data.source } else {
        if (element.sourcesystem) {
          if (element.insertedby === 'CRISP_INBOUND') {
            source = 'CRISP';
          } else if (element.insertedby != 'CRISP_INBOUND') {
            source = 'CJAMS / CRISP';
          }
        } else {
          source = 'CJAMS';
        }
      }
      const column = {
        immunizationdate: element.immunizationdate,
        vaccinename: element.vaccinename,
        source: source,
        ageatvaccine: ageatvaccine,
        comments: element.comments,
        personimmunizationconfigid: element.personimmunizationconfigid,
        personimmunizationid: element.personimmunizationid,
        description: element.description,
        recordstatus: element.recordstatus,
        updatedon: element.updatedon,
      };
      this.immunizationData.push(column);
    });
    this.immunizationData.sort((a, b) => {
      const dateA = moment(a.immunizationdate);
      const dateB = moment(b.immunizationdate);
      return dateA.diff(dateB);
    })
  }

  getAgeAtVaccine(immunizationdate: any, persondob: any) {
    if (!immunizationdate || !persondob) {
      return 'N/A';
    }

    const dob = new Date(persondob);
    const vacDate = new Date(immunizationdate);

    let years = vacDate.getFullYear() - dob.getFullYear();
    let months = vacDate.getMonth() - dob.getMonth();

    if (months < 0) {
      years--;
      months += 12;
    }

    return `${years} Year(s) ${months} Month(s)`;
  }

  initForm() {
    this.addVaccineForm = this._formBuilder.group({
      vaccinename: [null, Validators.required],
      dose_dt: [null, Validators.required],
      comments: [null]
    });
  }

  createVaccineWithData(data: any) {
    this.vaccinesWithData = [];
    data.forEach((item: any) => {
      const vaccine = this.immunizationTypes.find(val => val.personimmunizationconfigid === item.personimmunizationconfigid);
      const vaccinename = `${vaccine.value_text} ${vaccine.description}`;
      const vaccineschedule = `${vaccine.vaccineschedule}`;
      if (vaccine && !this.vaccinesWithData?.some(vac => vac.vaccinename == vaccinename)) {
        this.vaccinesWithData.push({ vaccinename, vaccineschedule, hasData: true });
      }
    });
    this.immunizationTypes.forEach(vaccine => {
      const vaccinename = `${vaccine.value_text} ${vaccine.description}`;
      const vaccineschedule = `${vaccine.vaccineschedule}`;
      if (vaccinename && !this.vaccinesWithData?.some(vac => vac.vaccinename == vaccinename)) {
        this.vaccinesWithData.push({ vaccinename, vaccineschedule, hasData: false });
      }
    })
    this.vaccinesWithData.sort((a, b) => a.vaccinename.localeCompare(b.vaccinename));
    this.vaccinesWithData.forEach(item => {
      this.tableVisibility[item.vaccinename] = item.hasData;
    });
    this.buttonName = 'Collapse All';
  }

  onSearch() {
    const extraFilters: any = {};
    this.updatedonFromQuery = 2;
    this.startDate = this.filterDateForm.get('startDate')?.value;
    this.endDate = this.filterDateForm.get('endDate')?.value;
    this.dateFilter = this.filterDateForm.get('filterDate')?.value;
    if (this.dateFilter === 'UPDATED_ON') {
      extraFilters['updatedonStartDt'] = this.startDate;
      extraFilters['updatedonEndDt'] = this.endDate;
    } else if (this.dateFilter === 'VACC_DATE') {
      extraFilters['immunizationStartDt'] = this.startDate;
      extraFilters['immunizationEndDt'] = this.endDate;
    }
    this.getImmunizedData(extraFilters);
  }

  initFilterForm() {
    this.filterDateForm = this._formBuilder.group({
      startDate: [this.startDate],
      endDate: [this.endDate],
      filterDate: [this.dateFilter]
    })
    this.filterDateForm.get('filterDate')?.valueChanges.subscribe((data) => {
      if (data) {
        this.disableDates = false;
      } else {
        this.disableDates = true;
      }
    })
  }

  clearFilter() {
    this.filterDateForm.reset();
    this.filterDateForm.markAsPristine();
    this.filterDateForm.get('startDate')?.disable();
    this.filterDateForm.get('endDate')?.disable();
    this.updatedonFromQuery = 3;
    this.getImmunizedData();
  }

  addVaccine() {
    this.selectedImmunization = null;
    this.reportMode = 'Add';
    this.submitUpdate = 'Submit';
    ($(this.addvaccinepopup)).modal('show');
  }

  private loadVaccineList() {
    this._commonHttpService.getPagedArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'agetype': 'All' }
      },
      'personimmunizationconfig/list?filter'
    ).subscribe(immunizationTypes => {
      if (immunizationTypes.data && Array.isArray(immunizationTypes.data)) {
        this.immunizationTypes = immunizationTypes.data;
        const queryParams = this._activatedRoute.snapshot.queryParams;
        const extraFilters: any = {};
        if (queryParams['updatedon'] && this.updatedonFromQuery == 0) {
          this.updatedonFromQuery = 1;
          var updatedondate = new Date(queryParams['updatedon']);
          updatedondate.setMinutes(updatedondate.getMinutes() + updatedondate.getTimezoneOffset());
          this.filterDateForm.patchValue({
            filterDate: 'UPDATED_ON',
            startDate: updatedondate,
            endDate: updatedondate
          });
          extraFilters['updatedonStartDt'] = queryParams['updatedon'];
          extraFilters['updatedonEndDt'] = queryParams['updatedon'];
        }
        this.getImmunizedData(extraFilters);
      }
    });
  }

  private getImmunizedData(extraFilters: any = {}) {
    const defaultFilters = {
      'personid': this._personInfoService.getPersonId()
    }
    const filters = { ...defaultFilters, ...extraFilters };
    this._commonHttpService.getPagedArrayList(
      {
        method: 'post',
        nolimit: true,
        where: filters
      },
      'personimmunizationconfig/immunizationlist?filter'
    ).subscribe(immunizationTypesData => {
      if (immunizationTypesData.data && Array.isArray(immunizationTypesData.data)) {
        this.fetchedImmunizationData = immunizationTypesData.data;
        this.processImmunizationData(immunizationTypesData.data);
        this.createVaccineWithData(immunizationTypesData.data);
      }
    });
  }

  openComments(immunization: any) {    
    this.selectedImmunizationComments = immunization;
    ($(this.immunizationnotespopupid)).modal('show');
  }

  closeModal() {
    $('#audittrail-expand').modal('hide');
    $('#history-popup').modal('hide');
  }

  saveImmunization(mode: any) {
    const input = this.addVaccineForm.getRawValue();
    const vaccine = this.immunizationTypes.find(item => (item.value_text+' '+item.description) === input.vaccinename);
    if(vaccine){
      let data;
      if(mode == 'Add'){
         data = {
          'personimmunizationconfigid': vaccine.personimmunizationconfigid,
          'immunizationdate': input.dose_dt,
          'comments': input.comments,
          'isnew': 1
        };
      }else if(mode == 'Edit'){
         data = {
          'personimmunizationconfigid': vaccine.personimmunizationconfigid,
          'immunizationdate': input.dose_dt,
          'comments': input.comments,
          'isnew': 1,
          'personimmunizationid' : this.selectedImmunization.personimmunizationid
        };
      }
      const isValidAdd = this.checkDateExist(data, mode) 
      if (!isValidAdd.success) {
        this._alertService.error(isValidAdd.message);
        return;
      }
      this._healthService.saveHealth({ 'personImmunization': data }).subscribe((_response: any) => {
        this._alertService.success('Immunization Info Saved Successfully');
        this.getImmunizedData();
      });
    }else{
      this._alertService.error('Vaccine not found');
    }    
    ($(this.addvaccinepopup)).modal('hide');
    this.resetForm();
  }

  editImmunization(column: any){
    this.reportMode = 'Edit';
    this.submitUpdate = 'Update';
    const vaccine = column.vaccinename + ' ' + column.description;
    this.editDoseDate = column.date;
    this.addVaccineForm.patchValue({
      vaccinename : vaccine,
      dose_dt : column.immunizationdate,
      comments: column.comments
    });
    ($(this.addvaccinepopup)).modal('show');
    this.selectedImmunization = column;
    this.addVaccineForm.valueChanges.subscribe(() => {
      this.checkForChange(this.selectedImmunization);
    })
  }

  checkForChange(initial: any) {
    this.isModified = moment(initial?.immunizationdate).format('YYYY-MM-DD') !== moment(this.addVaccineForm.get('dose_dt')?.value).format('YYYY-MM-DD') || initial.comments !== this.addVaccineForm.get('comments')?.value;
  }

  hideStatusPopup(isDelete: boolean) {
    if (isDelete) {
      ($('#confirm-popup')).modal('hide');
    }
  }
  updateStatus(column: any, recordstatus: any) {
    this.recordstatus = recordstatus;
    this.selectedRow = column;
    ($('#confirm-popup')).modal('show');
  }
  updateHealth() {
    this._healthService.updateHealth({
      recordstatus: ((this.recordstatus === 1) && this.selectedRow.recordstatus === 1) ? null : this.recordstatus,
      id: this.selectedRow.personimmunizationid
    }).subscribe(response => {
      let msg: any = (this.recordstatus === 0) ? "Deleted" :  this.returnMsgFn();
      this._alertService.success('Immunization Info '+ msg + ' Successfully');
      this.getImmunizedData();
      this.resetForm();
    });
  }

  private returnMsgFn(): any {
    return (this.recordstatus === 1) ? "Rejected" : "Undo";
  }

  resetForm() {
    this.reportMode = 'Add';
    this.addVaccineForm.reset();
    this.addVaccineForm.markAsPristine();
    ($(this.addvaccinepopup)).modal('hide');
  }

  showHistory(immunizationid: any) {
    this.auditlogTrail = [];
    this._commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: 30,
        page: 1,
        method: 'get',
        where: {
          columnid: 'personid',
          tableid: 'personimmunization_history',
          personimmunizationid: immunizationid,
          objectid: this._personInfoService.getPersonId()
        }
      }),
      'servicecase/getauditlogbyimmunizationid?filter').subscribe((result: any) => {
        if (result && result.data) {
          this.auditlogTrail = result.data;
          this.ready = true;
        } else {
          this.auditlogTrail = [];
        }
        if (this.ready) {
          ($('#history-popup')).modal('show');
        }
      });
  }

  toggleTable(val: any) {
    this.tableVisibility[val] = !this.tableVisibility[val];
  }

  toggleAll() {
    if (this.buttonName == 'Expand All') {
      this.vaccinesWithData.forEach(item => {
        this.tableVisibility[item.vaccinename] = item.hasData;
      });
      this.buttonName = 'Collapse All';
    } else {
      this.vaccinesWithData.forEach(item => {
        this.tableVisibility[item.vaccinename] = false;
      });
      this.buttonName = 'Expand All';
    }

  }
  checkDateExist(data: any, mode: any): any {
    if (mode === 'Add') {
      const personimmunizationconfigid = data.personimmunizationconfigid;
      const vaccdate = data.immunizationdate;
      const isAlreadyExistsVaccDate = this.fetchedImmunizationData.some(e => e.personimmunizationconfigid == personimmunizationconfigid && moment(e.immunizationdate).format('YYYY-MM-DD') == moment(vaccdate).format('YYYY-MM-DD'));
      if (isAlreadyExistsVaccDate) {
        return {
          message: `Vaccine Date already exists for the vaccine.`,
          success: false
        }
      } else {
        return {
          message: null,
          success: true
        }
      }
    } else if (mode === 'Edit') {
      const vaccdate = data.immunizationdate;
      const personimmunizationid = data.personimmunizationid;
      const comments = data.comments;
      const existingVaccine = this.fetchedImmunizationData.find(e => e.personimmunizationid = personimmunizationid);
      const isSameDate = moment(existingVaccine.immunizationdate).format('YYYY-MM-DD') == moment(vaccdate).format('YYYY-MM-DD') ? true : false;
      const isSameComments = comments == existingVaccine.comments ? true : false;
      if (isSameDate && isSameComments) {
        return {
          message: `Please change any values for update.`,
          success: false
        }
      } else {
        return {
          message: null,
          success: true
        }
      }
    }
  }
}
