import { Component, Input, OnInit } from '@angular/core';
import jsPDF from 'jspdf';
import { Subject } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
import { SafetyPlanView, SaftyPlan } from '../../../_entities/caseworker.data.model';
import { DataStoreService } from '../../../../../@core/services';
import { CASE_STORE_CONSTANTS } from '../../../_entities/caseworker.data.constants';
import { Html2CanvasService } from '../../../../../@core/services/html2canvas.service';
// import html2canvas from 'html2canvas';
// tslint:disable-next-line:import-blacklist

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'safety-plan-print-view',
    templateUrl: './safety-plan-print-view.component.html',
    styleUrls: ['./safety-plan-print-view.component.scss'],
    standalone: false
})
export class SafetyPlanPrintViewComponent implements OnInit {
    @Input()
    saftyPlan$!: Subject<SaftyPlan>;
    @Input()
    safetyPlanView!: SafetyPlanView;
    daNumber!: string;
    constructor(private route: ActivatedRoute, private _dataStoreService: DataStoreService,private html2canvas:Html2CanvasService) {

    }

    ngOnInit() {
        this.daNumber = this._dataStoreService.getData(CASE_STORE_CONSTANTS.DA_NUMBER);
        this.saftyPlan$.subscribe(sf => {
            // No content to add or call
        });
    }
    generatePDF() {
        const source: any = document.getElementById('printView');
        const self = this;
        const doc = new jsPDF('p', 'mm', 'a4');
        this.html2canvas.capture(source).then(function(
            canvas
        ) {
            const imgData = canvas.toDataURL('image/png');
            const pageHeight = 300;
            const imgWidth = 205;
            const imgHeight = (canvas.height * imgWidth) / canvas.width;
            let heightLeft = imgHeight;
            let position = 0;

            doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
            heightLeft -= pageHeight;

            while (heightLeft >= 0) {
                position = heightLeft - imgHeight;
                doc.addPage();
                doc.addImage(imgData, 'PNG', 0, position, imgWidth, imgHeight);
                heightLeft -= pageHeight;
            }

            doc.save(self.safetyPlanView.daNumber + '.pdf');
        });
    }
}
