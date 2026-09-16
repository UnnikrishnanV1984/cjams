import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ApAcaFormComponent } from './ap-aca-form.component';

describe('ApAcaFormComponent', () => {
  let component: ApAcaFormComponent;
  let fixture: ComponentFixture<ApAcaFormComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ApAcaFormComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ApAcaFormComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
