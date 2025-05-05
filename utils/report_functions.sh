### utils/report_functions.sh
#!/bin/bash

log_section() {
  echo "" && echo "===== $1 =====" && echo ""
}

check_updates() {
  echo "[CHECK] Procurando atualizações pendentes..."
  if command -v apt &>/dev/null; then
    apt list --upgradable 2>/dev/null
  elif command -v dnf &>/dev/null; then
    dnf check-update
  elif command -v pacman &>/dev/null; then
    checkupdates
  else
    echo "[ERRO] Gerenciador de pacotes não suportado."
  fi
}

check_passwords() {
  echo "[CHECK] Verificando comprimento dos hashes de senha..."
  sudo awk -F: 'length($2) < 20 { print $1 " possui hash de senha curta ou ausente." }' /etc/shadow
}

check_users() {
  echo "[CHECK] Usuários com shell ativo (/bin/bash):"
  awk -F: '$7 ~ /bash/ { print $1 }' /etc/passwd
}

check_firewall() {
  echo "[CHECK] Status do firewall:"
  if command -v ufw &>/dev/null; then
    sudo ufw status verbose
  elif command -v iptables &>/dev/null; then
    sudo iptables -L
  else
    echo "[ERRO] Nenhum firewall detectado."
  fi
}

check_permissions() {
  echo "[CHECK] Arquivos com permissão 777 no sistema (apenas /home e /tmp):"
  find /home /tmp -type f -perm 0777 -exec ls -l {} \; 2>/dev/null
}

check_history() {
  echo "[CHECK] Últimos comandos usados pelos usuários:"
  for user in $(awk -F: '$7 ~ /bash/ { print $1 }' /etc/passwd); do
    history_file="/home/$user/.bash_history"
    [ -f "$history_file" ] && echo "\n$user:" && tail -n 5 "$history_file"
  done
}

check_ports() {
  echo "[CHECK] Serviços escutando em portas externas:"
  ss -tuln | grep -v "127.0.0.1" | grep -v "::1"
}

generate_pdf() {
  if command -v enscript &>/dev/null && command -v ps2pdf &>/dev/null; then
    enscript "$1" -o - | ps2pdf - "$2"
    echo "[INFO] Relatório PDF gerado com sucesso."
  else
    echo "[AVISO] Dependências para gerar PDF não encontradas. Instale 'enscript' e 'ps2pdf'."
  fi
}
