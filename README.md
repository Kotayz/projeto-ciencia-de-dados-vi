# Projeto Ciência de Dados VI

## Execução de Script de Criação de instâncias:

```
sh criar-instancia.sh
```

## Criação e Configuração de Perfis

### Basic
```
lxc profile create basic
```

```
lxc profile edit basic
```

Incluir as seguintes configurações:
```
config: 
  user.user-data: |
    #cloud-config
    runcmd:
      - 'mkdir /teste'
      - 'touch /teste/FUNCIONA.bat'
    package-upgrade: true
    packages:
      - xll-apps
      - mesa-utils
      - tmate
config:
  limits.cpu: 1
  limits.memory: 512MB
```

### Standard
```
lxc profile create standard
```

```
lxc profile edit standard
```

Incluir as seguintes configurações:
```
config: 
  user.user-data: |
    #cloud-config
    runcmd:
      - 'mkdir /teste'
      - 'touch /teste/FUNCIONA.bat'
    package-upgrade: true
    packages:
      - xll-apps
      - mesa-utils
      - tmate
config:
  limits.cpu: 2
  limits.memory: 1024MB
```

### Premium
```
lxc profile create premium
```

```
lxc profile edit premium
```

Incluir as seguintes configurações:
```
config: 
  user.user-data: |
    #cloud-config
    runcmd:
      - 'mkdir /teste'
      - 'touch /teste/FUNCIONA.bat'
    package-upgrade: true
    packages:
      - xll-apps
      - mesa-utils
      - tmate
config:
  limits.cpu: 4
  limits.memory: 3072MB
```

## Listar Instancias
```
lxc list -c ns,limits.memory:MEM,limits.cpu:CPU,mMuDc
```

## Parar Instancia
```
lxc stop <nome_da_instancia>
```

## Iniciar Instancia
```
lxc start <nome_da_instancia>
```

## Remover Instancia
```
lxc delete <nome_da_instancia>
```

## Exemplo de Execução

![](execucao-do-sistema.gif width="400" height="790")
