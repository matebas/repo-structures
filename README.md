# Arquitetura e Estrutura do Repositório

Este repositório contém a infraestrutura e configurações de deploy baseadas na arquitetura definida no diagrama de referência. Abaixo estão os principais conceitos e decisões de design implementados.

## Estrutura de Rede

A infraestrutura de rede foi desenhada para garantir segurança, alta disponibilidade e isolamento entre ambientes. 

- **Isolamento de Ambientes:** Cada ambiente (Production e Development) roda separadamente em sua própria VPC/Conta, garantindo total isolamento do ambiente produtivo.
- **Topologia de Subnets:** 
  - Uma VPC distribuída entre várias subnets, com workloads espalhados por várias zonas de disponibilidade.
  - Para fins de ilustração, utilizamos 2 subnets privadas e 2 públicas, mas este número é sempre dimensionado de acordo com o tamanho e a necessidade do projeto.
- **Conectividade Externa (Load Balancer e NAT):** Um LoadBalancer é provisionado nas subnets públicas, redirecionando o tráfego e se comunicando com as redes privadas através de NAT Gateways.
- **Workloads Privados:** O cluster Google Kubernetes Engine (GKE) e todos os Worker Nodes são provisionados estritamente nas subnets privadas por segurança.
- **Regras de Acesso:** A entrada e a saída de dados são configuradas de forma rigorosa via regras de firewall.
- **Ambiente de Desenvolvimento (VPN):** A Development VPC é exposta apenas através de uma VPN, com acesso altamente restrito.

## Estrutura de GitOps

A gestão do ciclo de vida das aplicações no Kubernetes é feita seguindo os princípios de GitOps:

- **Ferramentas de Sincronização:** Utiliza-se **ArgoCD** (ou FluxCD) provisionado no próprio cluster para garantir que o estado do cluster reflita exatamente as definições do Git.
- **Kustomize Overlays:** A organização dos manifestos utiliza a arquitetura de **overlays com Kustomize** (ex: pastas base, dev, prod), permitindo o reuso de configurações.
- **Processo de Deploy de Imagens:** 
  - A imagem da aplicação é compilada (build) na esteira de CI/CD.
  - Com a tag da release, a imagem é versionada no repositório de imagens (Container Registry).
  - A promoção da nova imagem no ambiente é feita atualizando o arquivo `kustomization.yaml` (usando comandos como `kustomize edit set image`), alterando a tag nos Helm charts ou deployments/rollouts.
- **Segurança e Scan:** O **Trivy** é utilizado na pipeline para fazer o scanner de vulnerabilidades nas imagens geradas antes de serem promovidas aos ambientes.
