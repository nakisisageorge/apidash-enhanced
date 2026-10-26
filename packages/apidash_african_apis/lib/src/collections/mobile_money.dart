// Mobile Money API Collections
library apidash_african_apis.collections.mobile_money;

/// M-Pesa (Kenya, Tanzania, Ghana, Mozambique, DRC, Lesotho)
const Map<String, dynamic> mPesaKenyaCollection = {
  'name': 'M-Pesa Kenya',
  'description': 'Safaricom M-Pesa API collection for Kenya - STK Push, B2C, B2B, C2B, Reversal, Query',
  'baseUrl': 'https://api.safaricom.co.ke',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Authentication', 'requests': ['get_access_token']},
    {'name': 'STK Push', 'requests': ['stk_push', 'stk_push_query']},
    {'name': 'B2C Payment', 'requests': ['b2c_payment', 'b2c_result']},
    {'name': 'B2B Payment', 'requests': ['b2b_payment']},
    {'name': 'C2B Registration', 'requests': ['c2b_register_url', 'c2b_confirmation', 'c2b_validation']},
    {'name': 'Transaction Status', 'requests': ['transaction_status_query']},
    {'name': 'Reversal', 'requests': ['reversal_request']},
    {'name': 'Account Balance', 'requests': ['account_balance']},
  ],
  'requests': [
    {
      'id': 'mkes_get_token',
      'name': 'Get Access Token',
      'method': 'GET',
      'path': '/oauth/v1/generate?grant_type=client_credentials',
      'headers': {
        'Authorization': 'Basic {{consumer_key}}:{{consumer_secret}}',
      },
      'description': 'Generate OAuth access token for M-Pesa API',
    },
    {
      'id': 'mkes_stk_push',
      'name': 'STK Push Payment',
      'method': 'POST',
      'path': '/mpesa/stkpush/v1/processrequest',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'BusinessShortCode': '174379',
        'Password': '{{base64_encoded_password}}',
        'Timestamp': '{{timestamp}}',
        'TransactionType': 'CustomerPayBillOnline',
        'Amount': 100,
        'PartyA': '2547XXXXXXXX',
        'PartyB': '174379',
        'PhoneNumber': '2547XXXXXXXX',
        'CallBackURL': 'https://yourdomain.com/callback',
        'AccountReference': 'TestPayment',
        'TransactionDesc': 'STK Push Test',
      },
      'description': 'Initiate M-Pesa STK Push payment (Customer initiates payment via phone)',
    },
    {
      'id': 'mkes_stk_query',
      'name': 'STK Push Query',
      'method': 'POST',
      'path': '/mpesa/stkpushquery/v1/query',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'BusinessShortCode': '174379',
        'Password': '{{base64_encoded_password}}',
        'Timestamp': '{{timestamp}}',
        'CheckoutRequestID': 'ws_CO_123456789',
      },
      'description': 'Query status of an STK Push transaction',
    },
    {
      'id': 'mkes_b2c',
      'name': 'B2C Payment',
      'method': 'POST',
      'path': '/mpesa/b2c/v1/paymentrequest',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'InitiatorName': 'testapi',
        'SecurityCredential': '{{security_credential}}',
        'CommandID': 'BusinessPayment',
        'Amount': 5000,
        'PartyA': '600000',
        'PartyB': '2547XXXXXXXX',
        'Remarks': 'Salary payment',
        'QueueTimeOutURL': 'https://yourdomain.com/timeout',
        'ResultURL': 'https://yourdomain.com/result',
        'Occasion': 'Monthly salary',
      },
      'description': 'Business to Customer payment (e.g., salary disbursement)',
    },
    {
      'id': 'mkes_b2b',
      'name': 'B2B Payment',
      'method': 'POST',
      'path': '/mpesa/b2b/v1/paymentrequest',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'Initiator': 'testapi',
        'SecurityCredential': '{{security_credential}}',
        'CommandID': 'BusinessPayBill',
        'SenderIdentifierType': '4',
        'RecieverIdentifierType': '4',
        'Amount': 10000,
        'PartyA': '600000',
        'PartyB': '800000',
        'AccountReference': 'Invoice-123',
        'Remarks': 'Supplier payment',
        'QueueTimeOutURL': 'https://yourdomain.com/timeout',
        'ResultURL': 'https://yourdomain.com/result',
      },
      'description': 'Business to Business payment (e.g., supplier payment)',
    },
    {
      'id': 'mkes_c2b_register',
      'name': 'Register C2B URLs',
      'method': 'POST',
      'path': '/mpesa/c2b/v1/registerurl',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'ShortCode': '600000',
        'ResponseType': 'Completed',
        'ConfirmationURL': 'https://yourdomain.com/confirmation',
        'ValidationURL': 'https://yourdomain.com/validation',
      },
      'description': 'Register confirmation and validation URLs for C2B',
    },
    {
      'id': 'mkes_query',
      'name': 'Transaction Status Query',
      'method': 'POST',
      'path': '/mpesa/transactionstatus/v1/query',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'Initiator': 'testapi',
        'SecurityCredential': '{{security_credential}}',
        'CommandID': 'TransactionStatusQuery',
        'TransactionID': 'LKXXXX1234',
        'PartyA': '600000',
        'IdentifierType': '4',
        'ResultURL': 'https://yourdomain.com/result',
        'QueueTimeOutURL': 'https://yourdomain.com/timeout',
        'Remarks': 'Status check',
        'Occasion': 'Status query',
      },
      'description': 'Query the status of any M-Pesa transaction',
    },
    {
      'id': 'mkes_reversal',
      'name': 'Reversal Request',
      'method': 'POST',
      'path': '/mpesa/reversal/v1/request',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'Initiator': 'testapi',
        'SecurityCredential': '{{security_credential}}',
        'CommandID': 'TransactionReversal',
        'TransactionID': 'LKXXXX1234',
        'Amount': 1000,
        'ReceiverParty': '600000',
        'RecieverIdentifierType': '4',
        'ResultURL': 'https://yourdomain.com/result',
        'QueueTimeOutURL': 'https://yourdomain.com/timeout',
        'Remarks': 'Wrong transaction',
        'Occasion': 'Reversal',
      },
      'description': 'Request reversal of a completed transaction',
    },
    {
      'id': 'mkes_balance',
      'name': 'Account Balance',
      'method': 'POST',
      'path': '/mpesa/accountbalance/v1/query',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'Initiator': 'testapi',
        'SecurityCredential': '{{security_credential}}',
        'CommandID': 'AccountBalance',
        'PartyA': '600000',
        'IdentifierType': '4',
        'Remarks': 'Balance check',
        'QueueTimeOutURL': 'https://yourdomain.com/timeout',
        'ResultURL': 'https://yourdomain.com/result',
      },
      'description': 'Query M-Pesa account balance',
    },
  ],
};

