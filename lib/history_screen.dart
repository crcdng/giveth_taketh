import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web3modal_flutter/web3modal_flutter.dart';
import 'constants.dart' as constants;
import 'history_transaction.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<List<HistoryTransaction>> transactions;

  Future<List<HistoryTransaction>> fetchTransactionHistory() async {
    final response = await http.get(
        Uri.parse(
            'https://api-sepolia.etherscan.io/api?module=account&action=txlist&address=${constants.contractAddress}&startblock=0&endblock=99999999&sort=asc&apikey=${constants.etherscanApiKey}'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8'
        });

    if (response.statusCode == 200) {
      final responseBody = json.decode(response.body);
      Iterable l = responseBody["result"];
      List<HistoryTransaction> transactions =
          List<HistoryTransaction>.from(l.map((model) {
        return HistoryTransaction.fromJson(model);
      }));
      return transactions;
    } else {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    transactions = fetchTransactionHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none ||
                snapshot.data == null) {
              return Container();
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                bool isDeposit =
                    snapshot.data![index].functionName == "deposit()";
                return ListTile(
                  leading: isDeposit
                      ? const Icon(Icons.arrow_upward)
                      : const Icon(Icons.arrow_downward),
                  // TODO refactor
                  title: isDeposit
                      ? Text(
                          "deposit ${EtherAmount.fromBigInt(EtherUnit.wei, BigInt.tryParse(snapshot.data![index].value)!).getValueInUnit(EtherUnit.ether)} ETH")
                      // TODO get amount
                      : Text("withdrawal ${snapshot.data![index].value}"),
                  subtitle: Text(snapshot.data![index].from.toString()),
                );
              },
            );
          },
          future: transactions,
        ),
      ),
    );
  }
}
