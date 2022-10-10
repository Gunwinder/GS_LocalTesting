import { LightningElement, api } from 'lwc';

export default class CurrentDateTime extends LightningElement {
    @api tdate;
    tdate = new Date().toDateString();
 }