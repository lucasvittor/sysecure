### SySecure.sh
#!/bin/bash

# SySecure - Sistema Inteligente de Segurança
# Autor: Lucas Vitor
# Versão: 1.0

source ./utils/report_functions.sh

LOG_DIR="./logs"
REPORT_DIR="./reports"
DATE_TAG=$(date '+%Y%m%d')
LOG_FILE="$LOG_DIR/audit-$DATE_TAG.log"
PDF_FILE="$REPORT_DIR/audit-$DATE_TAG.pdf"

mkdir -p "$LOG_DIR" "$REPORT_DIR"

banner() {
  echo "================================================="
  echo "         🛡️ SysSecure Audit v1.0                "
  echo "     Sistema Inteligente de Segurança           "
  echo "================================================="
}

banner | tee -a "$LOG_FILE"
echo "[INFO] Iniciando Sistema de segurança em $(hostname) às $(date)" | tee -a "$LOG_FILE"

log_section "🔍 Verificação de Atualizações do Sistema"
check_updates | tee -a "$LOG_FILE"

log_section "🔑 Análise de Senhas e Usuários"
check_passwords | tee -a "$LOG_FILE"
check_users | tee -a "$LOG_FILE"

log_section "🧱 Verificação do Firewall"
check_firewall | tee -a "$LOG_FILE"

log_section "🗂️ Permissões e Arquivos Suspeitos"
check_permissions | tee -a "$LOG_FILE"

log_section "📜 Histórico de Comandos dos Usuários"
check_history | tee -a "$LOG_FILE"

log_section "📡 Portas Abertas e Serviços Escutando"
check_ports | tee -a "$LOG_FILE"

log_section "📝 Gerando Relatório PDF..."
generate_pdf "$LOG_FILE" "$PDF_FILE"

log_section "✅ Sistema Finalizada"
echo "[INFO] Relatório salvo em: $PDF_FILE" | tee -a "$LOG_FILE"
echo "[INFO] Arquivo de log salvo em: $LOG_FILE" | tee -a "$LOG_FILE"
