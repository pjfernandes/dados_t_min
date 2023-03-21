library("readxl")
library("tidyverse")
library("formattable")
library("openxlsx")

#####Lendo tabela
nome_arquivo <- "/home/uff/Downloads/DADOS - ESTAÇÃO CAMPOS DOS GOYTACAZES.xlsx"
df <- read_xlsx(nome_arquivo)

#####Pegando limiares da sheet de Média e transformando em um vetor
limiares_df <- read_xlsx(nome_arquivo, sheet="MÉDIA")
v <- as.vector(limiares_df[,16])[[1]][2:13]

#####Pegando os nomes das sheets
sheets <- excel_sheets(nome_arquivo)
year_sheets <- numeric()

for (i in 1:length(sheets)) {
  if(is.numeric(as.numeric(sheets[i]))) {
    year_sheets <- c(year_sheets, as.numeric(sheets[i]))
  }
}

year_sheets <- year_sheets[complete.cases(year_sheets)]

#####Eliminando cabeçalho
df_no_header <- df[8:nrow(df), ]
head(df_no_header)
tail(df_no_header)

####Vetor com as colunas referentes aos dados
colunas <- seq(2, 35, by=3)

# write dataset
wb <- createWorkbook()

for (i in 1:length(year_sheets)) {
  df <- read_xlsx(nome_arquivo, sheet=as.character(year_sheets[i]))
 
  df_no_header <- df[8:nrow(df), ]
  head(df_no_header)
  tail(df_no_header)
 
  addWorksheet(wb, sheetName=as.character(year_sheets[i]))
 
  for (j in 1:length(colunas)) {
    writeData(wb, sheet=as.character(year_sheets[i]), startCol = j, x = df_no_header[,colunas[j]])
    #y <- which(colnames(df_no_header[,colunas[j]]) == names(df_no_header[,colunas[j]])[1])
   
    x <- which(df_no_header[,colunas[j]] <= v[j])
   
    yellow_style <- createStyle(fgFill="#FFFF00")
    addStyle(wb, sheet=as.character(year_sheets[i]), style=yellow_style, rows=x+1, cols=j, gridExpand=TRUE)
  }
}

saveWorkbook(wb, "resultado.xlsx", overwrite=TRUE)

