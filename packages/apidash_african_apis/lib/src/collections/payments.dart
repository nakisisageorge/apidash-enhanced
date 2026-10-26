// Additional Payments API Collections
library apidash_african_apis.collections.payments;

/// MFS Africa (Pan-African mobile money interoperability)
const Map<String, dynamic> mfsAfricaCollection = {
  'name': 'MFS Africa',
  'description': 'MFS Africa API collection - Mobile money interoperability hub connecting 30+ African countries',
  'baseUrl': 'https://api.mfsafrica.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Transfers', 'requests': ['create_transfer', 'get_transfer_status', 'get_corridors']},
    {'name': 'Beneficiaries', 'requests': ['add_beneficiary', 'list_beneficiaries']},
    {'name': 'Wallets', 'requests': ['get_wallet_balance', 'get_wallet_transactions']},
  ],
  'requests': [
    {
      'id': 'mfs_create_transfer',
      'name': 'Create Cross-Border Transfer',
      'method': 'POST',
      'path': '/v1/transfers',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'source': {
          'country': 'KE',
          'currency': 'KES',
          'amount': 10000,
          'msisdn': '2547XXXXXXXX',
        },
        'destination': {
          'country': 'UG',
          'currency': 'UGX',
          'msisdn': '2567XXXXXXXX',
        },
        'reference': 'XFR123456',
      },
    },
  ],
};

/// Cellulant (Pan-African payments)
const Map<String, dynamic> cellulantCollection = {
  'name': 'Cellulant',
  'description': 'Cellulant API collection - Payments platform across Africa (Tingg, M-Pesa, MoMo, etc.)',
  'baseUrl': 'https://api.cellulant.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['initiate_payment', 'verify_payment', 'refund']},
    {'name': 'Collections', 'requests': ['collect_payment', 'get_collection_status']},
    {'name': 'Disbursements', 'requests': ['disburse_funds', 'get_disbursement_status']},
  ],
  'requests': [
    {
      'id': 'cell_initiate_payment',
      'name': 'Initiate Payment',
      'method': 'POST',
      'path': '/v1/payments',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 50000,
        'currency': 'NGN',
        'reference': 'PAY123456',
        'customer': {
          'email': 'customer@example.com',
          'phone': '080XXXXXXXX',
        },
      },
    },
  },
};

/// DPO Group (Pan-African payments)
const Map<String, dynamic> dpoGroupCollection = {
  'name': 'DPO Group',
  'description': 'DPO Group API collection - Payment gateway for Africa (30+ countries)',
  'baseUrl': 'https://api.dpopayments.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['create_payment', 'verify_payment', 'refund']},
    {'name': 'Subscriptions', 'requests': ['create_subscription', 'cancel_subscription']},
  ],
  'requests': [
    {
      'id': 'dpo_create_payment',
      'name': 'Create Payment',
      'method': 'POST',
      'path': '/v1/payments',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 10000,
        'currency': 'KES',
        'reference': 'PAY123456',
        'customer_email': 'customer@example.com',
        'redirect_url': 'https://yourdomain.com/return',
      },
    },
  ],
};

/// iPay Africa (Kenya, Uganda, Tanzania)
const Map<String, dynamic> ipayAfricaCollection = {
  'name': 'iPay Africa',
  'description': 'iPay Africa API collection - Payment gateway for East Africa',
  'baseUrl': 'https://api.ipayafrica.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['stk_push', 'verify_payment']},
    {'name': 'Refunds', 'requests': ['initiate_refund', 'get_refund_status']},
  ],
  'requests': [
    {
      'id': 'ipay_stk_push',
      'name': 'STK Push Payment',
      'method': 'POST',
      'path': '/v1/stk-push',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'phone': '2547XXXXXXXX',
        'amount': 1000,
        'reference': 'PAY123456',
        'callback_url': 'https://yourdomain.com/callback',
      },
    },
  ],
};

/// Jenga (Kenya, Uganda, Tanzania, Rwanda)
const Map<String, dynamic> jengaCollection = {
  'name': 'Jenga (Equity Bank API Platform)',
  'description': 'Jenga API collection - Equity Bank developer platform for fintech innovation',
  'baseUrl': 'https://api.jengahq.com',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Accounts', 'requests': ['get_accounts', 'get_balance', 'get_statement']},
    {'name': 'Transfers', 'requests': ['bank_transfer', 'mobile_money_transfer', 'card_transfer']},
    {'name': 'Payments', 'requests': ['bill_payment', 'airtime_purchase', 'merchant_payment']},
  ],
  'requests': [
    {
      'id': 'jenga_get_accounts',
      'name': 'Get Accounts',
      'method': 'GET',
      'path': '/v1/accounts',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
      },
    },
    {
      'id': 'jenga_mobile_money_transfer',
      'name': 'Mobile Money Transfer',
      'method': 'POST',
      'path': '/v1/transfers/mobile-money',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'source_account': 'ACC123456',
        'destination_phone': '2547XXXXXXXX',
        'amount': 5000,
        'currency': 'KES',
        'reference': 'XFR123456',
      },
    },
  ],
};

/// All payments collections
const Map<String, dynamic> paymentsCollections = {
  'mfs_africa': mfsAfricaCollection,
  'cellulant': cellulantCollection,
  'dpo_group': dpoGroupCollection,
  'ipay_africa': ipayAfricaCollection,
  'jenga': jengaCollection,
};