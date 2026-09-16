import { Component, OnInit, Injector } from '@angular/core'
import {
  PaginationInfo, PaginationRequest
} from '../../../../../@core/entities/common.entities'
import { PersonHealthService } from '../person-health.service'
import { PersonInfoService } from '../../person-info.service';
import { PersonDisabilityService } from '../../../person-disability/person-disability.service';
import { CommonHttpService, DataStoreService,SessionStorageService, AuthService } from '../../../../../@core/services';
import moment from 'moment';
import { QueryType } from '../../../../../@core/common/models/person-health-summary.model';
import { AppConstants } from '../../../../../@core/common/constants';
import { IntakeStoreConstants } from '../../../../newintake/my-newintake/my-newintake.constants';
import { FormGroup, FormBuilder } from '@angular/forms';
import { CASE_STORE_CONSTANTS } from '../../../../case-worker/_entities/caseworker.data.constants';
import { Router, ActivatedRoute } from '@angular/router';
import { CaseWorkerUrlConfig } from '../../../../case-worker/case-worker-url.config';
import { GLOBAL_MESSAGES } from '../../../../../@core/entities/constants';

@Component({
    selector: 'person-health-summary-cw',
    templateUrl: './person-health-summary-cw.component.html',
    styleUrls: ['./person-health-summary-cw.component.scss'],
    standalone: false
})
export class PersonHealthSummaryCwComponent implements OnInit {
  PHSDateForm!: FormGroup;
  paginationInfo: PaginationInfo = new PaginationInfo()
  personId: any
  placementList: any[] = [];
  providerplacement = 'Provider Placement';
  livingarrangement = 'Living Arrangement';
  childList: any[] = [];
  fetchedExaminationList: any[] = [];
  fetchedBirthDetails: any[] = [];
  fetchedReproductiveHealth: any[] = [];
  fetchedHospitalizationList: any[] = [];
  fetchedImmunizationList: any[] = [];
  fetchedCovidList: any[] = [];
  fetchedBehavirolHealthList: any[] = [];
  fetchedDisabilityList: any[] = [];
  fetchedFamilyHistory: any[] = [];
  fetchedFeedingInfoList: any[] = [];
  fetchedInsuranceInfo: any[] = [];
  fetchedMedicalConditionList: any[] = [];
  fetchedMedicationList: any[] = [];
  fetchedProviderInfo: any[] = [];
  fetchedMobilityList: any[] = [];
  fetchedSleepingList: any[] = [];
  fetchedEliminationList: any[] = [];
  fetchedHealthPassportList: any[] = [];
  totalcount!: number
  totalPage!: number
  pageInfo: PaginationInfo = new PaginationInfo()
  examinationList: any[] = []
  tableVisibility: any = {
    examination: false,
    reproductiveHealth: false,
    birthDetails: false,
    hospitalization: false,
    immunization: false,
    behavirolHealth: false,
    disability: false,
    familyHistory: false,
    feedingInfo: false,
    insuranceInfo: false,
    medicalCondition: false,
    medication: false,
    providerInfo: false,
    mobility: false,
    sleeping: false,
    elimination: false,
    healthPassport: false,
  };
  intakeNumber:any;
  startDate = moment().subtract(31, 'days').startOf('day').toDate();
  endDate = moment().subtract(1, 'day').startOf('day').toDate();

  //Accordion tabs
  allVisibility: boolean = false;


  today = new Date();
  placementDetails: any;

  immunizationHeaderStructure: any[] = [];
  immunizationDataStructure: any[] = [];
  immunizationTypes: any[] = [];
  personimmunizationconfigid: any


  examinationData: any[] = [];
  examinationTotalCount: any
  examinationColumns: string[] = [];
  examinationKeys: any[] = [];

  birthDetails: any[] = []
  birthDetailsData: any[] = [];
  birthDetailsTotalCount: any
  birthDetailsColumns: string[] = [];
  birthDetailsKeys: any[] = [];

  reproductiveHealthList: any[] = []
  reproductiveHealthData: any[] = [];
  reproductiveHealthTotalCount: any
  reproductiveHealthColumns: string[] = [];
  reproductiveHealthKeys: any[] = [];


  hospitalizationList: any[] = []
  hospitalizationData: any[] = [];
  hospitalizationTotalCount: any
  hospitalizationColumns: string[] = [];
  hospitalizationKeys: any[] = [];

  immunizationList: any[] = []
  immunizationData: any[] = [];
  immunizationTotalCount: any
  immunizationColumns: string[] = [];
  immunizationKeys: any[] = [];

  covidList: any[] = []
  covidData: any[] = [];
  covidTotalCount: any
  covidColumns: string[] = [];
  covidKeys: any[] = [];

  behavirolHealthList: any[] = []
  behavirolHealthData: any[] = [];
  behavirolHealthTotalCount: any
  behavirolHealthColumns: string[] = [];
  behavirolHealthKeys: any[] = [];

  disabilityList: any[] = []
  disabilityData: any[] = [];
  disabilityTotalCount: any
  disabilityColumns: string[] = [];
  disabilityKeys: any[] = [];

  familyHistoryList: any[] = []
  familyHistoryData: any[] = [];
  familyHistoryTotalCount: any
  familyHistoryColumns: string[] = [];
  familyHistoryKeys: any[] = [];

  feedingInfoList: any[] = []
  feedingInfoData: any[] = [];
  feedingInfoTotalCount: any
  feedingInfoColumns: string[] = [];
  feedingInfoKeys: any[] = [];

  insuranceInfoList: any[] = []
  insuranceInfoData: any[] = [];
  insuranceInfoTotalCount: any
  insuranceInfoColumns: string[] = [];
  insuranceInfoKeys: any[] = [];

  medicalConditionList: any[] = []
  medicalConditionData: any[] = [];
  medicalConditionTotalCount: any
  medicalConditionColumns: string[] = [];
  medicalConditionKeys: any[] = [];

  medicationList: any[] = []
  medicationData: any[] = [];
  medicationTotalCount: any
  medicationColumns: string[] = [];
  medicationKeys: any[] = [];

  providerInfoList: any[] = []
  providerInfoData: any[] = [];
  providerInfoTotalCount: any
  providerInfoColumns: string[] = [];
  providerInfoKeys: any[] = [];

  mobilityList: any[] = []
  mobilityData: any[] = [];
  mobilityTotalCount: any
  mobilityColumns: string[] = [];
  mobilityKeys: any[] = [];

  sleepingList: any[] = []
  sleepingData: any[] = [];
  sleepingTotalCount: any
  sleepingColumns: string[] = [];
  sleepingKeys: any[] = [];

  eliminationList: any[] = []
  eliminationData: any[] = [];
  eliminationTotalCount: any
  eliminationColumns: string[] = [];
  eliminationKeys: any[] = [];

  healthPassportList: any[] = []
  healthPassportData: any[] = [];
  healthPassportTotalCount: any
  healthPassportColumns: string[] = [];
  healthPassportKeys: any[] = [];;

  covidVaccines: any = [];
  covidVaccineTypes: any = [];
  removaldate: any;

  private _service: PersonInfoService;
  private _healthService: PersonHealthService;
  private _router: Router;
  private readonly route: ActivatedRoute;
  private _formBuilder: FormBuilder;
  private readonly _session: SessionStorageService;
  private _dataStoreService: DataStoreService;
  private _commonHttpService: CommonHttpService;
  private _personInfoService: PersonInfoService;
  private _personDisabilityService: PersonDisabilityService;
  private _authService: AuthService;
  constructor(private injector: Injector) {
    this._service = this.injector.get<PersonInfoService>(PersonInfoService);
    this._healthService = this.injector.get<PersonHealthService>(PersonHealthService);
    this._router = this.injector.get<Router>(Router);
    this._authService = this.injector.get<AuthService>(AuthService);
    this.route = this.injector.get<ActivatedRoute>(ActivatedRoute);
    this._formBuilder = this.injector.get<FormBuilder>(FormBuilder);
    this._session = this.injector.get<SessionStorageService>(SessionStorageService);
    this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
    this._commonHttpService = this.injector.get<CommonHttpService>(CommonHttpService);
    this._personInfoService = this.injector.get<PersonInfoService>(PersonInfoService);
    this._personDisabilityService = this.injector.get<PersonDisabilityService>(PersonDisabilityService);


    this.covidVaccineTypes = [
      { value: 'single', text: 'Single Shot Vaccine' },
      { value: 'two', text: 'Two Shot Vaccine' },
      { value: 'boost', text: 'Booster Shot' }
    ];
  }

