import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PersonBasicDetailsComponent } from './person-basic-details.component';

describe('PersonBasicDetailsComponent', () => {
  let component: PersonBasicDetailsComponent;
  let fixture: ComponentFixture<PersonBasicDetailsComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PersonBasicDetailsComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PersonBasicDetailsComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