/// M-Pesa Tanzania
const Map<String, dynamic> mPesaTanzaniaCollection = {
  'name': 'M-Pesa Tanzania',
  'description': 'Vodacom M-Pesa API collection for Tanzania',
  'baseUrl': 'https://api.vodacom.co.tz',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Authentication', 'requests': ['get_access_token']},
    {'name': 'Payments', 'requests': ['m2m_payment', 'm2b_payment', 'b2c_payment']},
    {'name': 'Queries', 'requests': ['transaction_status', 'account_balance']},
  ],
  'requests': [
    {
      'id': 'mptz_get_token',
      'name': 'Get Access Token',
      'method': 'POST',
      'path': '/token',
      'headers': {
        'Authorization': 'Basic {{client_id}}:{{client_secret}}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      'body': {
        'grant_type': 'client_credentials',
      },
    },
    {
      'id': 'mptz_m2m',
      'name': 'M2M Payment (Customer to Merchant)',
      'method': 'POST',
      'path': '/m2m/v1/process',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': '1000',
        'msisdn': '2557XXXXXXXX',
        'trans_ref': 'TXN123456',
        'callback_url': 'https://yourdomain.com/callback',
      },
    },
  ],
};

/// MoMo (MTN Mobile Money - Uganda, Ghana, Rwanda, Zambia, etc.)
const Map<String, dynamic> momoCollection = {
  'name': 'MTN MoMo',
  'description': 'MTN Mobile Money API collection - Uganda, Ghana, Rwanda, Zambia, Cameroon, Ivory Coast, etc.',
  'baseUrl': 'https://proxy.momoapi.mtn.com',
  'authType': 'subscription',
  'folders': [
    {'name': 'Authentication', 'requests': ['create_api_user', 'get_api_key', 'get_access_token']},
    {'name': 'Collections', 'requests': ['request_to_pay', 'get_transaction_status', 'request_refund']},
    {'name': 'Disbursements', 'requests': ['transfer', 'get_transfer_status']},
    {'name': 'Remittances', 'requests': ['get_remittance_status']},
    {'name': 'KYC', 'requests': ['get_basic_user_info', 'get_kyc_info']},
  ],
  'requests': [
    {
      'id': 'momo_create_user',
      'name': 'Create API User',
      'method': 'POST',
      'path': '/v1_0/apiuser',
      'headers': {
        'X-Reference-Id': '{{uuid}}',
        'Content-Type': 'application/json',
        'Ocp-Apim-Subscription-Key': '{{subscription_key}}',
      },
      'body': {
        'providerCallbackHost': 'yourdomain.com',
      },
    },
    {
      'id': 'momo_get_apikey',
      'name': 'Get API Key',
      'method': 'POST',
      'path': '/v1_0/apiuser/{{api_user_id}}/apikey',
      'headers': {
        'Content-Type': 'application/json',
        'Ocp-Apim-Subscription-Key': '{{subscription_key}}',
      },
    },
    {
      'id': 'momo_get_token',
      'name': 'Get Access Token',
      'method': 'POST',
      'path': '/collection/token/',
      'headers': {
        'Authorization': 'Basic {{api_user_id}}:{{api_key}}',
        'Ocp-Apim-Subscription-Key': '{{subscription_key}}',
        'Content-Type': 'application/json',
      },
    },
    {
      'id': 'momo_request_to_pay',
      'name': 'Request to Pay',
      'method': 'POST',
      'path': '/collection/v1_0/requesttopay',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'X-Reference-Id': '{{uuid}}',
        'X-Target-Environment': 'sandbox',
        'Ocp-Apim-Subscription-Key': '{{subscription_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': '1000',
        'currency': 'UGX',
        'externalId': 'EXT123456',
        'payer': {
          'partyIdType': 'MSISDN',
          'partyId': '2567XXXXXXXX',
        },
        'payerMessage': 'Payment for order #123',
        'payeeNote': 'Order #123',
      },
    },
  ],
};

