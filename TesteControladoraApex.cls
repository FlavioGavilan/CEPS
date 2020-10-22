/*
*Classe para fins de aprendizado
*@autor: Flávio Henrique Gavilan
*@empresa: everis
*/
@isTest
private class TesteControladoraApex {
    @isTest static void listaCepVazia(){
        String returnBody = '{"code" : 400, "message" : "NOT OK"}';
        String cep = '';
        
        MockViaCep meuMock = new MockViaCep(400, 'NOT OK', returnBody, new Map<String,String>());
        Test.setMock(HttpCalloutMock.class, meuMock);
        
        Endereco_Global__c cepEsperado = new Endereco_Global__c();
        cepEsperado.CEP__c = null;
        cepEsperado.Logradouro__c = null;
        cepEsperado.Complemento__c = null;
        cepEsperado.Bairro__c = null;
        cepEsperado.Municipio__c = null;
        cepEsperado.Estado__c = null;
        cepEsperado.Codigo_IBGE__c = null;
        cepEsperado.DDD__c = null;
        cepEsperado.Siafi__c = null;
        
        Test.startTest();
            
            Endereco_Global__c cepRecebido = ControladoraApex.updateValoresByCep(cep);
			
		Test.stopTest();
        System.assertEquals(cepEsperado, cepRecebido);
    }
    
    @isTest static void obterListaCepValorValido(){
        String cep = '88048000';
        String returnBody = '{"cep": "88048-000","logradouro": "Rodovia Francisco Magno Vieira",'+
                                    '"complemento": "","bairro": "Costeira do Pirajubaé","localidade": "Florianópolis",'+
                                    '"uf": "SC","ibge": "4205407","gia": "","ddd": "48","siafi": "8105"}';
        
        MockViaCep meuMock = new MockViaCep(201, 'OK', returnBody, new Map<String,String>());
        Test.setMock(HttpCalloutMock.class, meuMock);
        
        Endereco_Global__c cepEsperado = new Endereco_Global__c();
        cepEsperado.CEP__c = '88048-000';
        cepEsperado.Logradouro__c = 'Rodovia Francisco Magno Vieira';
        cepEsperado.Complemento__c = '';
        cepEsperado.Bairro__c = 'Costeira do Pirajubaé';
        cepEsperado.Municipio__c = 'Florianópolis';
        cepEsperado.Estado__c = 'SC';
        cepEsperado.Codigo_IBGE__c = '4205407';
        cepEsperado.DDD__c = '48';
        cepEsperado.Siafi__c = '8105';
        
        Test.startTest();
            
            Endereco_Global__c cepRecebido = ControladoraApex.updateValoresByCep(cep);
			
		Test.stopTest();
        System.assertEquals(cepEsperado, cepRecebido);
    } 
    
    @isTest static void obterListaCepValorInvalido(){
        String cep = '11111111';
        String returnBody = '{"erro": true}';
        
        MockViaCep meuMock = new MockViaCep(200, 'OK', returnBody, new Map<String,String>());
        Test.setMock(HttpCalloutMock.class, meuMock);
        
        Endereco_Global__c cepEsperado = new Endereco_Global__c();
        cepEsperado.CEP__c = null;
        cepEsperado.Logradouro__c = null;
        cepEsperado.Complemento__c = null;
        cepEsperado.Bairro__c = null;
        cepEsperado.Municipio__c = null;
        cepEsperado.Estado__c = null;
        cepEsperado.Codigo_IBGE__c = null;
        cepEsperado.DDD__c = null;
        cepEsperado.Siafi__c = null;
        
        Test.startTest();
            
            Endereco_Global__c cepRecebido = ControladoraApex.updateValoresByCep(cep);
			
		Test.stopTest();
        System.assertEquals(cepEsperado, cepRecebido);
    } 
}
