import { Component, OnInit, Input } from '@angular/core';
import { CommonHttpService, DataStoreService, AuthService } from '../../../../../../@core/services';
import { ServiceLog } from '../../_entities/service-plan.model';
import { CaseWorkerUrlConfig } from '../../../../case-worker-url.config';
import { Subject } from 'rxjs';
import jsPDF from 'jspdf';
import { DSDSActionSummary } from '../../../../_entities/caseworker.data.model';
import { Html2CanvasService } from '../../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'service-log',
    templateUrl: './service-log.component.html',
    styleUrls: ['./service-log.component.scss'],
    standalone: false
})
export class ServiceLogComponent implements OnInit {

  @Input() servicePlanId$!: Subject<string>;
  dsdsActionsSummary :DSDSActionSummary = new DSDSActionSummary();
  currentDate = new Date();
  pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
  serviceLog?: ServiceLog;

  constructor(private _httpService: CommonHttpService, private _dataStoreService: DataStoreService,private html2canvas:Html2CanvasService, ) { }

  ngOnInit() {

    this._dataStoreService.currentStore.subscribe((store) => {
      if (store['dsdsActionsSummary']) {
        this.dsdsActionsSummary = store['dsdsActionsSummary'];
      }
  }); 
    this.servicePlanId$.subscribe((id) => {
      if (id) {
      this._httpService.getSingle({
        serviceplanid: id,
        method: 'post',
      }, CaseWorkerUrlConfig.EndPoint.DSDSAction.ServicePlan.ServiceLog).subscribe((data) => {
        this.serviceLog = data;
      });
     }
    });
  }

  async downloadCasePdf(element: string) {
    const source: any = document.getElementById(element);
    const pages: any = source.getElementsByClassName('pdf-page');
    let pageImages: any[] = [];
    for (let i = 0; i < pages.length; i++) {

        await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas: any) => {
            const img = canvas.toDataURL('image/png');
            pageImages.push(img);
        });
    }
    const pageName = 'pageName';
    this.pdfFiles.push({ fileName: pageName, images: pageImages });
    pageImages = [];
    this.convertImageToPdf();

}

convertImageToPdf() {
  this.pdfFiles.forEach((pdfFile) => {
      const doc: any = new jsPDF();
      pdfFile.images.forEach((image, index) => {
          doc.addImage(image, 'JPEG', 0, 0);
          if (pdfFile.images.length > index + 1) {
              doc.addPage();
          }
      });
      doc.save(pdfFile.fileName);
  });
  (<any>$('#intake-complaint-pdf1')).modal('hide');
  this.pdfFiles = [];
}

}
