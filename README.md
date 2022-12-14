## Flutter Omise Payments

This package is Omise js wrapper for flutter. For Andorid, Web, iOS.

<img src="https://raw.githubusercontent.com/necessarylion/flutter_omise_payments/master/demo.png" alt="demo" width="200"/>

#### Usage 

```
OmisePayments(
  publicKey: 'pkey_xxxxxxxxxxxxxxxxxx',
  amount: 2500,
  currency: 'THB',
  locale: OmiseLocale.english,
  theme: '#192c66',
  paymentMethods: const [
    'credit_card',
    'mobile_banking_ocbc_pao',
    'paynow',
    'fpx',
    'touch_n_go',
    'grabpay',
    'shopeepay',
    'duitnow_obw',
    'duitnow_qr',
    'maybank_qr'
  ],
  onTokenCreated: (String token) {
    // do something here with token
  },
)
```

#### Get available payment methods for your account

```
List<String> paymentMethods = await OmisePayments.getAvailablePaymentMethods(publicKey);
```

#### Capability API

```
Capability capability = await OmisePayments.capability(publicKey);
```