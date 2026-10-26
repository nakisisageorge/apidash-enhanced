// FinTech API Collections
library apidash_african_apis.collections.fintech;

/// Flutterwave (Nigeria, Kenya, Ghana, South Africa, etc.)
const Map<String, dynamic> flutterwaveCollection = {
  'name': 'Flutterwave',
  'description': 'Flutterwave API collection - Payments, Transfers, Virtual Cards, Bill Payments across Africa',
  'baseUrl': 'https://api.flutterwave.com/v3',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['initialize_payment', 'verify_payment', 'refund_payment', 'get_payment_fee']},
    {'name': 'Transfers', 'requests': ['initiate_transfer', 'bulk_transfer', 'get_transfer_status', 'get_transfer_fee']},
    {'name': 'Virtual Cards', 'requests': ['create_virtual_card', 'fund_virtual_card', 'get_card_details', 'terminate_card']},
    {'name': 'Bill Payments', 'requests': ['get_billers', 'get_biller_items', 'pay_bill']},
    {'name': 'Subaccounts', 'requests': ['create_subaccount', 'list_subaccounts', 'fetch_subaccount']},
    {'name': 'Settlements', 'requests': ['get_settlements', 'get_settlement_details']},
    {'name': 'Webhooks', 'requests': ['create_webhook', 'list_webhooks', 'delete_webhook']},
  ],
  'requests': [
    {
      'id': 'fw_init_payment',
      'name': 'Initialize Payment',
      'method': 'POST',
      'path': '/payments',
      'headers': {
        'Authorization': 'Bearer {{secret_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'tx_ref': 'TXN123456',
        'amount': 10000,
        'currency': 'NGN',
        'redirect_url': 'https://yourdomain.com/callback',
        'customer': {
          'email': 'customer@example.com',
          'phonenumber': '080XXXXXXXX',
          'name': 'John Doe',
        },
        'customizations': {
          'title': 'My Store',
          'description': 'Payment for order #123',
          'logo': 'https://yourdomain.com/logo.png',
        },
      },
      'description': 'Initialize a payment on Flutterwave',
    },
    {
      'id': 'fw_verify_payment',
      'name': 'Verify Payment',
      'method': 'GET',
      'path': '/transactions/{{transaction_id}}/verify',
      'headers': {
        'Authorization': 'Bearer {{secret_key}}',
      },
      'description': 'Verify a payment transaction',
    },
    {
      'id': 'fw_initiate_transfer',
      'name': 'Initiate Transfer',
      'method': 'POST',
      'path': '/transfers',
      'headers': {
        'Authorization': 'Bearer {{secret_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'account_bank': '044',
        'account_number': '0123456789',
        'amount': 50000,
        'currency': 'NGN',
        'narration': 'Transfer to John Doe',
        'reference': 'TRF123456',
        'callback_url': 'https://yourdomain.com/transfer-callback',
      },
      'description': 'Initiate a bank transfer',
    },
  ],
};

/// Paystack (Nigeria, Ghana, South Africa, Kenya)
const Map<String, dynamic> paystackCollection = {
  'name': 'Paystack',
  'description': 'Paystack API collection - Payments, Subscriptions, Transfers, Virtual Terminal',
  'baseUrl': 'https://api.paystack.co',
  'authType': 'api_key',
  'folders': [
    {'name': 'Transactions', 'requests': ['initialize_transaction', 'verify_transaction', 'list_transactions', 'fetch_transaction']},
    {'name': 'Transfers', 'requests': ['initiate_transfer', 'verify_transfer', 'list_transfers']},
    {'name': 'Customers', 'requests': ['create_customer', 'list_customers', 'fetch_customer']},
    {'name': 'Subscriptions', 'requests': ['create_subscription', 'list_subscriptions', 'disable_subscription']},
    {'name': 'Plans', 'requests': ['create_plan', 'list_plans']},
    {'name': 'Virtual Accounts', 'requests': ['create_virtual_account', 'list_virtual_accounts']},
    {'name': 'Settlements', 'requests': ['list_settlements', 'fetch_settlement']},
    {'name': 'Webhooks', 'requests': ['create_webhook', 'list_webhooks']},
  ],
  'requests': [
    {
      'id': 'ps_init_transaction',
      'name': 'Initialize Transaction',
      'method': 'POST',
      'path': '/transaction/initialize',
      'headers': {
        'Authorization': 'Bearer {{secret_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'email': 'customer@example.com',
        'amount': 1000000,
        'reference': 'REF123456',
        'callback_url': 'https://yourdomain.com/callback',
        'metadata': {
          'order_id': 'ORD123',
          'customer_name': 'John Doe',
        },
      },
    },
    {
      'id': 'ps_verify_transaction',
      'name': 'Verify Transaction',
      'method': 'GET',
      'path': '/transaction/verify/{{reference}}',
      'headers': {
        'Authorization': 'Bearer {{secret_key}}',
      },
    },
  ],
};

