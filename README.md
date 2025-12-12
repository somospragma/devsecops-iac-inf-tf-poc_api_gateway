# Infrastructure as Code - API Gateway con OpenAPI

## 📋 Descripción General

Este proyecto implementa una infraestructura completa en AWS utilizando Terraform, con foco en la creación de un API Gateway REST configurado mediante OpenAPI (Swagger), integrado con un Network Load Balancer (NLB) y servicios ECS Fargate.

**Objetivo**: Optimizar la gestión de API Gateway, separando responsabilidades entre Infraestructura y Desarrollo, manteniendo el control con IaC en Terraform y flexibilidad para los equipos con OpenAPI y consola AWS.

## 🏗️ Arquitectura

La infraestructura implementa los siguientes componentes:

### Componentes Principales

1. **API Gateway REST (Regional)**
   - Configurado mediante especificación OpenAPI 2.0
   - Endpoint regional para mejor rendimiento
   - Integración con VPC Link para conectividad privada
   - Stage variables para configuración dinámica

2. **VPC Link**
   - Conexión segura entre API Gateway y recursos en VPC privada
   - Vinculado al Network Load Balancer

3. **Network Load Balancer (NLB)**
   - Balanceador de carga interno
   - Configurado en múltiples zonas de disponibilidad (us-east-2a, us-east-2b)
   - Cross-zone load balancing habilitado
   - Listener en puerto 5000

4. **Amazon ECS con Fargate**
   - Cluster ECS para contenedores sin servidor
   - Servicio ECS con imagen httpd:latest
   - Task Definition con 1024 CPU y 2048 MB de memoria
   - Desplegado en múltiples subnets para alta disponibilidad

5. **Networking**
   - VPC con CIDR 10.0.0.0/16
   - Subnets públicas en 2 zonas de disponibilidad:
     - us-east-2a: 10.0.0.0/24
     - us-east-2b: 10.0.1.0/24
   - Internet Gateway para conectividad externa
   - Route Tables configuradas para tráfico de Internet

6. **Security Groups**
   - Reglas de ingreso para puerto 80 (HTTP)
   - Reglas de ingreso para puerto 5000 (aplicación)

## 📂 Estructura del Proyecto

```
├── src/
│   ├── application/              # Configuración principal
│   │   ├── api-gateway.tf       # Definición de API Gateway y VPC Link
│   │   ├── backend.tf           # Configuración de backend (comentado)
│   │   ├── data.tf              # Data sources y templates
│   │   ├── ecs.tf               # Configuración de ECS Cluster y Services
│   │   ├── locals.tf            # Variables locales
│   │   ├── network.tf           # VPC, Subnets, Route Tables
│   │   ├── nlb.tf               # Network Load Balancer y Target Groups
│   │   ├── outputs.tf           # Outputs de Terraform
│   │   ├── providers.tf         # Configuración de providers
│   │   ├── security-group.tf    # Security Groups
│   │   ├── terraform.tfvars     # Valores de variables
│   │   ├── variables.tf         # Definición de variables
│   │   └── files/
│   │       └── api_gateway/
│   │           └── api-poc-manual-poc-swagger-apigateway.yaml
│   │
│   └── modules/                 # Módulos reutilizables
│       ├── containers/
│       │   ├── ecs/            # Módulo para ECS Cluster
│       │   └── ecs-services/   # Módulo para ECS Services y Tasks
│       ├── networking/
│       │   ├── api_gateway/    # Módulo de API Gateway
│       │   ├── vpc/            # Módulos de VPC (subnets, route tables, etc)
│       │   └── vpc_link/       # Módulo de VPC Link
│       └── security/
│           └── security_group/ # Módulo de Security Groups
```

## 🔧 Configuración de API Gateway con OpenAPI

### Especificación OpenAPI

El API Gateway está configurado mediante un archivo OpenAPI 2.0 (`api-poc-manual-poc-swagger-apigateway.yaml`) con las siguientes características:

