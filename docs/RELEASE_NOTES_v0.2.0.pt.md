# v0.2.0 — Escolha do teclado predefinido

[Español](RELEASE_NOTES_v0.2.0.es.md) · [English](RELEASE_NOTES_v0.2.0.md) · [Français](RELEASE_NOTES_v0.2.0.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.0.de.md) · [Italiano](RELEASE_NOTES_v0.2.0.it.md) · [Português](RELEASE_NOTES_v0.2.0.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.0.nb.md) · [Dansk](RELEASE_NOTES_v0.2.0.da.md) · [Русский](RELEASE_NOTES_v0.2.0.ru.md) · [Українська](RELEASE_NOTES_v0.2.0.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.0.be.md)

## Novo instalador

- As 17 disposições incluem agora uma janela com a caixa opcional **Usar como teclado predefinido da minha conta**. Selecione-a e instale ou aplique a alteração para guardar a preferência de entrada predefinida do Windows.
- Volte a abrir `setup.exe`, desmarque a caixa e clique em **Aplicar** para restaurar a preferência anterior, mantendo o teclado instalado. Se o teclado anterior não estiver disponível, o instalador pede para escolher outro método de entrada disponível.
- A caixa reflete a preferência atual do Windows. Os outros idiomas e teclados são preservados; ativações repetidas não substituem o registo de recuperação original pela mesma disposição.
- **Desinstalar** restaura primeiro o predefinido anterior, se necessário, e depois remove a disposição. A remoção direta por MSI ou Aplicações do Windows omite esta etapa adicional.
- A interface segue o idioma do Windows: espanhol, inglês, francês, alemão, italiano, português, norueguês bokmål, dinamarquês, russo, ucraniano e bielorrusso, com inglês como alternativa.
- Abra `setup.exe` normalmente, sem **Executar como administrador**. Só as operações MSI pedem elevação; as preferências aplicam-se à conta que abriu o instalador. Não é instalada nenhuma aplicação em segundo plano nem tarefa agendada.

## Fiabilidade e documentação

- O instalador evita consultas desnecessárias de preferências no arranque. Se a consulta do predefinido do Windows gerar uma exceção genérica, consulta a preferência guardada apenas para leitura. Os erros de acesso e valores inválidos continuam a ser erros.
- Os erros de configuração mostram o comando e a localização no script e guardam um ficheiro de diagnóstico local em `%LOCALAPPDATA%\AngleQuotes\logs`. Os registos não são enviados automaticamente.
- As instruções de instalação, restauração e remoção foram atualizadas nos 11 idiomas dos README e nas pastas das 17 disposições. Incluem-se os códigos-fonte de compilação, as traduções e os testes isolados de preferências.

## Compatibilidade e avisos

As DLL de teclado, pacotes MSI, atribuições de caracteres e textos de prática mantêm-se iguais aos da v0.1.0. Mantém-se o suporte de Windows 10/11 em x86/x64; ARM64 não está incluído. O Windows pode exigir terminar a sessão ou reiniciar antes de o teclado aparecer ou funcionar corretamente.

SmartScreen: o aviso «O Windows protegeu o seu PC», com «Editor desconhecido», foi observado ao executar setup.exe transferido do GitHub tanto na v0.1.0 como na v0.2.0. Os instaladores continuam sem assinatura digital. Se verificou a origem do ficheiro e decidir continuar, escolha «Mais informações» e depois «Executar mesmo assim», se o Windows disponibilizar essa opção. Não é necessário desativar o SmartScreen nem o Microsoft Defender.

## Validação

- Passam 35 verificações isoladas de preferências em Windows PowerShell 5.1 de 32 e 64 bits, usando definições do Windows e entradas do registo simuladas.
- Passam 204 verificações de metadados de instaladores, arquiteturas, nomes apresentados e recursos incorporados. Os relatórios das tabelas abrangem as 17 disposições, com 11 016 comparações de caracteres em cada arquitetura x86, x64 e WOW64, além de verificações de teclas mortas.
- As auditorias verificam os hashes dos 18 ZIP, os conteúdos das pastas individuais, as cópias dos README, as ligações locais e a codificação. O arranque real do instalador foi também verificado apenas para leitura em PowerShell de 32 e 64 bits.
- Testei com sucesso a candidata corrigida **Spanish (Spain) - Angle Quotes** em Windows Home x64, versão 26H2, compilação 26300.9818. Os casos individuais não foram registados separadamente. Não está comprovada a cobertura manual das outras 16 disposições nem de todas as versões Windows suportadas. As novas traduções não receberam revisão linguística independente.

Também verifiquei a compatibilidade: com uma disposição v0.1.0 já instalada, o instalador v0.2.0 reconheceu a instalação existente e permitiu defini-la como teclado predefinido. Isto verifica esse caso no computador testado, sem comprovar uma desinstalação e reinstalação completas nem a cobertura de todas as disposições.

## Transferências

Escolha `ANGLE_QUOTES_NATIVE_WINDOWS.zip` para todas as disposições ou o ZIP individual da sua. Extraia todo o ZIP e mantenha os ficheiros juntos. `SHA256SUMS.txt` contém os hashes SHA256 dos 18 ZIP disponíveis.

Os arquivos **Source code** ZIP/TAR.GZ do GitHub são gerados separadamente e não são os pacotes de instalação.
