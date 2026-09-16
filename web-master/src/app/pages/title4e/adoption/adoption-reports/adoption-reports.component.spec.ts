import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AdoptionReportsComponent } from './adoption-reports.component';

describe('AdoptionReportsComponent', () => {
  let component: AdoptionReportsComponent;
  let fixture: ComponentFixture<AdoptionReportsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AdoptionReportsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AdoptionReportsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
