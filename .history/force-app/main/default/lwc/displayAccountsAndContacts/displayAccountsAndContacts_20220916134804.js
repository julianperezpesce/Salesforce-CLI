import { LightningElement, wire } from 'lwc';
import displayAccountRecords from '@salesforce/apex/AccountDemoController.displayAccountRecords';
import displayContactRecords from '@salesforce/apex/AccountDemoController.displayContactRecords';

export default class DisplayAccountsAndContacts extends LightningElement {
    @wire(displayAccountRecords) accounts;
    
    accountId;
    handleClick(event) {
        this.accountId = event.target.value;
        const sampleDemoEvent = new CustomEvent('sampleDemoEvent', {
            detail: this.accountId
        });
        this.dispatchEvent(sampleDemoEvent);
    }
}