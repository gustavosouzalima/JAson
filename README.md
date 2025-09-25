# JAson.mqh Enhanced - JSON Library for MQL5

## Improvements Implemented (Version 1.13)

This enhanced version of the JAson.mqh library adds two new essential functions for converting JSON arrays to native MQL5 arrays.

### 🆕 New Functions

#### `ToArrLong(long &arr[])`
Converts a JSON array to an MQL5 long array.

**Parameters:**
- `arr[]` - Destination array to receive the converted values

**Return:**
- `true` - Conversion successful
- `false` - Conversion error (with message in the log)

**Example:**
```mql5
long contas_long[];
if(jv["contas_liberadas"].ToArrLong(contas_long))
{
    for(int i=0; i<ArraySize(contas_long); i++)
    {
        Print("Conta ", i, ": ", contas_long[i]);
    }
}
```

#### `ToArrStr(string &arr[])`
Converts a JSON array to an MQL5 string array.

**Parameters:**
- `arr[]` - Destination array to receive the converted values

**Return:**
- `true` - Conversion successful
- `false` - Conversion error (with message in the log)

**Example:**
```mql5
string contas_str[];
if(jv["contas_liberadas"].ToArrStr(contas_str))
{
    for(int i=0; i<ArraySize(contas_str); i++)
    {
        Print("Conta ", i, ": ", contas_str[i]);
    }
}
```

### 📝 Practical Use Case

**Input JSON:**
```json
{
    "assinatura_ativa": true,
    "usuario_cadastrado": true,
    "nome_completo": "Gustavo de Souza Lima Pereira",
    "data_fim": "2025-12-24T00:00:00+00:00",
    "contas_liberadas": ["29950", "12345", "67890"]
}
```

**MQL5 Code:**
```mql5
CJAVal jv;
jv.Deserialize(content);

// Check active subscription
if(jv["assinatura_ativa"].ToBool() == false)
{
    Print("Sem Assinatura Ativa");
    return("Sem Assinatura Ativa");
}

// Convert accounts to long array
long contas_long[];
if(jv["contas_liberadas"].ToArrLong(contas_long))
{
    // Check if specific account is released
    long conta_usuario = 29950;
    for(int i=0; i<ArraySize(contas_long); i++)
    {
        if(contas_long[i] == conta_usuario)
        {
            Print("Conta liberada encontrada!");
            break;
        }
    }
}
```

### ✨ Features of the New Functions

1. **Automatic Conversion**: Functions automatically convert between types (string → long, number → long)

2. **Error Handling**: Full validation with descriptive messages

3. **Compatibility**: Maintains full compatibility with existing code

4. **Performance**: Optimized operations for large arrays

5. **Flexibility**: Works with mixed arrays (numeric strings + numbers)

### 🛡️ Error Validation

The functions include robust validation:

- Checks if the JSON type is actually an array
- Validates the resizing of the target arrays
- Provides clear error messages in the log
- Returns false on failure

### 📦 Files Structure

```
JAson-Enhanced/
├── JAson.mqh              # Enhanced core library
├── Examples/
│   └── Example_Usage.mq5  # Complete practical example
└── README.md              # This documentation
```

### 🚀 How to Use

1. **Download** the enhanced JAson.mqh file
2. **Replace** your current JAson.mqh library 
3. **Compile** your projects normally (no breaking changes)
4. **Use** the new functions when needed:
   - `ToArrLong()` for numeric arrays
   - `ToArrStr()` for string arrays

### 💡 Migration Guide

**Before (not possible):**
```mql5
// No direct way to convert JSON arrays
```

**After (enhanced):**
```mql5
long numbers[];
string texts[];

// Convert JSON array to long array
jv["numbers"].ToArrLong(numbers);

// Convert JSON array to string array  
jv["texts"].ToArrStr(texts);
```

### 🔄 Compatibility

- ✅ **100% backward compatible** with existing code
- ✅ All original functions work unchanged
- ✅ Same deserialization syntax
- ✅ Same data access patterns
- ✅ Works with MQL5 Build 1000+

### 📋 API Reference

#### Original Functions (unchanged)
```mql5
long ToInt()        // Get long value
double ToDbl()      // Get double value  
bool ToBool()       // Get boolean value
string ToStr()      // Get string value
```

#### New Array Functions
```mql5
bool ToArrLong(long &arr[])     // Convert to long array
bool ToArrStr(string &arr[])    // Convert to string array
```

### ⚠️ Important Notes

- Functions modify arrays **by reference** (do not return arrays)
- In case of error, destination arrays may be **partially filled**
- Always **check return value** before using converted data
- JSON strings like `"123"` are automatically converted to `long` values

### 🤝 Contributing

This is an enhanced version of the original JAson.mqh library. Contributions and improvements are welcome!

### 📄 License

This software is licensed under the MIT License - see the original library for details.

### 🔗 Links

- **Original Library**: JAson.mqh (community library)
- **Enhanced Version**: This repository
- **Documentation**: This README
- **Issues**: GitHub Issues tab

---

**Made with ❤️ for the MQL5 community**