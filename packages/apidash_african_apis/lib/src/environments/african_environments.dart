// African Environments
library apidash_african_apis.environments.african_environments;

/// Pre-configured environments for African APIs
const Map<String, dynamic> africanEnvironments = {
  'm_pesa_kenya_sandbox': {
    'name': 'M-Pesa Kenya Sandbox',
    'description': 'Safaricom M-Pesa sandbox environment for testing',
    'baseUrl': 'https://sandbox.safaricom.co.ke',
    'variables': {
      'base_url': 'https://sandbox.safaricom.co.ke',
      'consumer_key': '{{safaricom_consumer_key}}',
      'consumer_secret': '{{safaricom_consumer_secret}}',
      'shortcode': '174379',
      'passkey': '{{safaricom_passkey}}',
      'initiator_name': 'testapi',
      'security_credential': '{{safaricom_security_credential}}',
    },
  },
  'm_pesa_tanzania_sandbox': {
    'name': 'M-Pesa Tanzania Sandbox',
    'description': 'Vodacom M-Pesa Tanzania sandbox environment',
    'baseUrl': 'https://sandbox.vodacom.co.tz',
    'variables': {
      'base_url': 'https://sandbox.vodacom.co.tz',
      'client_id': '{{vodacom_client_id}}',
      'client_secret': '{{vodacom_client_secret}}',
    },
  },
  'mtn_momo_sandbox': {
    'name': 'MTN MoMo Sandbox',
    'description': 'MTN Mobile Money sandbox (Uganda, Ghana, Rwanda, etc.)',
    'baseUrl': 'https://sandbox.momodeveloper.mtn.com',
    'variables': {
      'base_url': 'https://sandbox.momodeveloper.mtn.com',
      'subscription_key': '{{mtn_subscription_key}}',
      'api_user_id': '{{mtn_api_user_id}}',
      'api_key': '{{mtn_api_key}}',
      'target_environment': 'sandbox',
    },
  },
  'airtel_money_sandbox': {
    'name': 'Airtel Money Sandbox',
    'description': 'Airtel Money sandbox environment',
    'baseUrl': 'https://openapi.airtel.africa',
    'variables': {
      'base_url': 'https://openapi.airtel.africa',
      'client_id': '{{airtel_client_id}}',
      'client_secret': '{{airtel_client_secret}}',
      'country': 'KE',
      'currency': 'KES',
    },
  },
  'orange_money_sandbox': {
    'name': 'Orange Money Sandbox',
    'description': 'Orange Money sandbox environment',
    'baseUrl': 'https://api.orange.com',
    'variables': {
      'base_url': 'https://api.orange.com',
      'client_id': '{{orange_client_id}}',
      'client_secret': '{{orange_client_secret}}',
      'merchant_key': '{{orange_merchant_key}}',
    },
  },
  'wave_sandbox': {
    'name': 'Wave Sandbox',
    'description': 'Wave sandbox environment (Senegal, Ivory Coast)',
    'baseUrl': 'https://api.sandbox.wave.com',
    'variables': {
      'base_url': 'https://api.sandbox.wave.com',
      'api_key': '{{wave_api_key}}',
    },
  },
  'chipper_cash_sandbox': {
    'name': 'Chipper Cash Sandbox',
    'description': 'Chipper Cash sandbox environment',
    'baseUrl': 'https://api.sandbox.chippercash.com',
    'variables': {
      'base_url': 'https://api.sandbox.chippercash.com',
      'api_key': '{{chipper_api_key}}',
    },
  },
  'paga_sandbox': {
    'name': 'Paga Sandbox',
    'description': 'Paga sandbox environment (Nigeria)',
    'baseUrl': 'https://sandbox.mypaga.com',
    'variables': {
      'base_url': 'https://sandbox.mypaga.com',
      'api_key': '{{paga_api_key}}',
    },
  },
  'opay_sandbox': {
    'name': 'Opay Sandbox',
    'description': 'Opay sandbox environment (Nigeria)',
    'baseUrl': 'https://sandboxapi.opay.com',
    'variables': {
      'base_url': 'https://sandboxapi.opay.com',
      'api_key': '{{opay_api_key}}',
    },
  },
  'palmpay_sandbox': {
    'name': 'PalmPay Sandbox',
    'description': 'PalmPay sandbox environment (Nigeria, Ghana)',
    'baseUrl': 'https://sandbox.palmpay.com',
    'variables': {
      'base_url': 'https://sandbox.palmpay.com',
      'api_key': '{{palmpay_api_key}}',
    },
  },
  'flutterwave_sandbox': {
    'name': 'Flutterwave Sandbox',
    'description': 'Flutterwave sandbox environment',
    'baseUrl': 'https://api.flutterwave.com/v3',
    'variables': {
      'base_url': 'https://api.flutterwave.com/v3',
      'public_key': '{{flutterwave_public_key}}',
      'secret_key': '{{flutterwave_secret_key}}',
      'encryption_key': '{{flutterwave_encryption_key}}',
    },
  },
  'paystack_sandbox': {
    'name': 'Paystack Sandbox',
    'description': 'Paystack sandbox environment',
    'baseUrl': 'https://api.paystack.co',
    'variables': {
      'base_url': 'https://api.paystack.co',
      'secret_key': '{{paystack_secret_key}}',
      'public_key': '{{paystack_public_key}}',
    },
  },
  'interswitch_sandbox': {
    'name': 'Interswitch Sandbox',
    'description': 'Interswitch sandbox environment',
    'baseUrl': 'https://sandbox.interswitchng.com',
    'variables': {
      'base_url': 'https://sandbox.interswitchng.com',
      'client_id': '{{interswitch_client_id}}',
      'client_secret': '{{interswitch_client_secret}}',
      'terminal_id': '{{interswitch_terminal_id}}',
    },
  },
  'payfast_sandbox': {
    'name': 'Payfast Sandbox',
    'description': 'Payfast sandbox environment (South Africa)',
    'baseUrl': 'https://sandbox.payfast.co.za',
    'variables': {
      'base_url': 'https://sandbox.payfast.co.za',
      'merchant_id': '{{payfast_merchant_id}}',
      'merchant_key': '{{payfast_merchant_key}}',
      'passphrase': '{{payfast_passphrase}}',
    },
  },
  'ozow_sandbox': {
    'name': 'Ozow Sandbox',
    'description': 'Ozow sandbox environment (South Africa)',
    'baseUrl': 'https://api.sandbox.ozow.com',
    'variables': {
      'base_url': 'https://api.sandbox.ozow.com',
      'api_key': '{{ozow_api_key}}',
      'site_code': '{{ozow_site_code}}',
    },
  },
  'yoco_sandbox': {
    'name': 'Yoco Sandbox',
    'description': 'Yoco sandbox environment (South Africa)',
    'baseUrl': 'https://online.yoco.com/v1',
    'variables': {
      'base_url': 'https://online.yoco.com/v1',
      'secret_key': '{{yoco_secret_key}}',
      'public_key': '{{yoco_public_key}}',
    },
  },
  'peach_payments_sandbox': {
    'name': 'Peach Payments Sandbox',
    'description': 'Peach Payments sandbox environment',
    'baseUrl': 'https://api.sandbox.peachpayments.com',
    'variables': {
      'base_url': 'https://api.sandbox.peachpayments.com',
      'entity_id': '{{peach_entity_id}}',
      'api_key': '{{peach_api_key}}',
    },
  },
  'sendy_sandbox': {
    'name': 'Sendy Sandbox',
    'description': 'Sendy sandbox environment (Kenya, Uganda, Tanzania)',
    'baseUrl': 'https://api.sandbox.sendy.co.ke',
    'variables': {
      'base_url': 'https://api.sandbox.sendy.co.ke',
      'api_key': '{{sendy_api_key}}',
    },
  },
  'lori_systems_sandbox': {
    'name': 'Lori Systems Sandbox',
    'description': 'Lori Systems sandbox environment',
    'baseUrl': 'https://api.sandbox.lorisystems.com',
    'variables': {
      'base_url': 'https://api.sandbox.lorisystems.com',
      'api_key': '{{lori_api_key}}',
    },
  },
  'kobo360_sandbox': {
    'name': 'Kobo360 Sandbox',
    'description': 'Kobo360 sandbox environment',
    'baseUrl': 'https://api.sandbox.kobo360.com',
    'variables': {
      'base_url': 'https://api.sandbox.kobo360.com',
      'api_key': '{{kobo360_api_key}}',
    },
  },
  'truckr_sandbox': {
    'name': 'Truckr Sandbox',
    'description': 'Truckr sandbox environment (South Africa)',
    'baseUrl': 'https://api.sandbox.truckr.co.za',
    'variables': {
      'base_url': 'https://api.sandbox.truckr.co.za',
      'api_key': '{{truckr_api_key}}',
    },
  },
  'gig_logistics_sandbox': {
    'name': 'GIG Logistics Sandbox',
    'description': 'GIG Logistics sandbox environment (Nigeria, Ghana)',
    'baseUrl': 'https://api.sandbox.giglogistics.com',
    'variables': {
      'base_url': 'https://api.sandbox.giglogistics.com',
      'api_key': '{{gig_api_key}}',
    },
  },
  'standard_bank_sandbox': {
    'name': 'Standard Bank Sandbox',
    'description': 'Standard Bank sandbox environment',
    'baseUrl': 'https://api.sandbox.standardbank.com',
    'variables': {
      'base_url': 'https://api.sandbox.standardbank.com',
      'client_id': '{{sb_client_id}}',
      'client_secret': '{{sb_client_secret}}',
    },
  },
  'absa_sandbox': {
    'name': 'ABSA Sandbox',
    'description': 'ABSA Bank sandbox environment',
    'baseUrl': 'https://api.sandbox.absa.co.za',
    'variables': {
      'base_url': 'https://api.sandbox.absa.co.za',
      'client_id': '{{absa_client_id}}',
      'client_secret': '{{absa_client_secret}}',
    },
  },
  'fnb_sandbox': {
    'name': 'FNB Sandbox',
    'description': 'First National Bank sandbox environment',
    'baseUrl': 'https://api.sandbox.fnb.co.za',
    'variables': {
      'base_url': 'https://api.sandbox.fnb.co.za',
      'client_id': '{{fnb_client_id}}',
      'client_secret': '{{fnb_client_secret}}',
    },
  },
  'nedbank_sandbox': {
    'name': 'Nedbank Sandbox',
    'description': 'Nedbank sandbox environment',
    'baseUrl': 'https://api.sandbox.nedbank.co.za',
    'variables': {
      'base_url': 'https://api.sandbox.nedbank.co.za',
      'client_id': '{{nedbank_client_id}}',
      'client_secret': '{{nedbank_client_secret}}',
    },
  },
  'equity_bank_sandbox': {
    'name': 'Equity Bank Sandbox',
    'description': 'Equity Bank sandbox environment (East Africa)',
    'baseUrl': 'https://api.sandbox.equitybankgroup.com',
    'variables': {
      'base_url': 'https://api.sandbox.equitybankgroup.com',
      'api_key': '{{equity_api_key}}',
    },
  },
  'kcb_sandbox': {
    'name': 'KCB Group Sandbox',
    'description': 'KCB Group sandbox environment (East Africa)',
    'baseUrl': 'https://api.sandbox.kcbgroup.com',
    'variables': {
      'base_url': 'https://api.sandbox.kcbgroup.com',
      'api_key': '{{kcb_api_key}}',
    },
  },
  'coop_bank_sandbox': {
    'name': 'Co-operative Bank Sandbox',
    'description': 'Co-operative Bank of Kenya sandbox environment',
    'baseUrl': 'https://api.sandbox.co-opbank.co.ke',
    'variables': {
      'base_url': 'https://api.sandbox.co-opbank.co.ke',
      'api_key': '{{coop_api_key}}',
    },
  },
  'smile_identity_sandbox': {
    'name': 'Smile Identity Sandbox',
    'description': 'Smile Identity sandbox environment',
    'baseUrl': 'https://api.sandbox.smileidentity.com',
    'variables': {
      'base_url': 'https://api.sandbox.smileidentity.com',
      'partner_id': '{{smile_partner_id}}',
      'api_key': '{{smile_api_key}}',
    },
  },
  'youverify_sandbox': {
    'name': 'Youverify Sandbox',
    'description': 'Youverify sandbox environment',
    'baseUrl': 'https://api.sandbox.youverify.co',
    'variables': {
      'base_url': 'https://api.sandbox.youverify.co',
      'api_key': '{{youverify_api_key}}',
    },
  },
  'prembly_sandbox': {
    'name': 'Prembly Sandbox',
    'description': 'Prembly sandbox environment',
    'baseUrl': 'https://api.sandbox.prembly.com',
    'variables': {
      'base_url': 'https://api.sandbox.prembly.com',
      'api_key': '{{prembly_api_key}}',
    },
  },
  'mfs_africa_sandbox': {
    'name': 'MFS Africa Sandbox',
    'description': 'MFS Africa sandbox environment',
    'baseUrl': 'https://api.sandbox.mfsafrica.com',
    'variables': {
      'base_url': 'https://api.sandbox.mfsafrica.com',
      'api_key': '{{mfs_africa_api_key}}',
    },
  },
  'cellulant_sandbox': {
    'name': 'Cellulant Sandbox',
    'description': 'Cellulant sandbox environment',
    'baseUrl': 'https://api.sandbox.cellulant.com',
    'variables': {
      'base_url': 'https://api.sandbox.cellulant.com',
      'api_key': '{{cellulant_api_key}}',
    },
  },
  'dpo_group_sandbox': {
    'name': 'DPO Group Sandbox',
    'description': 'DPO Group sandbox environment',
    'baseUrl': 'https://api.sandbox.dpopayments.com',
    'variables': {
      'base_url': 'https://api.sandbox.dpopayments.com',
      'api_key': '{{dpo_api_key}}',
    },
  },
  'ipay_africa_sandbox': {
    'name': 'iPay Africa Sandbox',
    'description': 'iPay Africa sandbox environment (East Africa)',
    'baseUrl': 'https://api.sandbox.ipayafrica.com',
    'variables': {
      'base_url': 'https://api.sandbox.ipayafrica.com',
      'api_key': '{{ipay_api_key}}',
    },
  },
  'jenga_sandbox': {
    'name': 'Jenga Sandbox',
    'description': 'Jenga (Equity Bank) sandbox environment',
    'baseUrl': 'https://api.sandbox.jengahq.com',
    'variables': {
      'base_url': 'https://api.sandbox.jengahq.com',
      'client_id': '{{jenga_client_id}}',
      'client_secret': '{{jenga_client_secret}}',
    },
  },
};