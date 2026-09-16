import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CaseSearchListComponent } from './case-search-list.component';

describe('CaseSearchListComponent', () => {
  let component: CaseSearchListComponent;
  let fixture: ComponentFixture<CaseSearchListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CaseSearchListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CaseSearchListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
