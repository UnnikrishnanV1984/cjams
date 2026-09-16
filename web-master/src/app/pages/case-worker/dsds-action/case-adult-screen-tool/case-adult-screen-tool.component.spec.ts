import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { CaseAdultScreenToolComponent } from './case-adult-screen-tool.component';

describe('CaseAdultScreenToolComponent', () => {
  let component: CaseAdultScreenToolComponent;
  let fixture: ComponentFixture<CaseAdultScreenToolComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ CaseAdultScreenToolComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(CaseAdultScreenToolComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
