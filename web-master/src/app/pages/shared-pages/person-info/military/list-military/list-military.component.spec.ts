import { ComponentFixture, TestBed, waitForAsync } from '@angular/core/testing';

import { ListMilitaryComponent } from './list-military.component';

describe('ListMilitaryComponent', () => {
  let component: ListMilitaryComponent;
  let fixture: ComponentFixture<ListMilitaryComponent>;

  beforeEach(waitForAsync(() => {
    TestBed.configureTestingModule({
      declarations: [ ListMilitaryComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ListMilitaryComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
