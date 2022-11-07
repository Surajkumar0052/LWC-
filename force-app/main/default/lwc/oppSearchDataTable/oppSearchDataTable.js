import { LightningElement, track, wire } from 'lwc';
import getOppRecords from '@salesforce/apex/OpportunityController.getOppRecords';

export default class OppSearchDataTable extends LightningElement {

      @track columns = [
            { label: 'Name', fieldName: 'OpportunityName' },
            { label: 'Description', fieldName: 'OppDescription' },
            { label: 'Stage', fieldName: 'OppStage' },
            { label: 'Close Date', fieldName: 'OppCloseDate' },
            { label: 'Account Name', fieldName: 'AccountName' },
            { label: 'Contact Name', fieldName: 'ContactName' },
            { label: 'Contact Email', fieldName: 'ContactEmail' },
            { label: 'Contact Phone Number', fieldName: 'ContactPhone' },
      ];

      oppData;
      initialRecords;
      delayInterval = 300;
      typingTime;
      showMessage = false;
      searchKey = '';


      @wire(getOppRecords, { searchKey: '$searchKey' })
      opp({ data, error }) {
            if (data) {
                  this.oppData = data;
                  console.log('Data Stringified : ', data);
                  let tempRecords = JSON.parse(JSON.stringify(data));

                  tempRecords = tempRecords.map(row => {
                        return {
                              AccountName: row.accRec.Name, OpportunityName: row.oppRec.Name,
                              OppDescription: row.oppRec.Description, OppCloseDate: row.oppRec.CloseDate,
                              ContactName: row.contactRec.Name, ContactEmail: row.contactRec.Email,
                              ContactPhone: row.contactRec.Phone, OppStage: row.oppRec.StageName
                        };
                  })

                  this.oppData = tempRecords;
                  this.initialRecords = tempRecords;
            }
            if (error) {
                  console.log('Error in opp Data : ', error);
            }
      };


      handleSearch(event) {
            try {
                  clearTimeout(this.typingTime);
                  const searchKey = event.target.value.toLowerCase();
                  console.log('Input value : ', searchKey);
                  console.log('before this.oppdata', this.oppData);
                  let records = this.initialRecords;

                  this.typingTime = setTimeout(() => {
                        this.searchKey = searchKey;
                        if (searchKey) {
                              let rec = records.filter((r) => {
                                    if (r.AccountName.toLowerCase().includes(searchKey)) {
                                          console.log('Contact name : ', r.ContactName);
                                          return r.AccountName.toLowerCase().includes(searchKey)
                                    }

                                    else if (r.ContactName.toLowerCase().includes(searchKey)) {
                                          console.log('matched contact : ', r);
                                          return r.ContactName.toLowerCase().includes(searchKey);

                                    }
                                    else if (r.OppStage.toLowerCase().includes(searchKey)) {
                                          console.log('matched oppstage : ', r);
                                          return r.OppStage.toLowerCase().includes(searchKey);

                                    }

                              })

                              console.log('Matched data : ', rec);
                              this.oppData = rec;
                              if (this.oppData.size() == 0) {
                                    this.showMessage = true;
                              }
                        }
                        else {
                              this.showMessage = false;
                              this.oppData = this.initialRecords;
                        }

                  }, this.delayInterval);
            }
            catch (error) {
                  console.log('Error in searching account : ', error);
            }
      }


}