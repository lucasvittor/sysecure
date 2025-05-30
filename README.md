# 🛡️ SySecure – Auditoria de Segurança para Estações Linux

**Status:** ✅ Em Desenvolvimento

O **SySecure** é um script automatizado escrito em **Shell Script (Bash)**, que realizar uma auditoria rápida, eficiente e clara em estações Linux. Ele oferece verificações críticas de segurança, geração de relatórios em texto e PDF, e é ideal tanto para uso pessoal quanto profissional.

---

## 🔧 Tecnologias Utilizadas

- **Bash Script** – Lógica principal do sistema
- **Comandos Linux** – `awk`, `grep`, `cut`, `ss`, `ufw`, `find`, `passwd`, etc.
- **Enscript + ps2pdf (opcional)** – Para gerar relatórios em PDF
- **Sistema de logs** – Registro detalhado da auditoria por data

---

## 📌 Funcionalidades Atuais

✔️ Verificação de atualizações pendentes  
✔️ Detecção de senhas fracas (análise do `/etc/shadow`)  
✔️ Status do firewall (`ufw` ou `iptables`)  
✔️ Busca por arquivos com permissões 777  
✔️ Listagem de usuários com shell ativo  
✔️ Verificação dos últimos comandos executados por usuários  
✔️ Detecção de serviços escutando em portas externas  
✔️ Geração de relatório `.log` e `.pdf` automaticamente

---

## 🚀 Como Usar

```bash
git clone https://github.com/lucasvittor/sysecure.git
cd sysecure
chmod +x sysecure.sh
sudo ./sysecure.sh
