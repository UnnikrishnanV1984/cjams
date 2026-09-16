import { Component, ElementRef, EventEmitter, Input, Output } from '@angular/core';
import { Params, Router } from '@angular/router';
import { NavigationUtils, PersonInfoStore } from '../../../pages/_utils/navigation-utils.service';
import { AlertService, DataStoreService, SessionStorageService } from '../../../@core/services';
import { AppConstants } from '../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../pages/case-worker/_entities/caseworker.data.constants';
import { IntakeStoreConstants } from '../../../pages/newintake/my-newintake/my-newintake.constants';

declare let $: any;

@Component({
  selector: 'app-help-popover',
  templateUrl: './help-popover.component.html',
  styleUrls: ['./help-popover.component.scss'],
  standalone: false
})
export class HelpPopoverComponent {
  @Input() helpText: string = '';
  @Input() linkText: string = '';
  @Input() linkPath: string = '';
  @Input() dynamicPathBuilderFn?: () => string;
  @Input() queryParamsBuilderFn?: () => Params;
  @Input() shouldNavigate: boolean = false;
  @Input() actionMethodName: 'openEditPersonInfo' | 'openViewPersonInfo' | null = 'openEditPersonInfo';
  @Input() personId!: string | null;
  @Input() modalId: string = '';
  isVisible: boolean = false;
  @Output() saveData: EventEmitter<any> = new EventEmitter();
  @Output() dataRefresh: EventEmitter<any> = new EventEmitter();

  constructor(
    private router: Router,
    private _navigationUtils: NavigationUtils,
    private _dataStoreService: DataStoreService,
    private _session: SessionStorageService,
    private _alertservice: AlertService,
    private elementRef: ElementRef
  ) {}

  ngOnInit() {
    this.modalId = 'app-confirm-modal-' + Math.random().toString(36).substring(2);
  }
  toggle(): void {
    this.isVisible = !this.isVisible;
  }

  close(): void {
    this.isVisible = false;
  }

  getNavigationInfo(): any {
    const info = this._dataStoreService.getObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO);
    if(info){
      return info;
    }
    else {
      const navigationInfoData: any = localStorage.getItem('navigationInfo');
      return JSON.parse(navigationInfoData);;
    }
  }
  private getSource() {
    const source = this._dataStoreService?.getCurrentStore()?.dsdsActionsSummary?.da_subtype || this.getNavigationInfo()?.source;
    if(this.isIntakeMode()) {
      return AppConstants.CASE_TYPE.INTAKE;
    }
    if(['CPS-IR', 'CPS-AR'].includes(source)) {
      return AppConstants.CASE_TYPE.CPS_CASE;
    } else {
      return AppConstants.CASE_TYPE.SERVICE_CASE;
    }
  }

  private getUniqueNumber() {
    if(this.isIntakeMode()) {
      return this.getIntakeNumber()
    }
    return this.getCaseUuid();
  }
  private getCaseUuid() {
    const caseID = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    if (caseID) {
      return caseID;
    }
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    return caseInfo?.intakeserviceid ?? null;
  }
  private isIntakeMode() {
    return !!this.getIntakeNumber();
  }

  private getIntakeNumber() {
    const intakeStore = this._dataStoreService.getObj('intake');
    return intakeStore?.number ?? null;
  }
  private getCaseNumber() {
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    return caseInfo?.da_number ?? null;
  }
  private getData() {
    const data = {
      purposeId: null,
      caseNumber: null
    };

    if (this.isIntakeMode()) {
      const intakePurpose = this._dataStoreService.getData(IntakeStoreConstants.purposeSelected);
      if (intakePurpose && intakePurpose.code !== 'ROACPS') {
        data.purposeId = intakePurpose.value;
      }
    } else {
      data.purposeId = this._dataStoreService.getData('da_typeid');
      data.caseNumber = this.getCaseNumber();
    }

    return data;
  }

  confirmNavigation(): void {
    this.saveData.emit(true);
    if (!this.shouldNavigate) return;
    const source = this.getSource();
    const uniqueNumber = this.getUniqueNumber();
    const data = this.getData();
    if (
      this.personId &&
      this.actionMethodName &&
      typeof this._navigationUtils[this.actionMethodName] === 'function'
    ) {
      this.navigateToNewTab(this.personId,
        source,
        uniqueNumber,
        data,
        this.linkPath);
    }
  }

  refresh() : void {
    this.dataRefresh.emit(true);
  }

  navigateToNewTab (personId: string, caseType: string, uniqueNumber: string, data: any,linkPath: any) : void {

    const personInfo = Object.create(PersonInfoStore);
    personInfo.source = caseType;
    personInfo.sourceID = uniqueNumber;
    personInfo.personId = personId;
    personInfo.action = AppConstants.ACTIONS.EDIT;
    personInfo.data = data;
    this._dataStoreService.setObj(AppConstants.GLOBAL_KEY.PERSON_NAVIGATION_INFO, personInfo);
    localStorage.setItem('navigationInfo',JSON.stringify(personInfo));
    window.open(linkPath, '_blank');
  }
 
}