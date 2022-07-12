################################################
# Ação: Desativar usuários/Mover
# Criado por: Grosmam dos Santos, Raul
# Data alteração: 20/06/2022
################################################################################################################################################################################################

# Definindo variáveis para o arquivo CSV e para a OU a ser movida, assim como também as variáveis de data.
#$Users = import-csv -Path "C:\Users\raul.grosmam\Downloads\OneDrive_2022-06-21\Script_Remover_Usuario\Users_AEGEA.csv" -header "CPF", "Matricula", "Nome", "CPF2", "Identidade", "Funcao_Codigo", "Funcao_Nome", "mail", "Nome_da_mae", "Endereco_Logradouro", "Endereco_Numero", "Endereco_Bairro", "Endereco_Municipio_Nome", "Endereco_UF", "Endereco_CEP", "Telefone", "Empresa_Razao_Social", "Centro_de_result_cod", "Centro_de_result_nome", "Nasc", "Admissao", "Desligamento", "Nacionalidade", "Vinculo_Empregaticio_Nome", "Situacao", "Estabelecimento_cod" -Delimiter ";" | where-object {$_.Situacao -eq "Demiss�o"}
$Users_Ativos = import-csv -Path "Path do seu CSV" -header "CPF", "Matricula", "Nome", "CPF2", "Identidade", "Funcao_Codigo", "Funcao_Nome", "mail", "Nome_da_mae", "Endereco_Logradouro", "Endereco_Numero", "Endereco_Bairro", "Endereco_Municipio_Nome", "Endereco_UF", "Endereco_CEP", "Telefone", "Empresa_Razao_Social", "Centro_de_result_cod", "Centro_de_result_nome", "Nasc", "Admissao", "Desligamento", "Nacionalidade", "Vinculo_Empregaticio_Nome", "Situacao", "Estabelecimento_cod" -Delimiter ";" | where-object {$_.Situacao -eq "ATIVO"}
$Users_Demitidos = import-csv -Path "Path do seu CSV" -header "CPF", "Matricula", "Nome", "CPF2", "Identidade", "Funcao_Codigo", "Funcao_Nome", "mail", "Nome_da_mae", "Endereco_Logradouro", "Endereco_Numero", "Endereco_Bairro", "Endereco_Municipio_Nome", "Endereco_UF", "Endereco_CEP", "Telefone", "Empresa_Razao_Social", "Centro_de_result_cod", "Centro_de_result_nome", "Nasc", "Admissao", "Desligamento", "Nacionalidade", "Vinculo_Empregaticio_Nome", "Situacao", "Estabelecimento_cod" -Delimiter ";" | where-object {$_.Situacao -eq "Demiss�o"}
$OU_Dest = "DN da OU onde o usuário está"
$OU_Origin = "DN da OU onde o usuário deverá ir"
$data = Get-Date -Format dd-MM-yyyy
$date = Get-Date -Format yyyy-MM-dd
$DataDesabilitado = "Desativado em $data via script"
#Variavel de Comparacao, se há o mesmo usuário como Demissão e como Ativo, caso haja, o mesmo não será mexido pelo script.
$Comparacao = Compare-Object -ReferenceObject $Users_Ativos.mail -DifferenceObject $Users_Demitidos.mail -IncludeEqual | Where-Object {$_.SideIndicator -eq "=>"}


# Importando o módulo Active Directory.
Import-Module ActiveDirectory
   foreach ($Users in $Comparacao){
# Repetindo o comando para o número de linhas do arquivo CSV
    foreach ($User in $Users.InputObject){

    # Obter os dados dos usuários no CSV do ADP para acompanhamento

    #Pegar os usuários por OU especifica
    $Userobtido = Get-ADUser -SearchBase $OU_Origin -Filter "mail -like '$($User)'" -Properties DisplayName,MemberOf,mail    
    #Pegar os usuários na árvore do AD inteira
    #$Userobtido = Get-ADUser -Filter "mail -like '$($User)'" -Properties DisplayName,MemberOf

    #Pegando a data de expiração do usuário, caso não exista, setará para o dia da desativação.
    $ExpiracaoUser = Get-ADUser -SearchBase $OU_Origin -Filter "mail -like '$($Userobtido.mail)'" -Properties AccountExpirationDate | Select sAMAccountName, UserPrincipalName, distinguishedName, AccountExpirationDate
    if ($ExpiracaoUser.AccountExpirationDate -eq $null){
    Set-ADAccountExpiration -Identity $ExpiracaoUser.distinguishedName -DateTime (Get-Date).AddHours(24) }
    $ExpiracaoUser = Get-ADUser -SearchBase $OU_Origin -Filter "mail -like '$($Userobtido.mail)'" -Properties AccountExpirationDate | Select sAMAccountName, UserPrincipalName, distinguishedName, AccountExpirationDate
    $CompData = NEW-TIMESPAN -Start $ExpiracaoUser.AccountExpirationDate -End $data
           
        If ($Userobtido) {
        # Desabilitando a conta do usuário do CSV
            $Userobtido | Disable-ADAccount                        
            # Removendo os grupos de usuários expirados há mais de 730 dias, menos "Domain Users", sem confirmação.            
            if ($CompData.Days -gt 730){
                $Userobtido.MemberOf | ForEach-Object {
                Remove-ADGroupMember -Identity $_ -Members $Userobtido -Confirm:$False
                }
                }

        # Adiciona anotação no campo Description
            Set-Aduser $Userobtido -Description $DataDesabilitado

            # Movendo o usuário para a OU definida em $OU
            $Userobtido | Move-ADObject -TargetPath $OU_Dest

            #Log a ser gerada, com a data, o Nome do usuário movido, OU de Origem e OU de Destino
            "data:$(Get-Date) ---Nome:$($Userobtido.DisplayName) ---De:$($Userobtido.DistinguishedName) ---Para: $OU" | Out-File -Append Caminho_destino_$date.txt
             }
}
}
# Mensagem informando que o script foi executado com sucesso.
echo "O script foi executado com sucesso, consulte os usuários alterados no arquivo de log."