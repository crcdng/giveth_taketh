import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giveth_taketh/info_screen.dart';
import 'package:http/http.dart';
// import 'package:web3dart/web3dart.dart';
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'constants.dart' as constants;

typedef TransactionHash = String;

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  late Client _httpClient;
  late Web3Client _ethClient;
  late W3MService _w3mService;
  final _chainId = "11155111";

  // state

  String? currentBalance;

  // ---- transactions

  Future<TransactionHash> deposit(EtherAmount etherAmount) async {
    TransactionHash result = await transact(
        functionName: "deposit", params: [], etherAmount: etherAmount);
    return result;
  }

  // ---- queries

  Future<void> getBalance(String targetAdress) async {
    List<dynamic> result = await query("getBalance", []);

    var rawBalance = result.firstOrNull;
    if (rawBalance != null) {
      final balanceEther = EtherAmount.fromBigInt(EtherUnit.wei, rawBalance)
          .getValueInUnit(EtherUnit.ether);
      setState(() {
        currentBalance = balanceEther.toString();
      });
    }
  }

  // ---- subscription

  // ---- web3dart

  Future<List<dynamic>> query(String functionName, List<dynamic> params) async {
    final contract = await loadContractFromAbi();
    final ethFunction = contract.function(functionName);
    final result = await _ethClient.call(
        contract: contract, function: ethFunction, params: params);
    return result;
  }

  Future<DeployedContract> loadContractFromAbi() async {
    String abiString = await rootBundle.loadString('assets/abi.json');
    String contractAddress = constants.contractAddress;
    final contract = DeployedContract(
        ContractAbi.fromJson(abiString, "GivethTaketh"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  Future<TransactionHash> transact(
      {required String functionName,
      required List<dynamic> params,
      EtherAmount? etherAmount}) async {
    final contract = await loadContractFromAbi();
    final ethFunction = contract.function(functionName);
    EthPrivateKey credentials =
        EthPrivateKey.fromHex(constants.testPrivateKey); // Temp account
    final result = await _ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: ethFunction,
            parameters: params,
            value: etherAmount),
        chainId: null,
        fetchChainIdFromNetworkId: true);
    return result;
  }

  // ---- w3modal

  void initializeWeb3ModalService() async {
    final Set<String> excludedWalletIds = {
      'fd20dc426fb37566d803205b19bbc1d4096b248ac04548e3cfb6b3a38bd033aa', // Coinbase Wallet
    };

    final sepoliaChain = W3MChainInfo(
        chainName: "Sepolia",
        chainId: _chainId,
        namespace: "eip155:$_chainId",
        tokenName: "ETH",
        rpcUrl: "https://rpc.sepolia.org",
        blockExplorer: W3MBlockExplorer(
            name: "Sepolia Explorer", url: "https://sepolia.etherscan.io"));
    W3MChainPresets.chains.putIfAbsent(_chainId, () => sepoliaChain);

    _w3mService = W3MService(
      projectId: constants.walletConnectProjectId,
      excludedWalletIds: excludedWalletIds,
      metadata: const PairingMetadata(
        name: 'Web3Modal Flutter Example',
        description: 'Web3Modal Flutter Example',
        url: 'https://www.walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
        redirect: Redirect(
          native: 'hellometamaskdapp://',
          universal: 'https://www.walletconnect.com',
        ),
      ),
    );

    await _w3mService.init();

    _w3mService.onModalConnect.subscribe(_onModalConnect);
    _w3mService.onModalDisconnect.subscribe(_onModalDisConnect);
    _w3mService.onModalError.subscribe(_onModalError);
    _w3mService.onSessionExpireEvent.subscribe(_onSessionExpire);

    _w3mService.onSessionUpdateEvent.subscribe(_onSessionUpdate);
    _w3mService.onSessionEventEvent.subscribe(_onSessionEventEvent);
  }

  void _onModalConnect(ModalConnect? event) {
    if (kDebugMode) print("wallet connected");
  }

  void _onModalDisConnect(ModalDisconnect? event) {
    if (kDebugMode) print("wallet disconnected");
  }

  void _onModalError(ModalError? event) {
    if (kDebugMode) print("connection error");
  }

  void _onSessionExpire(SessionExpire? event) {
    if (kDebugMode) print("session expired");
  }

  void _onSessionUpdate(SessionUpdate? event) {
    if (kDebugMode) print("session updated");
  }

  void _onSessionEventEvent(SessionEvent? event) {
    if (kDebugMode) print("request event ");
  }
  // ---- flutter

  @override
  void initState() {
    super.initState();
    _httpClient = Client();
    _ethClient = Web3Client(constants.jsonRpcUrl, _httpClient); // JSON rpc API

    getBalance(constants.contractAddress);
    initializeWeb3ModalService();
  }

  @override
  void dispose() {
    _w3mService.onModalConnect.unsubscribe(_onModalConnect);
    _w3mService.onModalDisconnect.unsubscribe(_onModalDisConnect);
    _w3mService.onModalError.unsubscribe(_onModalError);
    _w3mService.onSessionExpireEvent.unsubscribe(_onSessionExpire);
    _w3mService.onSessionUpdateEvent.unsubscribe(_onSessionUpdate);
    _w3mService.onSessionEventEvent.unsubscribe(_onSessionEventEvent);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giveth Taketh'),
      ),
      body: Center(
        child: Column(
          children: [
            Text("Current Amount available: ${currentBalance ?? "---"}"),
            const SizedBox(height: 20),
            ElevatedButton(
              child: Text('Deposit'),
              onPressed: () {
                setState(() {
                  deposit(EtherAmount.inWei(BigInt.from(50000000000000000)));
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text('Info'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InfoScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
