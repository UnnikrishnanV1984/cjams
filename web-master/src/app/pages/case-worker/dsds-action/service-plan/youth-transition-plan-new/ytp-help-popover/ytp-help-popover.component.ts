import { Component, ElementRef, HostListener, Input, OnInit, ViewChild } from '@angular/core';
import { Params, Router } from '@angular/router';
import { NavigationUtils } from '../../../../../_utils/navigation-utils.service';
import { AlertService, DataStoreService, SessionStorageService } from '../../../../../../@core/services';
import { AppConstants } from '../../../../../../@core/common/constants';
import { CASE_STORE_CONSTANTS } from '../../../../_entities/caseworker.data.constants';
import { IntakeStoreConstants } from '../../../../../newintake/my-newintake/my-newintake.constants';
import { Observable } from 'rxjs';
declare let $: any;
@Component({
  selector: 'app-ytp-help-popover',
  templateUrl: './ytp-help-popover.component.html',
  styleUrls: ['./ytp-help-popover.component.scss'],
    standalone: false
})
export class YtpHelpPopoverComponent implements OnInit {
  @Input() helpText: string = '';
  @Input() linkText: string = '';
  @Input() linkPath: string = '';
  @Input() dynamicPathBuilderFn?: () => string;
  @Input() queryParamsBuilderFn?: () => Params;

  @Input() shouldNavigate: boolean = false;
  @Input() actionMethodName: 'openEditPersonInfo' | 'openViewPersonInfo' | 'openViewPersonHealthSummaryInfo' | null = 'openEditPersonInfo';
  @Input() personId: string | null = null;
  @Input() saveMethod: (() => Observable<any>) | null = null;
  @Input() newTab: boolean = false;

  modalId!
  : string;
  isVisible = false;

  @ViewChild('popoverWrapper', { static: true }) wrapperRef!: ElementRef;

  constructor(
    private router: Router,
    private _navigationUtils: NavigationUtils,
    private _dataStoreService: DataStoreService,
    private _session: SessionStorageService,
    private _alertservice: AlertService,
    private elementRef: ElementRef
  ) {}

  ngOnInit() {
    this.modalId = 'ytp-confirm-modal-' + Math.random().toString(36).substring(2);
  }

  toggle() {
    this.isVisible = !this.isVisible;
  }

  confirmNavigation(): void {
    $(`#${this.modalId}`).modal('show');
  }

  cancelDecision(): void {
    $(`#${this.modalId}`).modal('hide');
  }

  close() {
    this.isVisible = false;
  }

  @HostListener('document:click', ['$event'])
  onDocumentClick(event: MouseEvent) {
    const clickedInside = this.elementRef.nativeElement.contains(event.target);
    if (!clickedInside) {
      this.close();
    }
  }

  handleLinkClick() { 
    $(`#${this.modalId}`).modal('hide');
    this.close();
    if (!this.shouldNavigate) return;

    const navigateAfterSave = () => {
      const source = this.getSource();
      const uniqueNumber = this.getUniqueNumber();
      const data = this.getData();

      if (
        this.personId &&
        this.actionMethodName &&
        typeof this._navigationUtils[this.actionMethodName] === 'function'
      ) {
        this._navigationUtils[this.actionMethodName](
          this.personId,
          source,
          uniqueNumber,
          data
        );
      }

    const destinationPath = this.dynamicPathBuilderFn?.() || this.linkPath;
    const queryParams = this.queryParamsBuilderFn?.();

    if (destinationPath && !this.newTab) {
      this.router.navigate([destinationPath], { queryParams });
    } else {
      window.open(destinationPath, '_blank');
    }
  };

  if (this.saveMethod) {
    this.saveMethod().subscribe({
      next: () => {
        setTimeout(() => navigateAfterSave(), 1000);
      },
      error: (err) => {
        this._alertservice.error('Please enter all the mandatory information!');      }
    });
  } else {
    console.warn('No save method provided, navigating without saving.');
    navigateAfterSave();
  }
  }

  private getSource() {
    return AppConstants.CASE_TYPE.SERVICE_CASE;
  }

  private getUniqueNumber() {
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

  private getCaseNumber() {
    const caseInfo = this._dataStoreService.getData('dsdsActionsSummary');
    return caseInfo?.da_number ?? null;
  }

  private isIntakeMode() {
    return !!this.getIntakeNumber();
  }

  private getIntakeNumber() {
    const intakeStore = this._dataStoreService.getObj('intake');
    return intakeStore?.number ?? null;
  }
}