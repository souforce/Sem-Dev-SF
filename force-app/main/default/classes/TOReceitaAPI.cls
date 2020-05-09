public with sharing class TOReceitaAPI {
    
	@AuraEnabled
	public List<Atividade_principal> atividade_principal;
	@AuraEnabled
	public String data_situacao;
	@AuraEnabled
	public String nome;
	@AuraEnabled
	public String uf;
	@AuraEnabled
	public String telefone;
	@AuraEnabled
	public List<Atividade_principal> atividades_secundarias;
	@AuraEnabled
	public List<Qsa> qsa;
	@AuraEnabled
	public String situacao;
	@AuraEnabled
	public String bairro;
	@AuraEnabled
	public String logradouro;
	@AuraEnabled
	public String numero;
	@AuraEnabled
	public String cep;
	@AuraEnabled
	public String municipio;
	@AuraEnabled
	public String porte;
	@AuraEnabled
	public String abertura;
	@AuraEnabled
	public String natureza_juridica;
	@AuraEnabled
	public String fantasia;
	@AuraEnabled
	public String cnpj;
	@AuraEnabled
	public String ultima_atualizacao;
	@AuraEnabled
	public String status;
	@AuraEnabled
	public String message;
	@AuraEnabled
	public String tipo;
	@AuraEnabled
	public String complemento;
	@AuraEnabled
	public String email;
	@AuraEnabled
	public String efr;
	@AuraEnabled
	public String motivo_situacao;
	@AuraEnabled
	public String situacao_especial;
	@AuraEnabled
	public String data_situacao_especial;
	@AuraEnabled
	public String capital_social;
	@AuraEnabled
	public Extra extra;
	@AuraEnabled
	public Billing billing;

	public class Extra {
	}

	public class Billing {
		@AuraEnabled
		public Boolean free;
		@AuraEnabled
		public Boolean database;
	}

	public class Atividade_principal {
		@AuraEnabled
		public String text;
		@AuraEnabled
		public String code;
	}

	public class Qsa {
		@AuraEnabled
		public String qual;
		@AuraEnabled
		public String nome;
	}

	
	public static TOReceitaAPI parse(String json) {
		return (TOReceitaAPI) System.JSON.deserialize(json, TOReceitaAPI.class);
	}
}