/// Airtel Money (Multiple African countries)
const Map<String, dynamic> airtelMoneyCollection = {
  'name': 'Airtel Money',
  'description': 'Airtel Money API collection - Kenya, Uganda, Tanzania, Nigeria, Zambia, Malawi, etc.',
  'baseUrl': 'https://openapi.airtel.africa',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Authentication', 'requests': ['get_access_token']},
    {'name': 'Payments', 'requests': ['ussd_push', 'merchant_payment']},
    {'name': 'Queries', 'requests': ['transaction_status', 'balance']},
  ],
  'requests': [
    {
      'id': 'amt_get_token',
      'name': 'Get Access Token',
      'method': 'POST',
      'path': '/auth/oauth2/token',
      'headers': {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      'body': {
        'grant_type': 'client_credentials',
        'client_id': '{{client_id}}',
        'client_secret': '{{client_secret}}',
      },
    },
    {
      'id': 'amt_ussd_push',
      'name': 'USSD Push Payment',
      'method': 'POST',
      'path': '/merchant/v1/payments/',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
        'X-Country': 'KE',
        'X-Currency': 'KES',
      },
      'body': {
        'reference': 'REF123456',
        'subscriber': {
          'country': 'KE',
          'currency': 'KES',
          'msisdn': '2547XXXXXXXX',
        },
        'transaction': {
          'amount': '100',
          'country': 'KE',
          'currency': 'KES',
          'id': 'TXN123456',
        },
      },
    },
  ],
};

/// Orange Money (Multiple African countries)
const Map<String, dynamic> orangeMoneyCollection = {
  'name': 'Orange Money',
  'description': 'Orange Money API collection - Senegal, Ivory Coast, Mali, Burkina Faso, etc.',
  'baseUrl': 'https://api.orange.com',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Authentication', 'requests': ['get_access_token']},
    {'name': 'Payments', 'requests': ['payment_request', 'payment_status']},
    {'name': 'Transfers', 'requests': ['transfer', 'transfer_status']},
  ],
  'requests': [
    {
      'id': 'om_get_token',
      'name': 'Get Access Token',
      'method': 'POST',
      'path': '/oauth/v3/token',
      'headers': {
        'Authorization': 'Basic {{client_id}}:{{client_secret}}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      'body': {
        'grant_type': 'client_credentials',
      },
    },
    {
      'id': 'om_payment_request',
      'name': 'Payment Request',
      'method': 'POST',
      'path': '/orange-money-webpay/dev/v1/webpayment',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'merchant_key': '{{merchant_key}}',
        'currency': 'XOF',
        'order_id': 'ORDER123',
        'amount': 5000,
        'return_url': 'https://yourdomain.com/return',
        'cancel_url': 'https://yourdomain.com/cancel',
        'notif_url': 'https://yourdomain.com/notify',
        'lang': 'fr',
      },
    },
  ],
};

