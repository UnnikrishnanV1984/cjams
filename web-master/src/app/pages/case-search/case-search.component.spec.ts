import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CaseSearchComponent } from './case-search.component';

describe('CaseSearchComponent', () => {
  let component: CaseSearchComponent;
  let fixture: ComponentFixture<CaseSearchComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CaseSearchComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CaseSearchComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
