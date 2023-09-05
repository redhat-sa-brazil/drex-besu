# Hyperledger Besu em Openshift

A documentação é voltada para o deploy do Hyperledger Besu em ambientes **Openshift**.

Para entender o que é o Hyperledger Besu escrevi um artigo bem simples para explicar [leia aqui.](https://github.com/redhat-sa-brazil/drex-besu/blob/main/docs/hyperledger_besu.md "leia aqui.")

O howto mostra o deploy do besu observando a documentação que estão nos links abaixo:

- [Hyperledger](https://besu.hyperledger.org/23.4.0/private-networks/tutorials/kubernetes/playground "Hyperledger")
- [Arquitetura Bacen ](https://github.com/bacen/pilotord-kit-onboarding/blob/main/arquitetura.md "Arquitetura Bacen ")

Ambientes que estão sendo utilizado no openshift para este deploy.
- ARO
	- 4.12

*outros ambientes serão disponibilizados em breve*

###### ### Arquitetura do ARO
[![Arquitetura do ARO](https://github.com/redhat-sa-brazil/drex-besu/blob/main/docs/aro_architecture.png "Arquitetura do ARO")](https://github.com/redhat-sa-brazil/drex-besu/blob/main/docs/aro_architecture.png "Arquitetura do ARO")

###### ### Ambiente

ARO 4.12.x

###### ### Construção do container

- hyperledger-besu [23.4.1](https://github.com/hyperledger/besu/releases/tag/23.4.1 "23.4.1")(conforme especificado na arquitetura do bacen)
- [ubi9/openjdk17](registry.access.redhat.com/ubi9/openjdk-17:latest "ubi9/openjdk17")

