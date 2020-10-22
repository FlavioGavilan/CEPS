/*
*Classe para fins de aprendizado
*@autor: Flávio Henrique Gavilan
*@empresa: everis
*/
import { LightningElement } from 'lwc';
import { createRecord, createRecordInputFilteredByEditedFields } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CEP_FIELD from '@salesforce/schema/Endereco_Global__c.CEP__c';
import LOGRADOURO_FIELD from '@salesforce/schema/Endereco_Global__c.Logradouro__c';
import BAIRRO_FIELD from '@salesforce/schema/Endereco_Global__c.Bairro__c';
import LOCALIDADE_FIELD from '@salesforce/schema/Endereco_Global__c.Municipio__c';
import ESTADO_FIELD from '@salesforce/schema/Endereco_Global__c.Estado__c';
import IBGE_FIELD from '@salesforce/schema/Endereco_Global__c.Codigo_IBGE__c';
import DDD_FIELD from '@salesforce/schema/Endereco_Global__c.DDD__c';
import SIAFI_FIELD from '@salesforce/schema/Endereco_Global__c.Siafi__c';
import ENDERECO_GLOBAL_OBJECT from '@salesforce/schema/Endereco_Global__c';
import updateValoresByCep from '@salesforce/apex/ControladoraApex.updateValoresByCep';


export default class Ceps extends LightningElement {
    
    endereco_globalId;
    cep = '';
    condicao = '';

    handleCepChange(event) {        
        this.cep = event.target.value;

        if(this.cep.length > 0){
            if(isNaN(this.cep)){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Erro',
                        message: 'CEP só pode conter números.',
                        variant: 'error',                       
                    }),                    
                );
            }
        }

        if(this.cep.length > 0 && this.cep.length < 8){
            const camposValor = this.template.querySelectorAll('.slds-var-m-bottom_x-small');
            camposValor.forEach(campo => {
                campo = '';
            });
        }

        if(this.cep.length == 8){
    
            updateValoresByCep({cep:this.cep}).then(result => {
                this.condicao = result;
                this.error = undefined;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Sucesso',
                        message: 'Valor de cep carregado com sucesso.',
                        variant: 'sucess',                       
                    }),                    
                );
            })
            .catch(error=>{
                this.result = undefined;
                this.error = error;
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Erro',
                        message: 'Valor de cep é inválido ou não existe.',
                        variant: 'error',                       
                    }),                    
                );
            })
        }
    }

    cadastrarEndereco(){
        const fields = {};
            
        fields[CEP_FIELD.fieldApiName]=this.condicao.CEP__c;
        fields[LOGRADOURO_FIELD.fieldApiName]=this.condicao.Logradouro__c;
        fields[BAIRRO_FIELD.fieldApiName]=this.condicao.Bairro__c;
        fields[LOCALIDADE_FIELD.fieldApiName]=this.condicao.Municipio__c;
        fields[ESTADO_FIELD.fieldApiName]=this.condicao.Estado__c;
        fields[IBGE_FIELD.fieldApiName]=this.condicao.Codigo_IBGE__c;
        fields[DDD_FIELD.fieldApiName]=this.condicao.DDD__c;
        fields[SIAFI_FIELD.fieldApiName]=this.condicao.Siafi__c;
            
        const recordInput = { apiName: ENDERECO_GLOBAL_OBJECT.objectApiName, fields };
            
        createRecord(recordInput)
        .then(endereco_global => {
                
            this.endereco_globalId = endereco_global.id;

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Successo',
                    message: 'Endereço Global criado',
                    variant: 'success',                       
                }),                    
            );                    
        })

        .catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Não foi possível criar o registro desejado.',
                    message: error.body.message,
                    variant: 'error',
                }),
            );
        });
    }

}