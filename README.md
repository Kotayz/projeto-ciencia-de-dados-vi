# Projeto Ciência de Dados VI

Execução de Script de Criação de instâncias:

```
sh criar-instancia.sh
```

## Criação de Perfis

### Basic
```
lxc profile create basic
```

### Standard
```
lxc profile create standard
```

### Premium
```
lxc profile create premium
```

## Configurar Perfis

### Basic
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
  limits.cpu: 2
  limits.memory: 1024MB
```

### Premium
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
  limits.cpu: 4
  limits.memory: 3072MB
```