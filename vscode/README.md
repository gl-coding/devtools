# ubuntuVscode

在 Ubuntu 服务器上配置 SSH，并通过 VSCode Remote SSH 进行远程开发的操作指南。

## 前置条件

- 一台可 SSH 访问的 Ubuntu/Debian 服务器
- 本地已安装 [Visual Studio Code](https://code.visualstudio.com/)
- 服务器能访问外网（首次连接需自动下载 `vscode-server`）

## 快速概览

| 步骤 | 位置 | 说明 |
|------|------|------|
| 1 | 服务器 | 安装并启动 SSH 服务 |
| 2 | 服务器 / 云控制台 | 放行 22 端口（防火墙 + 安全组） |
| 3 | 服务器 | 配置 root 登录权限 |
| 4 | 本地 | 编辑 `~/.ssh/config` |
| 5 | 本地 VSCode | 使用 Remote-SSH 连接 |

详细命令见仓库中的 [`vscode.sh`](./vscode.sh)。

---

## 一、服务器端：安装并启动 SSH

```bash
# 检查 SSH 服务状态
systemctl status sshd

# 若未安装 openssh-server（Ubuntu/Debian）
sudo apt update && sudo apt install openssh-server

# 设置开机自启并立即启动
sudo systemctl enable --now sshd

# 确认 SSH 正在监听 22 端口
ss -tlnp | grep ssh
```

看到 `:22` 表示 SSH 服务正常运行。

---

## 二、服务器端：网络与防火墙

云服务器除系统防火墙外，还需在控制台 **安全组** 中放行 SSH 端口（默认 `22`），否则外网无法连接。

---

## 三、服务器端：允许 root 登录

VSCode Remote SSH 通常使用 `root` 账户连接。腾讯云等云厂商默认禁止直接 SSH 登录 root，需先设置密码：

```bash
# 以普通用户登录后，切换到 root 并设置密码
sudo su -
passwd root

# 重启 SSH 服务
sudo systemctl restart sshd
```

若仍无法 root 登录，编辑 `/etc/ssh/sshd_config`，确认以下配置：

```
PermitRootLogin yes
```

修改后重启 SSH：

```bash
sudo systemctl restart sshd
```

---

## 四、本地：配置 SSH

在本地创建或编辑 `~/.ssh/config`，新增主机配置：

```
Host my-server              # 自定义主机名，连接时显示
  HostName 192.168.1.100    # 服务器公网 IP
  User root                 # 登录用户名
  Port 22                   # SSH 端口（非默认端口时修改）
```

示例（替换为你的实际 IP）：

```
Host 49.232.104.111
  HostName 49.232.104.111
  User root
```

---

## 五、VSCode 连接

1. 在 VSCode 扩展市场安装 **Remote - SSH**
2. 打开命令面板：`Ctrl+Shift+P`（macOS：`Cmd+Shift+P`）
3. 选择 `Remote-SSH: Connect to Host`
4. 选择配置好的主机名（如 `my-server`）
5. 首次连接时输入 root 密码；VSCode 会自动在服务器安装 `vscode-server`（耗时较长，属正常现象）
6. 连接成功后，左下角显示 `SSH: <主机名>`，即可远程编辑服务器文件

---

## 常见问题

**连接超时**

- 检查服务器 IP 是否正确
- 确认安全组已放行 SSH 端口
- 确认 SSH 服务正在运行：`systemctl status sshd`

**root 登录被拒绝**

- 确认已执行 `passwd root` 设置密码
- 检查 `/etc/ssh/sshd_config` 中 `PermitRootLogin` 是否为 `yes`
- 修改配置后需 `sudo systemctl restart sshd`

**vscode-server 安装失败**

- 确认服务器能访问外网
- 检查磁盘空间是否充足
- 可尝试删除 `~/.vscode-server` 后重新连接

---

## 文件说明

| 文件 | 说明 |
|------|------|
| `README.md` | 本说明文档 |
| `vscode.sh` | 分步骤命令速查脚本（含注释） |