import { Component, OnInit, OnDestroy } from '@angular/core';
import { ServiceCasePlacementsService } from '../service-case-placements.service';
import { Router, ActivatedRoute } from '@angular/router';
import { CommonHttpService } from '../../../../../@core/services';
import { PaginationRequest, PaginationInfo } from '../../../../../@core/entities/common.entities';
import { PlacementConstants } from '../constants';
import moment from 'moment';
import { FinanceService } from '../../../../finance/finance.service';
import { environment } from '../../../../../../environments/environment';
import { HospitalizationService } from './../../../../../shared/services/hospitalization.service';

@Component({
    selector: 'removed-child-list',
    templateUrl: './removed-child-list.component.html',
    styleUrls: ['./removed-child-list.component.scss'],
    standalone: false
})
export class RemovedChildListComponent implements OnInit, OnDestroy {

  childList: any[] = [];
  accountpayableList: any[] = [];
  paymentDetails: any[] = [];
  selectedChild: any;
  paginationInfo: PaginationInfo  = new PaginationInfo();
  pageInfo: PaginationInfo  = new PaginationInfo();
  searchParams: any;
  changehistory: any[] = [];
  adjustment: any[] = [];
  providerDetails: any;
  overpayments: any[] = [];
  clientID: any;
  childSelected: any;
  environment = environment;
  dtformat = 'MM/DD/YYYY';
  constructor(private placementService: ServiceCasePlacementsService,
    private commonHttpService: CommonHttpService,
    private router: Router,
    private route: ActivatedRoute,
    private _financeSerice: FinanceService,
    private hospitalizationService: HospitalizationService) { }

  ngOnInit() {
    this.childList = this.placementService.childList;
    const selectedChildIndex = this.childList.findIndex((child)=>child.isSelected);
    if(selectedChildIndex > -1) {
      this.hospitalizationService.setSelectedPersonId(this.childList[selectedChildIndex]['personid'])
    }
    this.placementService.refresh$.subscribe(_ => {
      this.childList = this.placementService.childList;
      const selectedChildIndex1 = this.childList.findIndex((child)=>child.isSelected);
      if(selectedChildIndex1 > -1) {
        this.hospitalizationService.setSelectedPersonId(this.childList[selectedChildIndex1]['personid'])
      }
    });
    this.childList.forEach(res => {
      res.fullname = res.prefx + ' ' + res.firstname + ' ' + res.middlename + ' ' + res.lastname + ' ' + res.suffix;      
      return res.fullname;

    });
  }

  ngOnDestroy() {
    this.placementService.childList = [];
  }

  onChildChecked(event: any, child: any) {
    this.hospitalizationService.selectedPersonId = child['personid'];
    this.hospitalizationService.setSelectedPersonId(child['personid'])
    if(child.isbioadoptedflag === 1){
      this.childSelected = child;
      (<any>$('#bioadoptedflag')).modal('show');
      return;
    }
    this.placementService.selectChild(child, event.checked);
  }

  onCheckedChild(child: any) {
    this.placementService.selectChild(child, false);
  }

  showPlacementDetails(_placement: any) {
    this.placementService.placementDetails = this.placementService.childList;
    this.router.navigate(['details/' + PlacementConstants.ACTIONS.REVIEW], { relativeTo: this.route });
  }

  showChildHistory(child: any) {
    this.accountpayableList = [];
    this.paginationInfo.pageNumber = 1;
    this.paginationInfo.pageSize = 10;
    this.selectedChild = child;
    this.providerDetails = (child && child.placements && child.placements.length && child.placements[0].providerdetails) ? child.placements[0].providerdetails : null;
    this.commonHttpService.getPagedArrayList(
      new PaginationRequest({
        limit: this.paginationInfo.pageSize,
        page: this.paginationInfo.pageNumber,
        method: 'post',
        where: {
          clientid: this.selectedChild.cjamspid,
          payment_statuses_cd: [1636, 1634], 
        }
      }), 'tb_payment_header/getAccountsPayableHeaderForCase'
    ).subscribe((result: any) => {
      if (result) {
        this.accountpayableList = result.data;
      }
    });
  }

  childRemovalDate(removalHistory: any) {
    const dates = [...removalHistory].map(rec => rec.removaldate);
    dates.sort();
    dates.reverse();
    return dates[0];
  }
  toggleTable(id: any, index: any, paymentid: any) {
      (<any>$('.collapse.in')).collapse('hide');
      (<any>$('#' + id)).collapse('toggle');

    (<any>$('.provider-details tr')).removeClass('selected-bg');
    (<any>$(`#provider-details-${index}`)).addClass('selected-bg');

    this.commonHttpService.getPagedArrayList(new PaginationRequest({
      where: {
        paymentid: paymentid,
        clientid : this.selectedChild.cjamspid
      },
      limit : this.pageInfo.pageSize,
      page: this.pageInfo.pageNumber,
      method: 'post'
    }), 'tb_payment_header/getAccountsPayableInfo').subscribe(res => {
      this.paymentDetails = res.data;
    });
  }

  getAge(dateValue: any) {
    if (dateValue && moment(new Date(dateValue), this.dtformat, true).isValid()) {
        const rCDob = moment(new Date(dateValue), this.dtformat).toDate();
        return moment().diff(rCDob, 'years');
    } else {
        return '';
    }
  }

  getDateFormatted(date:any){
    if(date && moment(date).isValid()){
      return moment(date).format(this.dtformat);
    }else{
      return '';}
  }

  selectAccountsPayable(_payment: any) {
    // No data or function to call or add
  }

}
