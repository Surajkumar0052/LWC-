import { LightningElement, wire } from 'lwc';
import fetchAccounts from '@salesforce/apex/AccountController.fetchAccounts';
import { NavigationMixin } from 'lightning/navigation';

const actions = [
      { label: 'View', name: 'view' },
      { label: 'Edit', name: 'edit' },
];

const columns = [
      { label: 'Name', fieldName: 'Name' },
      { label: 'Industry', fieldName: 'Industry' },
      { label: 'Rating', fieldName: 'Rating', type: 'PickList' },
      {
            type: 'action',
            typeAttributes: { rowActions: actions },
      },
];

//use map/ find function, debouncing
export default class DataTableTask extends NavigationMixin(LightningElement) {

      accounts;
      columns = columns;
      initialRecords;
      showMessage = false;

      searchKey = '';

      delayInterval = 400;
      typingTime;

      @wire(fetchAccounts, { searchKey: '$searchKey' })
      wiredAccount({ data, error }) {
            
            if (data) {
                  console.log(data);
                  this.accounts = data;
                  this.initialRecords = data;

            } else if (error) {
                  console.log(error);
            };

      }


      handleRowAction(event) {

            const actionName = event.detail.action.name;
            const row = event.detail.row;
            switch (actionName) {
                  case 'view':
                        this[NavigationMixin.Navigate]({
                              type: 'standard__recordPage',
                              attributes: {
                                    recordId: row.Id,
                                    actionName: 'view'
                              }
                        });
                        break;
                  case 'edit':
                        this[NavigationMixin.Navigate]({
                              type: 'standard__recordPage',
                              attributes: {
                                    recordId: row.Id,
                                    objectApiName: 'Account',
                                    actionName: 'edit'
                              }
                        });
                        break;
                  default:
            }

      }

      handleSearch(event) {

            try {
                  clearTimeout(this.typingTime);
                  const searchKey = event.target.value.toLowerCase();
                  let records = this.accounts;

                  this.typingTime = setTimeout(() => {
                        this.searchKey = searchKey;
                        if (searchKey) {
                              let rec = records.filter((r) => {
                                    return r.Name.toLowerCase().includes(searchKey) ? r.Name.toLowerCase().includes(searchKey) : this.showMessage = false ;
                              })

                              console.log('Matched data : ', rec);
                              this.accounts = rec;
                        }
                        
                  }, this.delayInterval);
            }
            catch (error) {
                  console.log('Error in searching account : ', error);
            }

      }
}

