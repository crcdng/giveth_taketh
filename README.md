# giveth_taketh

a tiny socio-economic experiment (EthBerlin hackathon)

[Description](https://projects.ethberlin.org/submissions/315)

interacts with the smart contract at address [0x8EA3C9e14694F820F11c054a630607cf59C02FAC](https://sepolia.etherscan.io/address/0x8EA3C9e14694F820F11c054a630607cf59C02FAC) on the Sepolia testnet

requires metamask or similar wallet installed on the device

dependencies: 

* [infura API](https://www.infura.io/) or another rpc node on the Sepolia testnet
* [walletconnect API](https://cloud.walletconnect.com/)
* [etherscan API](https://docs.etherscan.io/api-pro/etherscan-api-pro)

platform: Android for now (see [this issue](https://github.com/WalletConnect/Web3ModalFlutter/issues/108)). needs Android minSdk = 23

to run, enter

```
flutter run \
--dart-define CONTRACT_ADDRESS=0x8EA3C9e14694F820F11c054a630607cf59C02FAC \
--dart-define NODE_URL=<YOUR INFURA KEY> \
--dart-define WALLET_CONNECT_ID=<YOUR WALLETCONNECT ID> \
--dart-define TEST_PRIVATE_KEY=<YOUR TEST SIGNER PRIVATE KEY> \
--dart-define ETHERSCAN_KEY=<YOUR ETHERSCAN API KEY> \
--hot
```

# Work in progress (post Hackathon) 

- Metamask signing still broken, some progress

# Open Issues 

- Metamask connection does not work on web, see [this issue](https://github.com/WalletConnect/Web3ModalFlutter/issues/108)
- Sepolia testnet hardcoded into the app, needs to be deployed on mainnet
- History: amount of transaction needs to be figured out

# Later 

- nicer History
- Data view
- refactor 'hackathon architecture'