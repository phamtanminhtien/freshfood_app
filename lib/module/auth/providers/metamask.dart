import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class WalletProvider extends ChangeNotifier {
  dynamic session;
  dynamic connector;

  String _account = '';
  String get account => _account;

  Future createSession() async {
    if (!connector.connected) {
      try {
        session = await connector.createSession(onDisplayUri: (uri) async {
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        return session;
      } catch (exp) {
        print(exp.toString());
        return null;
      }
    }
  }

  Future initWalletConnect() async {
    // Create a connector
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'WalletConnect',
        description: 'WalletConnect Developer App',
        url: 'https://walletconnect.org',
        icons: [
          'https://gblobscdn.gitbook.com/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
        ],
      ),
    );

    _account = session?.accounts.first ?? '';
    // Register session request callback

    connector.registerListeners(
      onConnect: (status) {
        _account = session.accounts[0];
        notifyListeners();
        print('onConnect: $_account');
      },
    );
  }

  String getAccount(int index) {
    if (index < 0 || index >= session.accounts.length) {
      return 'No account found';
    }

    if (session != null) {
      String account = session.accounts[index];
      account =
          '${account.substring(0, 10)}...${account.substring(account.length - 4, account.length)}';
      return account;
    } else {
      return 'No account found';
    }
  }

  Future<BigInt> getBalance(String address) async {
    if (connector.connected) {
      try {
        print('Getting balance for $address');
        BigInt balance = await connector.getBalance(address);
        print('Balance: $balance');
        return balance;
      } catch (exp) {
        print(exp.toString());
        return BigInt.zero;
      }
    } else {
      return BigInt.zero;
    }
  }

  Future disconnect() async {
    if (connector.connected) {
      try {
        await connector.killSession();
        return true;
      } catch (exp) {
        print(exp.toString());
        return false;
      }
    }
  }
}
