import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ExaminationCwComponent } from './examination-cw.component';

describe('ExaminationCwComponent', () => {
  let component: ExaminationCwComponent;
  let fixture: ComponentFixture<ExaminationCwComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ExaminationCwComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ExaminationCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
