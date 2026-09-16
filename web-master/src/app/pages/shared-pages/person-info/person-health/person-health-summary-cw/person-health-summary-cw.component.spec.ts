import { ComponentFixture, TestBed } from '@angular/core/testing';

import { PersonHealthSummaryCwComponent } from './person-health-summary-cw.component';

describe('PersonHealthSummaryCwComponent', () => {
  let component: PersonHealthSummaryCwComponent;
  let fixture: ComponentFixture<PersonHealthSummaryCwComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ PersonHealthSummaryCwComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonHealthSummaryCwComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
