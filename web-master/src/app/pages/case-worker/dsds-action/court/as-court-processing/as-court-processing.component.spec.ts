import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { AsCourtProcessingComponent } from './as-court-processing.component';

describe('AsCourtProcessingComponent', () => {
  let component: AsCourtProcessingComponent;
  let fixture: ComponentFixture<AsCourtProcessingComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ AsCourtProcessingComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(AsCourtProcessingComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
