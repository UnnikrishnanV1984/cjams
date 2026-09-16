import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonWorksDetailsComponent } from './person-works-details.component';

describe('PersonWorksDetailsComponent', () => {
  let component: PersonWorksDetailsComponent;
  let fixture: ComponentFixture<PersonWorksDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonWorksDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonWorksDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
