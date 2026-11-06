# Margem | Gestão de Precificação

Sistema estático com autenticação Supabase e salvamento em nuvem por usuário.

## Instalação

1. No Supabase, abra **SQL Editor** e execute o arquivo `supabase.sql`.
2. Em **Project Settings → API Keys**, copie somente a **publishable key** (ou a chave legada `anon`). Não use `service_role`, `secret` ou senhas.
3. No `config.js`, substitua `SUBSTITUA_PELA_CHAVE_PUBLICAVEL_OU_ANON` pela chave pública. A URL do projeto já foi preenchida.
4. Em **Authentication → Providers → Email**, configure acesso com e-mail e senha. Se a confirmação por e-mail estiver ligada, usuários precisam confirmar a conta.
5. Envie `index.html`, `config.js` e `supabase.sql` ao GitHub, na raiz do repositório. Configure Vercel como projeto **Other**, com diretório raiz `/` e sem build command. O `supabase.sql` não é necessário no deploy, mas pode permanecer versionado.
6. Em **Authentication → URL Configuration**, configure `Site URL` com o domínio publicado na Vercel.

## Notas importantes

- Os produtos ficam na tabela `public.user_workspaces`, em JSON por usuário. As políticas RLS restringem acesso ao proprietário autenticado.
- O sistema precisa de rede para carregar e salvar dados. Não edite os mesmos produtos em duas abas/dispositivos ao mesmo tempo: esta primeira versão usa sincronização do documento inteiro e a última gravação prevalece.
- O login usa autenticação Supabase; a chave pública pode estar no navegador. **Nunca** publique credenciais secretas.
- O sistema antigo usava `localStorage`; os dados antigos não são migrados automaticamente. Use **Exportar backup** na versão antiga e **Importar backup** na nova.
- Para evitar perda de dados, confirme o indicador **Salvo na nuvem** antes de fechar a página. Em caso de erro, clique no indicador para tentar novamente.
- O cálculo não inclui CAC e despesas que não foram preenchidas.
