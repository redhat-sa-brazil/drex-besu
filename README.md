# Hyperledger Besu em Openshift

A documentação é voltada para o deploy do Hyperledger Besu em ambientes **Openshift**.

Para entender o que é o Hyperledger Besu escrevi um artigo bem simples para explicar [leia aqui.](https://github.com/redhat-sa-brazil/drex-besu/blob/main/docs/hyperledger_besu.md "leia aqui.")

O howto mostra o deploy do besu observando a documentação que estão nos links abaixo:

- [Hyperledger](https://besu.hyperledger.org/23.4.0/private-networks/tutorials/kubernetes/playground "Hyperledger")
- [Arquitetura Bacen ](https://github.com/bacen/pilotord-kit-onboarding/blob/main/arquitetura.md "Arquitetura Bacen ")

Versão de openshift que está sendo utilizado para este deploy.
- ARO
	- 4.12

- ROSA e HCP
  - 4.12
  - 4.13
**Pre-req: ter o aws loadbalancer operator instalado no cluster ROSA verifique no [link mobb.ninja](https://mobb.ninja/docs/rosa/aws-load-balancer-operator/ "link mobb.ninja")*

> *outros ambientes serão disponibilizados em breve*

###### Arquitetura do ARO
[![Arquitetura do ARO](https://github.com/redhat-sa-brazil/drex-besu/blob/main/docs/aro_architecture.png "Arquitetura do ARO")](https://github.com/redhat-sa-brazil/drex-besu/blob/main/docs/aro_architecture.png "Arquitetura do ARO")

###### Construção do container

- hyperledger-besu [23.4.1](https://github.com/hyperledger/besu/releases/tag/23.4.1 "23.4.1")(conforme especificado na arquitetura do bacen)
- Red Hat Universal Base Image [ubi9/openjdk17](registry.access.redhat.com/ubi9/openjdk-17:latest "ubi9/openjdk17")

###### Portas de serviços para expor
8545(tcp) / 8546(tcp) / 8547(tcp) / 8550(tcp) / 8551(tcp) / 30303(tcp/udp)

- HTTP JSON-RPC - 8545
- WS JSON-RPC - 8546
- HTTP GraphQL - 8547
- HTTP ENGINE JSON-RPC - 8550
- WS ENGINE JSON-RPC -  8551
- P2P (TCP/UDP) - 30303

> Por conta do modelo de arquitetura utilizar RPC não é possivel a exposição pelo router default do Openshift, neste caso precisa ser realizado através de nodeport.
Os modelos integrados de implementação do Openshift nas clouds permite ser utilizado uma integração com os LoadBalancers, no caso da Azure o Standard LoadBalancer não precisamos nos preocupar com a escalabilidade dos nodes.

###### Build do Container
> No repositório temos o Dockerfile que já está preparado para ultima versão da UBI9 com o openjdk.

**Build com docker**

``
 docker build -t besu-ubi-23.4.1:latest -f Dockerfile .
``

**Build com podman**

``
 podman build -t besu-ubi-23.4.1:latest -f Dockerfile .
``

------------

**Configurando para realizar todo o deploy**

- Edite o arquivo vars.yml
```yaml
openshift_cluster: "https://api.xxxxxxx:6443" # informe a API do openshift
openshift_username: "XXXX" # informe o usuario do Openshift para deploy do projeto
openshift_password: "XXXX" # informe a senha do usuario do Openshift
project_name: besu-5 # informe o nome do projeto a ser criado no Openshift
project_display_name: "besu-5" # informe o nome do projeto a ser criado no Openshift
project_description: "bla" # informe o descritivo do projeto a ser criado no Openshift
```

- Para fazer o deploy do projeto rode o comando abaixo após alterar o arquivo.

``
  make aro
``

