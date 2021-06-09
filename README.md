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

#VSCode files
.vscode
```
- ajouter les dossiers `contracts` `scripts` `test`  
- ajouter la dépendences OpenZeppelin 
```zsh
yarn add @openzeppelin/contracts
```

```js
import "@openzeppelin/contracts/utils/Address.sol";
```
- ajouter les autres dépendances
```zsh
yarn add @nomiclabs/hardhat-waffle ethereum-waffle chai @nomiclabs/hardhat-ethers ethers --dev
```
- ajouter l'import de Waffle dans `hardhat.config.js`
```
require('@nomiclabs/hardhat-waffle')
```
- ajouter les dev dépendances
```
yarn add prettier prettier-plugin-solidity solhint eslint eslint-config-standard eslint-plugin-import eslint-plugin-mocha-no-only eslint-plugin-node eslint-plugin-promise eslint-plugin-standard --dev
```
- configurer les fichiers de parametrages : 
  - .prettierrc
```js
{
  "overrides": [
    {
      "files": "*.sol",
      "options": {
        "printWidth": 120,
        "tabWidth": 4,
        "useTabs": false,
        "singleQuote": false,
        "bracketSpacing": false,
        "explicitTypes": "always"
      }
    },
    {
      "files": "*.js",
      "options": {
        "tabWidth": 2,
        "useTabs": false,
        "semi": false,
        "singleQuote": true,
        "arrowParens": "always",
        "bracketSpacing": true
      }
    }
  ]
}
```
- .eslintrc
```js
{
  "extends": ["standard", "plugin:promise/recommended"],
  "plugins": ["mocha-no-only", "promise"],
  "env": {
    "browser": true,
    "node": true,
    "mocha": true,
    "jest": true
  },
  "globals": {
    "artifacts": false,
    "contract": false,
    "assert": false,
    "web3": false,
    "usePlugin": false,
    "extendEnvironment": false
  },
  "rules": {
    // Strict mode
    "strict": ["error", "global"],

    // Code style
    "array-bracket-spacing": ["off"],
    "camelcase": ["error", { "properties": "always" }],
    "comma-dangle": ["error", "always-multiline"],
    "comma-spacing": ["error", { "before": false, "after": true }],
    "dot-notation": ["error", { "allowKeywords": true, "allowPattern": "" }],
    "eol-last": ["error", "always"],
    "eqeqeq": ["error", "smart"],
    "generator-star-spacing": ["error", "before"],
    "indent": ["error", 2],
    "linebreak-style": ["error", "unix"],
    "max-len": ["error", 120, 2],
    "no-debugger": "off",
    "no-dupe-args": "error",
    "no-dupe-keys": "error",
    "no-mixed-spaces-and-tabs": ["error", "smart-tabs"],
    "no-redeclare": ["error", { "builtinGlobals": true }],
    "no-trailing-spaces": ["error", { "skipBlankLines": false }],
    "no-undef": "error",
    "no-use-before-define": "off",
    "no-var": "error",
    "object-curly-spacing": ["error", "always"],
    "prefer-const": "error",
    "quotes": ["error", "single"],
    "space-before-function-paren": ["error", "always"],

    "mocha-no-only/mocha-no-only": ["error"],

    "promise/always-return": "off",
    "promise/avoid-new": "off"
  },
  "parserOptions": {
    "ecmaVersion": 2018
  }
}
```
- .solhint.json
```js
{
  "extends": "solhint:recommended",
  "rules": {
    "func-order": "off",
    "mark-callable-contracts": "off",
    "no-empty-blocks": "off",
    "compiler-version": "off",
    "private-vars-leading-underscore": "error",
    "reason-string": "off",
    "func-visibility": ["error", { "ignoreConstructors": true }]
  }
}
```  
Puis l'ajouter dans le _hardhat.config.js_ : 
```js
require('@nomiclabs/hardhat-solhint')
```  
- editor.config
```js
# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

[*]
charset = utf-8
end_of_line = lf
indent_style = space
insert_final_newline = true
trim_trailing_whitespace = false
max_line_length = 120

[*.sol]
indent_size = 4

[*.js]
indent_size = 2

[*.adoc]
max_line_length = 0
```

- installer docgen :  
```zsh
yarn add --dev hardhat-docgen
```  
Puis dans _hardhat.config.js_ : 
```js
require('hardhat-docgen')
{...}
module.exports = {
  solidity: '0.8.4',
  docgen: {
    path: './docs',
    clear: true,
    runOnCompile: true,
  },
}
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