#### Configuración General
- **Swagger Version**: 2.0
- **basePath**: Variable dinámica según el entorno (`${env}`)
- **Schemes**: HTTPS únicamente

#### Endpoints

##### GET /prueba
- **Integración**: VPC Link con HTTP proxy
- **Backend**: `http://${nlb_dns}:5000`
- **Connection Type**: VPC_LINK
- **Method**: GET
- **Response**: 200 OK

##### OPTIONS /prueba
- **Propósito**: Manejo de CORS
- **Type**: Mock integration
- **Headers CORS**:
  - Access-Control-Allow-Origin: '*'
  - Access-Control-Allow-Methods: 'DELETE,GET,HEAD,OPTIONS,PATCH,POST,PUT'
  - Access-Control-Allow-Headers: 'Content-Type,Authorization,X-Amz-Date,X-Api-Key,X-Amz-Security-Token'

### Stage Variables

El API Gateway utiliza variables de stage para configuración dinámica:

```hcl
variables = {
  title     = aws_api_gateway_rest_api.api_gateway_rest.name
  vpcLinkId = var.vpclink_id
  nlb_dns   = var.nlb_dns_name
}
```

Estas variables son referenciadas en el archivo OpenAPI usando la sintaxis:
- `$${stageVariables.title}`
- `$${stageVariables.vpcLinkId}`
- `$${stageVariables.nlb_dns}`

### Template File

El archivo OpenAPI es procesado como template para permitir la inyección de variables:

```hcl
data "template_file" "template_file_api_swagger_public" {
  template = file("files/api_gateway/api-poc-manual-poc-swagger-apigateway.yaml")
  vars = {
    env = "${var.env}"
  }
}
```

## 🚀 Variables de Configuración

### Variables Principales (terraform.tfvars)

```hcl
vpc_cidr_block                 = "10.0.0.0/16"
subnet_public_az_a_cidr_blocks = "10.0.0.0/24"
subnet_public_az_b_cidr_blocks = "10.0.1.0/24"
env                            = "dev"
project_name                   = "poc-ficohsa"
```

### Variables Requeridas

| Variable | Tipo | Descripción |
|----------|------|-------------|
| `vpc_cidr_block` | string | CIDR block para la VPC |
| `env` | string | Nombre del ambiente (dev, prod, etc.) |
| `project_name` | string | Nombre del proyecto |
| `subnet_public_az_a_cidr_blocks` | string | CIDR para subnet en AZ-A |
| `subnet_public_az_b_cidr_blocks` | string | CIDR para subnet en AZ-B |

## 📦 Módulos Terraform

### Módulo API Gateway

**Ubicación**: `src/modules/networking/api_gateway/`

**Recursos creados**:
- `aws_api_gateway_rest_api`: API REST principal
- `aws_api_gateway_deployment`: Deployment del API
- `aws_api_gateway_stage`: Stage con variables de configuración

**Inputs**:
- `api_gw_name`: Nombre del API Gateway
- `description`: Descripción del API
- `file_swagger`: Contenido del archivo OpenAPI
- `endpoint_type`: Tipo de endpoint (REGIONAL, EDGE, PRIVATE)
- `env`: Entorno
- `vpclink_id`: ID del VPC Link
- `nlb_dns_name`: DNS del Network Load Balancer
- `api_gw_stage_name`: Nombre del stage

### Módulo VPC Link

**Ubicación**: `src/modules/networking/vpc_link/`

**Recurso creado**:
- `aws_api_gateway_vpc_link`: Conexión VPC Link

**Inputs**:
- `vpc_link_name`: Nombre del VPC Link
- `description`: Descripción
- `target_arn_list`: Lista de ARNs de NLBs

### Módulo ECS Services

**Ubicación**: `src/modules/containers/ecs-services/`

**Recursos creados**:
- `aws_ecs_service`: Servicio ECS con Fargate
- `aws_ecs_task_definition`: Definición de tarea
- IAM Roles y policies
- CloudWatch Log Groups

