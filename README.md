# ecommerce-sql
Projeto acadêmico de banco de dados relacional — modelagem e consultas SQL para cenário de e-commerce.

# 🛍️ Projeto SQL - Sistema de E-commerce

Este repositório contém o script SQL completo de um **banco de dados para um sistema de e-commerce**, desenvolvido para fins acadêmicos e de aprendizado em modelagem e consultas SQL.

## 📋 Descrição do Projeto
O projeto representa um cenário de loja virtual, com gerenciamento de:
- **Clientes** (PF e PJ, exclusivos entre si)
- **Pedidos** e **formas de pagamento** (um pedido pode ter várias formas)
- **Entregas**, com status e código de rastreio
- **Produtos**, **fornecedores**, **estoques** e **vendedores**

O banco foi estruturado para permitir análises e consultas que respondem perguntas como:
- Quantos pedidos cada cliente realizou;
- Quais vendedores também são fornecedores;
- Relação de produtos, fornecedores e estoques;
- Relação de nomes de fornecedores e seus produtos.

## 🧱 Estrutura do Banco
O script inclui:
- Criação do banco e tabelas (`CREATE DATABASE`, `CREATE TABLE`);
- Inserção de dados de exemplo (`INSERT INTO`);
- Consultas SQL demonstrativas (`SELECT` com `JOIN`, `GROUP BY`, etc.).

## 🧩 Tecnologias Utilizadas
- **MySQL**
- **SQL padrão** (DDL, DML, DQL)
- Modelagem relacional (entidades, chaves, relacionamentos)

## ✨ Autor
Desenvolvido por **Alessandra Vedoy**  
📅 Projeto acadêmico — 2025
