# African APIs Guide

Complete guide to using the 47 pre-built African API collections in API Dash Enhanced.

## Overview

API Dash Enhanced includes **47 pre-built, authenticated, sandbox-ready API collections** across 6 categories, covering mobile money, fintech, logistics, banking, identity, and payments across Africa.

## Quick Start

### Loading Collections
1. Open API Dash Enhanced
2. Go to **Collections** → **Import** → **African APIs**
3. Select categories or individual APIs
4. Collections are imported with pre-configured environments

### Via MCP Server
```json
{
  "tool": "import_collection",
  "arguments": {
    "format": "apidash",
    "source": "african_apis://mobile_money/m_pesa_kenya",
    "collectionName": "M-Pesa Kenya"
  }
}
```

## Categories

### 📱 Mobile Money (10 APIs)

| API | Countries | Auth | Key Endpoints |
|-----|-----------|------|---------------|
| **M-Pesa Kenya** | Kenya | OAuth2 | STK Push, B2C, B2B, C2B, Reversal, Query, Balance |
| **M-Pesa Tanzania** | Tanzania | OAuth2 | M2M, M2B, B2C, Query |
| **MTN MoMo** | Uganda, Ghana, Rwanda, Zambia, Cameroon, CI | Subscription Key | RequestToPay, Disbursement, Remittance, KYC |
| **Airtel Money** | Kenya, Uganda, Tanzania, Nigeria, Zambia, Malawi | OAuth2 | USSD Push, Merchant Payment, Query |
| **Orange Money** | Senegal, CI, Mali, Burkina Faso, etc. | OAuth2 | WebPayment, Transfer, Transfer Status |
| **Wave** | Senegal, CI | API Key | Create Invoice, Invoice Status, Transfer |
| **Chipper Cash** | Cross-border (NG, GH, KE, UG, RW, etc.) | API Key | Create Payment, Payment Status, Transfer |
| **Paga** | Nigeria | API Key | Money Transfer, Bill Payment, Balance |
| **Opay** | Nigeria | API Key | Initialize Payment, Verify Payment, Bank Transfer |
| **PalmPay** | Nigeria, Ghana | API Key | Create Order, Query Order |

#### M-Pesa Kenya Quick Start
```bash
# 1. Load collection: "M-Pesa Kenya"
# 2. Select environment: "M-Pesa Kenya Sandbox"
# 3. Configure variables:
#    - consumer_key: your_safaricom_consumer_key
#    - consumer_secret: your_safaricom_consumer_secret
#    - passkey: your_safaricom_passkey
#    - shortcode: 174379 (sandbox)
# 4. Use "STK Push Payment" request
# 5. AI prompt: "Initiate STK push for 254712345678, amount 1000, account ref ORDER123"
```

#### MTN MoMo Quick Start
```bash
# 1. Load collection: "MTN MoMo"
# 2. Select environment: "MTN MoMo Sandbox"
# 3. Configure variables:
#    - subscription_key: your_mtn_subscription_key
#    - api_user_id: your_mtn_api_user_id (from create_api_user)
#    - api_key: your_mtn_api_key (from get_api_key)
#    - target_environment: sandbox
# 4. Use "Request to Pay" request
# 5. AI prompt: "Request 1000 UGX from 256712345678 for order ORDER123"
```

### 💳 FinTech (7 APIs)

| API | Countries | Auth | Key Features |
|-----|-----------|------|--------------|
| **Flutterwave** | NG, KE, GH, ZA, UG, TZ, RW, etc. | API Key | Payments, Transfers, Virtual Cards, Bills, Subaccounts |
| **Paystack** | NG, GH, ZA, KE | API Key | Transactions, Transfers, Customers, Subscriptions, Virtual Accounts |
| **Interswitch** | NG, KE, UG, GH | OAuth2 | Payments, Transfers, Card Issuing, KYC |
| **Payfast** | South Africa | API Key | Payments, Subscriptions |
| **Ozow** | South Africa | API Key | Alternative Payments (EFT, Instant EFT) |
| **Yoco** | South Africa | API Key | Card Payments, Customers, Refunds |
| **Peach Payments** | ZA, KE, MU | API Key | Checkouts, Subscriptions |

