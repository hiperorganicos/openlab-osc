# Hiperorgânicos OSCGroups
Arquivos e instruções básicas para a conectividade OSC (Open Sound Control) utilizada no open lab


### Introdução ao OSC (english)

<http://opensoundcontrol.org/introduction-osc>


### O sistema OscGroups

Usamos o OscGroups por ser um sistema que facilita o multicast de dados entre os usuários. Quando o `OscGroupClient` (cliente) está rodando conectado a um `OscGroupServer` (no caso, o servidor do NANO), todas as mensagens que você envia para seu endereço local (localhost ou 127.0.0.1) na porta 22243, são enviadas para o servidor e a todos os outros clientes conectados, assim como todas mensagens enviadas pelos outros clientes chegam pra você na porta 22244. Confira os exemplos básicos de PD de envio e recebimento de dados.

Esquema de funcionamento:

<img src="https://raw.githubusercontent.com/hiperorganicos/openlab-osc/master/imagens/osc_schematic.png" alt="">


> OSCgroups is a system for routing OSC messages between a group of collaborating users. It is designed to make joining and leaving a group simple, and to overcome the problem of connecting multiple users behind different NAT routers using a NAT traversal server with the usual “NAT hole punching” scheme (you can put that into google for more info). OSCgroups also implements basic group functionality similar to the concept of channels in internet relay chat. You can read the README file for more info.
> <http://www.rossbencina.com/code/oscgroups>

	update 17/07/2013: conectividade facilitada

## Conectividade facilitada (RECOMENDADO!) (Mac e Windows)

Para simplificar o processo de conexão, criamos scripts de conexão: o arquivo applescript `hiper4.app` para plataforma OS X e o arquivo `hiper4.bat` para plataforma Windows.

Você só precisa fazer download do repositório pelo link <https://github.com/hiperorganicos/openlab-osc/archive/master.zip>, e após descompactar, acessar os diretórios `OscGroups/mac` ou `OscGroups/mac` para abrir esses scripts.

Ambos perguntam um login de usuário para conexão à rede. Após a reposta, a conexão é estabelecida e você já pode acessar a rede OSC no seu software (PureData, Processing, Max-MSP, etc).


## Conectividade via terminal

### 1. download do OscGroups

Todos os arquivos estão neste repositório no diretório OscGroups, mas vocês podem baixar pelos links:

- Windows e Mac: http://code.google.com/p/oscgroups/downloads/list
- Ubuntu: http://devolts.org/oscgroupslinux.tar.gz (compilados pelo glerm)

### 2. instalação

- Windows: descompactar arquivos
- Mac e Ubuntu: descompactar e copiar binarios para pasta **/usr/bin**

### 3. entrando na rede

Antes de abrir Puredata Processing etc, é preciso abrir o cliente do OscGroups e logar na rede

     OscGroupClient <serveraddress> <serverport> <localtoremoteport> <localtxport> <localrxport> <username> <password> <groupname> <grouppassword>

Vamos usa as portas padrão do OscGroups, de 22241 a 22244

##### Windows

Pelo prompt de comando, acesse o diretorio onde os binarios foram extraidos e abra o cliente com exatamente estes parametros (exceto username e password, que voces vao escolher)

    > cd Downloads
    > cd oscgroups
    > OscGroupClient 146.164.80.56 22242 22241 22243 22244 <username> <password> hiper4 nano
    
##### Mac e Ubuntu

Pelo terminal, abra o cliente com exatamente estes parametros (exceto username e password, que voces vao escolher)

    $ OscGroupClient 146.164.80.56 22242 22241 22243 22244 <username> <password> hiper4 nano
    
    
### 4. testando conectividade

A vantagem do OscGroups é o broadcast de dados: você envia mensagens pro seu próprio IP 127.0.0.1 na porta 22243,
e o servidor envia para todos os pontos conectados; assim como todas mensagens enviadas pelos outros pontos chegam pra você na porta 22244.

Na pasta PD deste repositório tem um patch de PD-extended para testarmos a conectividade.

### 5. modelo das mensagens OSC

Para facilitar o fluxo de dados, sugerimos o modelo **/user/interface** para as mensagens OSC,
enviando valores de **0.0** a **1.0**, algo como o exemplo abaixo:

    /guto/breathing       0.51
    /guto/ha              0.55
    /barbara/kinect_x     0.67
    /barbara/kinect_y     1.00
    /barbara/kinect_z     0.90
    ...
    /user/process         1.00