  ngOnInit(): void {
    this.initPHSDateFormGroup();
    this.paginationInfo.sortBy = null
    this.paginationInfo.sortColumn = null
    this.paginationInfo.sortBy = null
    this.paginationInfo.sortColumn = null
    this.personId = this._personInfoService.getPersonId();
    this.fetchExaminationList()
    this.fetchBirthDetails()
    this.fetchReproductiveHealth()
    this.fetchHospitalizationList()
    this.fetchImmunizationList()
    this.fetchBehavirolHealthList()
    this.fetchDisabilityList()
    this.fetchFamilyHistory()
    this.fetchFeedingInfoList()
    this.fetchInsuranceInfo()
    this.fetchMedicalConditionList()
    this.fetchMedicationList()
    this.fetchProviderInfoList()
    this.fetchMobilityList()
    this.fetchSleepingList()
    this.fetchEliminationList()
    if(this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID)) {
      this.getChildRemoval()
    }
    const activeModule = this._session.getItem('activeModuleNav');
    if (activeModule == 'Medical Specialist'){
      this._session.setItem('isView', false);
    }

  }

  initPHSDateFormGroup() {
    this.PHSDateForm = this._formBuilder.group({
      startDate: [this.startDate],
      endDate: [this.endDate]
    });
  }

  navigateToSection(sectionId: string) {
    this._healthService.setActiveSection(sectionId);
  }

  onSearch(): void {
    this.startDate = this.PHSDateForm.get('startDate')?.value;
    this.endDate = this.PHSDateForm.get('endDate')?.value;
    this.onsearchFilterData()
    // Fetch data based on the start and end date
    this.pageInfo = new PaginationInfo();
    this.paginationInfo = new PaginationInfo()
    this.fetchExaminationList()
    this.fetchBirthDetails()
    this.fetchReproductiveHealth()
    this.fetchHospitalizationList()
    this.fetchImmunizationList()
    this.fetchBehavirolHealthList()
    this.fetchDisabilityList()
    this.fetchFamilyHistory()
    this.fetchFeedingInfoList()
    this.fetchInsuranceInfo()
    this.fetchMedicalConditionList()
    this.fetchMedicationList()
    this.fetchProviderInfoList()
    this.fetchMobilityList()
    this.fetchSleepingList()
    this.fetchEliminationList()
    this.fetchHealthPassportList()

  }

  onsearchFilterData(){
    this.fetchedInsuranceInfo = [];
    this.insuranceInfoData = [];
    this.fetchedHealthPassportList = [];
    this.healthPassportData = [];
    this.fetchedEliminationList = [];
    this.eliminationData = [];
    this.fetchedSleepingList = [];
    this.sleepingData = [];
    this.fetchedMobilityList = [];
    this.mobilityData = [];
    this.fetchedProviderInfo = [];
    this.providerInfoData = [];
    this.fetchedFeedingInfoList = [];
    this.feedingInfoData = [];
    this.fetchedInsuranceInfo = [];
    this.insuranceInfoData = [];
  }

  searchAndSortUtil(sortColumn: any, sortBy: any, sortedList: any, dbPropertyName: any, query: any, columnMapping: any) {
    sortedList = this.sortList(sortColumn, sortBy, sortedList, columnMapping);
    sortedList = this.searchList(query, sortedList, columnMapping);
    return sortedList;
  }

  sortList(sortColumn: any, sortBy: any, sortedList: any, columnMapping: any) {
    if (!sortColumn || !sortBy) {
      return sortedList;
    }
    if (sortColumn === 'Provider Info' && sortBy) {
      return this.handleSortByProviderInfo(sortBy, sortedList);
    } else if (sortColumn && sortBy) {
      this.handleSortedListFn(sortedList, columnMapping, sortColumn, sortBy);
      return sortedList;
    }
  }
  // Assosiated with sortList method
  private handleSortedListFn(sortedList: any, columnMapping: any, sortColumn: any, sortBy: any) {
    sortedList.sort((a: any, b: any) => {
      const aValue = a[columnMapping[sortColumn]];
      const bValue = b[columnMapping[sortColumn]];

      // Handle empty values
      if (!aValue && !bValue) {
        return 0;
      } else if (!aValue) {
        return sortBy === 'asc' ? -1 : 1;
      } else if (!bValue) {
        return sortBy === 'asc' ? 1 : -1;
      }

      if (sortBy === 'asc') {
        return this.handleAscFn(aValue, bValue);
      } else if (sortBy === 'desc') {
        return this.handleDescFn(aValue, bValue);
      }
      return 0;
    });
  }
  // Assosiated with sortList method
  private handleDescFn(aValue: any, bValue: any) {
    if (typeof aValue === 'string' && typeof bValue === 'string') {
      return bValue.localeCompare(aValue);
    } else if (typeof aValue === 'number' && typeof bValue === 'number') {
      return bValue - aValue;
    } else if (typeof aValue === 'object' && typeof bValue === 'object') {
      if (aValue instanceof Date && bValue instanceof Date) {
        const dateA = new Date(aValue);
        const dateB = new Date(bValue);
        return dateB.getTime() - dateA.getTime();
      }
      if (Array.isArray(aValue) && Array.isArray(bValue)) {
        return JSON.stringify(bValue).localeCompare(JSON.stringify(aValue));
      }
    }
    return 0
  }
  // Assosiated with sortList method
  private handleAscFn(aValue: any, bValue: any) {
    if (typeof aValue === 'string' && typeof bValue === 'string') {
      return aValue.localeCompare(bValue);
    } else if (typeof aValue === 'number' && typeof bValue === 'number') {
      return aValue - bValue;
    } else if (typeof aValue === 'object' && typeof bValue === 'object') {
      if (aValue instanceof Date && bValue instanceof Date) {
        const dateA = new Date(aValue);
        const dateB = new Date(bValue);
        return dateA.getTime() - dateB.getTime();
      }
      if (Array.isArray(aValue) && Array.isArray(bValue)) {
        return JSON.stringify(aValue).localeCompare(JSON.stringify(bValue));
      }
    }
    return 0;
  }
  // Assosiated with sortList method
  private handleSortByProviderInfo(sortBy: any, sortedList: any) {
    if (sortBy === 'desc') {
      this.handleSortedListDescFn(sortedList);
    }

    if (sortBy === 'asc') {
      this.handleSortedListAscFn(sortedList);
    }
    return sortedList;
  }
  // Assosiated with sortList method
  private handleSortedListAscFn(sortedList: any) {
    sortedList.sort((a: any, b: any) => {
      if (!a.physician.physicianname && b.physician.physicianname) {
        return 1;
      }
      if (a.physician.physicianname && !b.physician.physicianname) {
        return -1;
      }
      if (!a.physician.physicianname && !b.physician.physicianname) {
        return 0;
      }
      return a.physician.physicianname.localeCompare(b.physician.physicianname);
    });
  }
  // Assosiated with sortList method
  private handleSortedListDescFn(sortedList: any) {
    sortedList.sort((a: any, b: any) => {
      if (!a.physician.physicianname && b.physician.physicianname) {
        return 1;
      }
      if (a.physician.physicianname && !b.physician.physicianname) {
        return -1;
      }
      if (!a.physician.physicianname && !b.physician.physicianname) {
        return 0;
      }
      return b.physician.physicianname.localeCompare(a.physician.physicianname);
    });
  }

  searchList(query: any, sortedList: any, columnMapping: any) {
    for (const key in query) {
      if (key !== 'sortColumn' && key !== 'sortDirection') {
        if (query[key] === null || query[key] === '') {
          continue;
        } else {
          const searchColumn = key;
          const searchValue = query[key];

          if (searchColumn === 'Provider Info') {
            const searchValuePI = query[key]?.toLowerCase();
            sortedList = sortedList.filter((e: any) =>
              e.physician?.physicianname?.toLowerCase().includes(searchValuePI)
              || e.physician?.speciality?.toLowerCase().includes(searchValuePI)
              || e.physician?.affilication?.toLowerCase().includes(searchValuePI)
            );
          } else {
            sortedList = this.handleIfSearchColumnIsNotProviderInfo(sortedList, columnMapping, searchColumn, searchValue);
          }
        }
      }
    }
    return sortedList;
  }
  // Assosiated with searchList method
  private handleIfSearchColumnIsNotProviderInfo(sortedList: any, columnMapping: any, searchColumn: string, searchValue: any) {
    sortedList = sortedList.filter(() => {
      const columnValue = (0, eval)(`item.${columnMapping[searchColumn]}`);
      if (typeof columnValue === 'string' && moment(columnValue, true).isValid()) {
        return this.getDateFormatted(columnValue).toLowerCase().includes(searchValue.toLowerCase());
      } else if (columnValue && typeof columnValue === 'string') {
        if (columnValue.toLowerCase() !== 'unknown') {
          return columnValue.toLowerCase().includes(searchValue.toLowerCase());

        } else {
          return searchValue.toLowerCase() === 'unknown';
        }
      } else if (columnValue && typeof columnValue === 'number') {
        return columnValue === Number(searchValue);
      } else if (columnValue && typeof JSON.stringify(columnValue) === 'string') {
        return JSON.stringify(columnValue).toLowerCase().includes(searchValue.toLowerCase());
      }
    });
    return sortedList;
  }

  toggleTable(table: string) {
    this.tableVisibility[table] = !this.tableVisibility[table];
  }

  toggleAll() {
    this.allVisibility = !this.allVisibility;
    Object.keys(this.tableVisibility).forEach((key) => {
      this.tableVisibility[key] = this.allVisibility
    });
  }

  fetchExaminationList() {
    // Fetch the examination list only if it's not already fetched
    this._healthService.getExaminationList({startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD')}).subscribe((list) => {
      if (list && Array.isArray(list) && list?.length) {
        // Store the fetched examination list
        this.fetchedExaminationList = list
        // Process the examination list
        this.loadExaminationList()
      } else if(list && Array.isArray(list) && list?.length === 0){
        this.fetchedExaminationList = [];
        this.examinationData = [];
      }
    });
  }


  loadExaminationList(query: QueryType = {}) {
    // Process the examination list
    const columnMapping: any = {
      'Nature of Exam': 'appointment[0].natureofexamdesc',
      'Appointment Date': 'appointment[0].apptDate',
      'Next Appointment Date': 'appointment[0].nextApptDate',
      'Speciality Exam': 'appointment[0].specialitydesc',
      'Provider Info': 'appointment[0].providerinfoflag',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn;
    const sortBy: any = query.sortDirection;

    let sortedList: any = this.fetchedExaminationList;

    const dbPropertyName = columnMapping[sortColumn];
    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);

    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.examinationList = sortedList?.slice(startIndex, endIndex);

    this.examinationData = this.examinationList?.map(examination => {
      const appointmentDate = this.getValueByPath(
        examination,
        columnMapping['Appointment Date']
      );

      const nextAppointmentDate = this.getValueByPath(
        examination,
        columnMapping['Next Appointment Date']
      );

      return {
        'Nature of Exam': this.getValueByPath(
          examination,
          columnMapping['Nature of Exam']
        ),

        'Appointment Date': appointmentDate
          ? this.getDateFormatted(appointmentDate)
          : '',

        'Next Appointment Date': nextAppointmentDate
          ? this.getDateFormatted(nextAppointmentDate)
          : '',

        'Speciality Exam': examination.appointment?.[0]?.specialitydesc ?? '',

        'Provider Info': examination.providerinfoflag
          ? `
            <td>
              <p>Physician Name: ${examination?.physician?.physicianname ?? ''}</p>
              <p>Speciality: ${examination?.physician?.speciality ?? ''}</p>
              <p>Affiliation/Organization: ${examination?.physician?.affilication ?? ''}</p>
            </td>
          `
          : `<td>N/A</td>`,

        Action: examination,
      };
    });
    
    this.examinationTotalCount =
      this.examinationList && this.examinationList?.length > 0
        ? sortedList?.length
        : 0
    this.examinationColumns = Object.keys(this.examinationData?.[0] || columnMapping);
    this.examinationKeys = Object.keys(this.examinationData?.[0] || columnMapping);
  }

  getValueByPath(obj: any, path: string): any {
    if (!obj || !path) return undefined;

    return path
      .replace(/\[(\d+)\]/g, '.$1') // appointment[0] → appointment.0
      .split('.')
      .reduce((acc, key) => acc?.[key], obj);
  }

  fetchBirthDetails() {
    this._healthService.getBirthInfo({startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD')}).subscribe((list) => {
      if (list && Array.isArray(list) && list.length) {
        this.fetchedBirthDetails = list[0].getbirthinfolist.personBirth;
        this.loadBirthDetails()
      } else if(list && Array.isArray(list) && list.length === 0){
        this.fetchedBirthDetails = [];
        this.birthDetailsData = [];
      }
    })
  }


  loadBirthDetails(query: QueryType = {}) {
    const columnMapping = {
      'Medical Conditions': 'mentalcondition',
      'Diseases': 'diseasescondition',
      'Birth Defects': 'birthdefects',
      'Comments': 'comments',
      'Updated By': 'updatedby',
      'Updated On': 'updatedon',
      'Action': 'view'
    };

    const sortedList = this.fetchedBirthDetails;
    this.birthDetailsData = sortedList?.map((e) => ({
      'Medical Conditions': e.mentalcondition,
      'Diseases': e.diseasescondition,
      'Birth Defects': e.birthdefects,
      'Comments': e.comments,
      'Updated By': e.updatedby,
      'Updated On': this.getDateFormatted(e.updatedon),
      Action: e,
    }))

    this.birthDetailsTotalCount =
      sortedList && sortedList.length > 0
        ? sortedList.length
        : 0
    this.birthDetailsColumns = Object.keys(this.birthDetailsData?.[0] || columnMapping)
    this.birthDetailsKeys = Object.keys(this.birthDetailsData?.[0] || columnMapping)
  }


  fetchReproductiveHealth() {
    this._healthService.getSexualInfo({startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD')}).subscribe((list) => {
      if (list.personsexualinfo && Array.isArray(list.personsexualinfo) && list.personsexualinfo.length) {
        console.log('list', list);
        this.fetchedReproductiveHealth = list.personsexualinfo
        this.loadReproductiveHealth()
      } else if(list.personsexualinfo && Array.isArray(list.personsexualinfo) && list.personsexualinfo.length === 0){
        this.fetchedReproductiveHealth = [];
        this.reproductiveHealthData = [];
      }
    })
  }

  getSexualActiveFlag(flag: string): string {
    if (flag === '1') {
      return 'Yes';
    } else if (flag === '0') {
      return 'No';
    } else {
      return 'Unknown';
    }
  }

  loadReproductiveHealth(query: QueryType = {}) {
    const columnMapping: any = {
      'Sexually Active': 'sexualactiveflag',
      'Number of Living Children': 'childrenno',
      'Sexually Transmiited Diseases': 'sextransdisdesc',
      'Birth Control Method': 'birthcontroldesc',
      'Updated By': 'updatedby_fullname',
      'Updated On': 'updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy: any = query.sortDirection
    let sortedList = this.fetchedReproductiveHealth?.map(e => {
      return { ...e, sexualactiveflag: this.getSexualActiveFlag(e.sexualactiveflag) }
    });
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.reproductiveHealthList = sortedList?.slice(startIndex, endIndex)

    this.reproductiveHealthData = this.reproductiveHealthList?.map((e) => ({
      'Sexually Active': e.sexualactiveflag,
      'Number of Living Children': e.childrenno,
      'Sexually Transmiited Diseases': e.sextransdisdesc,
      'Birth Control Method': e.birthcontroldesc,
      'Updated By': e.updatedby_fullname,
      'Updated On': this.getDateFormatted(e.updatedon),
      'Action': e,
    }))
    this.reproductiveHealthTotalCount =
      this.reproductiveHealthList && this.reproductiveHealthList?.length > 0
        ? sortedList?.length
        : 0
    this.reproductiveHealthColumns = Object.keys(this.reproductiveHealthData?.[0] || columnMapping)
    this.reproductiveHealthKeys = Object.keys(this.reproductiveHealthData?.[0] || columnMapping)
  }

  fetchHospitalizationList() {
    this._healthService.getHospitalizationInfo({startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD')}).subscribe((list) => {
      if (list.data && Array.isArray(list.data) && list.data.length) {
        this.fetchedHospitalizationList = list.data;
        this.loadHospitalizationList()
      } else if(list.data && Array.isArray(list.data) && list.data.length === 0) {
        this.fetchedHospitalizationList = [];
        this.hospitalizationData = [];
      }
    })
  }


  loadHospitalizationList(query: QueryType = {}) {
    const columnMapping: any = {
      'Type Of Hospitalization': 'hospitalization_typedesc',
      'Discharge Diagnosis': 'Hospital_DischargeDiagnoses',
      'Reason For Hospitalization': 'hospitalization_reasondesc',
      'Admission Date': 'Hospital_InpatientAdmissionDate',
      'Discharge Date': 'Hospital_DischargedDate',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedHospitalizationList;
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    this.handleHospitalizationPaginationFn(sortedList, columnMapping);
  }
  // Assosiated with loadHospitalizationList method
  private handleHospitalizationPaginationFn(sortedList: any[], columnMapping: any) {
    const currPage = this.pageInfo.pageNumber;

    const pageSize = 10;
    let startIndex = (currPage - 1) * pageSize;
    let endIndex = currPage * pageSize;

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.hospitalizationList = sortedList?.slice(startIndex, endIndex);

    this.hospitalizationData = this.hospitalizationList?.map((e) => ({
      'Type Of Hospitalization': e.hospitalization_typedesc,
      'Discharge Diagnosis': e.Hospital_DischargeDiagnoses,
      'Reason For Hospitalization': e.hospitalization_reasondesc,
      'Admission Date': e.Hospital_InpatientAdmissionDate ? this.getDateFormatted(e.Hospital_InpatientAdmissionDate) : '',
      'Discharge Date': e.Hospital_DischargedDate ? this.getDateFormatted(e.Hospital_DischargedDate) : '',
      Action: e,
    }));
    this.hospitalizationTotalCount =
      this.hospitalizationList && this.hospitalizationList?.length > 0
        ? sortedList?.length
        : 0;
    this.hospitalizationColumns = Object.keys(this.hospitalizationData?.[0] || columnMapping);
    this.hospitalizationKeys = Object.keys(this.hospitalizationData?.[0] || columnMapping);
  }

  fetchImmunizationList() {
    this.loadVaccineList();
  }


  loadImmunizationList(query: QueryType = {}) {
    const columnMapping: any = {
      'Vaccine Type': 'vaccine',
      'Source': 'source',
      'Administered Date': 'date',
      'Comments': 'comments',
      'Action': 'view'
    };

    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    const startIndex = (currPage - 1) * pageSize
    const endIndex = currPage * pageSize

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedImmunizationList?.map(e => {
      return {
        ...e, comments: e.comments?.replace(/<[^>]+>/g, '')
      }
    });
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    this.immunizationList = sortedList?.slice(startIndex, endIndex)

    this.immunizationData = this.immunizationList?.map((e) => ({
      'Vaccine Type': e.vaccine,
      'Source': e.source,
      'Administered Date': e.date,
      'Comments': e.comments,
      Action: e,
    }))
    this.immunizationTotalCount =
      this.immunizationList && this.immunizationList?.length > 0
        ? sortedList?.length
        : 0
    this.immunizationColumns = Object.keys(this.immunizationData?.[0] || columnMapping)
    this.immunizationKeys = Object.keys(this.immunizationData?.[0] || columnMapping)
  }

  processImmunizationDataStructure(data: any) {
    this.immunizationDataStructure = [];
    this.immunizationTypes.forEach((immunizationType: any) => {
      const immunizationTypeRow: any = this.getImmunizationTypeRow(immunizationType, data);
      this.immunizationDataStructure.push(immunizationTypeRow);
    });
    if(data) {
      this.fetchedImmunizationList = []
      this.immunizationDataStructure.forEach(v => {
        let vaccineType = '';
        v.forEach((e: any) => {
            vaccineType = this.handleImmunizationDataStructureLoopFn(e, vaccineType);
            this.fetchedImmunizationList.sort((a: any, b: any) => {
              if (a.vaccine == b.vaccine) {
                const dateA = moment(a.date);
                const dateB = moment(b.date);
                return dateA.diff(dateB);
              } else {
                return a.vaccine.localeCompare(b.vaccine)
              }
            })
        });
      })
      this.loadImmunizationList();
    }
  }
  // Assosiated with processImmunizationDataStructure method
  private handleImmunizationDataStructureLoopFn(e: any, vaccineType: string) {
    if (e.template === 'vaccine-type'){
      vaccineType = e.value;
    }
    if (e.template === 'data' && e.value.date) {

      this.fetchedImmunizationList.push({ vaccine: vaccineType, source: e.value.source, date: this.getDateFormatted(e.value.date), comments: e.value.comments });
    }
    return vaccineType;
  }


  getSource(data: any) {
    let source = '';
    if (data.sourcesystem) {
      if (data.updatedby === 'CRISP_INBOUND' && data.insertedby === 'CRISP_INBOUND') {
        source = 'CRISP';
      } else if (data.insertedby != 'CRISP_INBOUND') {
        source = 'CJAMS(CRISP)';
      }
    } else {
      source = 'CJAMS';
    }
    return source;
  }

  getImmunizationTypeRow(immunizationType: any, data: any) {
    const columns = [];
    const column = {
      template: '',
      value: ''
    };
    column.template = 'vaccine-type';
    column.value = immunizationType.value_text;
    columns.push(column);

    if (data && Array.isArray(data) && data.length) {
      data.forEach(item => {
        if (item.personimmunizationconfigid === immunizationType.personimmunizationconfigid) {
          let immunizeCol = {
            date: item.immunizationdate,
            comments: item.comments,
            source: this.getSource(item)
          }
          const doseColumn = {
            template: 'data',
            value: immunizeCol,
            immunizationtypekey: immunizationType.personimmunizationconfigid,
            personimmunizationid: item.personimmunizationid
          };
          columns.push(doseColumn);
        }
      })
    }

    return columns;
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
        this.getImmunizedData();
        this.processImmunizationDataStructure(null);
      }

    });
  }

  private getImmunizedData() {
    this._commonHttpService.getPagedArrayList(
      {
        method: 'get',
        nolimit: true,
        where: { 'personid': this._personInfoService.getPersonId(), startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD') }
      },
      'personimmunizationconfig/immunizationlist?filter'
    ).subscribe(immunizationTypes => {
      const filteredData: any[] = [];

      immunizationTypes.data.forEach(item => {
        if (item.recordstatus === null || item.recordstatus === 3) {
          filteredData.push(item);
        }
      })
      immunizationTypes.data = filteredData;
      if (immunizationTypes.data && Array.isArray(immunizationTypes.data)) {
        this.processImmunizationDataStructure(filteredData);
        this.loadImmunizationList();
      }
    });

  }

  // Assosiated with getImmunizedData method
  private checkCovidVaccineDoseFn(type: any) {
    if (this.covidVaccines.find((item: { dose: any; }) => item.dose === type.dose)) {
      if (type.comments === 'first') {
        const itemFound = this.covidVaccines.find((item: { dose: any; }) => item.dose === type.dose);
        itemFound.firstdose = type.immunizationdate;
        itemFound.firstdosepersonimmunizationid = type.personimmunizationid;
      } else if (type.comments === 'second') {
        const itemFound = this.covidVaccines.find((item: { dose: any; }) => item.dose === type.dose);
        itemFound.seconddose = type.immunizationdate;
        itemFound.seconddosepersonimmunizationid = type.personimmunizationid;
      }
    }
    else {
      this.covidVaccines.push({
        vaccinetype: this.covidVaccineTypes.find((item: { value: any; }) => item.value === type.dose).text,
        firstdose: type.comments === 'first' ? type.immunizationdate : null,
        seconddose: type.comments === 'second' ? type.immunizationdate : null,
        dose: type.dose,
        firstdosepersonimmunizationid: type.comments === 'first' ? type.personimmunizationid : null,
        seconddosepersonimmunizationid: type.comments === 'second' ? type.personimmunizationid : null
      });
    }
  }

  fetchBehavirolHealthList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId, startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD')  }
    }, 'personabusesubstance/behavesubstancelist?filter').subscribe(res => {
      this.fetchedBehavirolHealthList = res ? res.data : [];
      console.log(res);
      this.loadBehavirolHealthList()
    });
  }

  loadBehavirolHealthList(query: QueryType = {}) {
    const columnMapping: any = {
      'Behavioral Health': 'isbehaviouraldiagnosis',
      'Tobacco Use': 'isusetobacco',
      'Drug Use': 'isusedrug',
      'Alcohol Use': 'isusealcohol',
      'Updated By': 'updatedby',
      'Updated On': 'updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedBehavirolHealthList?.map(e => {
      return {
        ...e,
        isbehaviouraldiagnosis: e.isbehaviouraldiagnosis ? 'yes' : 'no',
        isusetobacco: e.isusetobacco ? 'yes' : 'no',
        isusedrug: e.isusedrug ? 'yes' : 'no',
        isusealcohol: e.isusealcohol ? 'yes' : 'no'
      }
    })
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.behavirolHealthList = sortedList?.slice(startIndex, endIndex)

    this.behavirolHealthData = this.behavirolHealthList?.map((e) => ({
      'Behavioral Health': e.isbehaviouraldiagnosis,
      'Tobacco Use': e.isusetobacco,
      'Drug Use': e.isusedrug,
      'Alcohol Use': e.isusealcohol,
      'Updated By': e.updatedby,
      'Updated On': this.getDateFormatted(e.updatedon),
      Action: e,
    }))
    this.behavirolHealthTotalCount =
      this.behavirolHealthList && this.behavirolHealthList?.length > 0
        ? sortedList?.length
        : 0
    this.behavirolHealthColumns = Object.keys(this.behavirolHealthData?.[0] || columnMapping)
    this.behavirolHealthKeys = Object.keys(this.behavirolHealthData?.[0] || columnMapping)
  }

  fetchDisabilityList() {
    this._personDisabilityService.getDisabilityList(this.personId, {startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD')}).subscribe((list) => {
      if (list && Array.isArray(list) && list?.length) {
        this.fetchedDisabilityList = list
        this.loadDisabilityList()
      } else if(list && Array.isArray(list) && list?.length === 0) {
        this.fetchedDisabilityList = [];
        this.disabilityData = [];
      }
    })
  }

  loadDisabilityList(query: QueryType = {}) {
    const columnMapping: any = {
      'Disability recorded': 'value_text',
      'Disability Status [Yes/No/Unknown]': 'disabilityconditiontypekey',
      'Disability Start Date': 'startdate',
      'Disability End Date': 'enddate',
      'Updated date': 'insertedon',
      'Updated By': 'submittedby',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection

    let sortedList = this.fetchedDisabilityList;

    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    this.handleDisabilityPaginationFn(sortedList, columnMapping);
  }
  // Assosiated with loadDisabilityList method
  private handleDisabilityPaginationFn(sortedList: any[], columnMapping: any) {
    const currPage = this.pageInfo.pageNumber;

    const pageSize = 10;
    let startIndex = (currPage - 1) * pageSize;
    let endIndex = currPage * pageSize;

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.disabilityList = sortedList?.slice(startIndex, endIndex);

    this.disabilityData = this.disabilityList?.map((e) => ({
      'Disability recorded': e.value_text,
      'Disability Status [Yes/No/Unknown]': e.disabilityconditiontypekey,
      'Disability Start Date': e.startdate ? this.getDateFormatted(e.startdate) : '',
      'Disability End Date': e.enddate ? this.getDateFormatted(e.enddate) : '',
      'Updated date': e.insertedon
        ? this.getDateFormatted(e.insertedon)
        : '',
      'Updated By': e.submittedby,
      Action: e,
    }));
    this.disabilityTotalCount =
      this.disabilityList && this.disabilityList?.length > 0
        ? sortedList?.length
        : 0;
    this.disabilityColumns = Object.keys(this.disabilityData?.[0] || columnMapping);
    this.disabilityKeys = Object.keys(this.disabilityData?.[0] || columnMapping);
  }

  fetchFamilyHistory() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId, startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD') }
    }, 'personfamilyinfo/getpersonfamilyhistory?filter').subscribe((list) => {
      if (list.data && Array.isArray(list.data) && list.data.length) {
        this.fetchedFamilyHistory = list.data || [];
        this.loadFamilyHistory()
      } else if(list.data && Array.isArray(list.data) && list.data.length === 0){
        this.fetchedFamilyHistory = [];
        this.familyHistoryData = [];
      }
    })
  }


  loadFamilyHistory(query: QueryType = {}) {
    const columnMapping: any = {
      'Name': 'clientlist',
      'Health Problem': 'major_health_problems',
      'Death Cause': 'cause_of_death',
      'Updated By': 'updatedby',
      'Updated On': 'updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedFamilyHistory;
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.familyHistoryList = sortedList?.slice(startIndex, endIndex)

    this.familyHistoryData = this.familyHistoryList?.map((e) => ({
      'Name': e.clientlist,
      'Health Problem': this.displayMajorHealthProblems(e.major_health_problems),
      'Death Cause': (e.cause_of_death) ? e.cause_of_death.description_tx : '',
      'Updated By': e.updatedby,
      'Updated On': this.getDateFormatted(e.updatedon),
      'Action': e,
    }))
    this.familyHistoryTotalCount =
      this.familyHistoryList && this.familyHistoryList?.length > 0
        ? sortedList?.length
        : 0
    this.familyHistoryColumns = Object.keys(this.familyHistoryData?.[0] || columnMapping)
    this.familyHistoryKeys = Object.keys(this.familyHistoryData?.[0] || columnMapping)
  }

  displayMajorHealthProblems(healthProblems: any) {
    if (healthProblems && healthProblems.length > 0) {
      return healthProblems.map((data: { description: any; }) => data.description).join(",");
    }
    return '';
  }

  fetchFeedingInfoList() {
  if (!this.fetchedFeedingInfoList?.length) {
    const startDateRequest = this.startDate? moment(this.startDate).format('YYYY-MM-DD') : null;
    const endDateRequest = this.endDate? moment(this.endDate).format('YYYY-MM-DD') : null;
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId, startDate: startDateRequest, endDate:  endDateRequest }
    }, 'personfamilyinfo/getpersonfeeding?filter').subscribe((list) => {
      if (list.data && Array.isArray(list.data) && list.data.length) {

        this.fetchedFeedingInfoList = list.data;
        this.loadFeedingInfoList()
      }
    })
  } else {
    this.loadFeedingInfoList()
  }
  }

  getIsCollateralValue(value: any) : string {
    let isCollateralValue;
    if (value) {
      isCollateralValue = 'Collateral';
    }
    else {
      isCollateralValue = '';
    }
    return isCollateralValue;
  }

  loadFeedingInfoList(query: QueryType = {}) {
    const columnMapping: any = {
      'Info provided by': 'ishousehold',
      'Feeding Position': 'feeding_position',
      'Diet Type': 'diettype',
      'Eater Type': 'eatertype',
      'Updated By': 'updatedby_fullname',
      'Updated On': 'updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedFeedingInfoList;
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.feedingInfoList = sortedList?.slice(startIndex, endIndex)

    this.feedingInfoData = this.feedingInfoList?.map((e) => {
      const col = e.iscollateral ? 'Collateral' : '';
      return ({
        'Info provided by': e.ishousehold ? 'Household' : col,
        'Feeding Position': e.feeding_position,
        'Diet Type': e.diettype,
        'Eater Type': e.eatertype,
        'Updated By': e.updatedby_fullname,
        'Updated On': this.getDateFormatted(e.updatedon),
        Action: e,
      })
    })
    this.feedingInfoTotalCount =
      this.feedingInfoList && this.feedingInfoList?.length > 0
        ? sortedList?.length
        : 0
    this.feedingInfoColumns = Object.keys(this.feedingInfoData?.[0] || columnMapping)
    this.feedingInfoKeys = Object.keys(this.feedingInfoData?.[0] || columnMapping)
  }

  fetchInsuranceInfo() {
    if (!this.fetchedInsuranceInfo?.length) {
      const startDateRequest = this.startDate ? moment(this.startDate).format('YYYY-MM-DD') : null;
      const endDateRequest = this.endDate ? moment(this.endDate).format('YYYY-MM-DD') : null;
  
      this._commonHttpService.getPagedArrayList({
        page: 1,
        limit: 20,
        method: 'get',
        where: { personid: this.personId, startDate: startDateRequest, endDate: endDateRequest }
      }, 'personhealthinsurance/list?filter').subscribe((list) => {
        if (list.data && Array.isArray(list.data) && list.data.length) {
          this.fetchedInsuranceInfo = list.data;
          this.loadInsuranceInfo();
        }
      });
    } else {
      this.loadInsuranceInfo();
    }
  }  

  loadInsuranceInfo(query: QueryType = {}) {
    const columnMapping: any = {
      'Insurance': 'ismedicaidmedicare',
      'Policy Holder Name': 'policyholdername',
      'Policy Effective Date': 'effectivedate',
      'Expiration Date': 'expirationdate',
      'Update On': 'updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedInsuranceInfo;

    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    this.handleInsuranceInfoPaginationFn(sortedList, columnMapping);
  }
  // Assosiated with loadInsuranceInfo method
  private handleInsuranceInfoPaginationFn(sortedList: any[], columnMapping: any) {
    const currPage = this.pageInfo.pageNumber;

    const pageSize = 10;
    let startIndex = (currPage - 1) * pageSize;
    let endIndex = currPage * pageSize;

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.insuranceInfoList = sortedList?.slice(startIndex, endIndex);

    this.insuranceInfoData = this.insuranceInfoList?.map((e) => ({
      'Insurance': e.ismedicaidmedicare ? 'Yes' : 'No',
      'Policy Holder Name': e.policyholdername,
      'Policy Effective Date': e.effectivedate ? this.getDateFormatted(e.effectivedate) : '',
      'Expiration Date': e.expirationdate ? this.getDateFormatted(e.expirationdate) : '',
      'Update On': e.updatedon ? this.getDateFormatted(e.updatedon) : '',
      Action: e,
    }));
    this.insuranceInfoTotalCount =
      this.insuranceInfoList && this.insuranceInfoList?.length > 0
        ? sortedList?.length
        : 0;
    this.insuranceInfoColumns = Object.keys(this.insuranceInfoData?.[0] || columnMapping);
    this.insuranceInfoKeys = Object.keys(this.insuranceInfoData?.[0] || columnMapping);
  }

  fetchMedicalConditionList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId, startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD') }
    }, 'personmedicalcondition/list?filter').subscribe((list) => {
      if (list.data && Array.isArray(list.data) && list.data.length) {
        this.fetchedMedicalConditionList = list.data;
        this.loadMedicalConditionList();
      } else if(list.data && Array.isArray(list.data) && list.data.length === 0){
        this.fetchedMedicalConditionList = [];
        this.medicalConditionData = [];
      }
     
    })
  }


  loadMedicalConditionList(query: QueryType = {}) {
    // Process the examination list
    const columnMapping: any = {
      'Medical Condition': 'medicalcondition',
      'Begin Date': 'begindate',
      'End Date': 'enddate',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection


    let sortedList = this.fetchedMedicalConditionList;
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    this.handleMedicalConditionPaginationFn(sortedList, columnMapping);
  }
  // Assosiated with loadMedicalConditionList method
  private handleMedicalConditionPaginationFn(sortedList: any[], columnMapping: any) {
    const currPage = this.pageInfo.pageNumber;

    const pageSize = 10;
    let startIndex = (currPage - 1) * pageSize;
    let endIndex = currPage * pageSize;

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.medicalConditionList = sortedList?.slice(startIndex, endIndex);

    this.medicalConditionData = this.medicalConditionList?.map((e) => ({
      'Medical Condition': this.getMedicalCondition(e.medicalcondition_icd10_desc),
      'Begin Date': e.begindate ? this.getDateFormatted(e.begindate) : '',
      'End Date': e.enddate ? this.getDateFormatted(e.enddate) : '',
      Action: e,
    }));
    this.medicalConditionTotalCount =
      this.medicalConditionList && this.medicalConditionList?.length > 0
        ? sortedList?.length
        : 0;
    this.medicalConditionColumns = Object.keys(this.medicalConditionData?.[0] || columnMapping);
    this.medicalConditionKeys = Object.keys(this.medicalConditionData?.[0] || columnMapping);
  }

  getMedicalCondition(medicalcondition_icd10_desc: any) {
    if (medicalcondition_icd10_desc && medicalcondition_icd10_desc !== 'null') {
      return JSON.parse(medicalcondition_icd10_desc).join();
    }
    return '';
  }

  fetchMedicationList() {
    this._commonHttpService.getPagedArrayList({
      page: 1,
      limit: 20,
      method: 'get',
      where: { personid: this.personId, startDate: moment(this.startDate).format('yyyy-MM-DD'), endDate: moment(this.endDate).format('yyyy-MM-DD') }
    }, 'personmedicalcondition/personmedicallist?filter').subscribe((list) => {
      if (list?.data && Array.isArray(list?.data) && list?.data?.length) {
        this.fetchedMedicationList = list.data;
        this.loadMedicationList()
      } else if(list?.data && Array.isArray(list?.data) && list?.data?.length === 0){
        this.fetchedMedicationList = [];
        this.medicationData = [];
      }
    })
  }


  loadMedicationList(query: QueryType = {}) {
    const columnMapping: any = {
      'Medication Name': 'medicationname',
      'Dosage': 'dosage',
      'Frequency': 'frequency',
      'Updated By': 'username',
      'Updated On': 'updatedon',
      'Date Prescribed': 'medicationeffectivedate',
      'Date Medication Started': 'datemedicationstarted',
      'Date Discontinued': 'medicationexpirationdate',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection

    let sortedList = this.fetchedMedicationList;
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    this.handleMedicalListPaginationFn(sortedList, columnMapping);
  }
  // Assosiated with loadMedicationList method
  private handleMedicalListPaginationFn(sortedList: any[], columnMapping: any) {
    const currPage = this.pageInfo.pageNumber;

    const pageSize = 10;
    let startIndex = (currPage - 1) * pageSize;
    let endIndex = currPage * pageSize;

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.medicationList = sortedList?.slice(startIndex, endIndex);

    this.medicationData = this.medicationList?.map((e) => ({
      'Medication Name': e.medicationname,
      'Dosage': e.dosage,
      'Frequency': e.frequency,
      'Updated By': e.username,
      'Updated On': (e.updatedon) ? this.getDateFormatted(e.updatedon) : '',
      'Date Prescribed': (e.medicationeffectivedate) ? this.getDateFormatted(e.medicationeffectivedate) : '',
      'Date Medication Started': (e.datemedicationstarted) ? this.getDateFormatted(e.datemedicationstarted) : '',
      'Date Discontinued': (e.medicationexpirationdate) ? this.getDateFormatted(e.medicationexpirationdate) : '',
      Action: e,
    }));
    this.medicationTotalCount =
      this.medicationList && this.medicationList?.length > 0
        ? sortedList?.length
        : 0;
    this.medicationColumns = Object.keys(this.medicationData?.[0] || columnMapping);
    this.medicationKeys = Object.keys(this.medicationData?.[0] || columnMapping);
  }

  fetchProviderInfoList() {
    if (!this.fetchedProviderInfo.length) {
      // Format startDate and endDate if they exist
      const startDateRequest = this.startDate ? moment(this.startDate).format('YYYY-MM-DD') : null;
      const endDateRequest = this.endDate ? moment(this.endDate).format('YYYY-MM-DD') : null;
  
      // Call the API with the personId and optional startDate, endDate
      this._commonHttpService.getPagedArrayList({
        page: 1,
        limit: 20,
        method: 'get',
        where: { personid: this.personId, startDate: startDateRequest, endDate: endDateRequest }
      }, 'personphycisianinfo/getproviderinfo?filter').subscribe((list) => {
        if (list.data && Array.isArray(list.data) && list.data.length) {
          // Store the fetched list and call the load function
          this.fetchedProviderInfo = list.data;
          this.loadProviderInfoList();
        }
      });
    } else {
      // If the list is already fetched, just load it
      this.loadProviderInfoList();
    }
  }  


  loadProviderInfoList(query: QueryType = {}) {
    const columnMapping: any = {
      'PCP': 'is_primary_care_physician',
      'NAME': 'physician_name',
      'SPECIALTY': 'physician_speciality_desc',
      'PHONE': 'physician_phone',
      'EMAIL': 'physician_email',
      'Updated By': 'updatedby',
      'Updated On': 'updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedProviderInfo?.map(e => {
      return {
        ...e, is_primary_care_physician: e.is_primary_care_physician ? 'Yes' : 'No'
      }
    });
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.providerInfoList = sortedList?.slice(startIndex, endIndex)

    this.providerInfoData = this.providerInfoList?.map((e) => ({
      'PCP': e.is_primary_care_physician,
      'NAME': e.physician_name,
      'SPECIALTY': e.physician_speciality_desc,
      'PHONE': e.physician_phone,
      'EMAIL': e.physician_email,
      'Updated By': e.updatedby,
      'Updated On': this.getDateFormatted(e.updatedon),
      Action: e,
    }))
    this.providerInfoTotalCount =
      this.providerInfoList && this.providerInfoList?.length > 0
        ? sortedList?.length
        : 0
    this.providerInfoColumns = Object.keys(this.providerInfoData?.[0] || columnMapping)
    this.providerInfoKeys = Object.keys(this.providerInfoData?.[0] || columnMapping)
  }

  fetchMobilityList() {
    if (!this.fetchedMobilityList?.length) {
      // Format startDate and endDate if they exist
      const startDateRequest = this.startDate ? moment(this.startDate).format('YYYY-MM-DD') : null;
      const endDateRequest = this.endDate ? moment(this.endDate).format('YYYY-MM-DD') : null;
  
      // Call the API with the personId and optional startDate, endDate
      this._commonHttpService.getPagedArrayList({
        page: 1,
        limit: 20,
        method: 'get',
        where: { personid: this.personId, startDate: startDateRequest, endDate: endDateRequest }
      }, 'personfamilyinfo/getpersonmobility?filter').subscribe((list) => {
        if (list.data && Array.isArray(list.data) && list.data.length) {
          // Store the fetched list and call the load function
          this.fetchedMobilityList = list.data;
          this.loadMobilityList();
        }
      });
    } else {
      // If the list is already fetched, just load it
      this.loadMobilityList();
    }
  }  


  loadMobilityList(query: QueryType = {}) {
    // Process the examination list
    const columnMapping: any = {
      'INFO PROVIDER NAME': 'provided_name',
      'RELATIONSHIP': 'relationship_desc',
      'CHILD SAT UP': 'satupage',
      'WALKED': 'walkedage',
      'TALKED': 'talkedage',
      'Updated By': 'updatedby_fullname',
      'Updated On': 'updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedMobilityList;
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.mobilityList = sortedList?.slice(startIndex, endIndex)

    this.mobilityData = this.mobilityList?.map((e) => ({
      'INFO PROVIDER NAME': e.provided_name,
      'RELATIONSHIP': e.relationship_desc,
      'CHILD SAT UP': e.satupage,
      'WALKED': e.walkedage,
      'TALKED': e.talkedage,
      'Updated By': e.updatedby_fullname,
      'Updated On': this.getDateFormatted(e.updatedon),
      Action: e,
    }))
    this.mobilityTotalCount =
      this.mobilityList && this.mobilityList?.length > 0
        ? sortedList?.length
        : 0
    this.mobilityColumns = Object.keys(this.mobilityData?.[0] || columnMapping)
    this.mobilityKeys = Object.keys(this.mobilityData?.[0] || columnMapping)
  }

  fetchSleepingList() {
    if (!this.fetchedSleepingList?.length) {
      const startDateRequest = this.startDate ? moment(this.startDate).format('YYYY-MM-DD') : null;
      const endDateRequest = this.endDate ? moment(this.endDate).format('YYYY-MM-DD') : null;
  
      this._commonHttpService.getPagedArrayList({
        page: 1,
        limit: 20,
        method: 'get',
        where: { personid: this.personId, startDate: startDateRequest, endDate: endDateRequest }
      }, 'personfamilyinfo/getpersonsleeping?filter').subscribe((list) => {
        if (list.data && Array.isArray(list.data) && list.data.length) {
          this.fetchedSleepingList = list.data;
          this.loadSleepingList();
        }
      });
    } else {
      this.loadSleepingList();
    }
  }

  loadSleepingList(query: QueryType = {}) {
    const columnMapping: any = {
      'INFO PROVIDER NAME': 'providedname',
      'ENVIRONMENT': 'sleepingenvironment',
      'SLEEPING PROBLEM': 'sleepingproblems',
      'Updated By': 'updatedby_fullname',
      'Updated On': 'updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedSleepingList;
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.sleepingList = sortedList?.slice(startIndex, endIndex)

    this.sleepingData = this.sleepingList?.map((e) => ({
      'INFO PROVIDER NAME': e.providedname,
      'ENVIRONMENT': e.sleepingenvironment,
      'SLEEPING PROBLEM': e.sleepingproblems,
      'Updated By': e.updatedby_fullname,
      'Updated On': this.getDateFormatted(e.updatedon),
      Action: e,
    }))
    this.sleepingTotalCount =
      this.sleepingList && this.sleepingList?.length > 0
        ? sortedList?.length
        : 0
    this.sleepingColumns = Object.keys(this.sleepingData?.[0] || columnMapping)
    this.sleepingKeys = Object.keys(this.sleepingData?.[0] || columnMapping)
  }

  fetchEliminationList() {
    if (!this.fetchedEliminationList?.length) {
        const startDateRequest = this.startDate? moment(this.startDate).format('YYYY-MM-DD') : null;
        const endDateRequest = this.endDate? moment(this.endDate).format('YYYY-MM-DD') : null;
      this._commonHttpService.getPagedArrayList({
        page: 1,
        limit: 20,
        method: 'get',
        where: { personid: this.personId, startDate: startDateRequest, endDate:  endDateRequest }
      }, 'personfamilyinfo/getpersonelimination?filter').subscribe((list) => {
        if (list.data && Array.isArray(list.data) && list.data.length) {

          this.fetchedEliminationList = list.data;
          this.loadEliminationList()
        }
      })
    } else {
      this.loadEliminationList()
    }
  }


  loadEliminationList(query: QueryType = {}) {
    const columnMapping: any = {
      'INFO PROVIDER NAME': 'v_providedname',
      'CURRENT STATUS': 'v_elimination_currentstatus',
      'Updated By': 'updatedby_fullname',
      'Updated On': 'v_updatedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedEliminationList;
    const dbPropertyName = columnMapping[sortColumn];

    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);


    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }
    this.eliminationList = sortedList?.slice(startIndex, endIndex)

    this.eliminationData = this.eliminationList?.map((e) => ({
      'INFO PROVIDER NAME': e.v_providedname,
      'CURRENT STATUS': e.v_elimination_currentstatus,
      'Updated By': e.updatedby_fullname,
      'Updated On': this.getDateFormatted(e.v_updatedon),
      Action: e,
    }))
    this.eliminationTotalCount =
      this.eliminationList && this.eliminationList?.length > 0
        ? sortedList?.length
        : 0
    this.eliminationColumns = Object.keys(this.eliminationData?.[0] || columnMapping)
    this.eliminationKeys = Object.keys(this.eliminationData?.[0] || columnMapping)
  }

  getChildRemoval() {
    this._commonHttpService
      .getSingle(
        {
          where: { objectid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID), 'objecttypekey': 'servicecase' },
          method: 'get'
        },
        CaseWorkerUrlConfig.EndPoint.DSDSAction.ChildRemoval
          .GetChildRemovalList + '?filter'
      ).subscribe(result => {
        if (result && result.length) {
          this.childList = result;
          const activeremoval = this.childList.filter(item => item.exitdate === null);
          if (activeremoval.length === 0) {
            this.removaldate = '';
          } else if (activeremoval.length === 1) {
            this.removaldate = activeremoval[0]?.removaldate || '';
          } else {
            this.removaldate = activeremoval.reduce((latest, item) => {
              return item?.removaldate < latest ? item?.removaldate : latest;
            }, activeremoval[0]?.removaldate);
          }
        }
        this.getPlacementRecordList();
      });
  }

  getPlacementRecordList() {
    this._commonHttpService
      .getPagedArrayList(
        new PaginationRequest({
          page: 1,
          limit: 10,
          method: 'get',
          where: { servicecaseid: this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID) },
        }),
        'placement/getplacementbyservicecase?filter'
      ).subscribe(result => {
        const personPlacement = result.data.filter(item => item.personid === this.personId);
        const validPlacementList: any[] = [];
        if (personPlacement.length > 0) {
          this.handlePersonPlacementMapFn(personPlacement, validPlacementList);

          // Living Arrangement
          this.handleLivingAArrangementFn(validPlacementList);

          //Provide Placement 
          this.handleProviderPlacementFn(validPlacementList);

          this._dataStoreService.setData('healthpassport-placementList', this.placementList);
          this.fetchHealthPassportList();
        } else {
          this.placementList = [];
          this.fetchHealthPassportList();
        }
      });
  }
  // Assosiated with getPlacementRecordList method
  private handleProviderPlacementFn(validPlacementList: any[]) {
    const providerPlacementListWithOutEndDate = validPlacementList.filter(item => item.enddate === null && item.placementtype === this.providerplacement).sort(item => item.enddate);
    if (providerPlacementListWithOutEndDate.length > 0) {
      providerPlacementListWithOutEndDate.forEach(element => {
        if (element.startdate >= this.removaldate) {
          this.placementList.push(element);
        }
      });
    }

    const providerPlacementListWithEndDate = validPlacementList.filter(item => item.enddate !== null && item.placementtype === this.providerplacement).sort(item => item.enddate);
    providerPlacementListWithEndDate.sort(function (a, b) {
      var c = new Date(a.enddate);
      var d = new Date(b.enddate);
      return c <= d ? 1 : -1;
    });

    if (providerPlacementListWithEndDate.length > 0) {
      if (providerPlacementListWithEndDate[0].startdate >= this.removaldate) {
        this.placementList.push(providerPlacementListWithEndDate[0]);
      }
    }
  }
  // Assosiated with getPlacementRecordList method
  private handleLivingAArrangementFn(validPlacementList: any[]) {
    const LAPlacementListWithoutEndDate = validPlacementList.filter(item => item.enddate === null && item.placementtype === this.livingarrangement).sort(item => item.enddate);
    if (LAPlacementListWithoutEndDate.length > 0) {
      LAPlacementListWithoutEndDate.forEach(element => {    // NOSONAR    // This function has less than 3 lines of identical code. Hence marking it as no sonar.
        if (element.startdate >= this.removaldate) {
          this.placementList.push(element);
        }
      });
    }

    const LAPlacementListWithEndDate = validPlacementList.filter(item => item.enddate !== null && item.placementtype === this.livingarrangement);
    LAPlacementListWithEndDate.sort(function (a, b) {    // NOSONAR    // This function has less than 3 lines of identical code. Hence marking it as no sonar.
      var c = new Date(a.enddate);
      var d = new Date(b.enddate);
      return c <= d ? 1 : -1;
    });

    if (LAPlacementListWithEndDate.length > 0) {
      if (LAPlacementListWithEndDate[0].startdate >= this.removaldate) {
        this.placementList.push(LAPlacementListWithEndDate[0]);
      }
    }
  }
  // Assosiated with getPlacementRecordList method
  private handlePersonPlacementMapFn(personPlacement: any[], validPlacementList: any[]) {
    personPlacement[0].placements.map((element: any) => {
      if (element.placementtypekey === 'PRPL') {
        element.placementtype = this.providerplacement;
        if (element.cpahomerevision.length > 0) {
          element.placementname = element.cpahomerevision[0].providername;
        } else {
          element.placementname = (element.providerdetails) ? element.providerdetails.providername : null;
        }
      } else {
        element.placementtype = this.livingarrangement;
        element.placementname = element.primarycaregiver ? element.primarycaregiver : element.livingarrangementtype;
      }
      if (this.returnPlacementDetailsCheckFn(element)) {
        validPlacementList.push(element);
      }
    });
  }

  private returnPlacementDetailsCheckFn(element: any) {
    return (element.placementname !== null && (element.isvoided === 0 || element.isvoided == null) && (element.routingstatus === 'Approved' || (element.routingstatus === 'Review' && element.revisionupdate && element.revisionupdate.enddate)));
  }

  // Assosiated with getPlacementRecordList method
  private returnTrueOrFalseFn(element: any) {
    return (element.placementname !== null && (element.isvoided === 0 || element.isvoided == null) && (element.routingstatus === 'Approved' || (element.routingstatus === 'Review' && element.revisionupdate && element.revisionupdate.enddate)));
  }

  fetchHealthPassportList() {
    if (!this.fetchedHealthPassportList) {
      // Format startDate and endDate if they exist
      const startDateRequest = this.startDate ? moment(this.startDate).format('YYYY-MM-DD') : null;
      const endDateRequest = this.endDate ? moment(this.endDate).format('YYYY-MM-DD') : null;
  
      // Call the API with the personId and optional startDate, endDate
      this._commonHttpService.getPagedArrayList({
        page: 1,
        limit: 100,
        method: 'post',
        where: { personid: this.personId, startDate: startDateRequest, endDate: endDateRequest }
      }, 'personhealthpassport/list').subscribe((list) => {
        if (list.data && Array.isArray(list.data) && list.data.length) {
          // Store the fetched health passport list
          this.fetchedHealthPassportList = list.data;
          
          // Add placement info to the list
          this.fetchedHealthPassportList.forEach(element => {
            const placementInfo = this.placementList.find(item => item.placementid === element.placementid);
            element.healthpassportname = (placementInfo) ? placementInfo.placementname : 'Placement Name Not Available';
          });
  
          // Process the health passport list
          this.loadHealthPassportList();
        }
      });
    } else {
      // If already fetched, just load the list
      this.loadHealthPassportList();
    }
  }
  

  fillPlacementInfo(value: any) {
    const placementInfo = this.placementList.find(item => item.placementid === value);
    if (placementInfo) {
      const placementinfoType = placementInfo.livingarrangementtype ? placementInfo.livingarrangementtype : placementInfo.placementtype;
      const type = (placementInfo.placementstructuredesc) ? placementInfo.placementstructuredesc : placementinfoType;
      this.placementDetails = {
        placementtypename: type,
        placementname: placementInfo.placementname,
        startdate: placementInfo.startdate,
        enddate: placementInfo.enddate
      }
    }
  }

  loadHealthPassportList(query: QueryType = {}) {
    const columnMapping: any = {
      'Child’s Placement': 'healthpassportname',
      'Health Passport Provided to Child’s Caregiver?': 'haspassportprovidedtocaregiver',
      'Date': 'effectivedate',
      'Updated on': 'insertedon',
      'Action': 'view'
    };

    const sortColumn: any = query.sortColumn
    const sortBy = query.sortDirection
    let sortedList = this.fetchedHealthPassportList;  
    const dbPropertyName = columnMapping[sortColumn];
    sortedList = this.searchAndSortUtil(sortColumn, sortBy, sortedList, dbPropertyName, query, columnMapping);

    // Pagination
    const currPage = this.pageInfo.pageNumber

    const pageSize = 10
    let startIndex = (currPage - 1) * pageSize
    let endIndex = currPage * pageSize

    if (sortedList?.length < 10) {
      startIndex = 0;
      endIndex = 10;
    }

    this.healthPassportList = sortedList?.slice(startIndex, endIndex)

    this.healthPassportData = this.healthPassportList?.map((e) => ({
      'Child’s Placement': e.healthpassportname,
      'Health Passport Provided to Child’s Caregiver?': e.haspassportprovidedtocaregiver,
      'Date': String(e.haspassportprovidedtocaregiver).toLowerCase() === 'yes' ? this.getDateFormatted(e.effectivedate) : '',
      'Updated on': e.insertedon ? this.getDateFormatted(e.insertedon) : '',
      Action: e,
    }))
    this.healthPassportTotalCount =
      this.healthPassportList && this.healthPassportList?.length > 0
        ? sortedList?.length
        : 0
    this.healthPassportColumns = Object.keys(this.healthPassportData?.[0] || columnMapping)
    this.healthPassportKeys = Object.keys(this.healthPassportData?.[0] || columnMapping)
  }

  navigateToDestination(event: any, value: any) {
    if (value == 'examination') {
      this._healthService.setActiveSection('examination-cw');
      this._router.navigate(['/pages/person-info-cw/health/examination'], { queryParams: { examination: true } });
      this._dataStoreService.setData('person-health-summary', event);
    }
    else if (value == 'birthDetails') {
      this._healthService.setActiveSection('birth-information-cw');
      this._router.navigate(['/pages/person-info-cw/health/birth-info'], { queryParams: { birthDetails: true } });
      this._dataStoreService.setData('birthDetails-health-summary', event);
    }
    else if (value == 'reproductiveHealth') {
      this._healthService.setActiveSection('sexual-information-cw');
      this._router.navigate(['/pages/person-info-cw/health/re-productive-health'], { queryParams: { reproductiveHealth: true } });
      this._dataStoreService.setData('reproductive-health-summary', event);
    }
    else if (value == 'hospitalization') {
      this._healthService.setActiveSection('hospitalization-cw');
      this._router.navigate(['/pages/person-info-cw/health/hospitalization'], { queryParams: { hospitalization: true } });
      this._dataStoreService.setData('hospitalization-health-summary', event);
    }
    else if (value == 'immunization') {
      this._healthService.setActiveSection('immunization-cw');
      this._router.navigate(['/pages/person-info-cw/health/immunization'], { queryParams: { immunization: true } });
      this._dataStoreService.setData('immunization-health-summary', event);
    }
    else if (value == 'behavirolHealth') {
      this._healthService.setActiveSection('behavioral-health-info-cw');
      this._router.navigate(['/pages/person-info-cw/health/behavioral-health'], { queryParams: { behavirolHealth: true } });
      this._dataStoreService.setData('behavirolHealth-health-summary', event);
    }
    else if (value == 'disability') {
      this._healthService.setActiveSection('person-disability-cw');
      this._router.navigate(['/pages/person-info-cw/health/disability'], { queryParams: { disability: true } });
      this._dataStoreService.setData('disability-health-summary', event);
    }
    else if (value == 'familyHistory') {
      this._healthService.setActiveSection('family-history-cw');
      this._router.navigate(['/pages/person-info-cw/health/family-history'], { queryParams: { familyHistory: true } });
      this._dataStoreService.setData('familyHistory-health-summary', event);
    }
    else if (value == 'feedingInfo') {
      this._healthService.setActiveSection('feeding-info');
      this._router.navigate(['/pages/person-info-cw/health/feeding-info'], { queryParams: { feedingInfo: true } });
      this._dataStoreService.setData('feedingInfo-health-summary', event);
    }
    else if (value == 'insuranceInfo') {
      this._healthService.setActiveSection('insurance-information-cw');
      this._router.navigate(['/pages/person-info-cw/health/insurance-info'], { queryParams: { insuranceInfo: true } });
      this._dataStoreService.setData('insuranceInfo-health-summary', event);
    }
    else if (value == 'medicalCondition') {
      this._healthService.setActiveSection('medical-conditions-cw');
      this._router.navigate(['/pages/person-info-cw/health/diseases-conditions'], { queryParams: { medicalCondition: true } });
      this._dataStoreService.setData('medicalCondition-health-summary', event);
    }
    else if (value == 'medication') {
      this._healthService.setActiveSection('medication-including-psychotropic-cw');
      this._router.navigate(['/pages/person-info-cw/health/medication-psychotropic'], { queryParams: { medication: true } });
      this._dataStoreService.setData('medication-health-summary', event);
    }
    else if (value == 'providerInfo') {
      this._healthService.setActiveSection('provider-dental-information-cw');
      this._router.navigate(['/pages/person-info-cw/health/provider-info'], { queryParams: { providerInfo: true } });
      this._dataStoreService.setData('providerInfo-health-summary', event);
    }
    else if (value == 'mobility') {
      this._healthService.setActiveSection('mobility-speech');
      this._router.navigate(['/pages/person-info-cw/health/mobility-speech'], { queryParams: { mobility: true } });
      this._dataStoreService.setData('mobility-health-summary', event);
    }
    else {
      this.handleHealthCondFn(value, event);
    }
  }


  // Assosiated with navigateToDestination method
  private handleHealthCondFn(value: any, event: any) {
    if (value == 'sleeping') {
      this._healthService.setActiveSection('sleeping-info-cw');
      this._router.navigate(['/pages/person-info-cw/health/sleeping-info'], { queryParams: { sleeping: true } });
      this._dataStoreService.setData('sleeping-health-summary', event);
    }
    else if (value == 'elimination') {
      this._healthService.setActiveSection('elimination-info-cw');
      this._router.navigate(['/pages/person-info-cw/health/elimination'], { queryParams: { elimination: true } });
      this._dataStoreService.setData('elimination-health-summary', event);
    }
    else if (value == 'healthPassport') {
      this._healthService.setActiveSection('health-passport-cw');
      this._router.navigate(['/pages/person-info-cw/health/health-passport'], { queryParams: { healthPassport: true } });
      this._dataStoreService.setData('healthPassport-health-summary', event);
    }
  }

  getDateFormatted(date: any) {
    if (date && moment(date).isValid()) {
      return moment(date).format('MM/DD/YYYY')
    } else {
      return ''
    }
  }

  callApi(query: any, value: any) {
    // console.log(query)
    query = JSON.parse(query)
    this.reusableConditionToLoadFn(value, query);
  }

  onSortedFunding(event: any, value: any) {
    event = JSON.parse(event)
    this.paginationInfo.sortBy = event.sortDirection
    this.paginationInfo.sortColumn = event.sortColumn
    this.reusableConditionToLoadFn(value, event);

  }

  goBack() {
    this._dataStoreService.setData(IntakeStoreConstants.NAVIGATE_TO_PERSON, true);
    this._dataStoreService.setData(IntakeStoreConstants.SELECT_PERSON_TAB_INTAKE, true);
    this._service.goBack();
  }

  handleAuthIdEvent(_data: any) {
    // No data or function add or call
  }

  pageNumberChanged(pageInfo: any, value: any) {
    this.pageInfo.pageNumber = pageInfo.page
    this.paginationInfo.sortColumn = pageInfo.query.sortColumn
    this.paginationInfo.sortBy = pageInfo.query.sortDirection
    this.reusableConditionToLoadFn(value, pageInfo.query);
  }

  private reusableConditionToLoadFn(value: any, query: any) {
    if (value == 'examination') {
      this.loadExaminationList(query);
    } else if (value == 'birthDetails') {
      this.loadBirthDetails(query);
    } else if (value == 'reproductiveHealth') {
      this.loadReproductiveHealth(query);
    } else if (value == 'hospitalization') {
      this.loadHospitalizationList(query);
    } else if (value == 'immunization') {
      this.loadImmunizationList(query);
    } else if (value == 'behavirolHealth') {
      this.loadBehavirolHealthList(query);
    } else if (value == 'disability') {
      this.loadDisabilityList(query);
    } else if (value == 'familyHistory') {
      this.loadFamilyHistory(query);
    } else if (value == 'feedingInfo') {
      this.loadFeedingInfoList(query);
    } else if (value == 'insuranceInfo') {
      this.loadInsuranceInfo(query);
    } else if (value == 'medicalCondition') {
      this.loadMedicalConditionList(query);
    } else if (value == 'medication') {
      this.loadMedicationList(query);
    } else if (value == 'providerInfo') {
      this.loadProviderInfoList(query);
    } else {
      this.handleHealthCondToLoadListFn(value, query);
    }
  }
  // Assosiated with reusableConditionToLoadFn method
  private handleHealthCondToLoadListFn(value: any, query: any) {
    if (value == 'mobility') {
      this.loadMobilityList(query);
    } else if (value == 'sleeping') {
      this.loadSleepingList(query);
    } else if (value == 'elimination') {
      this.loadEliminationList(query);
    } else if (value == 'healthPassport') {
      this.loadHealthPassportList(query);
    }
  }
  getCaseNumber() {
    const daNumber = this.route.snapshot.parent?.parent?.parent?.parent?.parent?.params['daNumber'];
    if (!daNumber) {
         const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
         return (caseInfo) ? caseInfo.da_number : null;
    }
    return daNumber;
 }
 getCurrentCaseType() {
  if (this.isServiceCaseData()) {
      return 'Service Case';
  } else if (this.isIntakeMode()) {
      return 'Intake';
  } else if (this.isAdoptionCase()) {
      return 'Adoption Case';
  } else {
      return 'CPS';
  }
}

