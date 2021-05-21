# Mise en place d'un projet HardHat
## Installation
Initialtion d'un package yarn :  
`yarn init -y`  
Puis installation de HardHat :  
`yarn add hardhat --dev`  
HardHat est juste un outils de dev, ce qui compte c'est le fichier `.sol` et ses dépendences (dites dures) comme OpenZeppelin.  

Dans le repo : `npx hardhat` (oui pour install Waffle). Exécutée une deuxième fois, cette commande nous donne les différentes commande possible (tasks).

Si on démarre avec un projet vide :  
- ajouter le `.gitignore`
```
node_modules

#Hardhat files
cache
artifacts
```
- ajouter les dossiers `contracts` `scripts` `test`  
- ajouter la dépendences OpenZeppelin 
```zsh
yarn add @openzeppelin/contracts
```
- ajouter les autres dépendances
```zsh
yarn add @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers --dev
```
- ajouter l'import de Waffle dans `hardhat.config.js`
```
import '@nomiclabs/hardhat-waffle'
```

## Compiler un contrat
`npx hardhat compile`  
Il sait ce qu'il doit compiler (les éléments du dossier `contract`). Cette commande créer un cache qui sauvegarde les différentes compillations que l'on a fait. Il compile également les SM des dépendances.  
Cette commande retourne un dossier `artifacts` dans lequel se trouve **l'ABI** et le **bytcode**  
Dans `hardhat.config.js` on peut modifier le compilateur.  

## Utilisation

`npx hardhat clean`  
Permet de néttoyer le dossier `artifact` et le `cache`

`npx hardhat test`  
Compile le contract si ce n'est pas fait. Lance l'exécution des tests définit dans le dossier `test`

`npx hardhat run script/myScript.js`  
Permet d'exécuter un script (souvent pour déployer)

`npx hardhat node`  
Ouvre un prompt comme `node` mais avec d'autres fonctionnalitées.  
On peut ajouter l'argument `--network localhost` pour sélectionner un réseau de déploiment.


`npx hardhat console --network localhost`  
Permet d'écouter la blockchain et les exécution réaliser dessus. 
