import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonHealthSectionLogComponent } from './person-health-section-log.component';

describe('PersonHealthSectionLogComponent', () => {
  let component: PersonHealthSectionLogComponent;
  let fixture: ComponentFixture<PersonHealthSectionLogComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonHealthSectionLogComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonHealthSectionLogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
