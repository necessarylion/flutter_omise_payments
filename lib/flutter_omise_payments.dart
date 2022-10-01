library flutter_omise_pay_js;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OmiseLocale {
  static get english => 'en';
  static get japan => 'ja';
  static get malaysia => 'my';
  static get thai => 'th';
}

class OmisePayments extends StatelessWidget {
  final String publicKey;
  final List<String>? paymentMethods;
  final String locale;
  final String currency;
  final String theme;
  final num amount;
  final Function(String) onTokenCreated;

  const OmisePayments({
    super.key,
    required this.publicKey,
    required this.currency,
    this.paymentMethods,
    this.locale = 'en',
    this.theme = '#192c66',
    required this.amount,
    required this.onTokenCreated,
  });

  @override
  Widget build(BuildContext context) {
    List<String> methods = paymentMethods ?? ['credit_card'];
    String encodedMethods = json.encode(methods);
    num formattedAmount = 0;
    if (currency.toLowerCase() != 'jpy') {
      formattedAmount = amount * 100;
    } else {
      formattedAmount = amount;
    }

    String content = """<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Omise Payments</title>
    <link href="https://cdn.omise.co/fonts/circular.css" rel="stylesheet" />
    <style>
    iframe {
      margin-top: -25px !important;
    }
    </style>
  </head>
  <body>
    <script src="https://cdn.omise.co/omise.js"></script>
  </body>
  <script type="text/javascript">
    function initOmise({ amount, currency, publicKey }) {
      let otherPaymentMethods = JSON.parse('$encodedMethods')
      let tokenCreated = false
      OmiseCard.configure({
        publicKey,
        submitAuto: 'no',
        image: '',
        otherPaymentMethods,
        style: {
          fontFamily: 'Circular,Arial,sans-serif',
          defaultSelectPaymentMethods: true,
          closeButton: {
            visible: false,
          },
          body: {
            width: '100%',
            padding: {
              mobile: '0px 15px 30px 15px',
            }
          },
          submitButton: {
            backgroundColor: '$theme',
            textColor: 'white',
          },
        },
        onCreateTokenSuccess: function (token) {
          MessageInvoker.postMessage(token);
        },
      })
      OmiseCard.open({
        amount: "$formattedAmount",
        currency: "$currency",
        locale: "$locale",
        frameLabel: "",
        frameDescription: "",
        submitLabel: "",
        location: 'no',
      })
    }
    window.addEventListener("load", (e) => {
        e.preventDefault();
        initOmise({
            amount: "$formattedAmount",
            currency: "$currency",
            publicKey: "$publicKey"
        });
    });
  </script>
</html>
""";
    Uri url = Uri.dataFromString(content,
        mimeType: 'text/html', encoding: Encoding.getByName('utf-8'));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: WebView(
            javascriptMode: JavascriptMode.unrestricted,
            debuggingEnabled: true,
            initialUrl: url.toString(),
            javascriptChannels: <JavascriptChannel>{
              JavascriptChannel(
                name: 'MessageInvoker',
                onMessageReceived: (s) {
                  onTokenCreated(s.message);
                },
              ),
            },
          ),
        ),
      ],
    );
  }
}
