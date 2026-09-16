import { ChangeDetectorRef, Component, OnInit } from '@angular/core';
import { NavigationEnd, Router } from '@angular/router';
import { ScriptInitializerService } from '../@core/services/script-initializer.service';

declare var $: any;
@Component({
    // tslint:disable-next-line:component-selector
    selector: 'app-pages',
    templateUrl: './pages.component.html',
    styleUrls: ['./pages.component.scss'],
    standalone: false
})
export class PagesComponent implements OnInit {
    constructor(private router: Router, private cdRef: ChangeDetectorRef, private dashboardInit: ScriptInitializerService) {}

    ngOnInit() {
        this.router.events.subscribe((evt: any) => {
            if (!(evt instanceof NavigationEnd)) {
                return;
            }
            window.scrollTo(0, 0);
        });
        $('.fa-calendar').on('click', function(e: any) {
            $(e)
                .parent()
                .find('input')
                .focus();
        });
        
        this.dashboardInit.init().then(() => {
            // No data or function to call
        });
    }


    ngAfterContentChecked() {
        this.cdRef.detectChanges();
    }
}
