import { Component, Injector, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import jsPDF from 'jspdf';

import { CommonHttpService } from '../../../../../@core/services';
import { Assessment, ChildRemoval, General, InvestigationSummary } from '../_entities/disposition.data.models';
import { DSDSActionSummary } from '../../../../providers/_entities/provider.data.model';
import { DataStoreService } from '../../../../../@core/services/data-store.service';
import { DsdsService } from '../../_services/dsds.service';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { Html2CanvasService } from '../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'investigation-report',
    templateUrl: './investigation-report.component.html',
    styleUrls: ['./investigation-report.component.scss'],
    standalone: false
})
export class InvestigationReportComponent implements OnInit {
    id!: string;
    currentDate = new Date();
    investigationSummary!: InvestigationSummary;
    generalSummary?: General;
    assessmentSummary!: Assessment[];
    childRemovalSummary!: ChildRemoval[];
    dsdsActionsSummary = new DSDSActionSummary();
    isServiceCase!: string;
    pdfFiles: { fileName: string; images: { image: string; height: any; name: string }[] }[] = [];
    private html2canvas:Html2CanvasService;
    private _dataStoreService: DataStoreService;
    private _dsdsService: DsdsService

    constructor(private _commonHttpService: CommonHttpService, private _route: ActivatedRoute, private readonly injector : Injector) {
        this.html2canvas = this.injector.get<Html2CanvasService>(Html2CanvasService);
        this._dataStoreService = this.injector.get<DataStoreService>(DataStoreService);
        this._dsdsService = this.injector.get<DsdsService>(DsdsService);
    }
    ngOnInit() {
        this.id = this._dataStoreService.getData(CASE_STORE_CONSTANTS.CASE_UID);
        this.isServiceCase = this._dsdsService.isServiceCase();
if (!this.isServiceCase) {
this.getInvestigationSummary();
}
this.dsdsActionsSummary = this._dataStoreService.getData('dsdsActionsSummary');
if (this.isServiceCase && this.dsdsActionsSummary.da_investigationid) {
this.getInvestigationSummary();
}
    }

    async downloadCasePdf(element: string) {
        const source: any = document.getElementById(element);
        const pages: any = source.getElementsByClassName('pdf-page');
        let pageImages: any[] = [];
        for (let i = 0; i < pages.length; i++) {    // NOSONAR // selecting item element has issue when writing for of loop
            await this.html2canvas.capture(<HTMLElement>pages.item(0)).then((canvas: any) => {
                const img = canvas.toDataURL('image/png');
                pageImages.push(img);
            });
        }
        const pageName = 'Investigation Summary';
        this.pdfFiles.push({ fileName: pageName, images: pageImages });
        pageImages = [];
        this.convertImageToPdf();
    }
    convertImageToPdf() {
        this.pdfFiles.forEach(pdfFile => {
            const doc: any = new jsPDF();
            pdfFile.images.forEach((image, index) => {
                doc.addImage(image, 'JPEG', 0, 0);
                if (pdfFile.images.length > index + 1) {
                    doc.addPage();
                }
            });
            doc.save(pdfFile.fileName);
        });
        $('#investigation-summary').modal('hide');
        this.pdfFiles = [];
    }

    private getInvestigationSummary() {
        this._commonHttpService
            .getSingle(
                {
                    intakeserviceid: this.isServiceCase ? this.dsdsActionsSummary.da_investigationid : this.id,
                    method: 'post'
                },
                'Investigations/getinvestigationsummary'
            )
            .subscribe(data => {
                if (data.length) {
                    this.investigationSummary = data[0];
                    if (this.investigationSummary.general !== null) {
                        this.fixNarrativeHistoryClearanceText();
                        
                        this.generalSummary = this.investigationSummary.general[0];
                        }
                    this.assessmentSummary = this.investigationSummary.assessment;
                    this.childRemovalSummary = this.investigationSummary.childremoval;
                }
            });
    }
    
    fixNarrativeHistoryClearanceText(){
        if(this.investigationSummary && Array.isArray(this.investigationSummary.general) && this.investigationSummary.general.length > 0)
        {
            let n='';
            let inv='';
            
            if(this.investigationSummary.general[0].narrative){
                n = n.replace(/(\\n)/g, '<br>');
                n = n.replace(/(\\r)/g, '');
                this.investigationSummary.general[0].narrative = n;
            }
            if(this.investigationSummary.inv_summary){
                inv = inv.replace(/(\\n)/g, '<br>');
                inv = inv.replace(/(\\r)/g, '');
                this.investigationSummary.inv_summary = inv;
            }
        }
    }

}
