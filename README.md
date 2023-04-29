# OrcamentoCentroCusto
A aplicação funciona tanto para o banco PostgreSQL como sem conexão com banco de dados, salvando os dados em um arquivo XML junto ao EXE.

## _Usando PostgreSQL_
Para que não seja necessária a instalação do banco de dados no local, vamos usar uma imagem do docker.
Execute os comandos no docker:
- docker pull postgres:10.23-alpine
- docker run --name postgres -p 7777:5432 -e POSTGRES_PASSWORD=postgres -d postgres:10.23-alpine

Baixe e copie as DLLs junto ao EXE:
- [DLLs PostgreSQL] - As DLLs estão na pasta bin
- libcrypto-1_1.dll
- libiconv-2.dll
- libintl-8.dll
- libpq.dll
- libssl-1_1.dll

Altere a configuração do arquivo **config.ini** que está junto ao EXE, substituindo o valor do campo **DATABASE** por ***postgres***, caso necessário poderá também alterar os demais campos conforme a configuração do seu banco de dados.

## _Usando localmente_
Altere a configuração do arquivo **config.ini** que está junto ao EXE, substituindo o valor do campo **DATABASE** por ***XML***, as configurações dos demais campos não serão utilizados.


[DLLs PostgreSQL]: <https://sbp.enterprisedb.com/getfile.jsp?fileid=1258256>