**Configuración**:
- Launch Type: FARGATE
- CPU: 1024
- Memory: 2048 MB
- Container: httpd:latest en puerto 80

## 🔐 Seguridad

### Security Groups

El security group configurado permite:
- **Puerto 80**: Acceso HTTP desde cualquier origen (0.0.0.0/0)
- **Puerto 5000**: Acceso a la aplicación desde cualquier origen (0.0.0.0/0)

### IAM Roles

El módulo ECS Services crea roles IAM para:
- **Execution Role**: Permite a ECS descargar imágenes y escribir logs
- **Task Role**: Permisos para la aplicación en ejecución

## 🌐 Región y Provider

- **Región AWS**: us-east-2 (Ohio)
- **Provider**: AWS ~> 5.54.1
- **Zonas de Disponibilidad**: us-east-2a, us-east-2b

### Tags Predeterminados

```hcl
default_tags {
  Environment     = "poc"
  ServiceProvider = "Pragma"
  CreationType    = "Terraform"
}
```

## 📋 Prerequisitos

1. Terraform >= 1.0
2. AWS CLI configurado con credenciales válidas
3. Permisos IAM suficientes para crear recursos de:
   - VPC y Networking
   - API Gateway
   - ECS y Fargate
   - IAM Roles
   - CloudWatch

## 🚀 Despliegue

### 1. Inicializar Terraform

```bash
cd src/application
terraform init
```

### 2. Validar Configuración

```bash
terraform validate
```

### 3. Ver Plan de Ejecución

```bash
terraform plan
```

### 4. Aplicar Cambios

```bash
terraform apply
```

### 5. Destruir Infraestructura

```bash
terraform destroy
```

## 🔄 Flujo de Tráfico

```
Internet → API Gateway (HTTPS)
    ↓
VPC Link
    ↓
Network Load Balancer (interno)
    ↓
Target Group (puerto 5000)
    ↓
ECS Fargate Service (httpd en puerto 80)
```

## 📝 Notas Importantes

1. **Backend S3**: El backend de Terraform está comentado. Para entornos productivos, se recomienda descomentar y configurar:
   ```hcl
   backend "s3" {
     bucket         = "bucket-poc-tfstate"
     key            = "path/to/terraform.tfstate"
     region         = "us-east-2"
     dynamodb_table = "terraform-locks"
     encrypt        = true
   }
   ```

2. **DNS Personalizado**: Hay variables comentadas en el módulo API Gateway para configurar un dominio personalizado:
   - `domain_name`
   - `certificate_arn`

3. **Security Groups**: Las reglas actuales permiten acceso desde cualquier origen (0.0.0.0/0). Para producción, se recomienda restringir los rangos IP.

4. **NLB Interno**: El Network Load Balancer está configurado como interno (`internal = true`), lo que significa que solo es accesible desde dentro de la VPC a través del VPC Link.

5. **Deployment Automático**: El API Gateway se redespliega automáticamente cuando cambia el contenido del archivo OpenAPI mediante el uso de `sha1(jsonencode())` en los triggers.

## 🛠️ Mejoras Futuras Sugeridas

1. ✅ Implementar backend S3 para gestión de estado remoto
2. ✅ Configurar dominio personalizado con certificado ACM
3. ✅ Implementar WAF para protección adicional del API Gateway
4. ✅ Añadir autenticación (Cognito, IAM, Custom Authorizers)
5. ✅ Configurar CloudWatch Alarms para monitoreo
6. ✅ Implementar múltiples stages (dev, staging, prod)
7. ✅ Añadir throttling y quotas en API Gateway
8. ✅ Implementar CI/CD para despliegue automatizado
9. ✅ Configurar logs de acceso en API Gateway
10. ✅ Implementar secrets management con AWS Secrets Manager

## 📞 Soporte

**Service Provider**: Pragma  
**Proyecto**: POC Ficohsa  
**Ambiente**: Development (dev)

## 📄 Licencia

Este proyecto es un Proof of Concept (POC) desarrollado por Pragma.
