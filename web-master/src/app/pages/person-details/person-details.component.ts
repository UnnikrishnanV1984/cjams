import { Component, OnInit } from '@angular/core';
import { DataStoreService, AuthService, CommonDropdownsService } from '../../@core/services';
import { Router, ActivatedRoute } from '@angular/router';
import { PersonDetailsService } from './person-details.service';
import { PersonTabConfig, PersonStatusTabConfig } from './person-tab-config';
import { PersonDetailConstants } from './person-details-constants';
import { IntakeUtils } from '../_utils/intake-utils.service';


@Component({
    // tslint:disable-next-line:component-selector
    selector: 'person-details',
    templateUrl: './person-details.component.html',
    styleUrls: ['./person-details.component.scss'],
    standalone: false
})
export class PersonDetailsComponent implements OnInit {

  personid: string | null | undefined;
  action: string | null | undefined;
  tabs: any[] = [];
  personStatusList: any[] = [];
  personStatus = PersonDetailConstants.ALL;
  PERSON_ALL_STATUS = PersonDetailConstants.ALL;
  isEditable = false;
  personActiveStatuses!: string;
  agency!: string;

  constructor(private _dataStoreService: DataStoreService,
    private router: Router,
    private route: ActivatedRoute,
    public personService: PersonDetailsService,
    private _dropDownService: CommonDropdownsService,
    private _intakeUtil: IntakeUtils,
    private _authService: AuthService) {
    this.personid = this.route.snapshot.paramMap.get('personid');
    this.action = this.route.snapshot.paramMap.get('action');
    this.route.data.subscribe(res => {
      this.personService.person = res.personDetails;
    });
    this.personService.action = this.action;
    this.isEditable = this.personService.isEditable;
  }

  ngOnInit() {
    this.agency = this._authService.getAgencyName();
    this.loadStatusDropdown();
    this.loadTabs();
    this.loadActiveStatus();
  }
  loadStatusDropdown() {
    this._dropDownService.getDropownsByTable('focuspersonstatus').subscribe(response => {
      this.personStatusList = response;
    });
  }

  loadActiveStatus() {
    this._intakeUtil.getFocusPersonStatus(this.personService.person.personid, null, null)
      .subscribe(statuses => {
        this.personActiveStatuses = Array.from(new Set(statuses.filter(status => status.description !== 'No Status').map(status => status.description))).toString();
      });
  }

  loadTabs() {
    const agency = this._authService.getAgencyName();
    this.tabs = [];
    this.personService.setPersonStatus(this.personStatus);
    if (this.personStatus === PersonDetailConstants.ALL) {
      if (!this.personService.isSupervisor()) {
        this.tabs = PersonTabConfig.map(item => {
          item.active = false;
          return item;
        }).filter(item => (item.path !== 'youth-status' && item.agency.includes(agency)));
      } else {
        this.tabs = PersonTabConfig.map(item => {
          item.active = false;
          return item;
        }).filter(item => (item.agency.includes(agency)));
      }
      this.refreshScrollingTabs();
      let tab = this.getCurrentTabDetails();
      if (!tab) {
        tab = this.tabs[0];
      }
      this.router.navigate([tab.path], { relativeTo: this.route });
      $(`[title='${tab.name}']`).addClass('active');
      $(`[title='${tab.name}']`).parent().addClass('active');
    } else {
      this.tabs = PersonStatusTabConfig.map(item => {
        item.active = false;
        return item;
      }).filter(item => (item.agency.includes(agency)));
      this.refreshScrollingTabs();
      this.router.navigate([this.tabs[2].path], { relativeTo: this.route });
      $(`[title='${this.tabs[2].name}']`).addClass('active');
      $(`[title='${this.tabs[2].name}']`).parent().addClass('active');
    }
  }


  private getCurrentTabDetails() {
    const urlSegments = this.router.url.split('/');
    let tab: any;
    this.tabs.forEach(tabObj => {
      if (urlSegments.includes(tabObj.path)) {
        tab = tabObj;
      }
    });
    return tab;
  }

  refreshScrollingTabs() {
    const __this = this;
    const tabsLiContent = this.tabs.map(function (tab) {
      return '<li role="presentation" title="' + tab.name + '" data-bs-trigger="hover" class="custom-li" routerLinkActive="active"></li>';
    });

    const tabsPostProcessors = this.tabs.map(function (tab) {
      return function ($li: any, $a: any) {
        $a.attr('href', '');
        if (tab.active) {
          $a.attr('class', 'active');
        }
        $a.click(function () {
          __this.tabs.forEach(filteredTab => {
            filteredTab.active = false;
          });
          tab.active = true;
          __this.router.navigate([tab.path], { relativeTo: __this.route });
        });
      };
    });
    (<any>$('#persontabs')).html('');
    (<any>$('#persontabs')).scrollingTabs({
      tabs: __this.tabs,
      propPaneId: 'path', // optional - pass in default value for demo purposes
      propTitle: 'name',
      disableScrollArrowsOnFullyScrolled: true,
      tabsLiContent: tabsLiContent,
      tabsPostProcessors: tabsPostProcessors,
      scrollToActiveTab: true,
      tabClickHandler: function (e: any) {
        $(__this).addClass('active');
        $(__this).parent().addClass('active');
      }
    });
  }
}
