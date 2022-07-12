Repositório para depósito de mini projetos pessoais.

##################################################################################

Curso de Terraform

Arquivos de organização realizado em meu curso do Terraform, nada muito elaborado.

Alguns TFs organizados, para criação de um ambiente na AWS (VMs, Bucket, NSGs, etc)

##################################################################################

Recuperador de Yamls

Script em Linux Shell, recuperador de Yamls Kubernetes.
O mesmo irá análisar totalmente o cluster no qual você está atuando e criará as pastas e os yamls de todo o ambiente do cluster (deploymentes, sts, configmaps, etc) separado por namespaces.
Tudo virá limpo, sem nenhum residuo criado pelo próprio Kubernetes.

A limpeza é feita por uma extensão chamado Neat, que poderá ser encontrado no link:

##################################################################################

Remocao de Usuario Desabilitado do AD

Script em Powershell, com a função de fazer a limpa de usuário desabilitados seguindo um padrão fornecido em um CSV.
No caso, foi criado um padrão para pegar o valor "Demissão" no arquivo. Todos que estiverem com esse campo escrito "Demissão", será desabilitado então movido para a OU descrita na variável OU_Dest.
OBS: Há casos que haverá usuário duplicado, como ATIVO e Demissão, nesse caso, o usuário será ignorado.
Há também o fato de que todos os usuários desabilitados há mais de 730 dias, terão todos seus acessos revogados. Para isso, foi então declarado a data de expiração de conta no momento da desabilitação. Constantemente o Script checará se esse valor se passou há 730 dias, caso sim, os acessos serão revogados.
No final de tudo, é gerado um Log de tudo que foi alterado.

##################################################################################

Teste de Ansible

Ambiente Ansible criado como testes em ambiente de produção.