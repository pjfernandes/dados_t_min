setwd("/home/pedro/Desktop/arquivos/analise_dados_uff/marcio")

df <- read.csv("dados.txt", sep="\t", h=T)

head(df)
###############################################################
sequence <- seq(2, ncol(df), by=2)

eventos_janeiro <- df[,sequence[1]] <= 20.7
eventos_fevereiro <- df[,sequence[2]] <= 20.9
eventos_marco <- df[,sequence[3]] <= 20.1
eventos_abril <- df[,sequence[4]] <= 18.7

#EXPORTANDO TABELA COM EVENTOS CLASSIFICADOS
df <- cbind(df, eventos_janeiro, eventos_fevereiro, eventos_marco, eventos_abril)
write.csv(df,"resultado.txt", row.names = F)

#EXPORTANDO TABELA COM CONTAGEM DE EVENTOS
soma_eventos_janeiro <- sum(df[,sequence[1]] <= 20.7, na.rm=T)
soma_eventos_fevereiro <- sum(df[,sequence[2]] <= 20.9, na.rm=T)
soma_eventos_marco <- sum(df[,sequence[3]] <= 20.1, na.rm=T)
soma_eventos_abril <- sum(df[,sequence[4]] <= 18.7, na.rm=T)

df_count <-   
  data.frame(
    soma_eventos_janeiro, 
    soma_eventos_fevereiro, 
    soma_eventos_marco, 
    soma_eventos_abril
  )

write.csv(df_count,"contagem_de_eventos.txt", row.names = F)

