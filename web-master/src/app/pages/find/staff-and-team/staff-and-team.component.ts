import { Component, OnInit } from '@angular/core';
import { Observable ,  Subject } from 'rxjs';

import { UsersSearchResult } from '../_entities/find-entity.module';

declare var $: any;

@Component({
    // tslint:disable-next-line:component-selector
    selector: 'staff-and-team',
    templateUrl: './staff-and-team.component.html',
    styleUrls: ['./staff-and-team.component.scss'],
    standalone: false
})
export class StaffAndTeamComponent implements OnInit {

    searchListSubject$: Subject<Observable<UsersSearchResult[]>>;
    totalRecordsSubject$: Subject<Observable<number>>;
    pageNumberSubject$: Subject<number>;
    userIDSubject$: Subject<UsersSearchResult>;

    searchList$!: Observable<UsersSearchResult[]>;
    totalRecords$!: Observable<number>;
    glyphiconclass = '.glyphicon';
    glyphiconminusclass ='glyphicon-minus';
    glyphiconplusclass ='glyphicon-plus';
    constructor() {
        this.searchListSubject$ = new Subject<Observable<UsersSearchResult[]>>();
        this.totalRecordsSubject$ = new Subject<Observable<number>>();
        this.pageNumberSubject$ = new Subject<number>();
        this.userIDSubject$ = new Subject<UsersSearchResult>();
    }

    ngOnInit() {
        this.searchListSubject$.subscribe(data => {
            this.searchList$ = data;
        });

        this.totalRecordsSubject$.subscribe(data => {
            this.totalRecords$ = data;
        });

        $('.collapse.in').each(() => {
            $(this).siblings('.card-header').find(this.glyphiconclass).addClass(this.glyphiconminusclass).removeClass(this.glyphiconplusclass);
        });

        // Toggle plus minus icon on show hide of collapse element
        $('.collapse').on('show.bs.collapse', () => {
            $(this).parent().find(this.glyphiconclass).removeClass(this.glyphiconplusclass).addClass(this.glyphiconminusclass);
        }).on('hide.bs.collapse', () => {
            $(this).parent().find(this.glyphiconclass).removeClass(this.glyphiconminusclass).addClass(this.glyphiconplusclass);
        });
    }

}