/// Wave (Senegal, Ivory Coast)
const Map<String, dynamic> waveCollection = {
  'name': 'Wave',
  'description': 'Wave Mobile Money API collection - Senegal, Ivory Coast',
  'baseUrl': 'https://api.wave.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['create_invoice', 'get_invoice_status']},
    {'name': 'Transfers', 'requests': ['create_transfer', 'get_transfer_status']},
  ],
  'requests': [
    {
      'id': 'wave_create_invoice',
      'name': 'Create Invoice',
      'method': 'POST',
      'path': '/v1/invoices',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 100000,
        'currency': 'XOF',
        'description': 'Invoice for services',
        'external_id': 'INV123456',
        'payer': {
          'phone': '+2217XXXXXXXX',
        },
      },
    },
  ],
};

/// Chipper Cash (Cross-border)
const Map<String, dynamic> chipperCashCollection = {
  'name': 'Chipper Cash',
  'description': 'Chipper Cash API collection - Cross-border payments across Africa',
  'baseUrl': 'https://api.chippercash.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['create_payment', 'get_payment_status']},
    {'name': 'Transfers', 'requests': ['create_transfer', 'get_transfer_status']},
    {'name': 'Users', 'requests': ['get_user_profile']},
  ],
  'requests': [
    {
      'id': 'cc_create_payment',
      'name': 'Create Payment',
      'method': 'POST',
      'path': '/v1/payments',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 1000,
        'currency': 'USD',
        'reference': 'PAY123456',
        'customer': {
          'email': 'customer@example.com',
          'phone': '+2547XXXXXXXX',
        },
      },
    },
  ],
};

/// Paga (Nigeria)
const Map<String, dynamic> pagaCollection = {
  'name': 'Paga',
  'description': 'Paga API collection - Nigeria payment platform',
  'baseUrl': 'https://api.paga.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['money_transfer', 'bill_payment']},
    {'name': 'Account', 'requests': ['get_balance', 'get_transaction_history']},
  ],
  'requests': [
    {
      'id': 'paga_money_transfer',
      'name': 'Money Transfer',
      'method': 'POST',
      'path': '/v1/transactions/money_transfer',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 50000,
        'currency': 'NGN',
        'reference': 'TXN123456',
        'recipient': {
          'phone': '080XXXXXXXX',
        },
      },
    },
  ],
};

/// Opay (Nigeria)
const Map<String, dynamic> opayCollection = {
  'name': 'Opay',
  'description': 'Opay API collection - Nigeria fintech platform',
  'baseUrl': 'https://api.opay.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['initialize_payment', 'verify_payment']},
    {'name': 'Transfers', 'requests': ['bank_transfer', 'transfer_status']},
  ],
  'requests': [
    {
      'id': 'opay_init_payment',
      'name': 'Initialize Payment',
      'method': 'POST',
      'path': '/v1/payments/initialize',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 500000,
        'currency': 'NGN',
        'reference': 'PAY123456',
        'customer': {
          'name': 'John Doe',
          'email': 'john@example.com',
          'phone': '080XXXXXXXX',
        },
      },
    },
  ],
};

/// PalmPay (Nigeria, Ghana)
const Map<String, dynamic> palmpayCollection = {
  'name': 'PalmPay',
  'description': 'PalmPay API collection - Nigeria, Ghana fintech platform',
  'baseUrl': 'https://api.palmpay.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['create_order', 'query_order']},
  ],
  'requests': [
    {
      'id': 'pp_create_order',
      'name': 'Create Order',
      'method': 'POST',
      'path': '/v1/orders',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 10000,
        'currency': 'NGN',
        'order_id': 'ORDER123456',
        'product_name': 'Product Name',
      },
    },
  ],
};

/// All mobile money collections
const Map<String, dynamic> mobileMoneyCollections = {
  'm_pesa_kenya': mPesaKenyaCollection,
  'm_pesa_tanzania': mPesaTanzaniaCollection,
  'mtn_momo': momoCollection,
  'airtel_money': airtelMoneyCollection,
  'orange_money': orangeMoneyCollection,
  'wave': waveCollection,
  'chipper_cash': chipperCashCollection,
  'paga': pagaCollection,
  'opay': opayCollection,
  'palmpay': palmpayCollection,
};