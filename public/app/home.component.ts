// public/app/home.component.ts
import {Component, OnInit} from 'angular2/core'
import {RouteParams}  from 'angular2/router'
import {Http, HTTP_PROVIDERS} from 'angular2/http';
@Component({
  selector: 'home',
  templateUrl: '/app/home.component.html'
})
export class HomeComponent {
  message: string;
  constructor( public http: Http){
    this.http.get('http://localhost:3000/api/v1/decks?auth=d26b896967444510804cab2f4e0d4d5f&user=1')
    .subscribe(
      data => this.message = data.json().some,
      err => console.log(err)
    );
  }
}
