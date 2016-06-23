json.array!(@admin_uos) do |admin_uo|
  json.extract! admin_uo, :id, :nome, :sigla, :codigo_ug, :cnpj, :endereco, :complemento, :bairro, :cidade_id, :cep
  json.url admin_uo_url(admin_uo, format: :json)
end
