# Zabbix XenServer

![Zabbix](https://img.shields.io/badge/Zabbix-4.4-blue.svg)
![XenServer](https://img.shields.io/badge/XenServer-Supported-green.svg)

Template para monitoramento de XenServer via Zabbix. Este template permite o monitoramento de discos HBA, redes físicas e memória de todos os nós do cluster XenServer. O agente Zabbix deve ser instalado no servidor mestre do XenServer.

## 🚀 Instalação do Zabbix Agent no XenServer

### 1️⃣ Adicionar repositórios
Execute os comandos abaixo para adicionar os repositórios necessários:
```sh
mkdir ~/downloads/
cd ~/downloads
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
rpm -Uvh https://repo.zabbix.com/zabbix/3.2/rhel/7/x86_64/zabbix-release-3.2-1.el7.noarch.rpm
```

### 2️⃣ Desabilitar novos repositórios
Para manter a compatibilidade com o XenServer, desative os repositórios recém-adicionados com os seguintes comandos:
```sh
sed -i -e "s/enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo
sed -i -e "s/enabled=1/enabled=0/" /etc/yum.repos.d/remi.repo
sed -i -e "s/enabled=1/enabled=0/" /etc/yum.repos.d/remi-safe.repo
sed -i -e "s/enabled=1/enabled=0/" /etc/yum.repos.d/zabbix.repo
```

### 3️⃣ Atualizar repositórios instalados
```sh
yum --enablerepo=epel --enablerepo=remi --enablerepo=base --enablerepo=zabbix makecache
```

### 4️⃣ Instalar o Zabbix Agent
```sh
yum --enablerepo=epel --enablerepo=remi --enablerepo=base --enablerepo=zabbix install zabbix-agent
```

### 5️⃣ Configurar firewall
Adicione a seguinte linha ao arquivo **/etc/sysconfig/iptables** para permitir a comunicação do agente Zabbix:
```
-A RH-Firewall-1-INPUT -p tcp --dport 10050 -j ACCEPT
```

### 6️⃣ Habilitar serviços
```sh
systemctl enable zabbix-agent
systemctl restart iptables
systemctl start zabbix-agent
```

---

## ⚙️ Configuração do Template

1. **Criar usuário no XenServer**
   - O usuário deve ter a permissão de **somente leitura** (testado com usuário do Active Directory).

2. **Copiar arquivos de configuração**
   - Copie a pasta `xenserver/` e o arquivo `userparameter_xenserver.conf` para dentro de **/etc/zabbix/zabbix_agentd.conf.d/**

3. **Configurar credenciais**
   - Edite o arquivo `zabbix_agentd.d/xenserver/xen_passwd` e adicione as credenciais do XenServer.

4. **Importar template no Zabbix**
   - No servidor Zabbix, importe o arquivo **xenserver_template.xml**.
   - Testado no Zabbix **4.4**.

---

## 📜 Licença
Este projeto é distribuído sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🤝 Contribuições
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

---

### 📌 Notas
- O template foi testado e validado para ambientes XenServer.
- Certifique-se de que as permissões e firewall estejam corretamente configurados para evitar problemas de comunicação.

📩 **Dúvidas ou sugestões?** Entre em contato ou abra uma issue no repositório!

---

🔥 **Feito com ❤️ para administradores de sistemas!**

