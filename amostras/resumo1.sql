/* extrai tabela de resumo de duas tabelas na base de dados
   para conversão para uma planilha dinâmica no Excel. */

COPY
(SELECT
    'Ambulatorial' AS MODAL_ATEND,
    SUBSTRING(MVM,1,4) AS ANO,
    SUBSTRING(MVM,5,2) AS MES,
    MVM AS CMPT,
    CODUNI AS CNES,
    CONCAT(TPFIN, SUBFIN) AS RUBRICA,
    SUM(QTDAPR) AS PRODUCAO,
    SUM(VALAPR) AS VALOR
  FROM
    PROD_AMB WHERE TPFIN = '04'
  GROUP BY
    MODAL_ATEND,
    ANO,
    MES,
    CMPT,
    CNES,
    RUBRICA

UNION ALL

SELECT
    'Hospitalar' AS MODAL_ATEND,
    ANO_CMPT AS ANO,
    MES_CMPT AS MES,
    CONCAT(ANO_CMPT,MES_CMPT) AS CMPT,
    CNES AS CNES,
    FAEC_TP AS RUBRICA,
    COUNT(*) AS PRODUCAO,
    SUM(VAL_TOT) AS VALOR
  FROM
    PROD_HOSP WHERE FINANC = '04'
  GROUP BY
    MODAL_ATEND,
    ANO,
    MES,
    CMPT,
	CNES,
    FAEC_TP,
    RUBRICA)
TO 'D:\bkp\TABWIN\prod_por_rubrica_e_estabelecimento.csv' WITH DELIMITER ';' CSV HEADER;
