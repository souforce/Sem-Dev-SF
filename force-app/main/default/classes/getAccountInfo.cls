public with sharing class getAccountInfo {
    
    public static Boolean hasCNPJVerication(String accountId){
        Account acc = [SELECT Id, Ultima_Atualizacao__c
                       FROM Account 
                       WHERE Id =: accountId];

        Boolean isVerified = false;

        if(acc.Ultima_Atualizacao__c != null){
            isVerified = true;
        }

        return isVerified;
    }

    @AuraEnabled
    public static string saveRecord(String accountId, String json) {
        TOReceitaAPI receitaAPI = TOReceitaAPI.parse(json);

        Account account = new Account(Id = accountId);
        account.Name = receitaAPI.nome;
        account.Razao_Social__c = receitaAPI.nome;
        account.Message__c = receitaAPI.message;
        account.Status__c = receitaAPI.status;
        account.Ultima_Atualizacao__c = receitaAPI.ultima_atualizacao;
        account.Tipo__c = receitaAPI.tipo;

        account.Phone = receitaAPI.telefone;

        account.BillingStreet = receitaAPI.logradouro + ', ' + receitaAPI.numero + ' - ' + receitaAPI.bairro;
        account.BillingPostalCode = receitaAPI.cep;
        account.BillingCity = receitaAPI.municipio;
        account.BillingState = receitaAPI.uf;

        update account;
        return account.Id;
    }
}