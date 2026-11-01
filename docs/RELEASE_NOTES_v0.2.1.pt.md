# v0.2.1 — Desinstalação fiável entre contas Windows

[Español](RELEASE_NOTES_v0.2.1.es.md) · [English](RELEASE_NOTES_v0.2.1.md) · [Français](RELEASE_NOTES_v0.2.1.fr.md) · [Deutsch](RELEASE_NOTES_v0.2.1.de.md) · [Italiano](RELEASE_NOTES_v0.2.1.it.md) · [Português](RELEASE_NOTES_v0.2.1.pt.md) · [Norsk bokmål](RELEASE_NOTES_v0.2.1.nb.md) · [Dansk](RELEASE_NOTES_v0.2.1.da.md) · [Русский](RELEASE_NOTES_v0.2.1.ru.md) · [Українська](RELEASE_NOTES_v0.2.1.uk.md) · [Беларуская](RELEASE_NOTES_v0.2.1.be.md)

## Novo instalador

- Corrige o erro **1605** causado pela confusão entre um teclado registado no sistema e uma instalação MSI pertencente à conta atual.
- A desinstalação seleciona o produto realmente registado após verificar o MSI em cache, o nome e a DLL, sem presumir a identidade a partir do pacote transferido.
- As instalações existentes por utilizador removem-se na conta proprietária. As instalações do computador pedem autorização de administrador.
- As novas instalações ficam registadas para todo o computador; o teclado predefinido continua a ser uma preferência por conta.
- Produtos ausentes, ambíguos ou não verificáveis são comunicados antes de restaurar a preferência. Não se apagam manualmente ficheiros de teclado nem entradas do registo.
- A janela e os diálogos mostram **v0.2.1**. As propriedades do ficheiro indicam a mesma versão. Remover um teclado do sistema pode afetar outras contas.

## Fiabilidade e documentação

- As novas instalações MSI usam explicitamente `ALLUSERS=1`. As remoções por utilizador não relançam a operação como outro administrador.
- Os registos detalhados `/L*V` e os diagnósticos de produto e contexto ficam localmente em `%LOCALAPPDATA%\AngleQuotes\logs`. Não são enviados automaticamente e podem conter identificadores de conta e caminhos.
- A saída de sucesso `0` é verificada no inventário MSI antes da confirmação. Mantém-se a saída `3010`, que pede reinício. A versão tem uma única fonte.

## Compatibilidade e avisos

As DLL de teclado, pacotes MSI, atribuições de caracteres e textos de prática mantêm-se iguais aos da v0.2.0. Mantém-se o suporte de Windows 10/11 em x86/x64; ARM64 não está incluído. O Windows pode exigir terminar a sessão ou reiniciar antes de o teclado aparecer ou funcionar corretamente.

SmartScreen: o aviso «O Windows protegeu o seu PC», com «Editor desconhecido», foi observado ao executar setup.exe transferido do GitHub tanto na v0.1.0 como na v0.2.0. Os instaladores continuam sem assinatura digital. Se verificou a origem do ficheiro e decidir continuar, escolha «Mais informações» e depois «Executar mesmo assim», se o Windows disponibilizar essa opção. Não é necessário desativar o SmartScreen nem o Microsoft Defender.

## Validação

- Passam 26 verificações isoladas de identidade e contexto MSI e as 35 de preferências em Windows PowerShell 5.1 de 32 e 64 bits. As definições Windows e operações MSI são simuladas.
- 238 verificações de metadados, arquiteturas, nomes apresentados, recursos incorporados e versões abrangem as 17 disposições. As DLL e pacotes MSI não mudam.
- Auditam-se os hashes dos 18 ZIP, conteúdos das pastas, cópias de documentação, ligações locais e codificação. As verificações apenas para leitura testam a deteção MSI nativa e o arranque real.
- Testei com sucesso Spanish (Spain) numa conta nova: instalação, ativação/desativação do predefinido, persistência após terminar sessão ou reiniciar e desinstalação. Primeiro removi a instalação antiga por utilizador. Não testei manualmente as outras 16 disposições nem todas as configurações Windows; as traduções não receberam revisão linguística independente. A compilação final acrescenta a versão visível à lógica testada.

Se uma instalação antiga pertencer a outra conta, remova-a primeiro na conta original e depois instale esta versão na conta pretendida. Criar uma conta ou abrir o novo instalador não migra um registo MSI por utilizador existente. Completei esta migração com sucesso e depois repeti o teste completo numa conta nova.

## Transferências

Escolha `ANGLE_QUOTES_NATIVE_WINDOWS.zip` para todas as disposições ou o ZIP individual da sua. Extraia todo o ZIP e mantenha os ficheiros juntos. `SHA256SUMS.txt` contém os hashes SHA256 dos 18 ZIP disponíveis.

Os arquivos **Source code** ZIP/TAR.GZ do GitHub são gerados separadamente e não são os pacotes de instalação.
