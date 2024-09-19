# Carregando nossas Bibliotecas

# Divisão entre treinamento e teste
library(caTools)

# Criar a matriz de confusão e avaliar o modelo
library(caret)

# Curva Roc
library(pROC)


# Carregando nossa base de dados 
base <-  read.csv('credit_data.csv')

# Colocando nossa classe como fator para o modelo glm
base$default <- as.factor(base$default)

# Vizulizando nossa classe
str(base)



# # Apagando minha coluna ClientID, pois ela nao ira fazer diferença 
# na hora de ultilizarmos nossos algoritimos
base$clientid <- NULL

# Atualizando meus valores com a media das idades

base$age <-  ifelse(base$age < 0, 40.92, base$age)

# na.rm = TRUE-- >NAO TRAZ OS VALORES FALTANTES
base$age <-  ifelse(is.na(base$age), mean(base$age, na.rm = TRUE), base$age)



# scale --> padroniza um vetor/matriz subtraindo os valores de sua m?dia e
# dividindo pelo desvio padr?o.

base[, 1:3] <-  scale(base[, 1:3])

# Chamando o comando set.seed

# set.seed --> por??o da base de dados onde iremos fazer a divis?o ou seja
# mesmo resultado do professor
set.seed(1)

# Criando nossa variavel de divisão 

# 1500 --> para treinar
# 500 --> teste 

divisao <- sample.split(base$default, SplitRatio = 0.75)
divisao

# Criando minha base de treinamento

base_treinamento <-  subset(base, divisao == TRUE) # # 1500 --> para treinar

# Criando minha base de dados de teste
base_teste <-  subset(base, divisao == FALSE) # # 500 --> teste


# ULTILIZAÇÃO DA REGRASSAO

# Criando nosso classificador

# formula = default --> ira ser meu atributo classe 
# ~. --> ira pegar o restante das colunas que são os previsores "income,age e loan"
# family = binomial --> onde iremos trabalhar com regressão logistica 
#  data = base --> onde ira receber nossa base de dados de treinamento

classificador <- glm(formula = default ~., family = binomial, data = base_treinamento)

# Criando minha variavel de probabilidades para vermos os resultados

# type ='response' --> opção informa as probabilidades de saída do formulário 

probabilidades <- predict(classificador, type ='response', newdata = base_teste[-4])

# Criando minhas variavel de previsão para a melhor vizualização dos resultados 
# sem notação cientifica

previsoes <- ifelse(probabilidades > 0.5, 1, 0)

# Criando minha matriz de confusão para a comparação dos resultados
matriz_confusao <- table(base_teste[, 4], previsoes)
print(matriz_confusao)

# nossa biblioteca caret para verificar nossa acuracia
confusionMatrix(matriz_confusao)


# Criando nossa Validação Cruzada para o teste

# Controle
controle <- trainControl(method = "cv", number = 10)

# Treinando nosso modelo com a Validação Cruzada

modelo_cross <- train(default ~., data = base_treinamento, 
                     method = "glm", trControl = controle, family = binomial)


# Vizualizando meu modelo
print(modelo_cross)

# Vizualizando minhas variaveis importantes
varImp(modelo_cross)

# Criando minhas Probabilidades

probabilidades_modelo_cross <- predict(modelo_cross, type ='prob', newdata = base_teste[-4])
probabilidades_modelo_cross[,2]


# Convertendo as probabilidades em previsões (ajustando o limiar se necessário)

previsoes_modelo_cross <- ifelse(probabilidades_modelo_cross[,2] > 0.5, 1, 0)
previsoes_modelo_cross

# Criando minha matriz de confusão

matriz_confusao_modelo_cross <- table(base_teste[, 4], previsoes_modelo_cross)
matriz_confusao_modelo_cross

# Verirficando minha acurcia do modelo
confusionMatrix(matriz_confusao_modelo_cross)

# Gerando nossa Curva ROC
roc_obj <- roc(base_teste$default, probabilidades_modelo_cross[, 2])
plot(roc_obj)

# Coeficientes do modelo
summary(classificador)

