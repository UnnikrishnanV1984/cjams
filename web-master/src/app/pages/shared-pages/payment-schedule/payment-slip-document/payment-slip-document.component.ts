import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { IntakeStoreConstants } from '../../../newintake/my-newintake/my-newintake.constants';
import { DataStoreService } from '../../../../@core/services';
import jsPDF from 'jspdf';
import { Html2CanvasService } from '../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
declare var $ : any
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'payment-slip-document',
    templateUrl: './payment-slip-document.component.html',
    styleUrls: ['./payment-slip-document.component.scss'],
    standalone: false
})
export class PaymentSlipDocumentComponent implements OnInit {

    restiutionDocumentInfo: any;
    downloadInProgress!: boolean;
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    slipCount = [1, 2];
    constructor(private router: Router,
        private route: ActivatedRoute,
        private _datastoreService: DataStoreService,private html2canvas:Html2CanvasService) { }



    ngOnInit() {
        $('#payment-slip-document').modal('show');
        this.restiutionDocumentInfo = this._datastoreService.getData(IntakeStoreConstants.restiutionDocumentInfo);
    }

    goBack(): void {
       $('#payment-slip-document').modal('hide');
        this.router.navigate(['../'], { relativeTo: this.route });
    }

    collectivePdfCreator() {
        this.downloadCasePdf('restitiutionPaymentSlip');
    }

    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages = source.getElementsByClassName('pdf-page');
        let pageImages: any[] = [];
        for (let i = 0; i < pages.length; i++) {
            const pageName = pages.item(i).getAttribute('data-page-name');
            const isPageEnd = pages.item(i).getAttribute('data-page-end');
            await this.html2canvas.capture(<HTMLElement>pages.item(i)).then((canvas:any) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
                if (isPageEnd === 'true') {
                    this.pdfFiles.push({ fileName: pageName, images: pageImages });
                    pageImages = [];
                }
            });
        }
        this.convertImageToPdf();
    }

    convertImageToPdf() {
        this.pdfFiles.forEach((pdfFile) => {
            const doc: any = new jsPDF();
            pdfFile.images.forEach((image, index) => {
                doc?.addImage(image, 'JPEG', 0, 0);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
        this.goBack();
        this.pdfFiles = [];
        this.downloadInProgress = false;
    }

}