#### Flutterwave Quick Start
```bash
# 1. Load: "Flutterwave"
# 2. Environment: "Flutterwave Sandbox"
# 3. Variables:
#    - public_key: FLWPUBK_TEST-xxxx
#    - secret_key: FLWSECK_TEST-xxxx
#    - encryption_key: FLWSECK_TESTxxxxxxxxxxxx (for card)
# 4. Use "Initialize Payment" request
# 5. AI prompt: "Create payment link for 10000 NGN, customer john@example.com, 08012345678"
```

### 🚚 Logistics (5 APIs)

| API | Countries | Auth | Key Features |
|-----|-----------|------|--------------|
| **Sendy** | KE, UG, TZ, NG | API Key | Deliveries, Quotes, Tracking, Webhooks |
| **Lori Systems** | KE, UG, NG, EG | API Key | Loads, Trucks, Booking, Tracking |
| **Kobo360** | NG, GH, KE, TG, CI | API Key | Shipments, Trucks, Quotes |
| **Truckr** | South Africa | API Key | Loads, Trucks, Booking |
| **GIG Logistics** | NG, GH | API Key | Parcels, Rates, Pickup Scheduling |

### 🏦 Banking (7 APIs)

| API | Countries | Auth | Key Features |
|-----|-----------|------|--------------|
| **Standard Bank** | ZA, Africa regions | OAuth2 | Accounts, Payments, Beneficiaries, Forex |
| **ABSA** | ZA, Africa regions | OAuth2 | Accounts, Transfers, Cards |
| **FNB** | South Africa | OAuth2 | Accounts, Payments, Scheduled Payments |
| **Nedbank** | ZA, Africa regions | OAuth2 | Accounts, Payments, Bulk Payments |
| **Equity Bank** | KE, UG, TZ, RW, CD | API Key | Accounts, Mobile Money Transfer, Bank Transfer |
| **KCB Group** | KE, UG, TZ, RW, BI, SS, CD | API Key | Accounts, M-Pesa Transfer, Card Payments |
| **Co-op Bank** | Kenya | API Key | Accounts, MCo-op Cash, Bill Payment |

### 🔐 Identity (3 APIs)

| API | Countries | Auth | Key Features |
|-----|-----------|------|--------------|
| **Smile Identity** | Pan-African | API Key | KYC, Biometric, Document Verification, Business Verification |
| **Youverify** | NG, GH, KE | API Key | Individual KYC, Business KYC, AML Screening |
| **Prembly** | NG, KE, GH | API Key | NIN, BVN, Driver's License, Voter's Card, CAC, TIN |

#### Smile Identity Quick Start
```bash
# 1. Load: "Smile Identity"
# 2. Environment: "Smile Identity Sandbox"
# 3. Variables:
#    - partner_id: your_smile_partner_id
#    - api_key: your_smile_api_key
# 4. Use "Submit KYC Job" request
# 5. AI prompt: "Verify Kenyan national ID 12345678 for John Doe, DOB 1990-01-01"
```

### 💰 Payments (5 APIs)

| API | Countries | Auth | Key Features |
|-----|-----------|------|--------------|
| **MFS Africa** | 30+ African countries | API Key | Cross-border Transfers, Corridors, Beneficiaries, Wallets |
| **Cellulant** | Pan-African | API Key | Payments, Collections, Disbursements |
| **DPO Group** | 30+ countries | API Key | Payments, Subscriptions, Refunds |
| **iPay Africa** | KE, UG, TZ | API Key | STK Push, Verify Payment, Refunds |
| **Jenga** | KE, UG, TZ, RW | OAuth2 | Accounts, Transfers, Bills, Airtime, Merchant Payments |

## Environment Configuration

Each API has pre-configured sandbox and production environments.

### Variable Patterns

| Auth Type | Variables |
|-----------|-----------|
| **OAuth2 Client Credentials** | `client_id`, `client_secret`, `base_url`, `token_url` |
| **API Key** | `api_key`, `public_key`, `secret_key`, `base_url` |
| **Subscription Key** | `subscription_key`, `api_user_id`, `api_key`, `target_environment` |
| **HMAC/Signature** | `api_key`, `secret_key`, `signature_method`, `base_url` |
| **Basic Auth** | `username`, `password`, `base_url` |

### Sandbox vs Production
| Aspect | Sandbox | Production |
|--------|---------|------------|
| **Base URL** | `sandbox.provider.com` | `api.provider.com` |
| **Credentials** | Test credentials | Live credentials |
| **Rate Limits** | Lower | Higher |
| **Webhooks** | Test endpoints | Live endpoints |
| **Transaction Limits** | Test amounts | Real limits |

## Authentication Helpers

