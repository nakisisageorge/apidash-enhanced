// Banking API Collections
library apidash_african_apis.collections.banking;

/// Standard Bank (South Africa, Africa regions)
const Map<String, dynamic> standardBankCollection = {
  'name': 'Standard Bank',
  'description': 'Standard Bank API collection - Corporate and retail banking across Africa',
  'baseUrl': 'https://api.standardbank.com',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Accounts', 'requests': ['list_accounts', 'get_account', 'get_balance', 'get_transactions']},
    {'name': 'Payments', 'requests': ['initiate_payment', 'bulk_payment', 'get_payment_status']},
    {'name': 'Beneficiaries', 'requests': ['list_beneficiaries', 'add_beneficiary', 'delete_beneficiary']},
    {'name': 'Forex', 'requests': ['get_rates', 'book_forex']},
  ],
  'requests': [
    {
      'id': 'sb_list_accounts',
      'name': 'List Accounts',
      'method': 'GET',
      'path': '/v1/accounts',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Accept': 'application/json',
      },
    },
    {
      'id': 'sb_initiate_payment',
      'name': 'Initiate Payment',
      'method': 'POST',
      'path': '/v1/payments',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'debtor_account': '123456789',
        'creditor_account': '987654321',
        'amount': 100000,
        'currency': 'ZAR',
        'reference': 'PAY123456',
      },
    },
  ],
};

/// ABSA (South Africa, Africa regions)
const Map<String, dynamic> absaCollection = {
  'name': 'ABSA',
  'description': 'ABSA Bank API collection - Digital banking services',
  'baseUrl': 'https://api.absa.co.za',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Accounts', 'requests': ['get_accounts', 'get_balance', 'get_statement']},
    {'name': 'Transfers', 'requests': ['internal_transfer', 'external_transfer', 'scheduled_transfer']},
    {'name': 'Cards', 'requests': ['get_cards', 'block_card', 'order_card']},
  ],
  'requests': [
    {
      'id': 'absa_get_accounts',
      'name': 'Get Accounts',
      'method': 'GET',
      'path': '/openbanking/v1/accounts',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'x-fapi-financial-id': 'absa',
      },
    },
  ],
};

/// FNB (South Africa)
const Map<String, dynamic> fnbCollection = {
  'name': 'FNB',
  'description': 'First National Bank API collection - South Africa retail and corporate banking',
  'baseUrl': 'https://api.fnb.co.za',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Accounts', 'requests': ['list_accounts', 'get_transactions']},
    {'name': 'Payments', 'requests': ['pay_beneficiary', 'pay_contacts', 'scheduled_payments']},
  ],
  'requests': [
    {
      'id': 'fnb_list_accounts',
      'name': 'List Accounts',
      'method': 'GET',
      'path': '/v1/accounts',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
      },
    },
  ],
};

/// Nedbank (South Africa, Africa regions)
const Map<String, dynamic> nedbankCollection = {
  'name': 'Nedbank',
  'description': 'Nedbank API collection - Digital banking and payment solutions',
  'baseUrl': 'https://api.nedbank.co.za',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Accounts', 'requests': ['get_accounts', 'get_balance']},
    {'name': 'Payments', 'requests': ['initiate_payment', 'bulk_payment']},
  ],
  'requests': [
    {
      'id': 'ned_get_accounts',
      'name': 'Get Accounts',
      'method': 'GET',
      'path': '/api/v1/accounts',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
      },
    },
  ],
};

/// Equity Bank (Kenya, Uganda, Tanzania, Rwanda, DRC)
const Map<String, dynamic> equityBankCollection = {
  'name': 'Equity Bank',
  'description': 'Equity Bank API collection - East Africa leading bank',
  'baseUrl': 'https://api.equitybankgroup.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Accounts', 'requests': ['get_accounts', 'get_balance']},
    {'name': 'Transfers', 'requests': ['internal_transfer', 'mobile_money_transfer', 'bank_transfer']},
  ],
  'requests': [
    {
      'id': 'eq_get_accounts',
      'name': 'Get Accounts',
      'method': 'GET',
      'path': '/v1/accounts',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
      },
    },
  ],
};

/// KCB (Kenya, Uganda, Tanzania, Rwanda, Burundi, South Sudan, DRC)
const Map<String, dynamic> kcbCollection = {
  'name': 'KCB Group',
  'description': 'Kenya Commercial Bank Group API collection - Largest bank in East Africa',
  'baseUrl': 'https://api.kcbgroup.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Accounts', 'requests': ['get_accounts', 'get_statement']},
    {'name': 'Payments', 'requests': ['mpesa_transfer', 'bank_transfer', 'card_payment']},
  ],
  'requests': [
    {
      'id': 'kcb_get_accounts',
      'name': 'Get Accounts',
      'method': 'GET',
      'path': '/v1/accounts',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
      },
    },
  ],
};

/// Co-operative Bank (Kenya)
const Map<String, dynamic> coopBankCollection = {
  'name': 'Co-operative Bank',
  'description': 'Co-operative Bank of Kenya API collection',
  'baseUrl': 'https://api.co-opbank.co.ke',
  'authType': 'api_key',
  'folders': [
    {'name': 'Accounts', 'requests': ['get_accounts', 'get_balance']},
    {'name': 'Mobile Banking', 'requests': ['mcoop_cash_transfer', 'bill_payment']},
  ],
  'requests': [
    {
      'id': 'coop_get_accounts',
      'name': 'Get Accounts',
      'method': 'GET',
      'path': '/v1/accounts',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
      },
    },
  ],
};

/// All banking collections
const Map<String, dynamic> bankingCollections = {
  'standard_bank': standardBankCollection,
  'absa': absaCollection,
  'fnb': fnbCollection,
  'nedbank': nedbankCollection,
  'equity_bank': equityBankCollection,
  'kcb_group': kcbCollection,
  'coop_bank': coopBankCollection,
};