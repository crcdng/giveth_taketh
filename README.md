# giveth_taketh

a tiny socio-economic experiment (EthBerlin hackathon)

platform: Android for now (see [this issue](https://github.com/WalletConnect/Web3ModalFlutter/issues/108))

interacts with the smart contract at address [0x5A7e83A6975cba64b4745946c53230bFA49D352D](https://sepolia.etherscan.io/address/0x5A7e83A6975cba64b4745946c53230bFA49D352D) on the Sepolia testnet

requires metamask or similar wallet installed on the device

dependencies: 

* [infura API](https://www.infura.io/) or another rpc node on the Sepolia testnet
* [walletconnect API](https://cloud.walletconnect.com/)
* [etherscan API](https://docs.etherscan.io/api-pro/etherscan-api-pro)

needs Android minSdk = 23

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

# Open Issues 

- Metamask signing does not work yet
- Metamask connection does not work on web, see [this issue](https://github.com/WalletConnect/Web3ModalFlutter/issues/108)
- Sepolia testnet hardcoded into the app, needs to be deployed on mainnet
- Histury amount of transaction needs to be figured out
- 'hackathon architecture'