### M-Pesa (Kenya)
```dart
// Auto-generates: password = base64(shortcode + passkey + timestamp)
// Auto-generates: timestamp = yyyyMMddHHmmss
// Auto-handles: token refresh
```

### MTN MoMo
```dart
// Auto-handles: create_api_user → get_api_key → get_access_token
// Auto-refreshes: access_token (1hr expiry)
// Auto-sets: X-Target-Environment (sandbox/production)
```

### Flutterwave
```dart
// Auto-handles: encryption_key for card payments
// Auto-generates: tx_ref if not provided
// Auto-sets: redirect_url from environment
```

### Paystack
```dart
// Auto-generates: reference if not provided
// Auto-sets: callback_url from environment
// Auto-handles: subaccount split payments
```

## Adding New African APIs

### 1. Research Checklist
- [ ] Official API documentation
- [ ] Sandbox environment available
- [ ] Authentication method documented
- [ ] Key endpoints identified
- [ ] Rate limits known
- [ ] Webhook support

### 2. Collection Structure
```dart
const Map<String, dynamic> newApiCollection = {
  'name': 'Provider Name',
  'description': 'Brief description of provider and coverage',
  'baseUrl': 'https://api.provider.com',
  'authType': 'oauth2|api_key|subscription|hmac|basic',
  'folders': [
    {'name': 'Auth', 'requests': ['get_token']},
    {'name': 'Payments', 'requests': ['pay', 'verify']},
    {'name': 'Queries', 'requests': ['status', 'balance']},
  ],
  'requests': [
    // Each request with: id, name, method, path, headers, body, description
  ],
};
```

### 3. Environment Template
```dart
'provider_sandbox': {
  'name': 'Provider Sandbox',
  'description': 'Sandbox environment for testing',
  'baseUrl': 'https://sandbox.provider.com',
  'variables': {
    'base_url': 'https://sandbox.provider.com',
    // auth-specific variables
  },
},
'provider_production': {
  'name': 'Provider Production',
  'description': 'Production environment',
  'baseUrl': 'https://api.provider.com',
  'variables': {
    'base_url': 'https://api.provider.com',
    // auth-specific variables
  },
},
```

### 4. Documentation
- Add to [African APIs Guide](AFRICAN_APIS_GUIDE.md)
- Include: quick start, auth flow, key endpoints, common errors
- Add example AI prompts

## Common Issues & Solutions

### M-Pesa: "Invalid Certificate"
- **Cause**: Missing Safaricom root CA
- **Fix**: Add Safaricom certificate to trust store or disable SSL verification (sandbox only)

### Flutterwave: "Invalid Encryption Key"
- **Cause**: Wrong encryption key format
- **Fix**: Use 32-char key from dashboard; ensure it's the *encryption* key, not secret

### Paystack: "Invalid Reference"
- **Cause**: Duplicate reference
- **Fix**: Auto-generate with `tx_ref_${DateTime.now().millisecondsSinceEpoch}`

### MTN MoMo: "User Not Found"
- **Cause**: Wrong target environment
- **Fix**: Ensure `X-Target-Environment` matches credentials (sandbox/production)

### Generic: "Rate Limit Exceeded"
- **Cause**: Too many requests
- **Fix**: Implement exponential backoff; check provider limits

## Rate Limits Reference

| API | Sandbox | Production |
|-----|---------|------------|
| M-Pesa | 50/min | 1000/min |
| Flutterwave | 100/min | 1000/min |
| Paystack | 200/min | 1000/min |
| MTN MoMo | 60/min | 300/min |
| Sendy | 30/min | 200/min |

## Support

- **Documentation**: [API Dash Enhanced Docs](https://nakisisageorge.github.io/apidash-enhanced/)
- **Issues**: [GitHub Issues](https://github.com/nakisisageorge/apidash-enhanced/issues)
- **Community**: [Discord](https://discord.gg/apidash)
- **Email**: nakisisageorge@gmail.com

## Contributing New APIs

We welcome new African API collections! See [CONTRIBUTING.md](../CONTRIBUTING.md#african-api-contributions) for the complete process.

### Priority Areas
- Ethiopia (Telebirr, CBE, etc.)
- Egypt (Fawry, Meeza, etc.)
- Morocco (CIH, Attijariwafa, etc.)
- Francophone West Africa (Moov, Orange, etc.)
- Agricultural, Health, Education APIs
- Government/Civic APIs

---

*Last updated: 2026-10-26 | API Dash Enhanced v0.1.0*