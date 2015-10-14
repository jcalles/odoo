#Puppet module to install  odoo

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with odoo](#setup)
    * [What odoo affects](#what-odoo-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with odoo](#beginning-with-odoo)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Modulo puppet para la instalacion por defecto de odoo desde los repositorios de paquetes para Ubuntu y CentOS. Este modulo ha sido probado en Ubuntu 14.04 y CentOS7 en maquinas vagrant.

## Module Description

El modulo realiza lo siguiente: 
* Agrega los repositorios de paquetes en funcion de la variable "osfamily". 
* crea el usuario y rol en la base de datos PostgreSQL para posteriormente iniciar odoo
* Levanta el servicio odoo en la direccion IP local y el puerto por defecto 8069

## Setup
El modo de utilizar el modulo es el siguiente:
* Clonar o tener accesible el modulo con el nombre odoo [Odoo](https://github.com/jcalles/odoo "")
* Tener acceso a internet o a un repositorio de paquetes. 


### Beginning with odoo
Este modulo depende del modulo puppet Postgresql [Postgresql](https://forge.puppetlabs.com/puppetlabs/postgresql "") y de sus propias dependencias ( concat, stdlibs, etc)

## Usage

```bash
puppet apply --modulepath=/path/to/modules/ -e "include odoo"
```

## Reference

Here, list the classes, types, providers, facts, etc contained in your module.
##### Puppet Forge:
* Postgresql
* concat
* stdlibs
* version (defaults 8.0)

## Limitations

Por los momentos solo la version 8.0 ha sido probada en Ubuntu 14.04 y CentOS 7 

## Development

Versin BETA, se aceptan contribuciones 

## Release Notes
Version 0.1.0

jcalles@4geeks.com.ve
tecnologia@4geeks.co

Project URL: https://github.com/jcalles/odoo

SITE URL
[4geeks](http://www.4geeks.co/es/ "")
