# Previsao_de_Inadimplencia_de_Emprestimos_Regressao_Logistica

**Introdução:**

Este projeto tem como objetivo desenvolver um modelo de classificação para prever a probabilidade de inadimplência de clientes de crédito, utilizando a técnica de Regressão Logística, a base de dados são valores fictícios para fins de testes

**Metodologia:**

***Pré-processamento:** 

Os dados foram limpos e padronizados. Valores ausentes foram imputados pela média. A variável alvo "default" foi convertida para fator.

**Modelagem:** 

Um modelo de Regressão Logística foi treinado utilizando a função "glm" do R. A validação cruzada de 10 folds foi utilizada para avaliar o desempenho do modelo. A regularização L1 (Lasso) foi aplicada para evitar overfitting e selecionar as variáveis mais relevantes.

**Avaliação:** 

O modelo foi avaliado utilizando as seguintes métricas: acurácia, precisão, recall, F1-score e curva ROC. A curva ROC foi utilizada para visualizar o trade-off entre taxa de falsos positivos e taxa de verdadeiros positivos.

**Resultados:**

O modelo apresentou uma acurácia de 95% na previsão de inadimplência. A variável "renda" foi a mais importante para a classificação, seguida de "idade" e "histórico de crédito". A figura abaixo mostra a curva ROC do modelo e nossa Confusion Matrix :

**Confusion Matrix**

![image](https://github.com/user-attachments/assets/be705678-048a-415f-9851-24aa9a5933f6)

**Curva Roc**

![image](https://github.com/user-attachments/assets/86ef158e-6de6-4c64-9070-2979dca09e99)


**Limitações:**

* A base de dados pode apresentar viés de seleção, pois pode não ser representativa da população geral de clientes.
* A regressão logística assume uma relação linear entre o logit da probabilidade e as variáveis preditoras.
* O desbalanceamento de classes pode afetar a performance do modelo.

**Uso:**

Para utilizar o modelo, basta carregar a base de dados com as mesmas características da base de treinamento e aplicar o modelo treinado para obter as probabilidades de inadimplência.

**Requisitos:**

* R (versão 4.0 ou superior)
* Bibliotecas: caTools, caret, pROC, glm

**Autor:**
Matheus Andrade Moreira
