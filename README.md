# JAson.mqh Enhanced - JSON Library for MQL5

## Improvements Implemented (Version 1.13)

This enhanced version of the JAson.mqh library adds two new essential functions for converting JSON arrays to native MQL5 arrays.

### 🆕 New Functions

#### `ToArrInt(long &arr[])`
Converts a JSON array to an MQL5 integer array (long).

**Parameters:**
- `arr[]` - Destination array to receive the converted values

**Return:**
- `true` - Conversion successful
- `false` - Conversion error (with message in the log)

**Example:**
```mql5
long conta_int[];

if(jv["contas_liberadas"].ToArrInt(contas_int))
{
for(int i=0; i<ArraySize(contas_int); i++)
{
Print("Conta ", i, ": ", contas_int[i]);
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
if(jv["released_accounts"].ToArrStr(accounts_str))
{
for(int i=0; i<ArraySize(accounts_str); i++)
{
Print("Account ", i, ": ", accounts_str[i]); }
}
```

### 📝 Practical Use Case

**Input JSON:**
```json
{
"active_subscription": true,
"registered_user": true,
"full_name": "Gustavo de Souza Lima Pereira",
"end_date": "2025-12-24T00:00:00+00:00",
"released_accounts": ["29950", "12345", "67890"]
}
```

**MQL5 Code:**
```mql5
CJAVal jv;
jv.Deserialize(content);

// Check active subscription
if(jv["active_subscription"].ToBool() == false)
{
Print("No Active Subscription");
return("No Active Subscription");
}

// Convert accounts to an array of integers
long accounts_int[];
if(jv["released_accounts"].ToArrInt(int_accounts))
{
// Check if a specific account is released
long user_account = 29950;
for(int i=0; i<ArraySize(int_accounts); i++)
{
if(int_accounts[i] == user_account)
{
Print("Released account found!");
break;
}
}
}
```

### ✨ Features of the New Functions

1. **Automatic Conversion**: Functions automatically convert between types (string → int, int → string)

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

### 📦 Included Files

1. **JAson_enhanced.mqh** - Enhanced core library
2. **Example_JAson_Enhanced.mq5** - Complete practical example
3. **README-JAson-Enhanced.md** - This documentation

### 🚀 How to Use

1. Replace your current JAson.mqh library with the enhanced version
2. Compile your projects normally
3. Use the new `ToArrInt()` and `ToArrStr()` functions when necessary

### ⚠️ Important Notes

- The functions modify arrays by reference (they do not return arrays)
- In case of error, the destination arrays may be partially filled
- Always check the return value before using the converted data
