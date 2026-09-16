import { Component, OnInit } from '@angular/core';
import { AppUser } from '../../../../../@core/entities/authDataModel';
import { DataStoreService, CommonHttpService } from '../../../../../@core/services';
import jsPDF from 'jspdf';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { CasePlanService } from '../case-plan.service';
import { Html2CanvasService } from './../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

@Component({
    selector: 'case-plan-four',
    templateUrl: './case-plan-four.component.html',
    styleUrls: ['./case-plan-four.component.scss'],
    standalone: false
})
export class CasePlanFourComponent implements OnInit {

  store: any;
  cp1Data: any;
  selectedVersion: any;
  ytpPlanGoalList: any[] = [];
  selectedYTPPlan: any;
  ytpData: any;
  intakeserviceid = '';
  selectedClientId!: string;
  approvalProcess!: string;
  selectedItem!: string;
  selectedPlan: any;
  selectedPlanId!: string;
  getUsersList: any[] = [];
  selectedPerson: any;
  selectService: any;
  id: any;
  daNumber: any;
  user!: AppUser;
  ytpList: any;
  
  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
  selYouth: any;
  ytpSummary: any = {};
  pdfBlobUrl: any;
  blobPdf!: Blob;
  blobPdf1: any = 'asd';
  isWithinCustomRange = true;

  constructor(
    private _commonHttpService: CommonHttpService,
    private _dataStoreService: DataStoreService,
    private _caseplanService: CasePlanService,
    private html2canvas:Html2CanvasService
  ) {
    this.store = this._dataStoreService.getCurrentStore();
    this.cp1Data = this.store['SELECTED_CHILD_DATA'];
    this.selectedVersion = this.store['SELECTED_VERSION'];
   }

  ngOnInit() {
    if(this.cp1Data) {
      this.getYTPPlanList(this.cp1Data.personid, this.selectedVersion);
    }
  }
  ngAfterViewInit() {
    this.scroll('versions-table');
  }

  scroll(id: any) {
    const el: any = document.getElementById(id);
    el.scrollIntoView({behavior: 'smooth', block: 'start', inline: 'nearest'});
  }

  selectPlan(item: any) {
    this.selectedYTPPlan = item;
    this.selYouth = item;
  }

  getYTPPlanList(clientID: any, version: any) {
    const fromdate = version && version.fromdate ? version.fromdate: null;
    const todate = version && version.todate ? version.todate: null;
    this.intakeserviceid = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
    return this._commonHttpService.getArrayList(
      {
        page: 1,
        limit: 20,
        method: 'get',
        where: {
          clientid: clientID,
          intakeserviceid: this.intakeserviceid,
          approvalstatuskey: 'Approved',
          fromdate: fromdate,
          todate: todate
        },
        order: 'insertedon desc'
      },'youthtransitionplan' + '?filter'
    ).subscribe(
      (response) => {
        let ytpListData: any = [];
        if (response && response.length > 0) {
          ytpListData = response.filter(i => i.summary_json);
          this.ytpList = ytpListData.filter((ver: any) => this.inDateRange(this.selectedVersion.fromdate, this.selectedVersion.todate, ver));
      }
    });
  }

  inDateRange(fromDate: any, toDate: any, ver: any) {
    if (!toDate) {
      toDate = new Date();
    }
    let res: boolean;
    let sDate = ver?.startdate?.split('T')[0];
    let eDate = ver?.enddate?.split('T')[0]
    if (sDate && eDate) {
      res = (new Date(sDate) >= new Date(fromDate) &&
       new Date(eDate) <= new Date(toDate));
    } else {
      res = (new Date(ver.insertedon) >= new Date(fromDate) && new Date(ver.insertedon) <= new Date(toDate));
    }
    return res;
  }

  closeView() {
    this.selectedYTPPlan = null;
    this.getYTPPlanList(this.cp1Data.personid, this.selectedVersion);
  }

  async downloadYTPPdf() {
    const pages: any = document.getElementsByClassName('pdf-page');
    let pageImages: any[] = [];
    for (let i = 0; i < pages.length; i++) {
      const pageName = pages.item(i).getAttribute('data-page-name');
      if (pageName === 'Youth Transitional Plan') {
        await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas) => {
          const img = canvas.toDataURL('image/png');
          pageImages.push(img);
        });
      }
    }

    this.pdfFiles.push({ fileName: 'Youth Transitional Plan', images: pageImages });
    pageImages = [];
    this.convertImageToPdf();
  }

  convertImageToPdf() {
    this.pdfFiles.forEach((pdfFile) => {
      var doc: any = null;
      doc = new jsPDF();
      var width = doc.internal.pageSize.getWidth() - 10;
      var heigth = doc.internal.pageSize.getHeight() - 10;

      pdfFile.images.forEach((image, index) => {

        doc.addImage(image, 'PNG', 3, 5, width, heigth);
        if (pdfFile.images.length > index + 1) {
          doc.addPage();
        }
      });
        doc.save(pdfFile.fileName);
    });
    (<any>$('#youthTransPlan')).modal('hide');
    this.pdfFiles = [];
  }
}