/*
*Classe para fins de aprendizado
*@autor: Flávio Henrique Gavilan
*@empresa: everis
*/
public class ControladoraApex {
    @AuraEnabled
    public static Endereco_Global__c updateValoresByCep(String cep){
     
		Endereco_Global__c eg = new Endereco_Global__c();
                               
		HttpResponse response = ServiceCalloutApex.calloutViaCep(cep);
        
        	Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        	
            //poderia estar em um método na camada service
        	eg.CEP__c = (String) results.get('cep');
            eg.Logradouro__c = (String) results.get('logradouro'); 
            eg.Complemento__c = (String) results.get('complemento'); 
            eg.Bairro__c = (String) results.get('bairro'); 
            eg.Municipio__c = (String) results.get('localidade'); 
            eg.Estado__c = (String) results.get('uf'); 
            eg.Codigo_IBGE__c = (String) results.get('ibge');
            eg.DDD__c = (String) results.get('ddd');
            eg.Siafi__c = (string) results.get('siafi');             
            
        	return eg;
            
    }
}
