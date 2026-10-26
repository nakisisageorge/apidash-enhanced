// Identity Verification API Collections
library apidash_african_apis.collections.identity;

/// Smile Identity (Pan-African KYC/AML)
const Map<String, dynamic> smileIdentityCollection = {
  'name': 'Smile Identity',
  'description': 'Smile Identity API collection - KYC, AML, Biometric verification across Africa',
  'baseUrl': 'https://api.smileidentity.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'KYC Verification', 'requests': ['submit_job', 'get_job_status', 'get_job_result']},
    {'name': 'Biometric', 'requests': ['enroll_face', 'verify_face', 'liveness_check']},
    {'name': 'Document Verification', 'requests': ['verify_id_document', 'verify_passport']},
    {'name': 'Business Verification', 'requests': ['verify_business', 'get_business_details']},
  ],
  'requests': [
    {
      'id': 'si_submit_job',
      'name': 'Submit KYC Job',
      'method': 'POST',
      'path': '/v1/jobs',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'partner_id': '{{partner_id}}',
        'job_type': 5,
        'job_id': 'JOB123456',
        'user_id': 'USER123',
        'callback_url': 'https://yourdomain.com/callback',
        'id_info': {
          'id_type': 'NATIONAL_ID',
          'id_number': '12345678',
          'country': 'KE',
          'first_name': 'John',
          'last_name': 'Doe',
          'dob': '1990-01-01',
        },
      },
    },
    {
      'id': 'si_get_job_status',
      'name': 'Get Job Status',
      'method': 'GET',
      'path': '/v1/jobs/{{job_id}}',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
      },
    },
  ],
};

/// Youverify (Nigeria, Ghana, Kenya)
const Map<String, dynamic> youverifyCollection = {
  'name': 'Youverify',
  'description': 'Youverify API collection - Identity verification and KYC for African businesses',
  'baseUrl': 'https://api.youverify.co',
  'authType': 'api_key',
  'folders': [
    {'name': 'Individual KYC', 'requests': ['verify_identity', 'get_verification_status']},
    {'name': 'Business KYC', 'requests': ['verify_business', 'get_business_report']},
    {'name': 'AML Screening', 'requests': ['screen_individual', 'screen_business']},
  ],
  'requests': [
    {
      'id': 'yv_verify_identity',
      'name': 'Verify Identity',
      'method': 'POST',
      'path': '/v1/kyc/individual',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'first_name': 'John',
        'last_name': 'Doe',
        'id_type': 'NIN',
        'id_number': '12345678901',
        'date_of_birth': '1990-01-01',
        'phone_number': '080XXXXXXXX',
      },
    },
  ],
};

/// Prembly (Nigeria, Kenya, Ghana)
const Map<String, dynamic> premblyCollection = {
  'name': 'Prembly',
  'description': 'Prembly API collection - Identity verification, KYC, and compliance',
  'baseUrl': 'https://api.prembly.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Verification', 'requests': ['verify_nin', 'verify_bvn', 'verify_driver_license', 'verify_voters_card']},
    {'name': 'Business', 'requests': ['verify_cac', 'verify_tin']},
  ],
  'requests': [
    {
      'id': 'pb_verify_nin',
      'name': 'Verify NIN (Nigeria)',
      'method': 'POST',
      'path': '/v1/verify/nin',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'nin': '12345678901',
      },
    },
    {
      'id': 'pb_verify_bvn',
      'name': 'Verify BVN (Nigeria)',
      'method': 'POST',
      'path': '/v1/verify/bvn',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'bvn': '12345678901',
      },
    },
  ],
};

/// All identity collections
const Map<String, dynamic> identityCollections = {
  'smile_identity': smileIdentityCollection,
  'youverify': youverifyCollection,
  'prembly': premblyCollection,
};