/// Interswitch (Nigeria, Kenya, Uganda, Ghana)
const Map<String, dynamic> interswitchCollection = {
  'name': 'Interswitch',
  'description': 'Interswitch API collection - Payments, Transfers, Card Issuing, KYC',
  'baseUrl': 'https://sandbox.interswitchng.com',
  'authType': 'oauth2',
  'folders': [
    {'name': 'Payments', 'requests': ['initiate_payment', 'verify_payment']},
    {'name': 'Transfers', 'requests': ['initiate_transfer', 'get_transfer_status']},
    {'name': 'Cards', 'requests': ['issue_card', 'get_card_details']},
  ],
  'requests': [
    {
      'id': 'isw_init_payment',
      'name': 'Initiate Payment',
      'method': 'POST',
      'path': '/api/v2/transactions',
      'headers': {
        'Authorization': 'Bearer {{access_token}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 100000,
        'currency': 'NGN',
        'customer_id': 'CUST123',
        'reference': 'TXN123456',
      },
    },
  ],
};

/// Payfast (South Africa)
const Map<String, dynamic> payfastCollection = {
  'name': 'Payfast',
  'description': 'Payfast API collection - South Africa payment gateway',
  'baseUrl': 'https://api.payfast.co.za',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['process_payment', 'get_payment_status']},
    {'name': 'Subscriptions', 'requests': ['create_subscription', 'cancel_subscription']},
  ],
  'requests': [
    {
      'id': 'pf_process_payment',
      'name': 'Process Payment',
      'method': 'POST',
      'path': '/api/process',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'merchant_id': '{{merchant_id}}',
        'merchant_key': '{{merchant_key}}',
        'amount': 10000,
        'item_name': 'Product Name',
        'return_url': 'https://yourdomain.com/return',
        'cancel_url': 'https://yourdomain.com/cancel',
        'notify_url': 'https://yourdomain.com/notify',
      },
    },
  ],
};

/// Ozow (South Africa)
const Map<String, dynamic> ozowCollection = {
  'name': 'Ozow',
  'description': 'Ozow API collection - South Africa alternative payment method',
  'baseUrl': 'https://api.ozow.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['create_payment', 'get_payment_status']},
  ],
  'requests': [
    {
      'id': 'oz_create_payment',
      'name': 'Create Payment',
      'method': 'POST',
      'path': '/v1/payments',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 10000,
        'currency': 'ZAR',
        'reference': 'PAY123456',
        'customer_email': 'customer@example.com',
      },
    },
  ],
};

/// Yoco (South Africa)
const Map<String, dynamic> yocoCollection = {
  'name': 'Yoco',
  'description': 'Yoco API collection - South Africa card payments',
  'baseUrl': 'https://online.yoco.com/v1',
  'authType': 'api_key',
  'folders': [
    {'name': 'Charges', 'requests': ['create_charge', 'get_charge', 'refund_charge']},
    {'name': 'Customers', 'requests': ['create_customer', 'get_customer']},
  ],
  'requests': [
    {
      'id': 'yoco_create_charge',
      'name': 'Create Charge',
      'method': 'POST',
      'path': '/charges',
      'headers': {
        'Authorization': 'Bearer {{secret_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'token': 'tok_123456',
        'amount_in_cents': 100000,
        'currency': 'ZAR',
        'metadata': {
          'order_id': 'ORD123',
        },
      },
    },
  ],
};

/// Peach Payments (South Africa, Kenya, Mauritius)
const Map<String, dynamic> peachPaymentsCollection = {
  'name': 'Peach Payments',
  'description': 'Peach Payments API collection - Payment gateway for Africa',
  'baseUrl': 'https://api.peachpayments.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Payments', 'requests': ['create_checkout', 'get_payment_status']},
    {'name': 'Subscriptions', 'requests': ['create_subscription', 'cancel_subscription']},
  ],
  'requests': [
    {
      'id': 'pp_create_checkout',
      'name': 'Create Checkout',
      'method': 'POST',
      'path': '/checkouts',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'amount': 10000,
        'currency': 'ZAR',
        'reference': 'ORD123456',
        'success_url': 'https://yourdomain.com/success',
        'cancel_url': 'https://yourdomain.com/cancel',
        'webhook_url': 'https://yourdomain.com/webhook',
      },
    },
  ],
};

/// All fintech collections
const Map<String, dynamic> fintechCollections = {
  'flutterwave': flutterwaveCollection,
  'paystack': paystackCollection,
  'interswitch': interswitchCollection,
  'payfast': payfastCollection,
  'ozow': ozowCollection,
  'yoco': yocoCollection,
  'peach_payments': peachPaymentsCollection,
};