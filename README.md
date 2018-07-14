# FPCC 1+2 - Reprodução de Experimento: Guia de Replicação

## Simulação de Processo de Consenso

Este repositório traz a reprodução de um experimento de simulação de consenso. O artigo que reporta o experimento original está disponível [aqui](https://dora.dmu.ac.uk/bitstream/handle/2086/7972/Distancias-Review.pdf?sequence=2). Trata-se da atividade final do curso de FPCC1+2(Fundamentos de Pesquisa em Ciência da Computação) da [pós-graduação em Ciência da Computação](http://www.computacao.ufcg.edu.br/pos-graduacao) da [UFCG](http://www.ufcg.edu.br).

## Organização

    `R`: código da biblioteca GDMR editada para esta reprodução

    `ASCSODSMOCIGDM`

        `data`: pasta com os dados resultantes da simulação.

        `R`: código específico para a simulação.

        `report`: notebook com as análises.

## Relatório

O relatório foi desenvolvido a partir de uma análise da reprodução que teve como intuito perseguir os objetivos expostos no experimento original. Aqui utilizei um método estatístico diferente do reportado pelo autor original, tal como descrito no relatório.

## Os dados

No script `ASCSODSMOCIGDM/R/simulator.R`, o métido `generate_sample` é usado para gerar o arquivo `ASCSODSMOCIGDM/data/data.crv` com os dados a serem analisados. O script `simulator.R` em si é a melhor documentação do que significa cada coluna em `ASCSODSMOCIGDM/data/data.crv`.

## Dependências

O relatório que descrevem esta foram compilado no seguinte ambiente:

- [Microsoft Windows 10](https://www.microsoft.com/pt-br/software-download/windows10)
- [R 3.5.0](https://www.r-project.org/)
- [RStudio Desktop 1.1.477](https://www.rstudio.com/products/rstudio/download/)

Na IDE do RStudio, instale os seguintes pacotes:

- `tidyverse`
- `lubridate`
- `here`
- `boot`
- `knitr`
- `gridExtra`
- `ggExtra`
- `gapminder`
- `ggalt`
- `ggplot2`
- `ggcorrplot`
- `broom`
- `modelr`

Além de algum compilador Tex. Aqui foi utilizado o MikTex.

## Guia para Replicação do Experimento

1. Configure o ambiente conforme descrito acima em "Dependências".
2. Clone este repositório. 
3. inicie a IDE RStudio.
4. Abra o projeto ".\GDMR.Rproj".
5. Digite em "Console": `devtools::install()`
6: Agora digite: `source('ASCSODSMOCIGDM/R/simulator.R')`
7. Então digite: `generate_sample()`
8. O resultado da simulaçãop estará em `ASCSODSMOCIGDM/data/data.csv`

*OBS: Caso prefira, em `ASCSODSMOCIGDM/data/data.csv` já eixste uma versão dos dados.

## Guia para Replicação da Análise

8. Abra o arquivo ".\ASCSODSMOCIGDM\report\peer.review.ref18.Rmd", ou sua versão resumida ".\ASCSODSMOCIGDM\report\peer.review.ref18-summarized.Rmd". Clique em "Knit" (canto superior esquerdo do editor). Dentre as opções apresentadas, selecione "knit to pdf".
9. O resultado será exibido e estará disponível em ".\ASCSODSMOCIGDM\report\peer.review.ref18.pdf" ou ".\ASCSODSMOCIGDM\report\peer.review.ref18-summarized.pdf".

*OBS: Caso prefira, os arquivos de saída (relatórios PDF) já possuem uma versão pronta para leitura e análise.
