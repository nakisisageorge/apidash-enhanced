// Logistics API Collections
library apidash_african_apis.collections.logistics;

/// Sendy (Kenya, Uganda, Tanzania, Nigeria)
const Map<String, dynamic> sendyCollection = {
  'name': 'Sendy',
  'description': 'Sendy API collection - On-demand logistics and fulfillment across East Africa',
  'baseUrl': 'https://api.sendy.co.ke',
  'authType': 'api_key',
  'folders': [
    {'name': 'Deliveries', 'requests': ['create_delivery', 'get_delivery', 'cancel_delivery', 'track_delivery']},
    {'name': 'Quotes', 'requests': ['get_quote', 'get_delivery_types']},
    {'name': 'Webhooks', 'requests': ['register_webhook', 'list_webhooks']},
  ],
  'requests': [
    {
      'id': 'sendy_create_delivery',
      'name': 'Create Delivery',
      'method': 'POST',
      'path': '/v1/deliveries',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'pickup': {
          'name': 'John Sender',
          'phone': '07XXXXXXXX',
          'location': 'Westlands, Nairobi',
          'coordinates': {'lat': -1.267, 'lng': 36.806},
        },
        'dropoff': {
          'name': 'Jane Receiver',
          'phone': '07YYYYYYYY',
          'location': 'Kilimani, Nairobi',
          'coordinates': {'lat': -1.292, 'lng': 36.787},
        },
        'package': {
          'description': 'Documents',
          'weight_kg': 0.5,
          'dimensions_cm': {'length': 30, 'width': 20, 'height': 2},
        },
        'delivery_type': 'express',
      },
    },
    {
      'id': 'sendy_get_quote',
      'name': 'Get Delivery Quote',
      'method': 'POST',
      'path': '/v1/quotes',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'pickup': 'Westlands, Nairobi',
        'dropoff': 'Kilimani, Nairobi',
        'package': {
          'weight_kg': 1,
          'dimensions_cm': {'length': 30, 'width': 20, 'height': 10},
        },
      },
    },
  ],
};

/// Lori Systems (Kenya, Uganda, Nigeria, Egypt)
const Map<String, dynamic> loriSystemsCollection = {
  'name': 'Lori Systems',
  'description': 'Lori Systems API collection - Trucking marketplace and logistics management',
  'baseUrl': 'https://api.lorisystems.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Loads', 'requests': ['create_load', 'get_load', 'update_load', 'cancel_load']},
    {'name': 'Trucks', 'requests': ['list_trucks', 'get_truck', 'book_truck']},
    {'name': 'Tracking', 'requests': ['track_load', 'get_eta']},
  ],
  'requests': [
    {
      'id': 'lori_create_load',
      'name': 'Create Load',
      'method': 'POST',
      'path': '/v1/loads',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'origin': 'Nairobi, Kenya',
        'destination': 'Kampala, Uganda',
        'cargo_type': 'general',
        'weight_kg': 10000,
        'volume_m3': 20,
        'pickup_date': '2026-11-01',
        'delivery_date': '2026-11-03',
      },
    },
  ],
};

/// Kobo360 (Nigeria, Ghana, Kenya, Togo, Ivory Coast)
const Map<String, dynamic> kobo360Collection = {
  'name': 'Kobo360',
  'description': 'Kobo360 API collection - Digital logistics platform connecting shippers and transporters',
  'baseUrl': 'https://api.kobo360.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Shipments', 'requests': ['create_shipment', 'get_shipment', 'track_shipment']},
    {'name': 'Trucks', 'requests': ['search_trucks', 'book_truck']},
    {'name': 'Quotes', 'requests': ['request_quote', 'accept_quote']},
  ],
  'requests': [
    {
      'id': 'kobo_create_shipment',
      'name': 'Create Shipment',
      'method': 'POST',
      'path': '/v1/shipments',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'pickup_location': 'Lagos, Nigeria',
        'delivery_location': 'Accra, Ghana',
        'cargo_description': 'Electronics',
        'weight_kg': 5000,
        'dimensions': {'length': 200, 'width': 100, 'height': 100},
        'pickup_date': '2026-11-01',
      },
    },
  ],
};

/// Truckr (South Africa)
const Map<String, dynamic> truckrCollection = {
  'name': 'Truckr',
  'description': 'Truckr API collection - South Africa trucking marketplace',
  'baseUrl': 'https://api.truckr.co.za',
  'authType': 'api_key',
  'folders': [
    {'name': 'Loads', 'requests': ['post_load', 'get_load', 'list_loads']},
    {'name': 'Trucks', 'requests': ['list_available_trucks', 'book_truck']},
  ],
  'requests': [
    {
      'id': 'truckr_post_load',
      'name': 'Post Load',
      'method': 'POST',
      'path': '/v1/loads',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'origin': 'Johannesburg',
        'destination': 'Cape Town',
        'load_type': 'palletized',
        'weight_kg': 15000,
        'pickup_date': '2026-11-01',
      },
    },
  ],
};

/// GIG Logistics (Nigeria, Ghana)
const Map<String, dynamic> gigLogisticsCollection = {
  'name': 'GIG Logistics',
  'description': 'GIG Logistics API collection - Courier and logistics services in West Africa',
  'baseUrl': 'https://api.giglogistics.com',
  'authType': 'api_key',
  'folders': [
    {'name': 'Parcels', 'requests': ['create_parcel', 'track_parcel', 'schedule_pickup']},
    {'name': 'Rates', 'requests': ['get_rates', 'calculate_shipping']},
  ],
  'requests': [
    {
      'id': 'gig_create_parcel',
      'name': 'Create Parcel',
      'method': 'POST',
      'path': '/v1/parcels',
      'headers': {
        'Authorization': 'Bearer {{api_key}}',
        'Content-Type': 'application/json',
      },
      'body': {
        'sender': {
          'name': 'John Sender',
          'phone': '080XXXXXXXX',
          'address': 'Victoria Island, Lagos',
        },
        'receiver': {
          'name': 'Jane Receiver',
          'phone': '080YYYYYYYY',
          'address': 'East Legon, Accra',
        },
        'parcel': {
          'weight_kg': 2,
          'dimensions_cm': {'length': 30, 'width': 20, 'height': 15},
          'description': 'Clothing items',
        },
      },
    },
  ],
};

/// All logistics collections
const Map<String, dynamic> logisticsCollections = {
  'sendy': sendyCollection,
  'lori_systems': loriSystemsCollection,
  'kobo360': kobo360Collection,
  'truckr': truckrCollection,
  'gig_logistics': gigLogisticsCollection,
};