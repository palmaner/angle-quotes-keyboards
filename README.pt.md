# Aspas angulares para Windows

[Español](README.es.md) · [English](README.md) · [Français](README.fr.md) · [Deutsch](README.de.md) · [Italiano](README.it.md) · [Português](README.pt.md) · [Norsk bokmål](README.nb.md) · [Dansk](README.da.md) · [Русский](README.ru.md) · [Українська](README.uk.md) · [Беларуская](README.be.md)

Criei estas 17 disposições nativas para escrever aspas angulares com AltGr, mantendo o teclado original sem AutoHotkey nem aplicações em segundo plano.

A coleção inclui **15 variantes originais e duas inglesas experimentais: Estados Unidos e Reino Unido**.

**[Transferir teclados](https://github.com/palmaner/angle-quotes-keyboards/releases/latest)** · [Comunicar um problema](https://github.com/palmaner/angle-quotes-keyboards/issues)

## Escolher a disposição

Escolha de acordo com o teclado habitual, não apenas com a nacionalidade. As ligações apresentam as instruções locais e todas as posições alteradas.

| Disposições e instruções | Abertura | Fecho |
| --- | --- | --- |
| [Espanhol (Espanha)](Spanish-Spain/README.txt), [Espanhol (América Latina)](Spanish-Latin-America/README.txt), [Italiano](Italian/README.txt), [Russo](Russian/README.txt), [Ucraniano](Ukrainian/README.txt), [Bielorrusso](Belarusian/README.txt), [Francês belga](Belgian-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| [Português (Portugal)](Portuguese-Portugal/README.txt), [Norueguês](Norwegian/README.txt) | AltGr+5 → « | AltGr+6 → » |
| [Alemão (Alemanha)](German-Germany/README.txt), [Alemão (Áustria)](German-Austria/README.txt), [Dinamarquês](Danish/README.txt) | AltGr+5 → » | AltGr+6 → « |
| [Francês suíço](Swiss-French/README.txt), [Alemão suíço](Swiss-German/README.txt), [Luxemburgo com francês suíço](Luxembourg-Swiss-French/README.txt) | AltGr+5 → « | AltGr+7 → » |
| **Experimental:** [Inglês (Estados Unidos)](English-United-States/README.txt), [Inglês (Reino Unido)](English-United-Kingdom/README.txt) | AltGr+5 → « | AltGr+7 → » |

As duas variantes inglesas servem para experimentar as aspas angulares, não para propor alterações à pontuação inglesa. Usam os teclados padrão dos EUA e do Reino Unido; Alt direito passa a funcionar como AltGr. Não são US-International nem UK Extended.

## Instalação

Windows 10/11 em PCs x86 ou x64; ARM64 não incluído. Não é necessária Internet nem a instalação do Keyboard Layout Creator.

1. Extraia todo o ZIP e abra a pasta do seu teclado. Mantenha os ficheiros juntos.
2. Abra **setup.exe** normalmente, sem **Executar como administrador**. A caixa **«Usar como teclado predefinido da minha conta»** é opcional: selecione-a para guardar a preferência entre sessões. Só a instalação pede permissões de administrador.
3. Prima **Win+Espaço** e selecione o nome terminado em **“- Angle Quotes”**.
4. Teste AltGr (Alt direito) e a fila superior dos números no Bloco de Notas.

**O instalador pode comportar-se de forma irregular: por vezes é necessário terminar a sessão e voltar a entrar para o teclado aparecer ou funcionar.**

Se setup.exe não iniciar, abra `_amd64.msi` para Windows de 64 bits ou `_i386.msi` para 32 bits. Os instaladores não estão assinados; o Windows pode mostrar um editor desconhecido. Abrir diretamente o MSI omite a caixa do teclado predefinido.

As novas instalações disponibilizam o teclado para todo o computador; a preferência predefinida aplica-se apenas à sua conta. Removê-lo pode afetar outras contas. Se a instalação antiga pertencer a outra conta, remova-a aí antes de reinstalar; abrir o novo instalador não a migra.

SmartScreen: o aviso «O Windows protegeu o seu PC», com «Editor desconhecido», foi observado ao executar setup.exe transferido do GitHub tanto na v0.1.0 como na v0.2.0. Os instaladores continuam sem assinatura digital. Se verificou a origem do ficheiro e decidir continuar, escolha «Mais informações» e depois «Executar mesmo assim», se o Windows disponibilizar essa opção. Não é necessário desativar o SmartScreen nem o Microsoft Defender.

## Alterações de caracteres

Em Espanha, Itália, Portugal, Noruega e Dinamarca, AltGr+5 substitui o euro; **€ continua em AltGr+E**. No francês belga, **[ continua disponível com AltGr e a tecla ^ junto a P**.

Nas variantes suíças, **§ passa para AltGr+8** e **a barra vertical para AltGr+1**. São substituídos ¢ e ¦, que atualmente não têm novos atalhos. Consulte primeiro as instruções locais.

As restantes combinações e os acentos verificados são preservados. Ctrl+Alt pode produzir os mesmos caracteres que AltGr.

## Voltar ao teclado anterior ou desinstalar

Para deixar de o usar como predefinido, reabra **setup.exe**, desmarque a caixa e clique em **«Aplicar»**. A preferência anterior é restaurada e o teclado continua instalado. Se o teclado anterior não estiver disponível, escolha outro. Para remover a disposição, clique em **«Desinstalar»** na mesma janela; a preferência anterior é restaurada primeiro, se necessário. Win+Espaço muda o teclado selecionado sem apagar esta preferência. A remoção direta pelas Aplicações do Windows ou pelo MSI não executa esta restauração.

## Prática de escrita

Incluí [textos de prática](practice/README.md) nos idiomas do projeto. As categorias indicam o tamanho de **cada parágrafo**, não do ficheiro nem da história: cerca de 10–25 palavras em short, 25–50 em medium e 80–120 em long. As linhas vazias separam parágrafos; a história pode continuar. Cole um ou vários no modo **custom** do Monkeytype. Cada ZIP individual inclui `practice/short.txt`, `practice/medium.txt`, `practice/long.txt` e um `practice.txt` combinado.

**Estes textos fictícios foram gerados com IA para praticar e podem conter erros.** Não são referências linguísticas nem normativas. Em inglês, as aspas angulares são usadas deliberadamente para testes.

## Testes e comentários

Experimentei cinco variantes originais no meu portátil e funcionam, por vezes após voltar a entrar na sessão. Não testei manualmente as 17, incluindo as duas inglesas experimentais. As verificações automáticas cobrem tabelas de caracteres, acentos e nomes em x86, x64 e WOW64.

Mantenho este projeto. Para comunicar uma falha, abra uma issue com a versão do Windows, teclado, atalho, resultado e se voltar a entrar na sessão ajudou.

v0.2.1: Testei com sucesso Spanish (Spain) numa conta nova: instalação, ativação/desativação do predefinido, persistência após terminar sessão ou reiniciar e desinstalação. Primeiro removi a instalação antiga por utilizador. Não testei manualmente as outras 16 disposições nem todas as configurações Windows; as traduções não receberam revisão linguística independente. A compilação final acrescenta a versão visível à lógica testada.

Criado com [Microsoft Keyboard Layout Creator 1.4](https://www.microsoft.com/en-us/download/details.aspx?id=102134). O meu código original e as minhas alterações usam a [licença MIT](LICENSE). Os componentes Microsoft mantêm as suas condições; consulte os [avisos de terceiros](THIRD_PARTY_NOTICES.md).

Para desenvolvimento (documentação em inglês): [compilar e verificar](docs/BUILD.md) / [comentários e contribuições](CONTRIBUTING.md).
