public with sharing class ReceitaAPI {
    private static final String endpoint = 'https://www.receitaws.com.br/v1/cnpj/';

    @AuraEnabled
    public static TOReceitaAPI callReceitaAPI(String CNPJ){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint + CNPJ);
        request.setMethod('GET');
        request.setTimeout(12000);
        try{
            HttpResponse response = http.send(request);
            if(response.getStatusCode() == 200){
                String json = response.getBody();
                return TOReceitaAPI.parse(json);
            } else if (response.getStatusCode() == 429){
                TOReceitaAPI toReceita = new TOReceitaAPI();
                toReceita.status = 'ERROR';
                toReceita.message = 'Too Many Request';

                return toReceita;
            }
        } catch(Exception ex) {
            TOReceitaAPI toReceitaErro = new TOReceitaAPI();
            toReceitaErro.status = 'ERROR';
            toReceitaErro.message = ex.getMessage();

            return toReceitaErro;
        }

        return null;
    }
}