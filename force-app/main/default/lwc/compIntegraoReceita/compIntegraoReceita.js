import { LightningElement, api, track, wire } from 'lwc';
import callReceitaAPI from '@salesforce/apex/ReceitaAPI.callReceitaAPI';
import saveRecord from '@salesforce/apex/getAccountInfo.saveRecord';
import { getRecord} from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CompIntegraoReceita extends LightningElement {
    @api recordId;
    @track record;
    @track error;
    @track isValidated;
    @track receitaData;

    @wire(getRecord, { recordId : '$recordId', fields : ['Account.Ultima_Atualizacao__c', 'Account.CNPJ__c']})
    wireAccount({ error, data }) {
        if (data) {
            this.isValidated = !!data.fields.Ultima_Atualizacao__c.value;

            this.record = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.record = undefined;
        }
    }

    consultarCNPJ() {
        let cnpj = this.record.fields.CNPJ__c.value;

        if (cnpj) {
            cnpj = cnpj.replace(/[^\d]/g, '');
            window.console.log(cnpj);

            callReceitaAPI({CNPJ : cnpj}).then(result => {
                this.receitaData = result;
            }).catch(error => {
                window.console.log(error);

                const event = new ShowToastEvent({
                    title: 'Erro',
                    message : 'Ocorreu um erro ao consultar os dados desse CNPJ.',
                    variant : 'error'// info, success
                });

                this.dispatchEvent(event);
            });
        }
    }

    salvar() {
        saveRecord({ accountId : this.recordId, json : JSON.stringify(this.receitaData) }).then(id => {
            window.console.log(id);

            this.isValidated = true;
            const event = new ShowToastEvent({
                title: 'Sucesso',
                message : 'As informações foram salvas com sucesso!',
                variant : 'success'// info, success
            });

            this.dispatchEvent(event);
        }).catch(error => {
            window.console.log(error);

            const event = new ShowToastEvent({
                title: 'Erro',
                message : 'Ocorreu ao salvar os seus dados.',
                variant : 'error'// info, success
            });
            this.dispatchEvent(event);
        })
    }
}