isAdoptionCase() {
  if (this._session.getItem(CASE_STORE_CONSTANTS.CASE_TYPE) === AppConstants.CASE_TYPE.ADOPTION_CASE) { 
      return true; }
  const dsds = this._dataStoreService.getData('dsdsActionsSummary');
  if (dsds && dsds.adoptioncasenumber != null) { 
      return true; }
  return false;
}
isServiceCaseData() {
  return this._session.getItem(CASE_STORE_CONSTANTS.IS_SERVICE_CASE);
}

getIntakeNumber() {
  const intakeStore = this._dataStoreService.getObj('intake');
  if (intakeStore && intakeStore.number) {
      this.intakeNumber = intakeStore.number
      return intakeStore.number;
  } else {
      return null;
  }
}

isIntakeMode() {
  return this.getIntakeNumber() ? true : false;
}
  downloadHealthReportPdf() {
    const objectid = this.getCaseNumber();
    const objectType = this.getCurrentCaseType();
    const comment = {
      logtype: 'print-person-health-summary', 
      description: 'print-person-health-summary',
      objectype: objectType,
      referenceid: this.personId,
      objectid: objectid
        };
        this._commonHttpService.create(comment, CaseWorkerUrlConfig.EndPoint.DSDSAction.Recording.AddDetailedAudit).subscribe(
            (result) => {
              console.log(result);
            },
            (error) => {
                console.log(GLOBAL_MESSAGES.ERROR_MESSAGE);
            }
        );
    const modal = {
        method: 'post',
        where: {
            documenttemplatekey: ['personhealthreport'],
            status: 'Person Health Summary',
            personid : this.personId,
            startDate: this.PHSDateForm.get('startDate')?.value,
            endDate: this.PHSDateForm.get('endDate')?.value,
        },
        limit: 20,
        order: 'desc',
        page: 1,
        count: -1
    };
    this._commonHttpService.download('evaluationdocument/generateintakedocument', modal)
        .subscribe(res => {
           console.log('Response:', res);  
            const blob = new Blob([new Uint8Array(res)]);
            const link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = `Person Health Summary_` +  moment().format('MM/DD/YYYY hh:mm A') + `.pdf`;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        });
  }
}