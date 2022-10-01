## Flutter Omise Payments

![](demo.png);

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