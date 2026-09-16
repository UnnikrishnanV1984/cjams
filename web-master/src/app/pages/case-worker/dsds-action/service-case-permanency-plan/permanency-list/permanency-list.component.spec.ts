import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { PermanencyListComponent } from './permanency-list.component';

describe('PermanencyListComponent', () => {
  let component: PermanencyListComponent;
  let fixture: ComponentFixture<PermanencyListComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ PermanencyListComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PermanencyListComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
