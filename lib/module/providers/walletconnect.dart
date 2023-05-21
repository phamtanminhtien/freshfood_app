import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web3dart/contracts.dart';
import 'package:web3dart/crypto.dart';
import 'package:http/http.dart';

class WalletConnectEthereumCredentials extends CustomTransactionSender {
  WalletConnectEthereumCredentials(
      {required this.provider, required this.etherAddress});

  final EthereumWalletConnectProvider provider;
  final EthereumAddress etherAddress;

  @override
  EthereumAddress get address => etherAddress;

  @override
  Future<EthereumAddress> extractAddress() {
    throw UnimplementedError();
  }

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    final hash = await provider.sendTransaction(
      from: transaction.from!.hex,
      to: transaction.to?.hex,
      data: transaction.data,
      gas: transaction.maxGas,
      gasPrice: transaction.gasPrice?.getInWei,
      value: transaction.value?.getInWei,
      nonce: transaction.nonce,
    );

    return hash;
  }

  @override
  Future<MsgSignature> signToSignature(Uint8List payload,
      {int? chainId, bool isEIP1559 = false}) {
    throw UnimplementedError();
  }

  @override
  MsgSignature signToEcSignature(
    Uint8List payload, {
    int? chainId,
    bool isEIP1559 = false,
  }) {
    throw UnimplementedError();
  }
}

class WalletProvider extends ChangeNotifier {
  late Web3Client _ethereum;
  late final EthereumWalletConnectProvider _provider;
  dynamic _session;
  dynamic _connector;
  String _account = '';
  String? _uri;

  dynamic get session => _session;
  WalletConnect get connector => _connector;
  // String get account => _account;
  EthereumAddress get account => EthereumAddress.fromHex(_account);

  String contractAddress = dotenv.get("FRESHFOOD_CONTRACT_ADDRESS");
  String infura =
      "https://sepolia.infura.io/v3/" + dotenv.get('INFURA_API_KEY');
  String devRpcUrl = dotenv.get('DEV_RPC_URL');
  String etherscanUrl = dotenv.get('ETHERSCAN_URL');
  Future createSession() async {
    if (!_connector.connected) {
      try {
        _session = await _connector.createSession(
            chainId: 1337,
            onDisplayUri: (uri) async {
              _uri = uri;
              launchUrl(Uri.parse(uri));
              //await launchUrlString(uri, mode: LaunchMode.externalApplication);
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
    _connector = WalletConnect(
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

    //_ethereum = Web3Client(infura, Client());
    _ethereum = Web3Client(devRpcUrl, Client());
    _provider = EthereumWalletConnectProvider(_connector);

    // Register session request callback
    connector.registerListeners(
      onConnect: (status) async {
        _account = _session.accounts[0];
        notifyListeners();
        print('onConnect: $_account');
      },
    );
  }

  String getFullAccountStr(bool? isShort) {
    if (_session != null) {
      if (!isShort!) {
        String accountStr =
            '${_account.substring(0, 10)}...${_account.substring(_account.length - 4, _account.length)}';
        return accountStr;
      } else {
        return _account;
      }
    } else {
      return 'No account found';
    }
  }

  Future<DeployedContract> getDeployedContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    final contract = DeployedContract(ContractAbi.fromJson(abi, "FreshFood"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  //get balance of account
  Future<double> getBalance() async {
    final amount =
        await _ethereum.getBalance(EthereumAddress.fromHex(_account));
    return amount.getValueInUnit(EtherUnit.ether).toDouble();
  }

  Future<List<dynamic>> getOwnerByAddress(EthereumAddress address) async {
    List<dynamic> result = await query("getOwnerByAddress", [address]);
    return result;
  }

  Future<dynamic> getProductById(int productId) async {
    var id = BigInt.from(productId);
    List<dynamic> products = await query("getProductById", [id]);
    return products;
  }

  Future<List<dynamic>> getProductByOwner(EthereumAddress address) async {
    List<dynamic> result = await query("getProductByOwner", [address]);
    return result;
  }

  Future<String> registerOwner(String name, String description) async {
    var response = await submit("registerOwner", [name, description]);
    return response;
  }

  Future<String> addProduct(String name, String origin, String imageUrl) async {
    var response = await submit("addProduct", [name, origin, imageUrl]);
    return response;
  }

  Future<String> addLog(int productId, String objectId, String hash,
      String location, int timestamp) async {
    var response = await submit("addLog", [
      BigInt.from(productId),
      objectId,
      hash,
      location,
      BigInt.from(timestamp)
    ]);
    return response;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await getDeployedContract();
    final ethFunction = contract.function(functionName);
    final result = await _ethereum.call(
        contract: contract, function: ethFunction, params: args);
    return result;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    try {
      DeployedContract contract = await getDeployedContract();
      final ethFunction = contract.function(functionName);

      final credential = WalletConnectEthereumCredentials(
          provider: _provider, etherAddress: EthereumAddress.fromHex(_account));

      final transaction = Transaction(
          to: EthereumAddress.fromHex(contractAddress),
          from: EthereumAddress.fromHex(_account),
          data: ethFunction.encodeCall(args),
          maxGas: 1000000);

      // EthPrivateKey credential =
      //     EthPrivateKey.fromHex(dotenv.get('METAMASK_PRIVATE_KEY'));

      // final transaction = Transaction.callContract(
      //     contract: contract,
      //     function: ethFunction,
      //     parameters: args,
      //     maxGas: 1000000);

      Future.delayed(const Duration(seconds: 1), () => openWalletApp());

      final result = await _ethereum.sendTransaction(
        credential,
        transaction,
        chainId: 1337,
      );

      //disconnect();
      return "Transaction is successful.\nHash: ${result.toString()}";
    } catch (e) {
      return "Transaction is rejected";
    }
  }

  Future<void> openWalletApp() async {
    if (_uri == null) return;
    await launchUrl(Uri.parse(_uri!));
  }

  showAlertDialog(BuildContext context, String message) {
    bool typeSuccess = message.contains("rejected") ? false : true;

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'vtks_distress',
                fontSize: 18.0,
              ),
            ),
            actions: [
              typeSuccess
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            var hash = message.split("Hash: ")[1].trim();
                            launchUrl(Uri.parse("$etherscanUrl/$hash"));
                            Navigator.of(context).pop();
                            Clipboard.setData(ClipboardData(
                                text: message.split("Hash: ")[1].trim()));
                          },
                          child: const Text(
                            'Copy',
                            style: TextStyle(
                              fontFamily: 'vtks_distress',
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'OK',
                            style: TextStyle(
                              fontFamily: 'vtks_distress',
                              fontSize: 18.0,
                            ),
                          ),
                        )
                      ],
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'OK',
                        style: TextStyle(
                          fontFamily: 'vtks_distress',
                          fontSize: 18.0,
                        ),
                      ),
                    ),
            ],
          );
        });
  }

  Future disconnect() async {
    if (_connector.connected) {
      try {
        await _connector.killSession();
        return true;
      } catch (exp) {
        print(exp.toString());
        return false;
      }
    }
  }
}
