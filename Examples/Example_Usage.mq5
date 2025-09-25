//+------------------------------------------------------------------+
//|                                            Exemplo JAson Enhanced |
//|             Exemplo de uso das novas funções ToArrLong e ToArrStr |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025"
#property version   "1.00"
#property strict

#include "JAson.mqh"

//+------------------------------------------------------------------+
//| Script program start function                                    |
//+------------------------------------------------------------------+
void OnStart()
{
    // JSON de exemplo como o usuário mencionou
    string content = "{\"assinatura_ativa\":true,\"usuario_cadastrado\":true,\"nome_completo\":\"Gustavo de Souza Lima\",\"data_fim\":\"2025-12-24T00:00:00+00:00\",\"contas_liberadas\":[\"29950\",\"12345\",\"67890\"]}";

    CJAVal jv;
    if(!jv.Deserialize(content))
    {
        Print("Erro ao deserializar JSON");
        return;
    }

    Print("=== TESTE DAS NOVAS FUNCOES ===");

    // Verificar assinatura ativa (uso original)
    if(jv["assinatura_ativa"].ToBool() == false)
    {
        Print("Sem Assinatura Ativa");
        return;
    }
    else
    {
        Print("Assinatura Ativa: SIM");
    }

    // NOVA FUNCIONALIDADE: Converter contas_liberadas para array de inteiros
    long contas_int[];
    if(jv["contas_liberadas"].ToArrLong(contas_int))
    {
        Print("\n=== CONTAS COMO INTEIROS ===");
        for(int i=0; i<ArraySize(contas_int); i++)
        {
            Print("Conta ", i, ": ", contas_int[i]);
        }

        // Exemplo: verificar se uma conta específica está liberada
        long conta_procurada = 29950;
        bool encontrou = false;
        for(int i=0; i<ArraySize(contas_int); i++)
        {
            if(contas_int[i] == conta_procurada)
            {
                encontrou = true;
                Print("Conta ", conta_procurada, " encontrada na posição ", i);
                break;
            }
        }
        if(!encontrou)
            Print("Conta ", conta_procurada, " NÃO encontrada");
    }
    else
    {
        Print("Erro ao converter contas para array de inteiros");
    }

    // NOVA FUNCIONALIDADE: Converter contas_liberadas para array de strings
    string contas_str[];
    if(jv["contas_liberadas"].ToArrStr(contas_str))
    {
        Print("\n=== CONTAS COMO STRINGS ===");
        for(int i=0; i<ArraySize(contas_str); i++)
        {
            Print("Conta ", i, ": \"", contas_str[i], "\"");
        }
    }
    else
    {
        Print("Erro ao converter contas para array de strings");
    }

    // Outros campos (funcionalidades já existentes)
    Print("\n=== OUTROS CAMPOS ===");
    Print("Nome completo: ", jv["nome_completo"].ToStr());
    Print("Data fim: ", jv["data_fim"].ToStr());
    Print("Usuario cadastrado: ", jv["usuario_cadastrado"].ToBool() ? "SIM" : "NAO");

    // Exemplo adicional com array misto
    TestArrayMisto();
}

//+------------------------------------------------------------------+
//| Teste com array contendo diferentes tipos                         |
//+------------------------------------------------------------------+
void TestArrayMisto()
{
    Print("\n=== TESTE ARRAY MISTO ===");

    // JSON com array contendo números como strings e números puros
    string json_misto = "{\"valores\":[\"100\", 200, \"300\", 400]}";

    CJAVal jv_misto;
    if(jv_misto.Deserialize(json_misto))
    {
        long valores_int[];
        if(jv_misto["valores"].ToArrLong(valores_int))
        {
            Print("Array misto convertido para inteiros:");
            for(int i=0; i<ArraySize(valores_int); i++)
            {
                Print("Valor ", i, ": ", valores_int[i]);
            }
        }

        string valores_str[];
        if(jv_misto["valores"].ToArrStr(valores_str))
        {
            Print("Array misto convertido para strings:");
            for(int i=0; i<ArraySize(valores_str); i++)
            {
                Print("Valor ", i, ": \"", valores_str[i], "\"");
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Exemplo de validação de conta do usuário                         |
//+------------------------------------------------------------------+
bool ValidarContaUsuario(string json_response, long conta_usuario)
{
    CJAVal jv;
    if(!jv.Deserialize(json_response))
    {
        Print("Erro: JSON inválido");
        return false;
    }

    // Verificar se assinatura está ativa
    if(!jv["assinatura_ativa"].ToBool())
    {
        Print("Erro: Assinatura não está ativa");
        return false;
    }

    // Verificar se usuário está cadastrado
    if(!jv["usuario_cadastrado"].ToBool())
    {
        Print("Erro: Usuário não está cadastrado");
        return false;
    }

    // Verificar se a conta está liberada
    long contas_liberadas[];
    if(!jv["contas_liberadas"].ToArrLong(contas_liberadas))
    {
        Print("Erro: Não foi possível obter as contas liberadas");
        return false;
    }

    for(int i=0; i<ArraySize(contas_liberadas); i++)
    {
        if(contas_liberadas[i] == conta_usuario)
        {
            Print("Sucesso: Conta ", conta_usuario, " está liberada");
            return true;
        }
    }

    Print("Erro: Conta ", conta_usuario, " não está liberada");
    return false;
}