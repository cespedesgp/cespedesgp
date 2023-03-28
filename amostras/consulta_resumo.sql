/*
   Para geração de tabela de resumo de produção do ano de 2022
   Verificar os casos de uso
*/

SET lc_numeric = 'pt_BR'; -- Apenas um ajuste mesmo que desnecessário em alguns casos.
COPY
(SELECT
  PROD.MODAL_ATEND,
  PROD.ANO,
  PROD.MES,
  PROD.CMPT,
  PROD.CO_GESTOR,
  PROD.CO_MUNICIPIO_ESTAB,
  TRIM(CONCAT(PROD.RUBRICA, ' ', d.ds_tpfin)) as RUBRICA,
  TRIM(CONCAT(PROD.CNES, ' ', b.fantasia)) AS ESTABELECIMENTO,
  TRIM(CONCAT(PROD.gr, ' ', e.no_grupo)) AS GRUPO,
  TRIM(CONCAT(PROD.sgr, ' ', f.no_sub_gru)) AS SUBGRUPO,
  TRIM(CONCAT(PROD.fo, ' ', h.no_forma)) AS FORMA_ORG,
  TRIM(CONCAT(PROD.PROCED, ' ', i.ds_regra)) AS PROCEDIMENTO,
  PROD.PRODUCAO,
  PROD.VALOR
FROM
(SELECT
  'Ambulatorial' AS MODAL_ATEND,
  SUBSTRING(MVM,1,4) AS ANO,
  SUBSTRING(MVM,5,2) AS MES,
  MVM AS CMPT,
  GESTAO AS CO_GESTOR,
  UFMUN AS CO_MUNICIPIO_ESTAB,
  CODUNI AS CNES,
  SUBSTRING(PROC_ID,1,2) AS GR,
  SUBSTRING(PROC_ID,1,4) AS SGR,
  SUBSTRING(PROC_ID,1,6) AS FO,
  PROC_ID AS PROCED,
  CONCAT(TPFIN, SUBFIN) AS RUBRICA,
  SUM(QTDAPR) AS PRODUCAO,
  REPLACE(SUM(VALAPR)::TEXT, '.', ',') AS VALOR    -- Somente para quando exportar para uso pelo MS Excel
--  SUM(VALAPR) AS VALOR                           -- Dependendo da situação utilizar este comando em substituição ao REPLACE imediatamente acima
--  TO_CHAR(SUM(QTDAPR), 'fm999G999') AS PRODUCAO, -- Utilizar quando este arquivo já é o produto final
--  TO_CHAR(SUM(VALAPR), 'fm999G999D99') AS VALOR  -- Utilizar quando este arquivo já é o produto final
FROM
  PROD_AMB
WHERE SUBSTRING(MVM,1,4)='2022' -- Remover/Modificar se necessário
GROUP BY
  MODAL_ATEND,
  ANO,
  MES,
  CMPT,
  CO_GESTOR,
  CO_MUNICIPIO_ESTAB,
  CNES,
  GR,
  SGR,
  FO,
  PROCED,
  RUBRICA

UNION ALL

SELECT
  'Hospitalar' AS MODAL_ATEND,
  ANO_CMPT AS ANO,
  MES_CMPT AS MES,
  CONCAT(ANO_CMPT,MES_CMPT) AS CMPT,
  UF_ZI AS CO_GESTOR,
  MUNIC_MOV AS CO_MUNICIPIO_ESTAB,
  CNES AS CNES,
  SUBSTRING(PROC_REA,1,2) AS GR,
  SUBSTRING(PROC_REA,1,4) AS SGR,
  SUBSTRING(PROC_REA,1,6) AS FO,
  PROC_REA AS PROCED,
  CASE
    WHEN FAEC_TP='' THEN CONCAT(FINANC,'0000')
    ELSE FAEC_TP END AS RUBRICA,
  COUNT(*) AS PRODUCAO,
  REPLACE(SUM(VAL_TOT)::TEXT, '.', ',') AS VALOR   -- Somente para quando exportar para uso pelo MS Excel
--  SUM(VAL_TOT) AS VALOR                          -- Dependendo da situação utilizar este comando em substituição ao REPLACE imediatamente acima
--  TO_CHAR(COUNT(*), 'fm999G999') AS PRODUCAO,    -- Utilizar quando este arquivo já é o produto final
--  TO_CHAR(SUM(VAL_TOT), 'fm999G999D99') AS VALOR -- Utilizar quando este arquivo já é o produto final
FROM
  PROD_HOSP
WHERE ANO_CMPT='2022' -- Remover/Modificar se necessário
GROUP BY
  MODAL_ATEND,
  ANO,
  MES,
  CMPT,
  CO_GESTOR,
  CO_MUNICIPIO_ESTAB,
  CNES,
  GR,
  SGR,
  FO,
  PROCED,
  FINANC,
  FAEC_TP,
  RUBRICA) AS PROD
LEFT JOIN CADGERAM b ON PROD.cnes=b.cnes
LEFT JOIN tp_finan d ON PROD.rubrica=d.co_tpfin
LEFT JOIN tb_grupo e ON PROD.GR=e.co_grupo
LEFT JOIN tb_subgr f ON PROD.sgr=f.co_sub_gru
LEFT JOIN tb_forma h ON PROD.fo=h.co_forma
LEFT JOIN tb_sigtap i ON PROD.proced=i.chave
ORDER BY
  MODAL_ATEND,
  ANO,
  MES,
  CMPT,
  CO_GESTOR,
  CO_MUNICIPIO_ESTAB,
  RUBRICA,
  ESTABELECIMENTO,
  GRUPO,
  SUBGRUPO,
  PROCED,
  FORMA_ORG,
  PROCEDIMENTO)
TO 'C:\bk\prod_SAMPLE.csv' WITH DELIMITER ';' CSV HEADER ENCODING 'WIN1252'
