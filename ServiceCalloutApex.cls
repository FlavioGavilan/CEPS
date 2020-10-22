/*
*Classe para fins de aprendizado
*@autor: Flávio Henrique Gavilan
*@empresa: everis
*/
public with sharing class ServiceCalloutApex {
    public static HttpResponse calloutViaCep(String cep){          
            
        Http h = new Http();
    	HttpRequest request = new HttpRequest();
        request.setEndpoint('https://viacep.com.br/ws/'+cep+'/json/');
    	request.setMethod('GET');
    	request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        request.setTimeout(3000);        	
        HttpResponse response = h.send(request);
        	
        return response;
    }
}
