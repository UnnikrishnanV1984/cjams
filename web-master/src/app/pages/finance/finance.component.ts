import { Component, OnInit, ElementRef } from '@angular/core';
import { AuthService } from '../../@core/services';
import { ActivatedRoute } from '@angular/router';
import { FinanceResolverService } from './finance-resolver-service';

@Component({
    selector: 'app-finance',
    templateUrl: './finance.component.html',
    styleUrls: ['./finance.component.scss'],
    standalone: false
})
export class FinanceComponent implements OnInit {
    constructor(
        private _authServie: AuthService,
        private elementRef: ElementRef,
        private route: ActivatedRoute,
        private financeResolverService: FinanceResolverService
    ) { 
        // this.route.data.subscribe(data => {
        //     if (data && data.hasOwnProperty('result')) {
        //         _authServie.setAuthDetail('finance',data.result);
        //     }
        // });
    }

    ngOnInit() {
        this.financeResolverService.getFinance().subscribe({
            next: (data: any) => {
                this._authServie.setAuthDetail('finance',data);
            }
        })
        this._authServie.addRemoveReadOnlyResources('FINANCE');
        const isReadOnly = this._authServie.readonlyButton('read_only_access', '');
        if (!isReadOnly) {
             const childInputNodes = this.elementRef.nativeElement.querySelectorAll('select, textarea, mat-select, quill-editor');
             childInputNodes.forEach(function(elem: any, index: number) {
                elem.disabled = true;
             });
         }

     }
}
