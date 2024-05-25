# giveth_taketh

a tiny socio-economic experiment (EthBerlin hackathon)

platform: Android for now (see [this issue](https://github.com/WalletConnect/Web3ModalFlutter/issues/108))

interacts with the smart contract at address [0x5A7e83A6975cba64b4745946c53230bFA49D352D](https://sepolia.etherscan.io/address/0x5A7e83A6975cba64b4745946c53230bFA49D352D) on the Sepolia testnet

requires metamask or similar wallet installed on the device

dependencies: 

* [infura account](https://www.infura.io/) or another rpc node on the Sepolia testnet
* [walletconnect accoumt](https://cloud.walletconnect.com/)
    
needs Android minSdk = 23

to run, enter

```
flutter run \
--dart-define CONTRACT_ADDRESS=0x5A7e83A6975cba64b4745946c53230bFA49D352D \
--dart-define NODE_URL=<YOUR RPC NODE URL> \
--dart-define WALLET_CONNECT_ID=<YOUR WALLET CONNECT PROJECT ID> \
--hot

```
